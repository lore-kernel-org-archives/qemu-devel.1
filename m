Received: from eggs.gnu.org ([209.51.188.92]:59561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gka4z-0007ys-L9
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 14:45:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gka4w-0007Rw-R2
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 14:45:24 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b]:44149)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gka4q-0006vl-Tx
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 14:45:18 -0500
Received: by mail-wr1-x42b.google.com with SMTP id z5so16443152wrt.11
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 11:45:12 -0800 (PST)
References: <20190117132703.17790-1-alex.bennee@linaro.org>
	<CAFEAcA_E2Lf9Zh2WhVDddJiD5TPPyLk1RvT7_Asn4vXnao1NjQ@mail.gmail.com>
	<20190117183002.GA21582@flamenco>
	<CAFEAcA_RN-68EXsfFqkXDp5BUB4QD01KqzCAX9=7VWPYN0NAvA@mail.gmail.com>
	<871s5byriy.fsf@linaro.org>
	<e655e325-15ad-9e97-eb27-8a15ea77a889@redhat.com>
	<87won1yk7y.fsf@linaro.org> <20190118181651.GA4194@flamenco>
	<CAFEAcA_-rWCT=S6hf=83tozdGtsj_U4zHi6jza4usbXk7cxkhQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA_-rWCT=S6hf=83tozdGtsj_U4zHi6jza4usbXk7cxkhQ@mail.gmail.com>
Date: Fri, 18 Jan 2019 19:45:10 +0000
Message-ID: <87tvi5ycl5.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 0/7] check-softfloat,
 fp-bench and clang compile fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Emilio G. Cota" <cota@braap.org>, Philippe =?utf-8?Q?Mathieu-Daud?= =?utf-8?Q?=C3=A9?= <philmd@redhat.com>


Peter Maydell <peter.maydell@linaro.org> writes:

> On Fri, 18 Jan 2019 at 18:16, Emilio G. Cota <cota@braap.org> wrote:
>>
>> On Fri, Jan 18, 2019 at 17:00:17 +0000, Alex Benn=C3=A9e wrote:
>> > Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> writes:
>> > > Can you modify the Makefile.include to use:
>> > >  "fp-test ... 2>int-to-float.err || {cat int-to-float.err && exit 1;=
}"
>> >
>> > Well it's in the test-softfloat macro but sure...
>>
>> Actually, can we do &> instead of 2> ?
>
> "&>" is a bashism. The POSIX equivalent is >file.err 2>&1
>
> thanks
> -- PMM

I've gone for this:

 # $1 =3D tests, $2 =3D description
 test-softfloat =3D $(call quiet-command, \
-                        cd $(BUILD_DIR)/tests/fp && ./fp-test -s $(FP_TL) =
$1 > $2.out 2> $2.err, \
+                        cd $(BUILD_DIR)/tests/fp && \
+                        ./fp-test -s $(FP_TL) $1 > $2.out 2>&1 || \
+                        (cat $2.out && exit 1;), \
                         "FLOAT TEST", $2)

As for the tests it seems quite a lot are broken on s390x for a reason I
don't quite follow yet:

 i32_to_f128
 i64_to_f128
 ui64_to_f128
 extF80_to_i32
 extF80_to_i32_r_minMag
 extF80_eq

and more which I haven't confirmed yet. I'm tempted to ifndef the tests
for s390 for now while we sort out what's going on. Should I re-send
with that?

--
Alex Benn=C3=A9e
