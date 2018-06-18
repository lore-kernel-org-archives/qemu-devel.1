Received: from eggs.gnu.org ([2001:4830:134:3::10]:55187)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fUrpW-0001E5-NX
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 06:56:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fUrpT-0007pH-Kk
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 06:56:14 -0400
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:40888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fUrpT-0007o0-DE
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 06:56:11 -0400
Received: by mail-wm0-x242.google.com with SMTP id n5-v6so14647643wmc.5
	for <qemu-devel@nongnu.org>; Mon, 18 Jun 2018 03:56:10 -0700 (PDT)
References: <20180615194705.28019-1-alex.bennee@linaro.org>
	<20180615194705.28019-13-alex.bennee@linaro.org>
	<f33bb30d-d884-2061-c404-ec0ae913ed28@redhat.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <f33bb30d-d884-2061-c404-ec0ae913ed28@redhat.com>
Date: Mon, 18 Jun 2018 11:56:08 +0100
Message-ID: <87r2l4jrcn.fsf@linaro.org>
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
To: Thomas Huth <thuth@redhat.com>
Cc: cota@braap.org, famz@redhat.com, berrange@redhat.com, f4bug@amsat.org, richard.henderson@linaro.org, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, peter.maydell@linaro.org, qemu-devel@nongnu.org


Thomas Huth <thuth@redhat.com> writes:

> On 15.06.2018 21:46, Alex Benn=C3=A9e wrote:
>> The fixed path and ports get in the way of running our tests and
>> builds in parallel. Instead of using TESTPATH we use mkdtemp() and
>> instead of a fixed port we allow the kernel to assign one and query it
>> afterwards.
>>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  tests/tcg/multiarch/linux-test.c | 37 ++++++++++++++++----------------
>>  1 file changed, 19 insertions(+), 18 deletions(-)
>>
>> diff --git a/tests/tcg/multiarch/linux-test.c b/tests/tcg/multiarch/linu=
x-test.c
>> index 6f2c531474..3f73b96420 100644
>> --- a/tests/tcg/multiarch/linux-test.c
>> +++ b/tests/tcg/multiarch/linux-test.c
>> @@ -41,8 +41,6 @@
>>  #include <setjmp.h>
>>  #include <sys/shm.h>
>>
>> -#define TESTPATH "/tmp/linux-test.tmp"
>> -#define TESTPORT 7654
>>  #define STACK_SIZE 16384
>>
>>  static void error1(const char *filename, int line, const char *fmt, ...)
>> @@ -85,19 +83,15 @@ static void test_file(void)
>>      struct iovec vecs[2];
>>      DIR *dir;
>>      struct dirent *de;
>> +    char template[] =3D "/tmp/linux-test-XXXXXX";
>> +    char *tmpdir =3D mkdtemp(template);
>>
>> -    /* clean up, just in case */
>> -    unlink(TESTPATH "/file1");
>> -    unlink(TESTPATH "/file2");
>> -    unlink(TESTPATH "/file3");
>> -    rmdir(TESTPATH);
>> +    chk_error(strlen(tmpdir));
>
> That line looks wrong to me. According to my man-page of mkdtemp(), it
> returns either NULL or a pointer to the modified string.
> In case of NULL, strlen(tmpdir) will simply crash. And even if it would
> not crash, strlen() only returns values >=3D 0, so there is no way the
> chk_error could ever report an error here.

As we only really want to check we did actually do a mkdtemp would:

  chk_error(tmpdir)

Be enough?

>
>  Thomas


--
Alex Benn=C3=A9e
