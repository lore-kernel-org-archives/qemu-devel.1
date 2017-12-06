Received: from eggs.gnu.org ([2001:4830:134:3::10]:50281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eMXJW-0000aX-Sj
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:52:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1eMXJT-00068B-Q2
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:52:30 -0500
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1eMXJT-00067b-Ft
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:52:27 -0500
Received: by mail-wr0-x243.google.com with SMTP id v22so3423863wrb.0
	for <qemu-devel@nongnu.org>; Wed, 06 Dec 2017 02:52:27 -0800 (PST)
References: <151203716694.2960.12305472500745415473.malonedeb@gac.canonical.com>
	<20171206093050.25308-1-alex.bennee@linaro.org>
	<B490A0F0-1C40-4ADD-831E-4968FC73107C@physik.fu-berlin.de>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <B490A0F0-1C40-4ADD-831E-4968FC73107C@physik.fu-berlin.de>
Date: Wed, 06 Dec 2017 10:52:24 +0000
Message-ID: <87y3mgqgbb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1735384] [RFC PATCH] target/sh4/translate.c:
 fix TCG leak during gusa sequence
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1735384 <1735384@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org


John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de> writes:

> Hi Alex!
>
> Wow, thanks! I wanted to run your suggested test today as I ran out of
> time yesterday and now you already fixed it :-).

Can you confirm you've tested it and your happy it works?

>
> Thanks a lot!
>
> Adrian
>
>> On Dec 6, 2017, at 10:30 AM, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> This fixes bug #1735384 while running java under qemu-sh4. When debug
>> was enabled it showed a problem with TCG temps. Once fixed I was able
>> to run java -version normally.
>>
>> Reported-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
>> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>> target/sh4/translate.c | 2 +-
>> 1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/target/sh4/translate.c b/target/sh4/translate.c
>> index 703020fe87..b4b5c822d0 100644
>> --- a/target/sh4/translate.c
>> +++ b/target/sh4/translate.c
>> @@ -2189,7 +2189,7 @@ static int decode_gusa(DisasContext *ctx, CPUSH4St=
ate *env, int *pmax_insns)
>>     }
>>
>>     /* If op_src is not a valid register, then op_arg was a constant.  */
>> -    if (op_src < 0) {
>> +    if (op_src < 0 && !TCGV_IS_UNUSED(op_arg)) {
>>         tcg_temp_free_i32(op_arg);
>>     }
>>
>> --
>> 2.15.1
>>
>> --
>> You received this bug notification because you are subscribed to the bug
>> report.
>> https://bugs.launchpad.net/bugs/1735384
>>
>> Title:
>>  OpenJDK JVM segfaults on qemu-sh4 (regression)
>>
>> Status in QEMU:
>>  New
>>
>> Bug description:
>>  Some of the recent changes introduced a regression which makes the
>>  OpenJDK JVM crash on qemu-sh4:
>>
>>  (sid-sh4-sbuild)root@nofan:/# java -version
>>  qemu: uncaught target signal 11 (Segmentation fault) - core dumped
>>  Segmentation fault
>>  (sid-sh4-sbuild)root@nofan:/#
>>
>>  An older version works fine:
>>
>>  (sid-sh4-sbuild)root@nofan:/# java -version
>>  openjdk version "9.0.1"
>>  OpenJDK Runtime Environment (build 9.0.1+11-Debian-1)
>>  OpenJDK Zero VM (build 9.0.1+11-Debian-1, interpreted mode)
>>  (sid-sh4-sbuild)root@nofan:/#
>>
>>  Haven't had time for bisecting this yet.
>>
>>  Adrian
>>
>> To manage notifications about this bug go to:
>> https://bugs.launchpad.net/qemu/+bug/1735384/+subscriptions


--
Alex Benn=C3=A9e
