Received: from eggs.gnu.org ([2001:4830:134:3::10]:43092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1faGHY-0007hk-A7
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:03:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1faGHU-0003nf-Nb
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 04:03:28 -0400
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Tue,  3 Jul 2018 09:03:03 +0100
Message-Id: <20180703080303.17355-2-rjones@redhat.com>
In-Reply-To: <20180703080303.17355-1-rjones@redhat.com>
References: <20180703080303.17355-1-rjones@redhat.com>
Subject: [Qemu-devel] [PATCH v6] crypto: Implement TLS Pre-Shared Keys (PSK).
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, berrange@redhat.com, qemu-block@nongnu.org

Pre-Shared Keys (PSK) is a simpler mechanism for enabling TLS
connections than using certificates.  It requires only a simple secret
key:

  $ mkdir -m 0700 /tmp/keys
  $ psktool -u rjones -p /tmp/keys/keys.psk
  $ cat /tmp/keys/keys.psk
  rjones:d543770c15ad93d76443fb56f501a31969235f47e999720ae8d2336f6a13fcbc

The key can be secretly shared between clients and servers.  Clients
must specify the directory containing the "keys.psk" file and a
username (defaults to "qemu").  Servers must specify only the
directory.

Example NBD client:

  $ qemu-img info \
    --object tls-creds-psk,id=tls0,dir=/tmp/keys,username=rjones,endpoint=client \
    --image-opts \
    file.driver=nbd,file.host=localhost,file.port=10809,file.tls-creds=tls0,file.export=/

Example NBD server using qemu-nbd:

  $ qemu-nbd -t -x / \
    --object tls-creds-psk,id=tls0,endpoint=server,dir=/tmp/keys \
    --tls-creds tls0 \
    image.qcow2

Example NBD server using nbdkit:

  $ nbdkit -n -e / -fv \
    --tls=on --tls-psk=/tmp/keys/keys.psk \
    file file=disk.img

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
---
 crypto/Makefile.objs           |   1 +
 crypto/tlscredspsk.c           | 308 +++++++++++++++++++++++++++++++++
 crypto/tlssession.c            |  56 +++++-
 crypto/trace-events            |   3 +
 include/crypto/tlscredspsk.h   | 106 ++++++++++++
 qemu-doc.texi                  |  37 ++++
 qemu-options.hx                |  24 +++
 tests/Makefile.include         |   4 +-
 tests/crypto-tls-psk-helpers.c |  50 ++++++
 tests/crypto-tls-psk-helpers.h |  29 ++++
 tests/test-crypto-tlssession.c | 185 +++++++++++++++++---
 11 files changed, 777 insertions(+), 26 deletions(-)

diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index 2b99e08062..756bab111b 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -15,6 +15,7 @@ crypto-obj-$(CONFIG_AF_ALG) += cipher-afalg.o
 crypto-obj-$(CONFIG_AF_ALG) += hash-afalg.o
 crypto-obj-y += tlscreds.o
 crypto-obj-y += tlscredsanon.o
+crypto-obj-y += tlscredspsk.o
 crypto-obj-y += tlscredsx509.o
 crypto-obj-y += tlssession.o
 crypto-obj-y += secret.o
diff --git a/crypto/tlscredspsk.c b/crypto/tlscredspsk.c
new file mode 100644
index 0000000000..7be7c8efdd
--- /dev/null
+++ b/crypto/tlscredspsk.c
@@ -0,0 +1,308 @@
+/*
+ * QEMU crypto TLS Pre-Shared Keys (PSK) support
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#include "qemu/osdep.h"
+#include "crypto/tlscredspsk.h"
+#include "tlscredspriv.h"
+#include "qapi/error.h"
+#include "qom/object_interfaces.h"
+#include "trace.h"
+
+
+#ifdef CONFIG_GNUTLS
+
+static int
+lookup_key(const char *pskfile, const char *username, gnutls_datum_t *key,
+           Error **errp)
+{
+    const size_t ulen = strlen(username);
+    GError *gerr = NULL;
+    char *content = NULL;
+    char **lines = NULL;
+    size_t clen = 0, i;
+    int ret = -1;
+
+    if (!g_file_get_contents(pskfile, &content, &clen, &gerr)) {
+        error_setg(errp, "Cannot read PSK file %s: %s",
+                   pskfile, gerr->message);
+        g_error_free(gerr);
+        return -1;
+    }
+
+    lines = g_strsplit(content, "\n", -1);
+    for (i = 0; lines[i] != NULL; ++i) {
+        if (strncmp(lines[i], username, ulen) == 0 && lines[i][ulen] == ':') {
+            key->data = (unsigned char *) g_strdup(&lines[i][ulen + 1]);
+            key->size = strlen(lines[i]) - ulen - 1;
+            ret = 0;
+            goto out;
+        }
+    }
+    error_setg(errp, "Username %s not found in PSK file %s",
+               username, pskfile);
+
+ out:
+    free(content);
+    g_strfreev(lines);
+    return ret;
+}
+
+static int
+qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds,
+                           Error **errp)
+{
+    char *pskfile = NULL, *dhparams = NULL;
+    const char *username;
+    int ret;
+    int rv = -1;
+    gnutls_datum_t key = { .data = NULL };
+
+    trace_qcrypto_tls_creds_psk_load(creds,
+            creds->parent_obj.dir ? creds->parent_obj.dir : "<nodir>");
+
+    if (creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
+        if (creds->username) {
+            error_setg(errp, "username should not be set when endpoint=server");
+            goto cleanup;
+        }
+
+        if (qcrypto_tls_creds_get_path(&creds->parent_obj,
+                                       QCRYPTO_TLS_CREDS_DH_PARAMS,
+                                       false, &dhparams, errp) < 0 ||
+            qcrypto_tls_creds_get_path(&creds->parent_obj,
+                                       QCRYPTO_TLS_CREDS_PSKFILE,
+                                       true, &pskfile, errp) < 0) {
+            goto cleanup;
+        }
+
+        ret = gnutls_psk_allocate_server_credentials(&creds->data.server);
+        if (ret < 0) {
+            error_setg(errp, "Cannot allocate credentials: %s",
+                       gnutls_strerror(ret));
+            goto cleanup;
+        }
+
+        if (qcrypto_tls_creds_get_dh_params_file(&creds->parent_obj, dhparams,
+                                                 &creds->parent_obj.dh_params,
+                                                 errp) < 0) {
+            goto cleanup;
+        }
+
+        gnutls_psk_set_server_credentials_file(creds->data.server, pskfile);
+        gnutls_psk_set_server_dh_params(creds->data.server,
+                                        creds->parent_obj.dh_params);
+    } else {
+        if (qcrypto_tls_creds_get_path(&creds->parent_obj,
+                                       QCRYPTO_TLS_CREDS_PSKFILE,
+                                       true, &pskfile, errp) < 0) {
+            goto cleanup;
+        }
+
+        if (creds->username) {
+            username = creds->username;
+        } else {
+            username = "qemu";
+        }
+        if (lookup_key(pskfile, username, &key, errp) != 0) {
+            goto cleanup;
+        }
+
+        ret = gnutls_psk_allocate_client_credentials(&creds->data.client);
+        if (ret < 0) {
+            error_setg(errp, "Cannot allocate credentials: %s",
+                       gnutls_strerror(ret));
+            goto cleanup;
+        }
+
+        gnutls_psk_set_client_credentials(creds->data.client,
+                                          username, &key, GNUTLS_PSK_KEY_HEX);
+    }
+
+    rv = 0;
+ cleanup:
+    g_free(key.data);
+    g_free(pskfile);
+    g_free(dhparams);
+    return rv;
+}
+
+
+static void
+qcrypto_tls_creds_psk_unload(QCryptoTLSCredsPSK *creds)
+{
+    if (creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT) {
+        if (creds->data.client) {
+            gnutls_psk_free_client_credentials(creds->data.client);
+            creds->data.client = NULL;
+        }
+    } else {
+        if (creds->data.server) {
+            gnutls_psk_free_server_credentials(creds->data.server);
+            creds->data.server = NULL;
+        }
+    }
+    if (creds->parent_obj.dh_params) {
+        gnutls_dh_params_deinit(creds->parent_obj.dh_params);
+        creds->parent_obj.dh_params = NULL;
+    }
+}
+
+#else /* ! CONFIG_GNUTLS */
+
+
+static void
+qcrypto_tls_creds_psk_load(QCryptoTLSCredsPSK *creds G_GNUC_UNUSED,
+                           Error **errp)
+{
+    error_setg(errp, "TLS credentials support requires GNUTLS");
+}
+
+
+static void
+qcrypto_tls_creds_psk_unload(QCryptoTLSCredsPSK *creds G_GNUC_UNUSED)
+{
+    /* nada */
+}
+
+
+#endif /* ! CONFIG_GNUTLS */
+
+
+static void
+qcrypto_tls_creds_psk_prop_set_loaded(Object *obj,
+                                      bool value,
+                                      Error **errp)
+{
+    QCryptoTLSCredsPSK *creds = QCRYPTO_TLS_CREDS_PSK(obj);
+
+    if (value) {
+        qcrypto_tls_creds_psk_load(creds, errp);
+    } else {
+        qcrypto_tls_creds_psk_unload(creds);
+    }
+}
+
+
+#ifdef CONFIG_GNUTLS
+
+
+static bool
+qcrypto_tls_creds_psk_prop_get_loaded(Object *obj,
+                                      Error **errp G_GNUC_UNUSED)
+{
+    QCryptoTLSCredsPSK *creds = QCRYPTO_TLS_CREDS_PSK(obj);
+
+    if (creds->parent_obj.endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
+        return creds->data.server != NULL;
+    } else {
+        return creds->data.client != NULL;
+    }
+}
+
+
+#else /* ! CONFIG_GNUTLS */
+
+
+static bool
+qcrypto_tls_creds_psk_prop_get_loaded(Object *obj G_GNUC_UNUSED,
+                                      Error **errp G_GNUC_UNUSED)
+{
+    return false;
+}
+
+
+#endif /* ! CONFIG_GNUTLS */
+
+
+static void
+qcrypto_tls_creds_psk_complete(UserCreatable *uc, Error **errp)
+{
+    object_property_set_bool(OBJECT(uc), true, "loaded", errp);
+}
+
+
+static void
+qcrypto_tls_creds_psk_finalize(Object *obj)
+{
+    QCryptoTLSCredsPSK *creds = QCRYPTO_TLS_CREDS_PSK(obj);
+
+    qcrypto_tls_creds_psk_unload(creds);
+}
+
+static void
+qcrypto_tls_creds_psk_prop_set_username(Object *obj,
+                                        const char *value,
+                                        Error **errp G_GNUC_UNUSED)
+{
+    QCryptoTLSCredsPSK *creds = QCRYPTO_TLS_CREDS_PSK(obj);
+
+    creds->username = g_strdup(value);
+}
+
+
+static char *
+qcrypto_tls_creds_psk_prop_get_username(Object *obj,
+                                        Error **errp G_GNUC_UNUSED)
+{
+    QCryptoTLSCredsPSK *creds = QCRYPTO_TLS_CREDS_PSK(obj);
+
+    return g_strdup(creds->username);
+}
+
+static void
+qcrypto_tls_creds_psk_class_init(ObjectClass *oc, void *data)
+{
+    UserCreatableClass *ucc = USER_CREATABLE_CLASS(oc);
+
+    ucc->complete = qcrypto_tls_creds_psk_complete;
+
+    object_class_property_add_bool(oc, "loaded",
+                                   qcrypto_tls_creds_psk_prop_get_loaded,
+                                   qcrypto_tls_creds_psk_prop_set_loaded,
+                                   NULL);
+    object_class_property_add_str(oc, "username",
+                                  qcrypto_tls_creds_psk_prop_get_username,
+                                  qcrypto_tls_creds_psk_prop_set_username,
+                                  NULL);
+}
+
+
+static const TypeInfo qcrypto_tls_creds_psk_info = {
+    .parent = TYPE_QCRYPTO_TLS_CREDS,
+    .name = TYPE_QCRYPTO_TLS_CREDS_PSK,
+    .instance_size = sizeof(QCryptoTLSCredsPSK),
+    .instance_finalize = qcrypto_tls_creds_psk_finalize,
+    .class_size = sizeof(QCryptoTLSCredsPSKClass),
+    .class_init = qcrypto_tls_creds_psk_class_init,
+    .interfaces = (InterfaceInfo[]) {
+        { TYPE_USER_CREATABLE },
+        { }
+    }
+};
+
+
+static void
+qcrypto_tls_creds_psk_register_types(void)
+{
+    type_register_static(&qcrypto_tls_creds_psk_info);
+}
+
+
+type_init(qcrypto_tls_creds_psk_register_types);
diff --git a/crypto/tlssession.c b/crypto/tlssession.c
index 96a02deb69..66a6fbe19c 100644
--- a/crypto/tlssession.c
+++ b/crypto/tlssession.c
@@ -21,6 +21,7 @@
 #include "qemu/osdep.h"
 #include "crypto/tlssession.h"
 #include "crypto/tlscredsanon.h"
+#include "crypto/tlscredspsk.h"
 #include "crypto/tlscredsx509.h"
 #include "qapi/error.h"
 #include "qemu/acl.h"
@@ -88,6 +89,14 @@ qcrypto_tls_session_pull(void *opaque, void *buf, size_t len)
     return session->readFunc(buf, len, session->opaque);
 }
 
+#define TLS_PRIORITY_ADDITIONAL_ANON "+ANON-DH"
+
+#if GNUTLS_VERSION_MAJOR >= 3
+#define TLS_ECDHE_PSK "+ECDHE-PSK:"
+#else
+#define TLS_ECDHE_PSK ""
+#endif
+#define TLS_PRIORITY_ADDITIONAL_PSK TLS_ECDHE_PSK "+DHE-PSK:+PSK"
 
 QCryptoTLSSession *
 qcrypto_tls_session_new(QCryptoTLSCreds *creds,
@@ -135,9 +144,12 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,
         char *prio;
 
         if (creds->priority != NULL) {
-            prio = g_strdup_printf("%s:+ANON-DH", creds->priority);
+            prio = g_strdup_printf("%s:%s",
+                                   creds->priority,
+                                   TLS_PRIORITY_ADDITIONAL_ANON);
         } else {
-            prio = g_strdup(CONFIG_TLS_PRIORITY ":+ANON-DH");
+            prio = g_strdup(CONFIG_TLS_PRIORITY ":"
+                            TLS_PRIORITY_ADDITIONAL_ANON);
         }
 
         ret = gnutls_priority_set_direct(session->handle, prio, NULL);
@@ -162,6 +174,42 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,
                        gnutls_strerror(ret));
             goto error;
         }
+    } else if (object_dynamic_cast(OBJECT(creds),
+                                   TYPE_QCRYPTO_TLS_CREDS_PSK)) {
+        QCryptoTLSCredsPSK *pcreds = QCRYPTO_TLS_CREDS_PSK(creds);
+        char *prio;
+
+        if (creds->priority != NULL) {
+            prio = g_strdup_printf("%s:%s",
+                                   creds->priority,
+                                   TLS_PRIORITY_ADDITIONAL_PSK);
+        } else {
+            prio = g_strdup(CONFIG_TLS_PRIORITY ":"
+                            TLS_PRIORITY_ADDITIONAL_PSK);
+        }
+
+        ret = gnutls_priority_set_direct(session->handle, prio, NULL);
+        if (ret < 0) {
+            error_setg(errp, "Unable to set TLS session priority %s: %s",
+                       prio, gnutls_strerror(ret));
+            g_free(prio);
+            goto error;
+        }
+        g_free(prio);
+        if (creds->endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
+            ret = gnutls_credentials_set(session->handle,
+                                         GNUTLS_CRD_PSK,
+                                         pcreds->data.server);
+        } else {
+            ret = gnutls_credentials_set(session->handle,
+                                         GNUTLS_CRD_PSK,
+                                         pcreds->data.client);
+        }
+        if (ret < 0) {
+            error_setg(errp, "Cannot set session credentials: %s",
+                       gnutls_strerror(ret));
+            goto error;
+        }
     } else if (object_dynamic_cast(OBJECT(creds),
                                    TYPE_QCRYPTO_TLS_CREDS_X509)) {
         QCryptoTLSCredsX509 *tcreds = QCRYPTO_TLS_CREDS_X509(creds);
@@ -353,6 +401,10 @@ qcrypto_tls_session_check_credentials(QCryptoTLSSession *session,
                             TYPE_QCRYPTO_TLS_CREDS_ANON)) {
         trace_qcrypto_tls_session_check_creds(session, "nop");
         return 0;
+    } else if (object_dynamic_cast(OBJECT(session->creds),
+                            TYPE_QCRYPTO_TLS_CREDS_PSK)) {
+        trace_qcrypto_tls_session_check_creds(session, "nop");
+        return 0;
     } else if (object_dynamic_cast(OBJECT(session->creds),
                             TYPE_QCRYPTO_TLS_CREDS_X509)) {
         if (session->creds->verifyPeer) {
diff --git a/crypto/trace-events b/crypto/trace-events
index e589990359..597389b73c 100644
--- a/crypto/trace-events
+++ b/crypto/trace-events
@@ -7,6 +7,9 @@ qcrypto_tls_creds_get_path(void *creds, const char *filename, const char *path)
 # crypto/tlscredsanon.c
 qcrypto_tls_creds_anon_load(void *creds, const char *dir) "TLS creds anon load creds=%p dir=%s"
 
+# crypto/tlscredspsk.c
+qcrypto_tls_creds_psk_load(void *creds, const char *dir) "TLS creds psk load creds=%p dir=%s"
+
 # crypto/tlscredsx509.c
 qcrypto_tls_creds_x509_load(void *creds, const char *dir) "TLS creds x509 load creds=%p dir=%s"
 qcrypto_tls_creds_x509_check_basic_constraints(void *creds, const char *file, int status) "TLS creds x509 check basic constraints creds=%p file=%s status=%d"
diff --git a/include/crypto/tlscredspsk.h b/include/crypto/tlscredspsk.h
new file mode 100644
index 0000000000..306d36c67d
--- /dev/null
+++ b/include/crypto/tlscredspsk.h
@@ -0,0 +1,106 @@
+/*
+ * QEMU crypto TLS Pre-Shared Key (PSK) support
+ *
+ * Copyright (c) 2018 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library; if not, see <http://www.gnu.org/licenses/>.
+ *
+ */
+
+#ifndef QCRYPTO_TLSCREDSPSK_H
+#define QCRYPTO_TLSCREDSPSK_H
+
+#include "crypto/tlscreds.h"
+
+#define TYPE_QCRYPTO_TLS_CREDS_PSK "tls-creds-psk"
+#define QCRYPTO_TLS_CREDS_PSK(obj)                  \
+    OBJECT_CHECK(QCryptoTLSCredsPSK, (obj), TYPE_QCRYPTO_TLS_CREDS_PSK)
+
+typedef struct QCryptoTLSCredsPSK QCryptoTLSCredsPSK;
+typedef struct QCryptoTLSCredsPSKClass QCryptoTLSCredsPSKClass;
+
+#define QCRYPTO_TLS_CREDS_PSKFILE "keys.psk"
+
+/**
+ * QCryptoTLSCredsPSK:
+ *
+ * The QCryptoTLSCredsPSK object provides a representation
+ * of the Pre-Shared Key credential used to perform a TLS handshake.
+ *
+ * This is a user creatable object, which can be instantiated
+ * via object_new_propv():
+ *
+ * <example>
+ *   <title>Creating TLS-PSK credential objects in code</title>
+ *   <programlisting>
+ *   Object *obj;
+ *   Error *err = NULL;
+ *   obj = object_new_propv(TYPE_QCRYPTO_TLS_CREDS_PSK,
+ *                          "tlscreds0",
+ *                          &err,
+ *                          "dir", "/path/to/dir",
+ *                          "endpoint", "client",
+ *                          NULL);
+ *   </programlisting>
+ * </example>
+ *
+ * Or via QMP:
+ *
+ * <example>
+ *   <title>Creating TLS-PSK credential objects via QMP</title>
+ *   <programlisting>
+ *    {
+ *       "execute": "object-add", "arguments": {
+ *          "id": "tlscreds0",
+ *          "qom-type": "tls-creds-psk",
+ *          "props": {
+ *             "dir": "/path/to/dir",
+ *             "endpoint": "client"
+ *          }
+ *       }
+ *    }
+ *   </programlisting>
+ * </example>
+ *
+ * Or via the CLI:
+ *
+ * <example>
+ *   <title>Creating TLS-PSK credential objects via CLI</title>
+ *   <programlisting>
+ *  qemu-system-x86_64 --object tls-creds-psk,id=tlscreds0,\
+ *          endpoint=client,dir=/path/to/dir[,username=qemu]
+ *   </programlisting>
+ * </example>
+ *
+ * The PSK file can be created and managed using psktool.
+ */
+
+struct QCryptoTLSCredsPSK {
+    QCryptoTLSCreds parent_obj;
+    char *username;
+#ifdef CONFIG_GNUTLS
+    union {
+        gnutls_psk_server_credentials_t server;
+        gnutls_psk_client_credentials_t client;
+    } data;
+#endif
+};
+
+
+struct QCryptoTLSCredsPSKClass {
+    QCryptoTLSCredsClass parent_class;
+};
+
+
+#endif /* QCRYPTO_TLSCREDSPSK_H */
diff --git a/qemu-doc.texi b/qemu-doc.texi
index 1cb3ba4341..d3924e928e 100644
--- a/qemu-doc.texi
+++ b/qemu-doc.texi
@@ -1262,6 +1262,7 @@ The recommendation is for the server to keep its certificates in either
 * tls_generate_server::
 * tls_generate_client::
 * tls_creds_setup::
+* tls_psk::
 @end menu
 @node tls_generate_ca
 @subsection Setup the Certificate Authority
@@ -1510,6 +1511,42 @@ example with VNC:
 $QEMU -vnc 0.0.0.0:0,tls-creds=tls0
 @end example
 
+@node tls_psk
+@subsection TLS Pre-Shared Keys (PSK)
+
+Instead of using certificates, you may also use TLS Pre-Shared Keys
+(TLS-PSK).  This can be simpler to set up than certificates but is
+less scalable.
+
+Use the GnuTLS @code{psktool} program to generate a @code{keys.psk}
+file containing one or more usernames and random keys:
+
+@example
+mkdir -m 0700 /tmp/keys
+psktool -u rich -p /tmp/keys/keys.psk
+@end example
+
+TLS-enabled servers such as qemu-nbd can use this directory like so:
+
+@example
+qemu-nbd \
+  -t -x / \
+  --object tls-creds-psk,id=tls0,endpoint=server,dir=/tmp/keys \
+  --tls-creds tls0 \
+  image.qcow2
+@end example
+
+When connecting from a qemu-based client you must specify the
+directory containing @code{keys.psk} and an optional @var{username}
+(defaults to ``qemu''):
+
+@example
+qemu-img info \
+  --object tls-creds-psk,id=tls0,dir=/tmp/keys,username=rich,endpoint=client \
+  --image-opts \
+  file.driver=nbd,file.host=localhost,file.port=10809,file.tls-creds=tls0,file.export=/
+@end example
+
 @node gdb_usage
 @section GDB usage
 
diff --git a/qemu-options.hx b/qemu-options.hx
index 81b1e99d58..16208f63f2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4123,6 +4123,30 @@ expensive operation that consumes random pool entropy, so it is
 recommended that a persistent set of parameters be generated
 upfront and saved.
 
+@item -object tls-creds-psk,id=@var{id},endpoint=@var{endpoint},dir=@var{/path/to/keys/dir}[,username=@var{username}]
+
+Creates a TLS Pre-Shared Keys (PSK) credentials object, which can be used to provide
+TLS support on network backends. The @option{id} parameter is a unique
+ID which network backends will use to access the credentials. The
+@option{endpoint} is either @option{server} or @option{client} depending
+on whether the QEMU network backend that uses the credentials will be
+acting as a client or as a server. For clients only, @option{username}
+is the username which will be sent to the server.  If omitted
+it defaults to ``qemu''.
+
+The @var{dir} parameter tells QEMU where to find the keys file.
+It is called ``@var{dir}/keys.psk'' and contains ``username:key''
+pairs.  This file can most easily be created using the GnuTLS
+@code{psktool} program.
+
+For server endpoints, @var{dir} may also contain a file
+@var{dh-params.pem} providing diffie-hellman parameters to use
+for the TLS server. If the file is missing, QEMU will generate
+a set of DH parameters at startup. This is a computationally
+expensive operation that consumes random pool entropy, so it is
+recommended that a persistent set of parameters be generated
+up front and saved.
+
 @item -object tls-creds-x509,id=@var{id},endpoint=@var{endpoint},dir=@var{/path/to/cred/dir},priority=@var{priority},verify-peer=@var{on|off},passwordid=@var{id}
 
 Creates a TLS anonymous credentials object, which can be used to provide
diff --git a/tests/Makefile.include b/tests/Makefile.include
index e8bb2d8f66..8859e88ffb 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -723,7 +723,9 @@ tests/test-crypto-tlscredsx509$(EXESUF): tests/test-crypto-tlscredsx509.o \
 
 tests/test-crypto-tlssession.o-cflags := $(TASN1_CFLAGS)
 tests/test-crypto-tlssession$(EXESUF): tests/test-crypto-tlssession.o \
-	tests/crypto-tls-x509-helpers.o tests/pkix_asn1_tab.o $(test-crypto-obj-y)
+	tests/crypto-tls-x509-helpers.o tests/pkix_asn1_tab.o \
+	tests/crypto-tls-psk-helpers.o \
+        $(test-crypto-obj-y)
 tests/test-util-sockets$(EXESUF): tests/test-util-sockets.o \
 	tests/socket-helpers.o $(test-util-obj-y)
 tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)
diff --git a/tests/crypto-tls-psk-helpers.c b/tests/crypto-tls-psk-helpers.c
new file mode 100644
index 0000000000..a8395477c3
--- /dev/null
+++ b/tests/crypto-tls-psk-helpers.c
@@ -0,0 +1,50 @@
+/*
+ * Copyright (C) 2015-2018 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library.  If not, see
+ * <http://www.gnu.org/licenses/>.
+ *
+ * Author: Richard W.M. Jones <rjones@redhat.com>
+ */
+
+#include "qemu/osdep.h"
+
+/* Include this first because it defines QCRYPTO_HAVE_TLS_TEST_SUPPORT */
+#include "crypto-tls-x509-helpers.h"
+
+#include "crypto-tls-psk-helpers.h"
+#include "qemu/sockets.h"
+
+#ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
+
+void test_tls_psk_init(const char *pskfile)
+{
+    FILE *fp;
+
+    fp = fopen(pskfile, "w");
+    if (fp == NULL) {
+        g_critical("Failed to create pskfile %s", pskfile);
+        abort();
+    }
+    /* Don't do this in real applications!  Use psktool. */
+    fprintf(fp, "qemu:009d5638c40fde0c\n");
+    fclose(fp);
+}
+
+void test_tls_psk_cleanup(const char *pskfile)
+{
+    unlink(pskfile);
+}
+
+#endif /* QCRYPTO_HAVE_TLS_TEST_SUPPORT */
diff --git a/tests/crypto-tls-psk-helpers.h b/tests/crypto-tls-psk-helpers.h
new file mode 100644
index 0000000000..9aec29f1a0
--- /dev/null
+++ b/tests/crypto-tls-psk-helpers.h
@@ -0,0 +1,29 @@
+/*
+ * Copyright (C) 2015-2018 Red Hat, Inc.
+ *
+ * This library is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU Lesser General Public
+ * License as published by the Free Software Foundation; either
+ * version 2.1 of the License, or (at your option) any later version.
+ *
+ * This library is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+ * Lesser General Public License for more details.
+ *
+ * You should have received a copy of the GNU Lesser General Public
+ * License along with this library.  If not, see
+ * <http://www.gnu.org/licenses/>.
+ *
+ * Author: Richard W.M. Jones <rjones@redhat.com>
+ */
+
+#include <gnutls/gnutls.h>
+
+#ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
+# include "qemu-common.h"
+
+void test_tls_psk_init(const char *keyfile);
+void test_tls_psk_cleanup(const char *keyfile);
+
+#endif /* QCRYPTO_HAVE_TLS_TEST_SUPPORT */
diff --git a/tests/test-crypto-tlssession.c b/tests/test-crypto-tlssession.c
index 82f21c27f2..7bd811796e 100644
--- a/tests/test-crypto-tlssession.c
+++ b/tests/test-crypto-tlssession.c
@@ -21,7 +21,9 @@
 #include "qemu/osdep.h"
 
 #include "crypto-tls-x509-helpers.h"
+#include "crypto-tls-psk-helpers.h"
 #include "crypto/tlscredsx509.h"
+#include "crypto/tlscredspsk.h"
 #include "crypto/tlssession.h"
 #include "qom/object_interfaces.h"
 #include "qapi/error.h"
@@ -31,8 +33,152 @@
 #ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
 
 #define WORKDIR "tests/test-crypto-tlssession-work/"
+#define PSKFILE WORKDIR "keys.psk"
 #define KEYFILE WORKDIR "key-ctx.pem"
 
+static ssize_t testWrite(const char *buf, size_t len, void *opaque)
+{
+    int *fd = opaque;
+
+    return write(*fd, buf, len);
+}
+
+static ssize_t testRead(char *buf, size_t len, void *opaque)
+{
+    int *fd = opaque;
+
+    return read(*fd, buf, len);
+}
+
+static QCryptoTLSCreds *test_tls_creds_psk_create(
+    QCryptoTLSCredsEndpoint endpoint,
+    const char *dir,
+    Error **errp)
+{
+    Error *err = NULL;
+    Object *parent = object_get_objects_root();
+    Object *creds = object_new_with_props(
+        TYPE_QCRYPTO_TLS_CREDS_PSK,
+        parent,
+        (endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER ?
+         "testtlscredsserver" : "testtlscredsclient"),
+        &err,
+        "endpoint", (endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER ?
+                     "server" : "client"),
+        "dir", dir,
+        "priority", "NORMAL",
+        NULL
+        );
+
+    if (err) {
+        error_propagate(errp, err);
+        return NULL;
+    }
+    return QCRYPTO_TLS_CREDS(creds);
+}
+
+
+static void test_crypto_tls_session_psk(void)
+{
+    QCryptoTLSCreds *clientCreds;
+    QCryptoTLSCreds *serverCreds;
+    QCryptoTLSSession *clientSess = NULL;
+    QCryptoTLSSession *serverSess = NULL;
+    int channel[2];
+    bool clientShake = false;
+    bool serverShake = false;
+    Error *err = NULL;
+    int ret;
+
+    /* We'll use this for our fake client-server connection */
+    ret = socketpair(AF_UNIX, SOCK_STREAM, 0, channel);
+    g_assert(ret == 0);
+
+    /*
+     * We have an evil loop to do the handshake in a single
+     * thread, so we need these non-blocking to avoid deadlock
+     * of ourselves
+     */
+    qemu_set_nonblock(channel[0]);
+    qemu_set_nonblock(channel[1]);
+
+    clientCreds = test_tls_creds_psk_create(
+        QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT,
+        WORKDIR,
+        &err);
+    g_assert(clientCreds != NULL);
+
+    serverCreds = test_tls_creds_psk_create(
+        QCRYPTO_TLS_CREDS_ENDPOINT_SERVER,
+        WORKDIR,
+        &err);
+    g_assert(serverCreds != NULL);
+
+    /* Now the real part of the test, setup the sessions */
+    clientSess = qcrypto_tls_session_new(
+        clientCreds, NULL, NULL,
+        QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT, &err);
+    serverSess = qcrypto_tls_session_new(
+        serverCreds, NULL, NULL,
+        QCRYPTO_TLS_CREDS_ENDPOINT_SERVER, &err);
+
+    g_assert(clientSess != NULL);
+    g_assert(serverSess != NULL);
+
+    /* For handshake to work, we need to set the I/O callbacks
+     * to read/write over the socketpair
+     */
+    qcrypto_tls_session_set_callbacks(serverSess,
+                                      testWrite, testRead,
+                                      &channel[0]);
+    qcrypto_tls_session_set_callbacks(clientSess,
+                                      testWrite, testRead,
+                                      &channel[1]);
+
+    /*
+     * Finally we loop around & around doing handshake on each
+     * session until we get an error, or the handshake completes.
+     * This relies on the socketpair being nonblocking to avoid
+     * deadlocking ourselves upon handshake
+     */
+    do {
+        int rv;
+        if (!serverShake) {
+            rv = qcrypto_tls_session_handshake(serverSess,
+                                               &err);
+            g_assert(rv >= 0);
+            if (qcrypto_tls_session_get_handshake_status(serverSess) ==
+                QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
+                serverShake = true;
+            }
+        }
+        if (!clientShake) {
+            rv = qcrypto_tls_session_handshake(clientSess,
+                                               &err);
+            g_assert(rv >= 0);
+            if (qcrypto_tls_session_get_handshake_status(clientSess) ==
+                QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
+                clientShake = true;
+            }
+        }
+    } while (!clientShake && !serverShake);
+
+
+    /* Finally make sure the server & client validation is successful. */
+    g_assert(qcrypto_tls_session_check_credentials(serverSess, &err) == 0);
+    g_assert(qcrypto_tls_session_check_credentials(clientSess, &err) == 0);
+
+    object_unparent(OBJECT(serverCreds));
+    object_unparent(OBJECT(clientCreds));
+
+    qcrypto_tls_session_free(serverSess);
+    qcrypto_tls_session_free(clientSess);
+
+    close(channel[0]);
+    close(channel[1]);
+}
+
+
 struct QCryptoTLSSessionTestData {
     const char *servercacrt;
     const char *clientcacrt;
@@ -44,24 +190,10 @@ struct QCryptoTLSSessionTestData {
     const char *const *wildcards;
 };
 
-
-static ssize_t testWrite(const char *buf, size_t len, void *opaque)
-{
-    int *fd = opaque;
-
-    return write(*fd, buf, len);
-}
-
-static ssize_t testRead(char *buf, size_t len, void *opaque)
-{
-    int *fd = opaque;
-
-    return read(*fd, buf, len);
-}
-
-static QCryptoTLSCreds *test_tls_creds_create(QCryptoTLSCredsEndpoint endpoint,
-                                              const char *certdir,
-                                              Error **errp)
+static QCryptoTLSCreds *test_tls_creds_x509_create(
+    QCryptoTLSCredsEndpoint endpoint,
+    const char *certdir,
+    Error **errp)
 {
     Error *err = NULL;
     Object *parent = object_get_objects_root();
@@ -104,7 +236,7 @@ static QCryptoTLSCreds *test_tls_creds_create(QCryptoTLSCredsEndpoint endpoint,
  * initiate a TLS session across them. Finally do
  * do actual cert validation tests
  */
-static void test_crypto_tls_session(const void *opaque)
+static void test_crypto_tls_session_x509(const void *opaque)
 {
     struct QCryptoTLSSessionTestData *data =
         (struct QCryptoTLSSessionTestData *)opaque;
@@ -159,13 +291,13 @@ static void test_crypto_tls_session(const void *opaque)
     g_assert(link(KEYFILE,
                   CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY) == 0);
 
-    clientCreds = test_tls_creds_create(
+    clientCreds = test_tls_creds_x509_create(
         QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT,
         CLIENT_CERT_DIR,
         &err);
     g_assert(clientCreds != NULL);
 
-    serverCreds = test_tls_creds_create(
+    serverCreds = test_tls_creds_x509_create(
         QCRYPTO_TLS_CREDS_ENDPOINT_SERVER,
         SERVER_CERT_DIR,
         &err);
@@ -285,7 +417,13 @@ int main(int argc, char **argv)
     mkdir(WORKDIR, 0700);
 
     test_tls_init(KEYFILE);
+    test_tls_psk_init(PSKFILE);
 
+    /* Simple initial test using Pre-Shared Keys. */
+    g_test_add_func("/qcrypto/tlssession/psk",
+                    test_crypto_tls_session_psk);
+
+    /* More complex tests using X.509 certificates. */
 # define TEST_SESS_REG(name, caCrt,                                     \
                        serverCrt, clientCrt,                            \
                        expectServerFail, expectClientFail,              \
@@ -296,7 +434,7 @@ int main(int argc, char **argv)
         hostname, wildcards                                             \
     };                                                                  \
     g_test_add_data_func("/qcrypto/tlssession/" # name,                 \
-                         &name, test_crypto_tls_session);               \
+                         &name, test_crypto_tls_session_x509);          \
 
 
 # define TEST_SESS_REG_EXT(name, serverCaCrt, clientCaCrt,              \
@@ -309,7 +447,7 @@ int main(int argc, char **argv)
         hostname, wildcards                                             \
     };                                                                  \
     g_test_add_data_func("/qcrypto/tlssession/" # name,                 \
-                         &name, test_crypto_tls_session);               \
+                         &name, test_crypto_tls_session_x509);          \
 
     /* A perfect CA, perfect client & perfect server */
 
@@ -518,6 +656,7 @@ int main(int argc, char **argv)
     test_tls_discard_cert(&clientcertlevel2breq);
     unlink(WORKDIR "cacertchain-sess.pem");
 
+    test_tls_psk_cleanup(PSKFILE);
     test_tls_cleanup(KEYFILE);
     rmdir(WORKDIR);
 
-- 
2.17.1
