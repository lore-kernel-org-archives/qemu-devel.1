Received: from eggs.gnu.org ([2001:4830:134:3::10]:50016)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1e4C7C-0002hT-Di
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:35:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sw@weilnetz.de>) id 1e4C79-0003JO-9M
	for qemu-devel@nongnu.org; Mon, 16 Oct 2017 16:35:58 -0400
References: <20171016202912.1117-1-sw@weilnetz.de>
From: Stefan Weil <sw@weilnetz.de>
Message-ID: <6f30365c-ed10-d062-5179-06ad70dafae3@weilnetz.de>
Date: Mon, 16 Oct 2017 22:35:52 +0200
MIME-Version: 1.0
In-Reply-To: <20171016202912.1117-1-sw@weilnetz.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] oslib-posix: Fix compiler warning and some
 data types
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

Sorry, Philippe, I did not notice that "git send-email"
did not add you to the addressee list.

And I forgot to add "v3" to the subject line.

I=E2=80=8C should not send e-mails late in the night ...

Stefan


Am 16.10.2017 um 22:29 schrieb Stefan Weil:
> gcc warning:
>=20
> /qemu/util/oslib-posix.c:304:11: error:
>  variable =E2=80=98addr=E2=80=99 might be clobbered by =E2=80=98longjmp=
=E2=80=99 or =E2=80=98vfork=E2=80=99
>  [-Werror=3Dclobbered]
>=20
> Fix also some related data types:
>=20
> numpages, hpagesize are used as pointer offset.
> Always use size_t for them and also for the derived
> numpages_per_thread and size_per_thread.
>=20
> Avoid a type cast by declaring addr volatile.
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> Signed-off-by: Stefan Weil <sw@weilnetz.de>
> ---
>=20
> v2: Fix more data types (partially as discussed with Richard)
>=20
> v3: Keep volatile type cast (suggested by Philippe and Paolo)
>=20
> Regards
> Stefan
>=20
>  util/oslib-posix.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
>=20
> diff --git a/util/oslib-posix.c b/util/oslib-posix.c
> index 80086c549f..382bd4a231 100644
> --- a/util/oslib-posix.c
> +++ b/util/oslib-posix.c
> @@ -59,8 +59,8 @@
> =20
>  struct MemsetThread {
>      char *addr;
> -    uint64_t numpages;
> -    uint64_t hpagesize;
> +    size_t numpages;
> +    size_t hpagesize;
>      QemuThread pgthread;
>      sigjmp_buf env;
>  };
> @@ -301,11 +301,7 @@ static void sigbus_handler(int signal)
>  static void *do_touch_pages(void *arg)
>  {
>      MemsetThread *memset_args =3D (MemsetThread *)arg;
> -    char *addr =3D memset_args->addr;
> -    uint64_t numpages =3D memset_args->numpages;
> -    uint64_t hpagesize =3D memset_args->hpagesize;
>      sigset_t set, oldset;
> -    int i =3D 0;
> =20
>      /* unblock SIGBUS */
>      sigemptyset(&set);
> @@ -315,6 +311,10 @@ static void *do_touch_pages(void *arg)
>      if (sigsetjmp(memset_args->env, 1)) {
>          memset_thread_failed =3D true;
>      } else {
> +        char *addr =3D memset_args->addr;
> +        size_t numpages =3D memset_args->numpages;
> +        size_t hpagesize =3D memset_args->hpagesize;
> +        size_t i;
>          for (i =3D 0; i < numpages; i++) {
>              /*
>               * Read & write back the same value, so we don't
> @@ -351,7 +351,8 @@ static inline int get_memset_num_threads(int smp_cp=
us)
>  static bool touch_all_pages(char *area, size_t hpagesize, size_t numpa=
ges,
>                              int smp_cpus)
>  {
> -    uint64_t numpages_per_thread, size_per_thread;
> +    size_t numpages_per_thread;
> +    size_t size_per_thread;
>      char *addr =3D area;
>      int i =3D 0;
> =20
>=20
