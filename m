Received: from eggs.gnu.org ([2001:4830:134:3::10]:54760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJaYf-0002YE-TI
	for qemu-devel@nongnu.org; Fri, 18 May 2018 04:16:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fJaYb-0001DH-Ki
	for qemu-devel@nongnu.org; Fri, 18 May 2018 04:16:13 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:34793)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fJaYb-0001Ci-CM
	for qemu-devel@nongnu.org; Fri, 18 May 2018 04:16:09 -0400
Received: by mail-wr0-x242.google.com with SMTP id p18-v6so8244761wrm.1
	for <qemu-devel@nongnu.org>; Fri, 18 May 2018 01:16:09 -0700 (PDT)
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-33-alex.bennee@linaro.org>
	<9ef2bc85-cead-080c-8313-bf0113d5019e@linaro.org>
	<927cd32b-6de1-3702-5125-e682fb2ffcd4@amsat.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <927cd32b-6de1-3702-5125-e682fb2ffcd4@amsat.org>
Date: Fri, 18 May 2018 09:16:06 +0100
Message-ID: <87k1s1e5vd.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 32/49] tests/tcg/arm: add fcvt test
 cases for AArch32/64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>


Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> writes:

> On 05/17/2018 05:30 PM, Richard Henderson wrote:
>> On 05/17/2018 10:47 AM, Alex Benn=C3=A9e wrote:
>>> This runs through the usual float to float conversions and crucially
>>> also runs with ARM Alternative Half Precision Format.
>>>
>>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> [rth: tweak vcvtb.f16.f32/vctb.f32.f16 code and regen]
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>
>>> ---
>>> v4
>>>   - add fcvt.ref and check results against it
>>>   - fix single_to_half, single_to_double conversions
>>>   - properly toggle AHP mode (fpsr->fpcr)
>>>   - more values around the AHP margins
>>>   - add INF/NAN/SNAN inputs
>>>   - build for ARM and AArch64
>>>   - fix bug for hex literals
>>>   - add float-to-int
>>>   - checkpatch fix
>>> ---
>>
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> Thanks Richard, I was not very motivated to review each line of the
> fcvt.ref files =3D)
>
>> diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.targ=
et
>> index 9d2b551732..7bb777f442 100644
>> --- a/tests/tcg/arm/Makefile.target
>> +++ b/tests/tcg/arm/Makefile.target
>> @@ -8,7 +8,9 @@ ARM_SRC=3D$(SRC_PATH)/tests/tcg/arm
>>  # Set search path for all sources
>>  VPATH 		+=3D $(ARM_SRC)
>>
>> -TESTS +=3D hello-arm test-arm-iwmmxt
>> +ARM_TESTS=3Dhello-arm test-arm-iwmmxt
>> +
>> +TESTS +=3D $(ARM_TESTS) fcvt
>>
>>  hello-arm: CFLAGS+=3D-marm -ffreestanding
>>  hello-arm: LDFLAGS+=3D-nostdlib
>> @@ -24,3 +26,14 @@ run-test-mmap: test-mmap
>>  	$(call quiet-command, $(QEMU) -p 8192 $< 8192 > test-mmap-8192.out,
> "TEST", "$< (8k pages) on $(TARGET_NAME)")
>>  	$(call quiet-command, $(QEMU) -p 16384 $< 16384 >
> test-mmap-16384.out, "TEST", "$< (16k pages) on $(TARGET_NAME)")
>>  endif
>> +
>> +ifeq ($(TARGET_NAME), arm)
>> +fcvt: LDFLAGS+=3D-lm
>> +# fcvt: CFLAGS+=3D-march=3Darmv8.2-a+fp16 -mfpu=3Dneon-fp-armv8
>
> Alex, What is your idea here, enable this later?
> Maybe add some TODO comment around..

How about:

# AArch32 doesn't support all combinations of FP16<->FOO in it's base
# profile. Once the AArch32 profile is caught up we should build an
# additional binary and reference to test the additional combinations.

I backed the change out when I realised the stretch compiler didn't
support the same range as my local (18.04) gcc's.

>
> Except this nit, for both Makefile.target:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
>> +
>> +run-fcvt: fcvt
>> +	$(call quiet-command, \
>> +		$(QEMU) $< > fcvt.out && \
>> +		diff -u $(ARM_SRC)/fcvt.ref fcvt.out, \
>> +		"TEST", "$< (default) on $(TARGET_NAME)")
>> +endif
>
> $ make -j1 run-tcg-tests-aarch64-linux-user
>   BUILD   debian9
>   BUILD   debian-arm64-cross
>   CROSS-BUILD aarch64 guest-tests with docker qemu:debian-arm64-cross
>   BUILD   debian9
>   BUILD   debian-arm64-cross
>   CROSS-BUILD aarch64 guest-tests with docker qemu:debian-arm64-cross
>   RUN-TESTS for aarch64
>   TEST    test-mmap (default) on aarch64
>   TEST    test-mmap (8k pages) on aarch64
>   TEST    test-mmap (16k pages) on aarch64
>   TEST    test-mmap (32k pages) on aarch64
>   TEST    sha1 on aarch64
>   TEST    linux-test on aarch64
>   TEST    testthread on aarch64
>   TEST    fcvt (default) on aarch64
>   TEST    sysregs on aarch64
>
> \o/
>
> Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>


--
Alex Benn=C3=A9e
