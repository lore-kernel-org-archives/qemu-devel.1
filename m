Received: from eggs.gnu.org ([2001:4830:134:3::10]:39135)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fUsu8-0004ND-He
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 08:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fUsu3-0000q2-Id
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 08:05:04 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:42328)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fUsu3-0000pc-Aq
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 08:04:59 -0400
Received: by mail-wr0-x243.google.com with SMTP id w10-v6so16560712wrk.9
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 05:04:59 -0700 (PDT)
References: <20180615194705.28019-1-alex.bennee@linaro.org>
	<20180615194705.28019-13-alex.bennee@linaro.org>
	<f33bb30d-d884-2061-c404-ec0ae913ed28@redhat.com>
	<87r2l4jrcn.fsf@linaro.org> <20180618110830.GC3589@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20180618110830.GC3589@redhat.com>
Date: Mon, 18 Jun 2018 13:04:57 +0100
Message-ID: <87po0ojo5y.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, cota@braap.org, famz@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org, qemu-devel@nongnu.org


Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Jun 18, 2018 at 11:56:08AM +0100, Alex Benn=C3=A9e wrote:
>>
>> Thomas Huth <thuth@redhat.com> writes:
>>
>> > On 15.06.2018 21:46, Alex Benn=C3=A9e wrote:
>> >> The fixed path and ports get in the way of running our tests and
>> >> builds in parallel. Instead of using TESTPATH we use mkdtemp() and
>> >> instead of a fixed port we allow the kernel to assign one and query it
>> >> afterwards.
>> >>
>> >> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> >> ---
>> >>  tests/tcg/multiarch/linux-test.c | 37 ++++++++++++++++--------------=
--
>> >>  1 file changed, 19 insertions(+), 18 deletions(-)
>> >>
>> >> diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/l=
inux-test.c
>> >> index 6f2c531474..3f73b96420 100644
>> >> --- a/tests/tcg/multiarch/linux-test.c
>> >> +++ b/tests/tcg/multiarch/linux-test.c
>> >> @@ -41,8 +41,6 @@
>> >>  #include <setjmp.h>
>> >>  #include <sys/shm.h>
>> >>
>> >> -#define TESTPATH "/tmp/linux-test.tmp"
>> >> -#define TESTPORT 7654
>> >>  #define STACK_SIZE 16384
>> >>
>> >>  static void error1(const char *filename, int line, const char *fmt, =
...)
>> >> @@ -85,19 +83,15 @@ static void test_file(void)
>> >>      struct iovec vecs[2];
>> >>      DIR *dir;
>> >>      struct dirent *de;
>> >> +    char template[] =3D "/tmp/linux-test-XXXXXX";
>> >> +    char *tmpdir =3D mkdtemp(template);
>> >>
>> >> -    /* clean up, just in case */
>> >> -    unlink(TESTPATH "/file1");
>> >> -    unlink(TESTPATH "/file2");
>> >> -    unlink(TESTPATH "/file3");
>> >> -    rmdir(TESTPATH);
>> >> +    chk_error(strlen(tmpdir));
>> >
>> > That line looks wrong to me. According to my man-page of mkdtemp(), it
>> > returns either NULL or a pointer to the modified string.
>> > In case of NULL, strlen(tmpdir) will simply crash. And even if it would
>> > not crash, strlen() only returns values >=3D 0, so there is no way the
>> > chk_error could ever report an error here.
>>
>> As we only really want to check we did actually do a mkdtemp would:
>>
>>   chk_error(tmpdir)
>>
>> Be enough?
>
> I feel like this is a common task across all our test cases, so we would
> be well served by defining a helper program to give better semantics.
>
> I feel like we should be creating temporary files in the build dir too
> by default, rather than /tmp, since some of our test suites create quite
> large files and /tmp is a limited size RAMFS on many distros. THis leads
> to obscure errors when running many tests in parallel if space is exhaust=
ed.
>
> So how about creating a shared function:
>
>     char *qtest_tempdir(const char *basename) {
>         char *here =3D g_get_current_dir();
> 	char *tmpl =3D g_strdup_printf("%s/%sXXXXXX", here, basename);
> 	g_free(here);
>         char *res =3D g_mkstemp(tmpl);
> 	if (res =3D=3D NULL) {
> 	    error_report("Unable to create temporary dir: %s",
> 	                 strerror(errno));
>             abort();
> 	}
> 	return res;
>     }

We could do, although we can't use glib due to the potential vagaries
of cross compile setups. However my personal feeling is to keep the TCG
tests as self contained as possible for the time being.

>
> To be used as
>
>      char *dir =3D qtest_tempdir("linux-test");
>
>
> And all other test suites can be updated to use this over time too.

Is this something that could be addressed in later patches?

>
> Regards,
> Daniel


--
Alex Benn=C3=A9e
