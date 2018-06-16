Received: from eggs.gnu.org ([2001:4830:134:3::10]:46895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fUHA1-0005Yo-Hx
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 15:46:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fUH9x-00083g-JM
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 15:46:57 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54110 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fUH9x-00082A-DY
	for qemu-devel@nongnu.org; Sat, 16 Jun 2018 15:46:53 -0400
References: <20180615194705.28019-1-alex.bennee@linaro.org>
	<20180615194705.28019-13-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f33bb30d-d884-2061-c404-ec0ae913ed28@redhat.com>
Date: Sat, 16 Jun 2018 21:46:42 +0200
MIME-Version: 1.0
In-Reply-To: <20180615194705.28019-13-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 12/54] tests/tcg/multiarch: don't hard
 code paths/ports for linux-test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org

On 15.06.2018 21:46, Alex Benn=C3=A9e wrote:
> The fixed path and ports get in the way of running our tests and
> builds in parallel. Instead of using TESTPATH we use mkdtemp() and
> instead of a fixed port we allow the kernel to assign one and query it
> afterwards.
>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  tests/tcg/multiarch/linux-test.c | 37 ++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 18 deletions(-)
>=20
> diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/lin=
ux-test.c
> index 6f2c531474..3f73b96420 100644
> --- a/tests/tcg/multiarch/linux-test.c
> +++ b/tests/tcg/multiarch/linux-test.c
> @@ -41,8 +41,6 @@
>  #include <setjmp.h>
>  #include <sys/shm.h>
> =20
> -#define TESTPATH "/tmp/linux-test.tmp"
> -#define TESTPORT 7654
>  #define STACK_SIZE 16384
> =20
>  static void error1(const char *filename, int line, const char *fmt, ..=
.)
> @@ -85,19 +83,15 @@ static void test_file(void)
>      struct iovec vecs[2];
>      DIR *dir;
>      struct dirent *de;
> +    char template[] =3D "/tmp/linux-test-XXXXXX";
> +    char *tmpdir =3D mkdtemp(template);
> =20
> -    /* clean up, just in case */
> -    unlink(TESTPATH "/file1");
> -    unlink(TESTPATH "/file2");
> -    unlink(TESTPATH "/file3");
> -    rmdir(TESTPATH);
> +    chk_error(strlen(tmpdir));

That line looks wrong to me. According to my man-page of mkdtemp(), it
returns either NULL or a pointer to the modified string.
In case of NULL, strlen(tmpdir) will simply crash. And even if it would
not crash, strlen() only returns values >=3D 0, so there is no way the
chk_error could ever report an error here.

 Thomas
