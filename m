Received: from eggs.gnu.org ([2001:4830:134:3::10]:57851)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dmKC4-0007LS-Uv
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 09:35:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1dmKC3-00007C-Do
	for qemu-devel@nongnu.org; Mon, 28 Aug 2017 09:35:08 -0400
MIME-Version: 1.0
References: <20170828113737.12199-1-f4bug@amsat.org>
In-Reply-To: <20170828113737.12199-1-f4bug@amsat.org>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Mon, 28 Aug 2017 13:34:52 +0000
Message-ID: <CAJ+F1CKL67s4eEYa5N0yy7xZj8NBsmzjRwADJJtDuhAAOiOE2A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests: fix incorrect size_t format in
 benchmark-crypto
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, "Daniel P . Berrange" <berrange@redhat.com>, Longpeng <longpeng2@huawei.com>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On Mon, Aug 28, 2017 at 1:38 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

>   $ make check-speed
>   tests/benchmark-crypto-hash.c: In function 'test_hash_speed':
>   tests/benchmark-crypto-hash.c:44:5: error: format '%ld' expects argumen=
t
> of type 'long int', but argument 2 has type 'size_t' [-Werror=3Dformat=3D=
]
>        g_print("Testing chunk_size %ld bytes ", chunk_size);
>        ^
>   tests/benchmark-crypto-hash.c: In function 'main':
>   tests/benchmark-crypto-hash.c:62:9: error: format '%lu' expects argumen=
t
> of type 'long unsigned int', but argument 4 has type 'size_t'
> [-Werror=3Dformat=3D]
>            snprintf(name, sizeof(name), "/crypto/hash/speed-%lu", i);
>            ^
>   cc1: all warnings being treated as errors
>   rules.mak:66: recipe for target 'tests/benchmark-crypto-hash.o' failed
>   make: *** [tests/benchmark-crypto-hash.o] Error 1
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>

 Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

---
> testing v2.10.0-rc4
>
>  tests/benchmark-crypto-cipher.c | 4 ++--
>  tests/benchmark-crypto-hash.c   | 4 ++--
>  tests/benchmark-crypto-hmac.c   | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/tests/benchmark-crypto-cipher.c
> b/tests/benchmark-crypto-cipher.c
> index c6a40929e4..cf98443468 100644
> --- a/tests/benchmark-crypto-cipher.c
> +++ b/tests/benchmark-crypto-cipher.c
> @@ -59,7 +59,7 @@ static void test_cipher_speed(const void *opaque)
>      total /=3D 1024 * 1024; /* to MB */
>
>      g_print("cbc(aes128): ");
> -    g_print("Testing chunk_size %ld bytes ", chunk_size);
> +    g_print("Testing chunk_size %zu bytes ", chunk_size);
>      g_print("done: %.2f MB in %.2f secs: ", total, g_test_timer_last());
>      g_print("%.2f MB/sec\n", total / g_test_timer_last());
>
> @@ -80,7 +80,7 @@ int main(int argc, char **argv)
>
>      for (i =3D 512; i <=3D (64 * 1204); i *=3D 2) {
>          memset(name, 0 , sizeof(name));
> -        snprintf(name, sizeof(name), "/crypto/cipher/speed-%lu", i);
> +        snprintf(name, sizeof(name), "/crypto/cipher/speed-%zu", i);
>          g_test_add_data_func(name, (void *)i, test_cipher_speed);
>      }
>
> diff --git a/tests/benchmark-crypto-hash.c b/tests/benchmark-crypto-hash.=
c
> index 6769d2a11b..122bfb6b85 100644
> --- a/tests/benchmark-crypto-hash.c
> +++ b/tests/benchmark-crypto-hash.c
> @@ -41,7 +41,7 @@ static void test_hash_speed(const void *opaque)
>
>      total /=3D 1024 * 1024; /* to MB */
>      g_print("sha256: ");
> -    g_print("Testing chunk_size %ld bytes ", chunk_size);
> +    g_print("Testing chunk_size %zu bytes ", chunk_size);
>      g_print("done: %.2f MB in %.2f secs: ", total, g_test_timer_last());
>      g_print("%.2f MB/sec\n", total / g_test_timer_last());
>
> @@ -59,7 +59,7 @@ int main(int argc, char **argv)
>
>      for (i =3D 512; i <=3D (64 * 1204); i *=3D 2) {
>          memset(name, 0 , sizeof(name));
> -        snprintf(name, sizeof(name), "/crypto/hash/speed-%lu", i);
> +        snprintf(name, sizeof(name), "/crypto/hash/speed-%zu", i);
>          g_test_add_data_func(name, (void *)i, test_hash_speed);
>      }
>
> diff --git a/tests/benchmark-crypto-hmac.c b/tests/benchmark-crypto-hmac.=
c
> index 72408be987..c30250df3e 100644
> --- a/tests/benchmark-crypto-hmac.c
> +++ b/tests/benchmark-crypto-hmac.c
> @@ -56,7 +56,7 @@ static void test_hmac_speed(const void *opaque)
>      total /=3D 1024 * 1024; /* to MB */
>
>      g_print("hmac(sha256): ");
> -    g_print("Testing chunk_size %ld bytes ", chunk_size);
> +    g_print("Testing chunk_size %zu bytes ", chunk_size);
>      g_print("done: %.2f MB in %.2f secs: ", total, g_test_timer_last());
>      g_print("%.2f MB/sec\n", total / g_test_timer_last());
>
> @@ -74,7 +74,7 @@ int main(int argc, char **argv)
>
>      for (i =3D 512; i <=3D (64 * 1204); i *=3D 2) {
>          memset(name, 0 , sizeof(name));
> -        snprintf(name, sizeof(name), "/crypto/hmac/speed-%lu", i);
> +        snprintf(name, sizeof(name), "/crypto/hmac/speed-%zu", i);
>          g_test_add_data_func(name, (void *)i, test_hmac_speed);
>      }
>
> --
> 2.14.1
>
>
> --
Marc-Andr=C3=A9 Lureau
