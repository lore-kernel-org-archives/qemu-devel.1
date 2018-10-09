Received: from eggs.gnu.org ([2001:4830:134:3::10]:38722)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9sch-00005z-EI
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:04:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1g9sca-0003AD-Pz
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:04:31 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c]:50835)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1g9scZ-00037m-MS
	for qemu-devel@nongnu.org; Tue, 09 Oct 2018 10:04:24 -0400
Received: by mail-wm1-x32c.google.com with SMTP id i8-v6so2009380wmg.0
	for <qemu-devel@nongnu.org>; Tue, 09 Oct 2018 07:04:21 -0700 (PDT)
MIME-Version: 1.0
References: <20181009125541.24455-1-berrange@redhat.com>
	<20181009125541.24455-2-berrange@redhat.com>
In-Reply-To: <20181009125541.24455-2-berrange@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 9 Oct 2018 18:04:07 +0400
Message-ID: <CAJ+F1CKLOPLL-Y+Vdh95-BeXfguyKnj4_U1ag-VCNXj5Z9f+aA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/6] crypto: expand algorithm coverage for
 cipher benchmark
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: QEMU <qemu-devel@nongnu.org>, Alberto Garcia <berto@igalia.com>

Hi

On Tue, Oct 9, 2018 at 4:57 PM Daniel P. Berrang=C3=A9 <berrange@redhat.com=
> wrote:
>
> Add testing coverage for AES with XTS, ECB and CTR modes
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  tests/benchmark-crypto-cipher.c | 149 +++++++++++++++++++++++++++-----

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

>  1 file changed, 126 insertions(+), 23 deletions(-)
>
> diff --git a/tests/benchmark-crypto-cipher.c b/tests/benchmark-crypto-cip=
her.c
> index f5a0d0bc32..a8325a9510 100644
> --- a/tests/benchmark-crypto-cipher.c
> +++ b/tests/benchmark-crypto-cipher.c
> @@ -15,17 +15,27 @@
>  #include "crypto/init.h"
>  #include "crypto/cipher.h"
>
> -static void test_cipher_speed(const void *opaque)
> +static void test_cipher_speed(size_t chunk_size,
> +                              QCryptoCipherMode mode,
> +                              QCryptoCipherAlgorithm alg)
>  {
>      QCryptoCipher *cipher;
>      Error *err =3D NULL;
>      double total =3D 0.0;
> -    size_t chunk_size =3D (size_t)opaque;
>      uint8_t *key =3D NULL, *iv =3D NULL;
>      uint8_t *plaintext =3D NULL, *ciphertext =3D NULL;
> -    size_t nkey =3D qcrypto_cipher_get_key_len(QCRYPTO_CIPHER_ALG_AES_12=
8);
> -    size_t niv =3D qcrypto_cipher_get_iv_len(QCRYPTO_CIPHER_ALG_AES_128,
> -                                           QCRYPTO_CIPHER_MODE_CBC);
> +    size_t nkey;
> +    size_t niv;
> +
> +    if (!qcrypto_cipher_supports(alg, mode)) {
> +        return;
> +    }
> +
> +    nkey =3D qcrypto_cipher_get_key_len(alg);
> +    niv =3D qcrypto_cipher_get_iv_len(alg, mode);
> +    if (mode =3D=3D QCRYPTO_CIPHER_MODE_XTS) {
> +        nkey *=3D 2;
> +    }
>
>      key =3D g_new0(uint8_t, nkey);
>      memset(key, g_test_rand_int(), nkey);
> @@ -38,14 +48,14 @@ static void test_cipher_speed(const void *opaque)
>      plaintext =3D g_new0(uint8_t, chunk_size);
>      memset(plaintext, g_test_rand_int(), chunk_size);
>
> -    cipher =3D qcrypto_cipher_new(QCRYPTO_CIPHER_ALG_AES_128,
> -                                QCRYPTO_CIPHER_MODE_CBC,
> +    cipher =3D qcrypto_cipher_new(alg, mode,
>                                  key, nkey, &err);
>      g_assert(cipher !=3D NULL);
>
> -    g_assert(qcrypto_cipher_setiv(cipher,
> -                                  iv, niv,
> -                                  &err) =3D=3D 0);
> +    if (mode !=3D QCRYPTO_CIPHER_MODE_ECB)
> +        g_assert(qcrypto_cipher_setiv(cipher,
> +                                      iv, niv,
> +                                      &err) =3D=3D 0);
>
>      g_test_timer_start();
>      do {
> @@ -55,13 +65,26 @@ static void test_cipher_speed(const void *opaque)
>                                          chunk_size,
>                                          &err) =3D=3D 0);
>          total +=3D chunk_size;
> -    } while (g_test_timer_elapsed() < 5.0);
> +    } while (g_test_timer_elapsed() < 1.0);
>
>      total /=3D MiB;
> -    g_print("cbc(aes128): ");
> -    g_print("Testing chunk_size %zu bytes ", chunk_size);
> -    g_print("done: %.2f MB in %.2f secs: ", total, g_test_timer_last());
> -    g_print("%.2f MB/sec\n", total / g_test_timer_last());
> +    g_print("Enc chunk %zu bytes ", chunk_size);
> +    g_print("%.2f MB/sec ", total / g_test_timer_last());
> +
> +    total =3D 0.0;
> +    g_test_timer_start();
> +    do {
> +        g_assert(qcrypto_cipher_decrypt(cipher,
> +                                        plaintext,
> +                                        ciphertext,
> +                                        chunk_size,
> +                                        &err) =3D=3D 0);
> +        total +=3D chunk_size;
> +    } while (g_test_timer_elapsed() < 1.0);
> +
> +    total /=3D MiB;
> +    g_print("Dec chunk %zu bytes ", chunk_size);
> +    g_print("%.2f MB/sec ", total / g_test_timer_last());
>
>      qcrypto_cipher_free(cipher);
>      g_free(plaintext);
> @@ -70,19 +93,99 @@ static void test_cipher_speed(const void *opaque)
>      g_free(key);
>  }
>
> -int main(int argc, char **argv)
> +
> +static void test_cipher_speed_ecb_aes_128(const void *opaque)
> +{
> +    size_t chunk_size =3D (size_t)opaque;
> +    test_cipher_speed(chunk_size,
> +                      QCRYPTO_CIPHER_MODE_ECB,
> +                      QCRYPTO_CIPHER_ALG_AES_128);
> +}
> +
> +static void test_cipher_speed_ecb_aes_256(const void *opaque)
>  {
> -    size_t i;
> -    char name[64];
> +    size_t chunk_size =3D (size_t)opaque;
> +    test_cipher_speed(chunk_size,
> +                      QCRYPTO_CIPHER_MODE_ECB,
> +                      QCRYPTO_CIPHER_ALG_AES_256);
> +}
> +
> +static void test_cipher_speed_cbc_aes_128(const void *opaque)
> +{
> +    size_t chunk_size =3D (size_t)opaque;
> +    test_cipher_speed(chunk_size,
> +                      QCRYPTO_CIPHER_MODE_CBC,
> +                      QCRYPTO_CIPHER_ALG_AES_128);
> +}
>
> +static void test_cipher_speed_cbc_aes_256(const void *opaque)
> +{
> +    size_t chunk_size =3D (size_t)opaque;
> +    test_cipher_speed(chunk_size,
> +                      QCRYPTO_CIPHER_MODE_CBC,
> +                      QCRYPTO_CIPHER_ALG_AES_256);
> +}
> +
> +static void test_cipher_speed_ctr_aes_128(const void *opaque)
> +{
> +    size_t chunk_size =3D (size_t)opaque;
> +    test_cipher_speed(chunk_size,
> +                      QCRYPTO_CIPHER_MODE_CTR,
> +                      QCRYPTO_CIPHER_ALG_AES_128);
> +}
> +
> +static void test_cipher_speed_ctr_aes_256(const void *opaque)
> +{
> +    size_t chunk_size =3D (size_t)opaque;
> +    test_cipher_speed(chunk_size,
> +                      QCRYPTO_CIPHER_MODE_CTR,
> +                      QCRYPTO_CIPHER_ALG_AES_256);
> +}
> +
> +static void test_cipher_speed_xts_aes_128(const void *opaque)
> +{
> +    size_t chunk_size =3D (size_t)opaque;
> +    test_cipher_speed(chunk_size,
> +                      QCRYPTO_CIPHER_MODE_XTS,
> +                      QCRYPTO_CIPHER_ALG_AES_128);
> +}
> +
> +static void test_cipher_speed_xts_aes_256(const void *opaque)
> +{
> +    size_t chunk_size =3D (size_t)opaque;
> +    test_cipher_speed(chunk_size,
> +                      QCRYPTO_CIPHER_MODE_XTS,
> +                      QCRYPTO_CIPHER_ALG_AES_256);
> +}
> +
> +
> +int main(int argc, char **argv)
> +{
>      g_test_init(&argc, &argv, NULL);
>      g_assert(qcrypto_init(NULL) =3D=3D 0);
>
> -    for (i =3D 512; i <=3D 64 * KiB; i *=3D 2) {
> -        memset(name, 0 , sizeof(name));
> -        snprintf(name, sizeof(name), "/crypto/cipher/speed-%zu", i);
> -        g_test_add_data_func(name, (void *)i, test_cipher_speed);
> -    }
> +#define ADD_TEST(mode, cipher, keysize, chunk)                          =
\
> +    g_test_add_data_func(                                               =
\
> +        "/crypto/cipher/" #mode "-" #cipher "-" #keysize "/chunk-" #chun=
k, \
> +        (void *)chunk,                                                  =
\
> +        test_cipher_speed_ ## mode ## _ ## cipher ## _ ## keysize)
> +
> +#define ADD_TESTS(chunk)                        \
> +    do {                                        \
> +        ADD_TEST(ecb, aes, 128, chunk);         \
> +        ADD_TEST(ecb, aes, 256, chunk);         \
> +        ADD_TEST(cbc, aes, 128, chunk);         \
> +        ADD_TEST(cbc, aes, 256, chunk);         \
> +        ADD_TEST(ctr, aes, 128, chunk);         \
> +        ADD_TEST(ctr, aes, 256, chunk);         \
> +        ADD_TEST(xts, aes, 128, chunk);         \
> +        ADD_TEST(xts, aes, 256, chunk); \
> +    } while (0)
> +
> +    ADD_TESTS(512);
> +    ADD_TESTS(4096);
> +    ADD_TESTS(16384);
> +    ADD_TESTS(65536);
>
>      return g_test_run();
>  }
> --
> 2.17.1
>
>


--
Marc-Andr=C3=A9 Lureau
