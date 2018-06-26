Received: from eggs.gnu.org ([2001:4830:134:3::10]:50559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fXlAj-0006TN-15
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:26:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rjones@redhat.com>) id 1fXlAf-00054z-8q
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:26:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rjones@redhat.com>) id 1fXlAf-00053I-04
	for qemu-devel@nongnu.org; Tue, 26 Jun 2018 06:26:01 -0400
Received: from smtp.corp.redhat.com (int-mx12.intmail.prod.int.phx2.redhat.com
	[10.5.11.27])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39A5B3082148
	for <qemu-devel@nongnu.org>; Tue, 26 Jun 2018 10:26:00 +0000 (UTC)
From: "Richard W.M. Jones" <rjones@redhat.com>
Date: Tue, 26 Jun 2018 11:25:54 +0100
Message-Id: <20180626102554.23290-2-rjones@redhat.com>
In-Reply-To: <20180626102554.23290-1-rjones@redhat.com>
References: <20180626102554.23290-1-rjones@redhat.com>
Subject: [Qemu-devel] [PATCH v2] crypto: Implement TLS Pre-Shared Keys (PSK).
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
 crypto/Makefile.objs         |   1 +
 crypto/tlscredspsk.c         | 300 +++++++++++++++++++++++++++++++++++++++++++
 crypto/tlssession.c          |  38 ++++++
 crypto/trace-events          |   3 +
 include/crypto/tlscredspsk.h | 106 +++++++++++++++
 qemu-doc.texi                |  37 ++++++
 qemu-options.hx              |  24 ++++
 7 files changed, 509 insertions(+)

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
index 0000000000..e9ec23b457
--- /dev/null
+++ b/crypto/tlscredspsk.c
@@ -0,0 +1,300 @@
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
+    FILE *fp;
+    char line[1024]; /* Maximum key length in psktool is 512 bytes. */
+    size_t ulen = strlen(username);
+    size_t len;
+
+    fp = fopen(pskfile, "r");
+    if (fp == NULL) {
+        error_setg_errno(errp, errno, "Cannot open PSK file %s", pskfile);
+        return -1;
+    }
+    while (fgets(line, sizeof line, fp) != NULL) {
+        if (strncmp(line, username, ulen) == 0 && line[ulen] == ':') {
+            len = strlen(line);
+            if (len > 0 && line[len - 1] == '\n') {
+                len--;
+                line[len] = '\0';
+            }
+            key->data = (unsigned char *) g_strdup(&line[ulen + 1]);
+            key->size = len - ulen - 1;
+            fclose(fp);
+            return 0;
+        }
+    }
+    fclose(fp);
+    error_setg(errp, "Username %s not found in PSK file %s",
+               username, pskfile);
+    return -1;
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
index 96a02deb69..aed754bb83 100644
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
@@ -162,6 +163,39 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,
                        gnutls_strerror(ret));
             goto error;
         }
+    } else if (object_dynamic_cast(OBJECT(creds),
+                                   TYPE_QCRYPTO_TLS_CREDS_PSK)) {
+        QCryptoTLSCredsPSK *pcreds = QCRYPTO_TLS_CREDS_PSK(creds);
+        char *prio;
+
+        if (creds->priority != NULL) {
+            prio = g_strdup_printf("%s:+PSK:+DHE-PSK", creds->priority);
+        } else {
+            prio = g_strdup(CONFIG_TLS_PRIORITY ":+PSK:+DHE-PSK");
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
@@ -353,6 +387,10 @@ qcrypto_tls_session_check_credentials(QCryptoTLSSession *session,
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
index 0000000000..6bc2158ea9
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
+ *             "endpoint": "client",
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
+ *  qemu-system-x86_64 -object tls-creds-psk,id=tlscreds0,\
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
index 282bc3dc35..a4f9373699 100644
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
index d5b0c26e8e..afc5e6528f 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4099,6 +4099,30 @@ expensive operation that consumes random pool entropy, so it is
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
+upfront and saved.
+
 @item -object tls-creds-x509,id=@var{id},endpoint=@var{endpoint},dir=@var{/path/to/cred/dir},priority=@var{priority},verify-peer=@var{on|off},passwordid=@var{id}
 
 Creates a TLS anonymous credentials object, which can be used to provide
-- 
2.16.2
