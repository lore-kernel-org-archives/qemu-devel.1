Received: from eggs.gnu.org ([2001:4830:134:3::10]:54106)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMsL1-0000N8-Lg
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:24:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gMsKw-0002ER-Vz
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:23:59 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:51078)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gMsKw-0002Df-JL
	for qemu-devel@nongnu.org; Wed, 14 Nov 2018 05:23:54 -0500
Received: by mail-wm1-x341.google.com with SMTP id 124-v6so14963600wmw.0
	for <qemu-devel@nongnu.org>; Wed, 14 Nov 2018 02:23:54 -0800 (PST)
References: <20181113175437.26492-1-laurent@vivier.eu>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181113175437.26492-1-laurent@vivier.eu>
Date: Wed, 14 Nov 2018 10:23:51 +0000
Message-ID: <87a7mcdkjs.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests/tcg/multiarch: fix 32bit linux-test
 on 64bit host
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>


Laurent Vivier <laurent@vivier.eu> writes:

> Fix:
>
>   TEST    linux-test on i386
>   .../tests/tcg/multiarch/linux-test.c:201: readdir
>
> readdir() calls getdents64() to have the list of the entries in a
> directory, and getdents64() can return 64bit d_off values (with ext4,
> for instance) that will not fit in the 32bit d_off field of the
> readdir() dirent structure.
>
> To avoid that, use readdir64() to use a 64bit d_off field too.
>
> Signed-off-by: Laurent Vivier <laurent@vivier.eu>

I guess the only remaining question is do we want to defend the other
case or just say it's not supported and all binaries are expected to use
modern-ish libcs with getdents64?

Anyway:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

I'm preparing a pull-req with a travis patch, would you like me to
include this as well?


> ---
>  tests/tcg/multiarch/linux-test.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linux=
-test.c
> index e80eccc0ce..fa4243fc04 100644
> --- a/tests/tcg/multiarch/linux-test.c
> +++ b/tests/tcg/multiarch/linux-test.c
> @@ -83,7 +83,7 @@ static void test_file(void)
>      struct utimbuf tbuf;
>      struct iovec vecs[2];
>      DIR *dir;
> -    struct dirent *de;
> +    struct dirent64 *de;
>      /* TODO: make common tempdir creation for tcg tests */
>      char template[] =3D "/tmp/linux-test-XXXXXX";
>      char *tmpdir =3D mkdtemp(template);
> @@ -186,7 +186,7 @@ static void test_file(void)
>          error("opendir");
>      len =3D 0;
>      for(;;) {
> -        de =3D readdir(dir);
> +        de =3D readdir64(dir);
>          if (!de)
>              break;
>          if (strcmp(de->d_name, ".") !=3D 0 &&


--
Alex Benn=C3=A9e
