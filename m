Received: from eggs.gnu.org ([2001:4830:134:3::10]:57605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fUs1W-0003Ek-U3
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:08:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fUs1T-0007cz-Mq
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:08:38 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:59328 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fUs1T-0007cj-G6
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 07:08:35 -0400
Date: Mon, 18 Jun 2018 12:08:30 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180618110830.GC3589@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180615194705.28019-1-alex.bennee@linaro.org>
	<20180615194705.28019-13-alex.bennee@linaro.org>
	<f33bb30d-d884-2061-c404-ec0ae913ed28@redhat.com>
	<87r2l4jrcn.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87r2l4jrcn.fsf@linaro.org>
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
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, cota@braap.org, famz@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org, qemu-devel@nongnu.org

On Mon, Jun 18, 2018 at 11:56:08AM +0100, Alex Benn=C3=A9e wrote:
>=20
> Thomas Huth <thuth@redhat.com> writes:
>=20
> > On 15.06.2018 21:46, Alex Benn=C3=A9e wrote:
> >> The fixed path and ports get in the way of running our tests and
> >> builds in parallel. Instead of using TESTPATH we use mkdtemp() and
> >> instead of a fixed port we allow the kernel to assign one and query =
it
> >> afterwards.
> >>
> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> >> ---
> >>  tests/tcg/multiarch/linux-test.c | 37 ++++++++++++++++-------------=
---
> >>  1 file changed, 19 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/=
linux-test.c
> >> index 6f2c531474..3f73b96420 100644
> >> --- a/tests/tcg/multiarch/linux-test.c
> >> +++ b/tests/tcg/multiarch/linux-test.c
> >> @@ -41,8 +41,6 @@
> >>  #include <setjmp.h>
> >>  #include <sys/shm.h>
> >>
> >> -#define TESTPATH "/tmp/linux-test.tmp"
> >> -#define TESTPORT 7654
> >>  #define STACK_SIZE 16384
> >>
> >>  static void error1(const char *filename, int line, const char *fmt,=
 ...)
> >> @@ -85,19 +83,15 @@ static void test_file(void)
> >>      struct iovec vecs[2];
> >>      DIR *dir;
> >>      struct dirent *de;
> >> +    char template[] =3D "/tmp/linux-test-XXXXXX";
> >> +    char *tmpdir =3D mkdtemp(template);
> >>
> >> -    /* clean up, just in case */
> >> -    unlink(TESTPATH "/file1");
> >> -    unlink(TESTPATH "/file2");
> >> -    unlink(TESTPATH "/file3");
> >> -    rmdir(TESTPATH);
> >> +    chk_error(strlen(tmpdir));
> >
> > That line looks wrong to me. According to my man-page of mkdtemp(), i=
t
> > returns either NULL or a pointer to the modified string.
> > In case of NULL, strlen(tmpdir) will simply crash. And even if it wou=
ld
> > not crash, strlen() only returns values >=3D 0, so there is no way th=
e
> > chk_error could ever report an error here.
>=20
> As we only really want to check we did actually do a mkdtemp would:
>=20
>   chk_error(tmpdir)
>=20
> Be enough?

I feel like this is a common task across all our test cases, so we would
be well served by defining a helper program to give better semantics.

I feel like we should be creating temporary files in the build dir too
by default, rather than /tmp, since some of our test suites create quite
large files and /tmp is a limited size RAMFS on many distros. THis leads
to obscure errors when running many tests in parallel if space is exhaust=
ed.

So how about creating a shared function:

    char *qtest_tempdir(const char *basename) {
        char *here =3D g_get_current_dir();
	char *tmpl =3D g_strdup_printf("%s/%sXXXXXX", here, basename);
	g_free(here);
        char *res =3D g_mkstemp(tmpl);
	if (res =3D=3D NULL) {
	    error_report("Unable to create temporary dir: %s",
	                 strerror(errno));
            abort();
	}
	return res;
    }

To be used as

     char *dir =3D qtest_tempdir("linux-test");


And all other test suites can be updated to use this over time too.

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
