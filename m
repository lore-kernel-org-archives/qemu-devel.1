Received: from eggs.gnu.org ([2001:4830:134:3::10]:40685)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1faK3g-0002cy-KZ
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:05:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1faK3Z-00079p-Cy
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:05:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43456 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1faK3Z-00079f-4r
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 08:05:17 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B7C41818533A
	for <qemu-devel@nongnu.org>; Tue,  3 Jul 2018 12:05:16 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue,  3 Jul 2018 13:05:12 +0100
Message-Id: <20180703120512.31648-2-berrange@redhat.com>
In-Reply-To: <20180703120512.31648-1-berrange@redhat.com>
References: <20180703120512.31648-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/1] crypto: Implement TLS Pre-Shared Keys (PSK).
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Richard Jones <rjones@redhat.com>, =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>

From: "Richard W.M. Jones" <rjones@redhat.com>

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
    --object tls-creds-psk,id=3Dtls0,dir=3D/tmp/keys,username=3Drjones,en=
dpoint=3Dclient \
    --image-opts \
    file.driver=3Dnbd,file.host=3Dlocalhost,file.port=3D10809,file.tls-cr=
eds=3Dtls0,file.export=3D/

Example NBD server using qemu-nbd:

  $ qemu-nbd -t -x / \
    --object tls-creds-psk,id=3Dtls0,endpoint=3Dserver,dir=3D/tmp/keys \
    --tls-creds tls0 \
    image.qcow2

Example NBD server using nbdkit:

  $ nbdkit -n -e / -fv \
    --tls=3Don --tls-psk=3D/tmp/keys/keys.psk \
    file file=3Ddisk.img

Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
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
 tests/test-crypto-tlssession.c | 179 ++++++++++++++++---
 11 files changed, 774 insertions(+), 23 deletions(-)
 create mode 100644 crypto/tlscredspsk.c
 create mode 100644 include/crypto/tlscredspsk.h
 create mode 100644 tests/crypto-tls-psk-helpers.c
 create mode 100644 tests/crypto-tls-psk-helpers.h

diff --git a/crypto/Makefile.objs b/crypto/Makefile.objs
index 2b99e08062..756bab111b 100644
--- a/crypto/Makefile.objs
+++ b/crypto/Makefile.objs
@@ -15,6 +15,7 @@ crypto-obj-$(CONFIG_AF_ALG) +=3D cipher-afalg.o
 crypto-obj-$(CONFIG_AF_ALG) +=3D hash-afalg.o
 crypto-obj-y +=3D tlscreds.o
 crypto-obj-y +=3D tlscredsanon.o
+crypto-obj-y +=3D tlscredspsk.o
 crypto-obj-y +=3D tlscredsx509.o
 crypto-obj-y +=3D tlssession.o
 crypto-obj-y +=3D secret.o
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
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
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
+lookup_key(const char *pskfile, const char *username, gnutls_datum_t *ke=
y,
+           Error **errp)
+{
+    const size_t ulen =3D strlen(username);
+    GError *gerr =3D NULL;
+    char *content =3D NULL;
+    char **lines =3D NULL;
+    size_t clen =3D 0, i;
+    int ret =3D -1;
+
+    if (!g_file_get_contents(pskfile, &content, &clen, &gerr)) {
+        error_setg(errp, "Cannot read PSK file %s: %s",
+                   pskfile, gerr->message);
+        g_error_free(gerr);
+        return -1;
+    }
+
+    lines =3D g_strsplit(content, "\n", -1);
+    for (i =3D 0; lines[i] !=3D NULL; ++i) {
+        if (strncmp(lines[i], username, ulen) =3D=3D 0 && lines[i][ulen]=
 =3D=3D ':') {
+            key->data =3D (unsigned char *) g_strdup(&lines[i][ulen + 1]=
);
+            key->size =3D strlen(lines[i]) - ulen - 1;
+            ret =3D 0;
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
+    char *pskfile =3D NULL, *dhparams =3D NULL;
+    const char *username;
+    int ret;
+    int rv =3D -1;
+    gnutls_datum_t key =3D { .data =3D NULL };
+
+    trace_qcrypto_tls_creds_psk_load(creds,
+            creds->parent_obj.dir ? creds->parent_obj.dir : "<nodir>");
+
+    if (creds->parent_obj.endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SER=
VER) {
+        if (creds->username) {
+            error_setg(errp, "username should not be set when endpoint=3D=
server");
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
+        ret =3D gnutls_psk_allocate_server_credentials(&creds->data.serv=
er);
+        if (ret < 0) {
+            error_setg(errp, "Cannot allocate credentials: %s",
+                       gnutls_strerror(ret));
+            goto cleanup;
+        }
+
+        if (qcrypto_tls_creds_get_dh_params_file(&creds->parent_obj, dhp=
arams,
+                                                 &creds->parent_obj.dh_p=
arams,
+                                                 errp) < 0) {
+            goto cleanup;
+        }
+
+        gnutls_psk_set_server_credentials_file(creds->data.server, pskfi=
le);
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
+            username =3D creds->username;
+        } else {
+            username =3D "qemu";
+        }
+        if (lookup_key(pskfile, username, &key, errp) !=3D 0) {
+            goto cleanup;
+        }
+
+        ret =3D gnutls_psk_allocate_client_credentials(&creds->data.clie=
nt);
+        if (ret < 0) {
+            error_setg(errp, "Cannot allocate credentials: %s",
+                       gnutls_strerror(ret));
+            goto cleanup;
+        }
+
+        gnutls_psk_set_client_credentials(creds->data.client,
+                                          username, &key, GNUTLS_PSK_KEY=
_HEX);
+    }
+
+    rv =3D 0;
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
+    if (creds->parent_obj.endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_CLI=
ENT) {
+        if (creds->data.client) {
+            gnutls_psk_free_client_credentials(creds->data.client);
+            creds->data.client =3D NULL;
+        }
+    } else {
+        if (creds->data.server) {
+            gnutls_psk_free_server_credentials(creds->data.server);
+            creds->data.server =3D NULL;
+        }
+    }
+    if (creds->parent_obj.dh_params) {
+        gnutls_dh_params_deinit(creds->parent_obj.dh_params);
+        creds->parent_obj.dh_params =3D NULL;
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
+    QCryptoTLSCredsPSK *creds =3D QCRYPTO_TLS_CREDS_PSK(obj);
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
+    QCryptoTLSCredsPSK *creds =3D QCRYPTO_TLS_CREDS_PSK(obj);
+
+    if (creds->parent_obj.endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SER=
VER) {
+        return creds->data.server !=3D NULL;
+    } else {
+        return creds->data.client !=3D NULL;
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
+    QCryptoTLSCredsPSK *creds =3D QCRYPTO_TLS_CREDS_PSK(obj);
+
+    qcrypto_tls_creds_psk_unload(creds);
+}
+
+static void
+qcrypto_tls_creds_psk_prop_set_username(Object *obj,
+                                        const char *value,
+                                        Error **errp G_GNUC_UNUSED)
+{
+    QCryptoTLSCredsPSK *creds =3D QCRYPTO_TLS_CREDS_PSK(obj);
+
+    creds->username =3D g_strdup(value);
+}
+
+
+static char *
+qcrypto_tls_creds_psk_prop_get_username(Object *obj,
+                                        Error **errp G_GNUC_UNUSED)
+{
+    QCryptoTLSCredsPSK *creds =3D QCRYPTO_TLS_CREDS_PSK(obj);
+
+    return g_strdup(creds->username);
+}
+
+static void
+qcrypto_tls_creds_psk_class_init(ObjectClass *oc, void *data)
+{
+    UserCreatableClass *ucc =3D USER_CREATABLE_CLASS(oc);
+
+    ucc->complete =3D qcrypto_tls_creds_psk_complete;
+
+    object_class_property_add_bool(oc, "loaded",
+                                   qcrypto_tls_creds_psk_prop_get_loaded=
,
+                                   qcrypto_tls_creds_psk_prop_set_loaded=
,
+                                   NULL);
+    object_class_property_add_str(oc, "username",
+                                  qcrypto_tls_creds_psk_prop_get_usernam=
e,
+                                  qcrypto_tls_creds_psk_prop_set_usernam=
e,
+                                  NULL);
+}
+
+
+static const TypeInfo qcrypto_tls_creds_psk_info =3D {
+    .parent =3D TYPE_QCRYPTO_TLS_CREDS,
+    .name =3D TYPE_QCRYPTO_TLS_CREDS_PSK,
+    .instance_size =3D sizeof(QCryptoTLSCredsPSK),
+    .instance_finalize =3D qcrypto_tls_creds_psk_finalize,
+    .class_size =3D sizeof(QCryptoTLSCredsPSKClass),
+    .class_init =3D qcrypto_tls_creds_psk_class_init,
+    .interfaces =3D (InterfaceInfo[]) {
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
@@ -88,6 +89,14 @@ qcrypto_tls_session_pull(void *opaque, void *buf, size=
_t len)
     return session->readFunc(buf, len, session->opaque);
 }
=20
+#define TLS_PRIORITY_ADDITIONAL_ANON "+ANON-DH"
+
+#if GNUTLS_VERSION_MAJOR >=3D 3
+#define TLS_ECDHE_PSK "+ECDHE-PSK:"
+#else
+#define TLS_ECDHE_PSK ""
+#endif
+#define TLS_PRIORITY_ADDITIONAL_PSK TLS_ECDHE_PSK "+DHE-PSK:+PSK"
=20
 QCryptoTLSSession *
 qcrypto_tls_session_new(QCryptoTLSCreds *creds,
@@ -135,9 +144,12 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,
         char *prio;
=20
         if (creds->priority !=3D NULL) {
-            prio =3D g_strdup_printf("%s:+ANON-DH", creds->priority);
+            prio =3D g_strdup_printf("%s:%s",
+                                   creds->priority,
+                                   TLS_PRIORITY_ADDITIONAL_ANON);
         } else {
-            prio =3D g_strdup(CONFIG_TLS_PRIORITY ":+ANON-DH");
+            prio =3D g_strdup(CONFIG_TLS_PRIORITY ":"
+                            TLS_PRIORITY_ADDITIONAL_ANON);
         }
=20
         ret =3D gnutls_priority_set_direct(session->handle, prio, NULL);
@@ -162,6 +174,42 @@ qcrypto_tls_session_new(QCryptoTLSCreds *creds,
                        gnutls_strerror(ret));
             goto error;
         }
+    } else if (object_dynamic_cast(OBJECT(creds),
+                                   TYPE_QCRYPTO_TLS_CREDS_PSK)) {
+        QCryptoTLSCredsPSK *pcreds =3D QCRYPTO_TLS_CREDS_PSK(creds);
+        char *prio;
+
+        if (creds->priority !=3D NULL) {
+            prio =3D g_strdup_printf("%s:%s",
+                                   creds->priority,
+                                   TLS_PRIORITY_ADDITIONAL_PSK);
+        } else {
+            prio =3D g_strdup(CONFIG_TLS_PRIORITY ":"
+                            TLS_PRIORITY_ADDITIONAL_PSK);
+        }
+
+        ret =3D gnutls_priority_set_direct(session->handle, prio, NULL);
+        if (ret < 0) {
+            error_setg(errp, "Unable to set TLS session priority %s: %s"=
,
+                       prio, gnutls_strerror(ret));
+            g_free(prio);
+            goto error;
+        }
+        g_free(prio);
+        if (creds->endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SERVER) {
+            ret =3D gnutls_credentials_set(session->handle,
+                                         GNUTLS_CRD_PSK,
+                                         pcreds->data.server);
+        } else {
+            ret =3D gnutls_credentials_set(session->handle,
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
         QCryptoTLSCredsX509 *tcreds =3D QCRYPTO_TLS_CREDS_X509(creds);
@@ -353,6 +401,10 @@ qcrypto_tls_session_check_credentials(QCryptoTLSSess=
ion *session,
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
@@ -7,6 +7,9 @@ qcrypto_tls_creds_get_path(void *creds, const char *filen=
ame, const char *path)
 # crypto/tlscredsanon.c
 qcrypto_tls_creds_anon_load(void *creds, const char *dir) "TLS creds ano=
n load creds=3D%p dir=3D%s"
=20
+# crypto/tlscredspsk.c
+qcrypto_tls_creds_psk_load(void *creds, const char *dir) "TLS creds psk =
load creds=3D%p dir=3D%s"
+
 # crypto/tlscredsx509.c
 qcrypto_tls_creds_x509_load(void *creds, const char *dir) "TLS creds x50=
9 load creds=3D%p dir=3D%s"
 qcrypto_tls_creds_x509_check_basic_constraints(void *creds, const char *=
file, int status) "TLS creds x509 check basic constraints creds=3D%p file=
=3D%s status=3D%d"
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
+ * License along with this library; if not, see <http://www.gnu.org/lice=
nses/>.
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
+ *   Error *err =3D NULL;
+ *   obj =3D object_new_propv(TYPE_QCRYPTO_TLS_CREDS_PSK,
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
+ *  qemu-system-x86_64 --object tls-creds-psk,id=3Dtlscreds0,\
+ *          endpoint=3Dclient,dir=3D/path/to/dir[,username=3Dqemu]
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
@@ -1262,6 +1262,7 @@ The recommendation is for the server to keep its ce=
rtificates in either
 * tls_generate_server::
 * tls_generate_client::
 * tls_creds_setup::
+* tls_psk::
 @end menu
 @node tls_generate_ca
 @subsection Setup the Certificate Authority
@@ -1510,6 +1511,42 @@ example with VNC:
 $QEMU -vnc 0.0.0.0:0,tls-creds=3Dtls0
 @end example
=20
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
+  --object tls-creds-psk,id=3Dtls0,endpoint=3Dserver,dir=3D/tmp/keys \
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
+  --object tls-creds-psk,id=3Dtls0,dir=3D/tmp/keys,username=3Drich,endpo=
int=3Dclient \
+  --image-opts \
+  file.driver=3Dnbd,file.host=3Dlocalhost,file.port=3D10809,file.tls-cre=
ds=3Dtls0,file.export=3D/
+@end example
+
 @node gdb_usage
 @section GDB usage
=20
diff --git a/qemu-options.hx b/qemu-options.hx
index 81b1e99d58..16208f63f2 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4123,6 +4123,30 @@ expensive operation that consumes random pool entr=
opy, so it is
 recommended that a persistent set of parameters be generated
 upfront and saved.
=20
+@item -object tls-creds-psk,id=3D@var{id},endpoint=3D@var{endpoint},dir=3D=
@var{/path/to/keys/dir}[,username=3D@var{username}]
+
+Creates a TLS Pre-Shared Keys (PSK) credentials object, which can be use=
d to provide
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
 @item -object tls-creds-x509,id=3D@var{id},endpoint=3D@var{endpoint},dir=
=3D@var{/path/to/cred/dir},priority=3D@var{priority},verify-peer=3D@var{o=
n|off},passwordid=3D@var{id}
=20
 Creates a TLS anonymous credentials object, which can be used to provide
diff --git a/tests/Makefile.include b/tests/Makefile.include
index e8bb2d8f66..8859e88ffb 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -723,7 +723,9 @@ tests/test-crypto-tlscredsx509$(EXESUF): tests/test-c=
rypto-tlscredsx509.o \
=20
 tests/test-crypto-tlssession.o-cflags :=3D $(TASN1_CFLAGS)
 tests/test-crypto-tlssession$(EXESUF): tests/test-crypto-tlssession.o \
-	tests/crypto-tls-x509-helpers.o tests/pkix_asn1_tab.o $(test-crypto-obj=
-y)
+	tests/crypto-tls-x509-helpers.o tests/pkix_asn1_tab.o \
+	tests/crypto-tls-psk-helpers.o \
+        $(test-crypto-obj-y)
 tests/test-util-sockets$(EXESUF): tests/test-util-sockets.o \
 	tests/socket-helpers.o $(test-util-obj-y)
 tests/test-io-task$(EXESUF): tests/test-io-task.o $(test-io-obj-y)
diff --git a/tests/crypto-tls-psk-helpers.c b/tests/crypto-tls-psk-helper=
s.c
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
+/* Include this first because it defines QCRYPTO_HAVE_TLS_TEST_SUPPORT *=
/
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
+    fp =3D fopen(pskfile, "w");
+    if (fp =3D=3D NULL) {
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
diff --git a/tests/crypto-tls-psk-helpers.h b/tests/crypto-tls-psk-helper=
s.h
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
diff --git a/tests/test-crypto-tlssession.c b/tests/test-crypto-tlssessio=
n.c
index 82f21c27f2..7bd811796e 100644
--- a/tests/test-crypto-tlssession.c
+++ b/tests/test-crypto-tlssession.c
@@ -21,7 +21,9 @@
 #include "qemu/osdep.h"
=20
 #include "crypto-tls-x509-helpers.h"
+#include "crypto-tls-psk-helpers.h"
 #include "crypto/tlscredsx509.h"
+#include "crypto/tlscredspsk.h"
 #include "crypto/tlssession.h"
 #include "qom/object_interfaces.h"
 #include "qapi/error.h"
@@ -31,20 +33,9 @@
 #ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
=20
 #define WORKDIR "tests/test-crypto-tlssession-work/"
+#define PSKFILE WORKDIR "keys.psk"
 #define KEYFILE WORKDIR "key-ctx.pem"
=20
-struct QCryptoTLSSessionTestData {
-    const char *servercacrt;
-    const char *clientcacrt;
-    const char *servercrt;
-    const char *clientcrt;
-    bool expectServerFail;
-    bool expectClientFail;
-    const char *hostname;
-    const char *const *wildcards;
-};
-
-
 static ssize_t testWrite(const char *buf, size_t len, void *opaque)
 {
     int *fd =3D opaque;
@@ -59,9 +50,150 @@ static ssize_t testRead(char *buf, size_t len, void *=
opaque)
     return read(*fd, buf, len);
 }
=20
-static QCryptoTLSCreds *test_tls_creds_create(QCryptoTLSCredsEndpoint en=
dpoint,
-                                              const char *certdir,
-                                              Error **errp)
+static QCryptoTLSCreds *test_tls_creds_psk_create(
+    QCryptoTLSCredsEndpoint endpoint,
+    const char *dir,
+    Error **errp)
+{
+    Error *err =3D NULL;
+    Object *parent =3D object_get_objects_root();
+    Object *creds =3D object_new_with_props(
+        TYPE_QCRYPTO_TLS_CREDS_PSK,
+        parent,
+        (endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SERVER ?
+         "testtlscredsserver" : "testtlscredsclient"),
+        &err,
+        "endpoint", (endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SERVER ?
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
+    QCryptoTLSSession *clientSess =3D NULL;
+    QCryptoTLSSession *serverSess =3D NULL;
+    int channel[2];
+    bool clientShake =3D false;
+    bool serverShake =3D false;
+    Error *err =3D NULL;
+    int ret;
+
+    /* We'll use this for our fake client-server connection */
+    ret =3D socketpair(AF_UNIX, SOCK_STREAM, 0, channel);
+    g_assert(ret =3D=3D 0);
+
+    /*
+     * We have an evil loop to do the handshake in a single
+     * thread, so we need these non-blocking to avoid deadlock
+     * of ourselves
+     */
+    qemu_set_nonblock(channel[0]);
+    qemu_set_nonblock(channel[1]);
+
+    clientCreds =3D test_tls_creds_psk_create(
+        QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT,
+        WORKDIR,
+        &err);
+    g_assert(clientCreds !=3D NULL);
+
+    serverCreds =3D test_tls_creds_psk_create(
+        QCRYPTO_TLS_CREDS_ENDPOINT_SERVER,
+        WORKDIR,
+        &err);
+    g_assert(serverCreds !=3D NULL);
+
+    /* Now the real part of the test, setup the sessions */
+    clientSess =3D qcrypto_tls_session_new(
+        clientCreds, NULL, NULL,
+        QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT, &err);
+    serverSess =3D qcrypto_tls_session_new(
+        serverCreds, NULL, NULL,
+        QCRYPTO_TLS_CREDS_ENDPOINT_SERVER, &err);
+
+    g_assert(clientSess !=3D NULL);
+    g_assert(serverSess !=3D NULL);
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
+            rv =3D qcrypto_tls_session_handshake(serverSess,
+                                               &err);
+            g_assert(rv >=3D 0);
+            if (qcrypto_tls_session_get_handshake_status(serverSess) =3D=
=3D
+                QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
+                serverShake =3D true;
+            }
+        }
+        if (!clientShake) {
+            rv =3D qcrypto_tls_session_handshake(clientSess,
+                                               &err);
+            g_assert(rv >=3D 0);
+            if (qcrypto_tls_session_get_handshake_status(clientSess) =3D=
=3D
+                QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
+                clientShake =3D true;
+            }
+        }
+    } while (!clientShake && !serverShake);
+
+
+    /* Finally make sure the server & client validation is successful. *=
/
+    g_assert(qcrypto_tls_session_check_credentials(serverSess, &err) =3D=
=3D 0);
+    g_assert(qcrypto_tls_session_check_credentials(clientSess, &err) =3D=
=3D 0);
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
+struct QCryptoTLSSessionTestData {
+    const char *servercacrt;
+    const char *clientcacrt;
+    const char *servercrt;
+    const char *clientcrt;
+    bool expectServerFail;
+    bool expectClientFail;
+    const char *hostname;
+    const char *const *wildcards;
+};
+
+static QCryptoTLSCreds *test_tls_creds_x509_create(
+    QCryptoTLSCredsEndpoint endpoint,
+    const char *certdir,
+    Error **errp)
 {
     Error *err =3D NULL;
     Object *parent =3D object_get_objects_root();
@@ -104,7 +236,7 @@ static QCryptoTLSCreds *test_tls_creds_create(QCrypto=
TLSCredsEndpoint endpoint,
  * initiate a TLS session across them. Finally do
  * do actual cert validation tests
  */
-static void test_crypto_tls_session(const void *opaque)
+static void test_crypto_tls_session_x509(const void *opaque)
 {
     struct QCryptoTLSSessionTestData *data =3D
         (struct QCryptoTLSSessionTestData *)opaque;
@@ -159,13 +291,13 @@ static void test_crypto_tls_session(const void *opa=
que)
     g_assert(link(KEYFILE,
                   CLIENT_CERT_DIR QCRYPTO_TLS_CREDS_X509_CLIENT_KEY) =3D=
=3D 0);
=20
-    clientCreds =3D test_tls_creds_create(
+    clientCreds =3D test_tls_creds_x509_create(
         QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT,
         CLIENT_CERT_DIR,
         &err);
     g_assert(clientCreds !=3D NULL);
=20
-    serverCreds =3D test_tls_creds_create(
+    serverCreds =3D test_tls_creds_x509_create(
         QCRYPTO_TLS_CREDS_ENDPOINT_SERVER,
         SERVER_CERT_DIR,
         &err);
@@ -285,7 +417,13 @@ int main(int argc, char **argv)
     mkdir(WORKDIR, 0700);
=20
     test_tls_init(KEYFILE);
+    test_tls_psk_init(PSKFILE);
+
+    /* Simple initial test using Pre-Shared Keys. */
+    g_test_add_func("/qcrypto/tlssession/psk",
+                    test_crypto_tls_session_psk);
=20
+    /* More complex tests using X.509 certificates. */
 # define TEST_SESS_REG(name, caCrt,                                     =
\
                        serverCrt, clientCrt,                            =
\
                        expectServerFail, expectClientFail,              =
\
@@ -296,7 +434,7 @@ int main(int argc, char **argv)
         hostname, wildcards                                             =
\
     };                                                                  =
\
     g_test_add_data_func("/qcrypto/tlssession/" # name,                 =
\
-                         &name, test_crypto_tls_session);               =
\
+                         &name, test_crypto_tls_session_x509);          =
\
=20
=20
 # define TEST_SESS_REG_EXT(name, serverCaCrt, clientCaCrt,              =
\
@@ -309,7 +447,7 @@ int main(int argc, char **argv)
         hostname, wildcards                                             =
\
     };                                                                  =
\
     g_test_add_data_func("/qcrypto/tlssession/" # name,                 =
\
-                         &name, test_crypto_tls_session);               =
\
+                         &name, test_crypto_tls_session_x509);          =
\
=20
     /* A perfect CA, perfect client & perfect server */
=20
@@ -518,6 +656,7 @@ int main(int argc, char **argv)
     test_tls_discard_cert(&clientcertlevel2breq);
     unlink(WORKDIR "cacertchain-sess.pem");
=20
+    test_tls_psk_cleanup(PSKFILE);
     test_tls_cleanup(KEYFILE);
     rmdir(WORKDIR);
=20
--=20
2.17.1
