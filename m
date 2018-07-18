Received: from eggs.gnu.org ([2001:4830:134:3::10]:47018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffmnS-0003Ha-1o
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:47:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffmnN-0005er-29
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:47:14 -0400
Received: from mail-vk0-x244.google.com ([2607:f8b0:400c:c05::244]:43374)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffmnM-0005eb-R1
	for qemu-devel@nongnu.org; Wed, 18 Jul 2018 09:47:08 -0400
Received: by mail-vk0-x244.google.com with SMTP id s17-v6so2509495vke.10
	for <qemu-devel@nongnu.org>; Wed, 18 Jul 2018 06:47:08 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180718093815.8104-1-berrange@redhat.com>
	<20180718093815.8104-4-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <80e397c9-e77e-4e3d-04c6-8b90df9cfb30@amsat.org>
Date: Wed, 18 Jul 2018 10:47:04 -0300
MIME-Version: 1.0
In-Reply-To: <20180718093815.8104-4-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for 3.0 3/4] tests: use error_abort in
 places expecting errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "=?UTF-8?Q?Daniel_P._Berrang=c3=a9?=" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 07/18/2018 06:38 AM, Daniel P. Berrangé wrote:
> Most of the TLS related tests are passing an in a "Error" object to
> methods that are expected to fail, but then ignoring any error that is
> set and instead asserting on a return value. This means that when an
> error is unexpectedly raised, no information about it is printed out,
> making failures hard to diagnose. Changing these tests to pass in
> &error_abort will make unexpected failures print messages to stderr.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  tests/test-crypto-tlscredsx509.c | 11 +----
>  tests/test-crypto-tlssession.c   | 76 ++++++++++++--------------------
>  tests/test-io-channel-tls.c      | 24 ++++------
>  3 files changed, 39 insertions(+), 72 deletions(-)
> 
> diff --git a/tests/test-crypto-tlscredsx509.c b/tests/test-crypto-tlscredsx509.c
> index af2f80e89c..30f9ac4bbf 100644
> --- a/tests/test-crypto-tlscredsx509.c
> +++ b/tests/test-crypto-tlscredsx509.c
> @@ -54,7 +54,7 @@ static QCryptoTLSCreds *test_tls_creds_create(QCryptoTLSCredsEndpoint endpoint,
>          "sanity-check", "yes",
>          NULL);
>  
> -    if (*errp) {
> +    if (!creds) {
>          return NULL;
>      }
>      return QCRYPTO_TLS_CREDS(creds);
> @@ -74,7 +74,6 @@ static void test_tls_creds(const void *opaque)
>      struct QCryptoTLSCredsTestData *data =
>          (struct QCryptoTLSCredsTestData *)opaque;
>      QCryptoTLSCreds *creds;
> -    Error *err = NULL;
>  
>  #define CERT_DIR "tests/test-crypto-tlscredsx509-certs/"
>      mkdir(CERT_DIR, 0700);
> @@ -113,17 +112,11 @@ static void test_tls_creds(const void *opaque)
>           QCRYPTO_TLS_CREDS_ENDPOINT_SERVER :
>           QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT),
>          CERT_DIR,
> -        &err);
> +        data->expectFail ? NULL : &error_abort);
>  
>      if (data->expectFail) {
> -        error_free(err);
>          g_assert(creds == NULL);
>      } else {
> -        if (err) {
> -            g_printerr("Failed to generate creds: %s\n",
> -                       error_get_pretty(err));
> -            error_free(err);
> -        }
>          g_assert(creds != NULL);
>      }
>  
> diff --git a/tests/test-crypto-tlssession.c b/tests/test-crypto-tlssession.c
> index 7bd811796e..fd9acf9067 100644
> --- a/tests/test-crypto-tlssession.c
> +++ b/tests/test-crypto-tlssession.c
> @@ -52,28 +52,21 @@ static ssize_t testRead(char *buf, size_t len, void *opaque)
>  
>  static QCryptoTLSCreds *test_tls_creds_psk_create(
>      QCryptoTLSCredsEndpoint endpoint,
> -    const char *dir,
> -    Error **errp)
> +    const char *dir)
>  {
> -    Error *err = NULL;
>      Object *parent = object_get_objects_root();
>      Object *creds = object_new_with_props(
>          TYPE_QCRYPTO_TLS_CREDS_PSK,
>          parent,
>          (endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER ?
>           "testtlscredsserver" : "testtlscredsclient"),
> -        &err,
> +        &error_abort,
>          "endpoint", (endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER ?
>                       "server" : "client"),
>          "dir", dir,
>          "priority", "NORMAL",
>          NULL
>          );
> -
> -    if (err) {
> -        error_propagate(errp, err);
> -        return NULL;
> -    }
>      return QCRYPTO_TLS_CREDS(creds);
>  }
>  
> @@ -87,7 +80,6 @@ static void test_crypto_tls_session_psk(void)
>      int channel[2];
>      bool clientShake = false;
>      bool serverShake = false;
> -    Error *err = NULL;
>      int ret;
>  
>      /* We'll use this for our fake client-server connection */
> @@ -104,25 +96,23 @@ static void test_crypto_tls_session_psk(void)
>  
>      clientCreds = test_tls_creds_psk_create(
>          QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT,
> -        WORKDIR,
> -        &err);
> +        WORKDIR);
>      g_assert(clientCreds != NULL);
>  
>      serverCreds = test_tls_creds_psk_create(
>          QCRYPTO_TLS_CREDS_ENDPOINT_SERVER,
> -        WORKDIR,
> -        &err);
> +        WORKDIR);
>      g_assert(serverCreds != NULL);
>  
>      /* Now the real part of the test, setup the sessions */
>      clientSess = qcrypto_tls_session_new(
>          clientCreds, NULL, NULL,
> -        QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT, &err);
> +        QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT, &error_abort);
> +    g_assert(clientSess != NULL);
> +
>      serverSess = qcrypto_tls_session_new(
>          serverCreds, NULL, NULL,
> -        QCRYPTO_TLS_CREDS_ENDPOINT_SERVER, &err);
> -
> -    g_assert(clientSess != NULL);
> +        QCRYPTO_TLS_CREDS_ENDPOINT_SERVER, &error_abort);
>      g_assert(serverSess != NULL);
>  
>      /* For handshake to work, we need to set the I/O callbacks
> @@ -145,7 +135,7 @@ static void test_crypto_tls_session_psk(void)
>          int rv;
>          if (!serverShake) {
>              rv = qcrypto_tls_session_handshake(serverSess,
> -                                               &err);
> +                                               &error_abort);
>              g_assert(rv >= 0);
>              if (qcrypto_tls_session_get_handshake_status(serverSess) ==
>                  QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
> @@ -154,7 +144,7 @@ static void test_crypto_tls_session_psk(void)
>          }
>          if (!clientShake) {
>              rv = qcrypto_tls_session_handshake(clientSess,
> -                                               &err);
> +                                               &error_abort);
>              g_assert(rv >= 0);
>              if (qcrypto_tls_session_get_handshake_status(clientSess) ==
>                  QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
> @@ -165,8 +155,10 @@ static void test_crypto_tls_session_psk(void)
>  
>  
>      /* Finally make sure the server & client validation is successful. */
> -    g_assert(qcrypto_tls_session_check_credentials(serverSess, &err) == 0);
> -    g_assert(qcrypto_tls_session_check_credentials(clientSess, &err) == 0);
> +    g_assert(qcrypto_tls_session_check_credentials(serverSess,
> +                                                   &error_abort) == 0);
> +    g_assert(qcrypto_tls_session_check_credentials(clientSess,
> +                                                   &error_abort) == 0);
>  
>      object_unparent(OBJECT(serverCreds));
>      object_unparent(OBJECT(clientCreds));
> @@ -192,17 +184,15 @@ struct QCryptoTLSSessionTestData {
>  
>  static QCryptoTLSCreds *test_tls_creds_x509_create(
>      QCryptoTLSCredsEndpoint endpoint,
> -    const char *certdir,
> -    Error **errp)
> +    const char *certdir)
>  {
> -    Error *err = NULL;
>      Object *parent = object_get_objects_root();
>      Object *creds = object_new_with_props(
>          TYPE_QCRYPTO_TLS_CREDS_X509,
>          parent,
>          (endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER ?
>           "testtlscredsserver" : "testtlscredsclient"),
> -        &err,
> +        &error_abort,
>          "endpoint", (endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER ?
>                       "server" : "client"),
>          "dir", certdir,
> @@ -217,11 +207,6 @@ static QCryptoTLSCreds *test_tls_creds_x509_create(
>          "sanity-check", "no",
>          NULL
>          );
> -
> -    if (err) {
> -        error_propagate(errp, err);
> -        return NULL;
> -    }
>      return QCRYPTO_TLS_CREDS(creds);
>  }
>  
> @@ -249,7 +234,6 @@ static void test_crypto_tls_session_x509(const void *opaque)
>      int channel[2];
>      bool clientShake = false;
>      bool serverShake = false;
> -    Error *err = NULL;
>      int ret;
>  
>      /* We'll use this for our fake client-server connection */
> @@ -293,14 +277,12 @@ static void test_crypto_tls_session_x509(const void *opaque)
>  
>      clientCreds = test_tls_creds_x509_create(
>          QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT,
> -        CLIENT_CERT_DIR,
> -        &err);
> +        CLIENT_CERT_DIR);
>      g_assert(clientCreds != NULL);
>  
>      serverCreds = test_tls_creds_x509_create(
>          QCRYPTO_TLS_CREDS_ENDPOINT_SERVER,
> -        SERVER_CERT_DIR,
> -        &err);
> +        SERVER_CERT_DIR);
>      g_assert(serverCreds != NULL);
>  
>      acl = qemu_acl_init("tlssessionacl");
> @@ -314,13 +296,13 @@ static void test_crypto_tls_session_x509(const void *opaque)
>      /* Now the real part of the test, setup the sessions */
>      clientSess = qcrypto_tls_session_new(
>          clientCreds, data->hostname, NULL,
> -        QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT, &err);
> +        QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT, &error_abort);
> +    g_assert(clientSess != NULL);
> +
>      serverSess = qcrypto_tls_session_new(
>          serverCreds, NULL,
>          data->wildcards ? "tlssessionacl" : NULL,
> -        QCRYPTO_TLS_CREDS_ENDPOINT_SERVER, &err);
> -
> -    g_assert(clientSess != NULL);
> +        QCRYPTO_TLS_CREDS_ENDPOINT_SERVER, &error_abort);
>      g_assert(serverSess != NULL);
>  
>      /* For handshake to work, we need to set the I/O callbacks
> @@ -343,7 +325,7 @@ static void test_crypto_tls_session_x509(const void *opaque)
>          int rv;
>          if (!serverShake) {
>              rv = qcrypto_tls_session_handshake(serverSess,
> -                                               &err);
> +                                               &error_abort);
>              g_assert(rv >= 0);
>              if (qcrypto_tls_session_get_handshake_status(serverSess) ==
>                  QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
> @@ -352,7 +334,7 @@ static void test_crypto_tls_session_x509(const void *opaque)
>          }
>          if (!clientShake) {
>              rv = qcrypto_tls_session_handshake(clientSess,
> -                                               &err);
> +                                               &error_abort);
>              g_assert(rv >= 0);
>              if (qcrypto_tls_session_get_handshake_status(clientSess) ==
>                  QCRYPTO_TLS_HANDSHAKE_COMPLETE) {
> @@ -365,10 +347,9 @@ static void test_crypto_tls_session_x509(const void *opaque)
>      /* Finally make sure the server validation does what
>       * we were expecting
>       */
> -    if (qcrypto_tls_session_check_credentials(serverSess, &err) < 0) {
> +    if (qcrypto_tls_session_check_credentials(
> +            serverSess, data->expectServerFail ? NULL : &error_abort) < 0) {
>          g_assert(data->expectServerFail);
> -        error_free(err);
> -        err = NULL;
>      } else {
>          g_assert(!data->expectServerFail);
>      }
> @@ -376,10 +357,9 @@ static void test_crypto_tls_session_x509(const void *opaque)
>      /*
>       * And the same for the client validation check
>       */
> -    if (qcrypto_tls_session_check_credentials(clientSess, &err) < 0) {
> +    if (qcrypto_tls_session_check_credentials(
> +            clientSess, data->expectClientFail ? NULL : &error_abort) < 0) {
>          g_assert(data->expectClientFail);
> -        error_free(err);
> -        err = NULL;
>      } else {
>          g_assert(!data->expectClientFail);
>      }
> diff --git a/tests/test-io-channel-tls.c b/tests/test-io-channel-tls.c
> index bb88ee870f..4900c6d433 100644
> --- a/tests/test-io-channel-tls.c
> +++ b/tests/test-io-channel-tls.c
> @@ -30,6 +30,7 @@
>  #include "crypto/init.h"
>  #include "crypto/tlscredsx509.h"
>  #include "qemu/acl.h"
> +#include "qapi/error.h"
>  #include "qom/object_interfaces.h"
>  
>  #ifdef QCRYPTO_HAVE_TLS_TEST_SUPPORT
> @@ -64,8 +65,7 @@ static void test_tls_handshake_done(QIOTask *task,
>  
>  
>  static QCryptoTLSCreds *test_tls_creds_create(QCryptoTLSCredsEndpoint endpoint,
> -                                              const char *certdir,
> -                                              Error **errp)
> +                                              const char *certdir)
>  {
>      Object *parent = object_get_objects_root();
>      Object *creds = object_new_with_props(
> @@ -73,7 +73,7 @@ static QCryptoTLSCreds *test_tls_creds_create(QCryptoTLSCredsEndpoint endpoint,
>          parent,
>          (endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER ?
>           "testtlscredsserver" : "testtlscredsclient"),
> -        errp,
> +        &error_abort,
>          "endpoint", (endpoint == QCRYPTO_TLS_CREDS_ENDPOINT_SERVER ?
>                       "server" : "client"),
>          "dir", certdir,
> @@ -89,9 +89,6 @@ static QCryptoTLSCreds *test_tls_creds_create(QCryptoTLSCredsEndpoint endpoint,
>          NULL
>          );
>  
> -    if (*errp) {
> -        return NULL;
> -    }
>      return QCRYPTO_TLS_CREDS(creds);
>  }
>  
> @@ -121,7 +118,6 @@ static void test_io_channel_tls(const void *opaque)
>      int channel[2];
>      struct QIOChannelTLSHandshakeData clientHandshake = { false, false };
>      struct QIOChannelTLSHandshakeData serverHandshake = { false, false };
> -    Error *err = NULL;
>      QIOChannelTest *test;
>      GMainContext *mainloop;
>  
> @@ -157,14 +153,12 @@ static void test_io_channel_tls(const void *opaque)
>  
>      clientCreds = test_tls_creds_create(
>          QCRYPTO_TLS_CREDS_ENDPOINT_CLIENT,
> -        CLIENT_CERT_DIR,
> -        &err);
> +        CLIENT_CERT_DIR);
>      g_assert(clientCreds != NULL);
>  
>      serverCreds = test_tls_creds_create(
>          QCRYPTO_TLS_CREDS_ENDPOINT_SERVER,
> -        SERVER_CERT_DIR,
> -        &err);
> +        SERVER_CERT_DIR);
>      g_assert(serverCreds != NULL);
>  
>      acl = qemu_acl_init("channeltlsacl");
> @@ -176,10 +170,10 @@ static void test_io_channel_tls(const void *opaque)
>      }
>  
>      clientChanSock = qio_channel_socket_new_fd(
> -        channel[0], &err);
> +        channel[0], &error_abort);
>      g_assert(clientChanSock != NULL);
>      serverChanSock = qio_channel_socket_new_fd(
> -        channel[1], &err);
> +        channel[1], &error_abort);
>      g_assert(serverChanSock != NULL);
>  
>      /*
> @@ -193,12 +187,12 @@ static void test_io_channel_tls(const void *opaque)
>      /* Now the real part of the test, setup the sessions */
>      clientChanTLS = qio_channel_tls_new_client(
>          QIO_CHANNEL(clientChanSock), clientCreds,
> -        data->hostname, &err);
> +        data->hostname, &error_abort);
>      g_assert(clientChanTLS != NULL);
>  
>      serverChanTLS = qio_channel_tls_new_server(
>          QIO_CHANNEL(serverChanSock), serverCreds,
> -        "channeltlsacl", &err);
> +        "channeltlsacl", &error_abort);
>      g_assert(serverChanTLS != NULL);
>  
>      qio_channel_tls_handshake(clientChanTLS,
> 
