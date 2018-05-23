Received: from eggs.gnu.org ([2001:4830:134:3::10]:54719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fLLPG-00041S-IK
	for qemu-devel@nongnu.org; Wed, 23 May 2018 00:29:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fLLPD-0006df-Bt
	for qemu-devel@nongnu.org; Wed, 23 May 2018 00:29:46 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57418 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fLLPD-0006dR-6H
	for qemu-devel@nongnu.org; Wed, 23 May 2018 00:29:43 -0400
References: <1526977831-31129-1-git-send-email-thuth@redhat.com>
	<d12338f0-277e-99bf-388b-61c9ec2919f5@ilande.co.uk>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <08b14c26-a458-214b-f962-ab5723299495@redhat.com>
Date: Wed, 23 May 2018 06:29:39 +0200
MIME-Version: 1.0
In-Reply-To: <d12338f0-277e-99bf-388b-61c9ec2919f5@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] tests/boot-serial: Do not delete the
 output file in case of errors
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Maydell <peter.maydell@linaro.org>

On 22.05.2018 23:21, Mark Cave-Ayland wrote:
> On 22/05/18 09:30, Thomas Huth wrote:
>=20
>> Peter reported that the boot-serial tester sometimes runs into timeout=
s
>> with SPARC guests. It's currently completely unclear whether this is d=
ue
>> to too much load on the host machine (so that the guest really just ra=
n
>> too slow), or whether there is something wrong with the guest's firmwa=
re
>> boot. For further debugging, we need the serial output of the guest in
>> case of errors, so instead of unlinking the file immediately, this is
>> now only done in case of success. In case of error, print the name of =
the
>> file with the serial output via g_error() (which then also calls abort=
()
>> internally to mark the test as failed).
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>> =C2=A0 tests/boot-serial-test.c | 17 +++++++++--------
>> =C2=A0 1 file changed, 9 insertions(+), 8 deletions(-)
>>
>> diff --git a/tests/boot-serial-test.c b/tests/boot-serial-test.c
>> index 4d6815c..952a2e7 100644
>> --- a/tests/boot-serial-test.c
>> +++ b/tests/boot-serial-test.c
>> @@ -111,9 +111,8 @@ static testdef_t tests[] =3D {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 { NULL }
>> =C2=A0 };
>> =C2=A0 -static void check_guest_output(const testdef_t *test, int fd)
>> +static bool check_guest_output(const testdef_t *test, int fd)
>> =C2=A0 {
>> -=C2=A0=C2=A0=C2=A0 bool output_ok =3D false;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int i, nbr =3D 0, pos =3D 0, ccnt;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char ch;
>> =C2=A0 @@ -125,8 +124,7 @@ static void check_guest_output(const testde=
f_t
>> *test, int fd)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pos +=3D 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (test->expect[pos] =3D=3D '\0') {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* We've reached t=
he end of the expected string! */
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 output_ok =3D true;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto done;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return true;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 } else {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 pos =3D 0;
>> @@ -136,8 +134,7 @@ static void check_guest_output(const testdef_t
>> *test, int fd)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_usleep(10000)=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -done:
>> -=C2=A0=C2=A0=C2=A0 g_assert(output_ok);
>> +=C2=A0=C2=A0=C2=A0 return false;
>> =C2=A0 }
>> =C2=A0 =C2=A0 static void test_machine(const void *data)
>> @@ -180,12 +177,16 @@ static void test_machine(const void *data)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-no-shutdown -serial
>> chardev:serial0 %s",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 codeparam, code ? cod=
etmp : "",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 test->machine, serial=
tmp, test->extra);
>> -=C2=A0=C2=A0=C2=A0 unlink(serialtmp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (code) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 unlink(codetmp)=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 check_guest_output(test, ser_fd);
>> +=C2=A0=C2=A0=C2=A0 if (!check_guest_output(test, ser_fd)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_error("Failed to find ex=
pected string. Please check '%s'",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 serialtmp);
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 unlink(serialtmp);
>> +
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 qtest_quit(global_qtest);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 close(ser_fd);
>=20
> Is this for qemu-system-sparc rather than qemu-system-sparc64? The
> reason for asking is that OpenBIOS for SPARC32 writes zeros to all
> physical RAM before launching the Forth machine to work around a bug in
> older Solaris versions whereby the kernel page tables weren't explicitl=
y
> zeroed and so the kernel would panic on boot due to junk PTEs.

Peter apparently hit the issue on both, SPARC32 and SPARC64, see:

https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg01057.html

and

https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg04553.html

... so no clue whether they are really related, two completely
independent issues, or a generic issue that we've just seen by accident
on Sparc machines so far. I hope we'll get a little bit more information
once somebody hits the issue with the above patch included.

 Thomas
