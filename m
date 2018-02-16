Received: from eggs.gnu.org ([2001:4830:134:3::10]:34612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emYxv-0000yb-IX
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 00:53:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emYxr-00057f-MH
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 00:53:47 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:51396 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1emYxr-00056T-HQ
	for qemu-devel@nongnu.org; Fri, 16 Feb 2018 00:53:43 -0500
References: <20180204222356.14546-1-richard.henderson@linaro.org>
	<20180204222356.14546-3-richard.henderson@linaro.org>
	<3edd5d86-1c7c-1a32-4203-5ea4c432ad1f@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <b1fc9805-a231-6f78-ed0d-318a3f1293bb@redhat.com>
Date: Fri, 16 Feb 2018 06:53:21 +0100
MIME-Version: 1.0
In-Reply-To: <3edd5d86-1c7c-1a32-4203-5ea4c432ad1f@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 2/3] tests: Enable boot-serial-test for hppa
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 16.02.2018 00:55, Philippe Mathieu-Daud=C3=A9 wrote:
> On 02/04/2018 07:23 PM, Richard Henderson wrote:
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>> ---
>>  tests/boot-serial-test.c | 1 +
>>  tests/Makefile.include   | 2 ++
>>  2 files changed, 3 insertions(+)
>>
>> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
>> index 418c5b92dc..ea87a80be7 100644
>> --- a/tests/boot-serial-test.c
>> +++ b/tests/boot-serial-test.c
>> @@ -87,6 +87,7 @@ static testdef_t tests[] =3D {
>>        sizeof(kernel_plml605), kernel_plml605 },
>>      { "moxie", "moxiesim", "", "TT", sizeof(bios_moxiesim), 0, bios_m=
oxiesim },
>>      { "arm", "raspi2", "", "TT", sizeof(bios_raspi2), 0, bios_raspi2 =
},
>> +    { "hppa", "hppa", "", "SeaBIOS wants SYSTEM HALT" },
>> =20
>>      { NULL }
>>  };
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index ca82e0c0cc..83def6994c 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -299,6 +299,8 @@ gcov-files-x86_64-y =3D $(subst i386-softmmu/,x86_=
64-softmmu/,$(gcov-files-i386-y)
>> =20
>>  check-qtest-alpha-y =3D tests/boot-serial-test$(EXESUF)
>> =20
>> +check-qtest-hppa-y =3D tests/boot-serial-test$(EXESUF)
>> +
>>  check-qtest-m68k-y =3D tests/boot-serial-test$(EXESUF)
>> =20
>>  check-qtest-microblaze-y =3D tests/boot-serial-test$(EXESUF)
>>
>=20
> I got this failure in 2 different branches:
>=20
>   GTESTER check-qtest-hppa
> **
> ERROR:tests/boot-serial-test.c:137:check_guest_output: assertion failed=
:
> (output_ok)
> GTester: last random seed: R02S55e7df877597841c1b3b62962e410123
> make: *** [check-qtest-hppa] Error 1
> make: *** Waiting for unfinished jobs....

Uh, oh, I actually can also reproduce this on my laptop when putting a
lot of load on the system (make -j10 in another window). I think I know
what the problem is: I've introduced a counter in commit 92b540dac9fc3a5
to handle the timeouts in a better way. But in case ccnt reaches 512,
the current read character is ignored - and if that character is part of
the string that we are looking for, the test fails to match the string.

Almost all of the tests look for a string within the first 512 bytes of
firmware output, so the problem never triggered there. But the hppa test
looks for a string at the very end of a long output, so that's likely
the reason that the problem triggered here.

The fix is pretty simple:

diff a/tests/boot-serial-test.c b/tests/boot-serial-test.c
--- a/tests/boot-serial-test.c
+++ b/tests/boot-serial-test.c
@@ -117,7 +117,7 @@ static void check_guest_output(const testdef_t
*test, int fd)
     /* Poll serial output... Wait at most 60 seconds */
     for (i =3D 0; i < 6000; ++i) {
         ccnt =3D 0;
-        while ((nbr =3D read(fd, &ch, 1)) =3D=3D 1 && ccnt++ < 512) {
+        while (ccnt++ < 512 && (nbr =3D read(fd, &ch, 1)) =3D=3D 1) {
             if (ch =3D=3D test->expect[pos]) {
                 pos +=3D 1;
                 if (test->expect[pos] =3D=3D '\0') {

I'll submit this as a proper patch...

 Thomas
