Received: from eggs.gnu.org ([2001:4830:134:3::10]:60413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fi0Qk-00030e-Db
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:45:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fi0Qi-00044n-L8
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:44:58 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33830 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fi0Qi-00044H-FW
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 12:44:56 -0400
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Date: Tue, 24 Jul 2018 17:44:47 +0100
Message-Id: <20180724164448.7606-4-berrange@redhat.com>
In-Reply-To: <20180724164448.7606-1-berrange@redhat.com>
References: <20180724164448.7606-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/4] tests: use error_abort in places expecting
 errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>, Peter Maydell <peter.maydell@linaro.org>

Most of the TLS related tests are passing an in a "Error" object to
methods that are expected to fail, but then ignoring any error that is
set and instead asserting on a return value. This means that when an
error is unexpectedly raised, no information about it is printed out,
making failures hard to diagnose. Changing these tests to pass in
&error_abort will make unexpected failures print messages to stderr.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
---
 tests/test-crypto-tlscredsx509.c | 11 +----
 tests/test-crypto-tlssession.c   | 76 ++++++++++++--------------------
 tests/test-io-channel-tls.c      | 24 ++++------
 3 files changed, 39 insertions(+), 72 deletions(-)

diff --git a/tests/test-crypto-tlscredsx509.c b/tests/test-crypto-tlscred=
sx509.c
index af2f80e89c..30f9ac4bbf 100644
--- a/tests/test-crypto-tlscredsx509.c
+++ b/tests/test-crypto-tlscredsx509.c
@@ -54,7 +54,7 @@ static QCryptoTLSCreds *test_tls_creds_create(QCryptoTL=
SCredsEndpoint endpoint,
         "sanity-check", "yes",
         NULL);
=20
-    if (*errp) {
+    if (!creds) {
         return NULL;
     }
     return QCRYPTO_TLS_CREDS(creds);
@@ -74,7 +74,6 @@ static void test_tls_creds(const void *opaque)
     struct QCryptoTLSCredsTestData *data =3D
         (struct QCryptoTLSCredsTestData *)opaque;
     QCryptoTLSCreds *creds;
-    Error *err =3D NULL;
=20
 #define CERT_DIR "tests/test-crypto-tlscredsx509-certs/"
     mkdir(CERT_DIR, 0700);
@@ -113,17 +112,11 @@ static void test_tls_creds(const void *opaque)
          QCRYPTO_TLS_CREDS_ENDPOINT_SERVER :
          QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT),
         CERT_DIR,
-        &err);
+        data->expectFail ? NULL : &error_abort);
=20
     if (data->expectFail) {
-        error_free(err);
         g_assert(creds =3D=3D NULL);
     } else {
-        if (err) {
-            g_printerr("Failed to generate creds: %s\n",
-                       error_get_pretty(err));
-            error_free(err);
-        }
         g_assert(creds !=3D NULL);
     }
=20
diff --git a/tests/test-crypto-tlssession.c b/tests/test-crypto-tlssessio=
n.c
index 7bd811796e..fd9acf9067 100644
--- a/tests/test-crypto-tlssession.c
+++ b/tests/test-crypto-tlssession.c
@@ -52,28 +52,21 @@ static ssize_t testRead(char *buf, size_t len, void *=
opaque)
=20
 static QCryptoTLSCreds *test_tls_creds_psk_create(
     QCryptoTLSCredsEndpoint endpoint,
-    const char *dir,
-    Error **errp)
+    const char *dir)
 {
-    Error *err =3D NULL;
     Object *parent =3D object_get_objects_root();
     Object *creds =3D object_new_with_props(
         TYPE_QCRYPTO_TLS_CREDS_PSK,
         parent,
         (endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SERVER ?
          "testtlscredsserver" : "testtlscredsclient"),
-        &err,
+        &error_abort,
         "endpoint", (endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SERVER ?
                      "server" : "client"),
         "dir", dir,
         "priority", "NORMAL",
         NULL
         );
-
-    if (err) {
-        error_propagate(errp, err);
-        return NULL;
-    }
     return QCRYPTO_TLS_CREDS(creds);
 }
=20
@@ -87,7 +80,6 @@ static void test_crypto_tls_session_psk(void)
     int channel[2];
     bool clientShake =3D false;
     bool serverShake =3D false;
-    Error *err =3D NULL;
     int ret;
=20
     /* We'll use this for our fake client-server connection */
@@ -104,25 +96,23 @@ static void test_crypto_tls_session_psk(void)
=20
     clientCreds =3D test_tls_creds_psk_create(
         QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT,
-        WORKDIR,
-        &err);
+        WORKDIR);
     g_assert(clientCreds !=3D NULL);
=20
     serverCreds =3D test_tls_creds_psk_create(
         QCRYPTO_TLS_CREDS_ENDPOINT_SERVER,
-        WORKDIR,
-        &err);
+        WORKDIR);
     g_assert(serverCreds !=3D NULL);
=20
     /* Now the real part of the test, setup the sessions */
     clientSess =3D qcrypto_tls_session_new(
         clientCreds, NULL, NULL,
-        QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT, &err);
+        QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT, &error_abort);
+    g_assert(clientSess !=3D NULL);
+
     serverSess =3D qcrypto_tls_session_new(
         serverCreds, NULL, NULL,
-        QCRYPTO_TLS_CREDS_ENDPOINT_SERVER, &err);
-
-    g_assert(clientSess !=3D NULL);
+        QCRYPTO_TLS_CREDS_ENDPOINT_SERVER, &error_abort);
     g_assert(serverSess !=3D NULL);
=20
     /* For handshake to work, we need to set the I/O callbacks
@@ -145,7 +135,7 @@ static void test_crypto_tls_session_psk(void)
         int rv;
         if (!serverShake) {
             rv =3D qcrypto_tls_session_handshake(serverSess,
-                                               &err);
+                                               &error_abort);
             g_assert(rv >=3D 0);
             if (qcrypto_tls_session_get_handshake_status(serverSess) =3D=
=3D
                 QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
@@ -154,7 +144,7 @@ static void test_crypto_tls_session_psk(void)
         }
         if (!clientShake) {
             rv =3D qcrypto_tls_session_handshake(clientSess,
-                                               &err);
+                                               &error_abort);
             g_assert(rv >=3D 0);
             if (qcrypto_tls_session_get_handshake_status(clientSess) =3D=
=3D
                 QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
@@ -165,8 +155,10 @@ static void test_crypto_tls_session_psk(void)
=20
=20
     /* Finally make sure the server & client validation is successful. *=
/
-    g_assert(qcrypto_tls_session_check_credentials(serverSess, &err) =3D=
=3D 0);
-    g_assert(qcrypto_tls_session_check_credentials(clientSess, &err) =3D=
=3D 0);
+    g_assert(qcrypto_tls_session_check_credentials(serverSess,
+                                                   &error_abort) =3D=3D =
0);
+    g_assert(qcrypto_tls_session_check_credentials(clientSess,
+                                                   &error_abort) =3D=3D =
0);
=20
     object_unparent(OBJECT(serverCreds));
     object_unparent(OBJECT(clientCreds));
@@ -192,17 +184,15 @@ struct QCryptoTLSSessionTestData {
=20
 static QCryptoTLSCreds *test_tls_creds_x509_create(
     QCryptoTLSCredsEndpoint endpoint,
-    const char *certdir,
-    Error **errp)
+    const char *certdir)
 {
-    Error *err =3D NULL;
     Object *parent =3D object_get_objects_root();
     Object *creds =3D object_new_with_props(
         TYPE_QCRYPTO_TLS_CREDS_X509,
         parent,
         (endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SERVER ?
          "testtlscredsserver" : "testtlscredsclient"),
-        &err,
+        &error_abort,
         "endpoint", (endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SERVER ?
                      "server" : "client"),
         "dir", certdir,
@@ -217,11 +207,6 @@ static QCryptoTLSCreds *test_tls_creds_x509_create(
         "sanity-check", "no",
         NULL
         );
-
-    if (err) {
-        error_propagate(errp, err);
-        return NULL;
-    }
     return QCRYPTO_TLS_CREDS(creds);
 }
=20
@@ -249,7 +234,6 @@ static void test_crypto_tls_session_x509(const void *=
opaque)
     int channel[2];
     bool clientShake =3D false;
     bool serverShake =3D false;
-    Error *err =3D NULL;
     int ret;
=20
     /* We'll use this for our fake client-server connection */
@@ -293,14 +277,12 @@ static void test_crypto_tls_session_x509(const void=
 *opaque)
=20
     clientCreds =3D test_tls_creds_x509_create(
         QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT,
-        CLIENT_CERT_DIR,
-        &err);
+        CLIENT_CERT_DIR);
     g_assert(clientCreds !=3D NULL);
=20
     serverCreds =3D test_tls_creds_x509_create(
         QCRYPTO_TLS_CREDS_ENDPOINT_SERVER,
-        SERVER_CERT_DIR,
-        &err);
+        SERVER_CERT_DIR);
     g_assert(serverCreds !=3D NULL);
=20
     acl =3D qemu_acl_init("tlssessionacl");
@@ -314,13 +296,13 @@ static void test_crypto_tls_session_x509(const void=
 *opaque)
     /* Now the real part of the test, setup the sessions */
     clientSess =3D qcrypto_tls_session_new(
         clientCreds, data->hostname, NULL,
-        QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT, &err);
+        QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT, &error_abort);
+    g_assert(clientSess !=3D NULL);
+
     serverSess =3D qcrypto_tls_session_new(
         serverCreds, NULL,
         data->wildcards ? "tlssessionacl" : NULL,
-        QCRYPTO_TLS_CREDS_ENDPOINT_SERVER, &err);
-
-    g_assert(clientSess !=3D NULL);
+        QCRYPTO_TLS_CREDS_ENDPOINT_SERVER, &error_abort);
     g_assert(serverSess !=3D NULL);
=20
     /* For handshake to work, we need to set the I/O callbacks
@@ -343,7 +325,7 @@ static void test_crypto_tls_session_x509(const void *=
opaque)
         int rv;
         if (!serverShake) {
             rv =3D qcrypto_tls_session_handshake(serverSess,
-                                               &err);
+                                               &error_abort);
             g_assert(rv >=3D 0);
             if (qcrypto_tls_session_get_handshake_status(serverSess) =3D=
=3D
                 QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
@@ -352,7 +334,7 @@ static void test_crypto_tls_session_x509(const void *=
opaque)
         }
         if (!clientShake) {
             rv =3D qcrypto_tls_session_handshake(clientSess,
-                                               &err);
+                                               &error_abort);
             g_assert(rv >=3D 0);
             if (qcrypto_tls_session_get_handshake_status(clientSess) =3D=
=3D
                 QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
@@ -365,10 +347,9 @@ static void test_crypto_tls_session_x509(const void =
*opaque)
     /* Finally make sure the server validation does what
      * we were expecting
      */
-    if (qcrypto_tls_session_check_credentials(serverSess, &err) < 0) {
+    if (qcrypto_tls_session_check_credentials(
+            serverSess, data->expectServerFail ? NULL : &error_abort) < =
0) {
         g_assert(data->expectServerFail);
-        error_free(err);
-        err =3D NULL;
     } else {
         g_assert(!data->expectServerFail);
     }
@@ -376,10 +357,9 @@ static void test_crypto_tls_session_x509(const void =
*opaque)
     /*
      * And the same for the client validation check
      */
-    if (qcrypto_tls_session_check_credentials(clientSess, &err) < 0) {
+    if (qcrypto_tls_session_check_credentials(
+            clientSess, data->expectClientFail ? NULL : &error_abort) < =
0) {
         g_assert(data->expectClientFail);
-        error_free(err);
-        err =3D NULL;
     } else {
         g_assert(!data->expectClientFail);
     }
diff --git a/tests/test-io-channel-tls.c b/tests/test-io-channel-tls.c
index bb88ee870f..4900c6d433 100644
--- a/tests/test-io-channel-tls.c
+++ b/tests/test-io-channel-tls.c
@@ -30,6 +30,7 @@
 #include "crypto/init.h"
 #include "crypto/tlscredsx509.h"
 #include "qemu/acl.h"
+#include "qapi/error.h"
 #include "qom/object_interfaces.h"
=20
 #ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
@@ -64,8 +65,7 @@ static void test_tls_handshake_done(QIOTask *task,
=20
=20
 static QCryptoTLSCreds *test_tls_creds_create(QCryptoTLSCredsEndpoint en=
dpoint,
-                                              const char *certdir,
-                                              Error **errp)
+                                              const char *certdir)
 {
     Object *parent =3D object_get_objects_root();
     Object *creds =3D object_new_with_props(
@@ -73,7 +73,7 @@ static QCryptoTLSCreds *test_tls_creds_create(QCryptoTL=
SCredsEndpoint endpoint,
         parent,
         (endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SERVER ?
          "testtlscredsserver" : "testtlscredsclient"),
-        errp,
+        &error_abort,
         "endpoint", (endpoint =3D=3D QCRYPTO_TLS_CREDS_ENDPOINT_SERVER ?
                      "server" : "client"),
         "dir", certdir,
@@ -89,9 +89,6 @@ static QCryptoTLSCreds *test_tls_creds_create(QCryptoTL=
SCredsEndpoint endpoint,
         NULL
         );
=20
-    if (*errp) {
-        return NULL;
-    }
     return QCRYPTO_TLS_CREDS(creds);
 }
=20
@@ -121,7 +118,6 @@ static void test_io_channel_tls(const void *opaque)
     int channel[2];
     struct QIOChannelTLSHandshakeData clientHandshake =3D { false, false=
 };
     struct QIOChannelTLSHandshakeData serverHandshake =3D { false, false=
 };
-    Error *err =3D NULL;
     QIOChannelTest *test;
     GMainContext *mainloop;
=20
@@ -157,14 +153,12 @@ static void test_io_channel_tls(const void *opaque)
=20
     clientCreds =3D test_tls_creds_create(
         QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT,
-        CLIENT_CERT_DIR,
-        &err);
+        CLIENT_CERT_DIR);
     g_assert(clientCreds !=3D NULL);
=20
     serverCreds =3D test_tls_creds_create(
         QCRYPTO_TLS_CREDS_ENDPOINT_SERVER,
-        SERVER_CERT_DIR,
-        &err);
+        SERVER_CERT_DIR);
     g_assert(serverCreds !=3D NULL);
=20
     acl =3D qemu_acl_init("channeltlsacl");
@@ -176,10 +170,10 @@ static void test_io_channel_tls(const void *opaque)
     }
=20
     clientChanSock =3D qio_channel_socket_new_fd(
-        channel[0], &err);
+        channel[0], &error_abort);
     g_assert(clientChanSock !=3D NULL);
     serverChanSock =3D qio_channel_socket_new_fd(
-        channel[1], &err);
+        channel[1], &error_abort);
     g_assert(serverChanSock !=3D NULL);
=20
     /*
@@ -193,12 +187,12 @@ static void test_io_channel_tls(const void *opaque)
     /* Now the real part of the test, setup the sessions */
     clientChanTLS =3D qio_channel_tls_new_client(
         QIO_CHANNEL(clientChanSock), clientCreds,
-        data->hostname, &err);
+        data->hostname, &error_abort);
     g_assert(clientChanTLS !=3D NULL);
=20
     serverChanTLS =3D qio_channel_tls_new_server(
         QIO_CHANNEL(serverChanSock), serverCreds,
-        "channeltlsacl", &err);
+        "channeltlsacl", &error_abort);
     g_assert(serverChanTLS !=3D NULL);
=20
     qio_channel_tls_handshake(clientChanTLS,
--=20
2.17.1
