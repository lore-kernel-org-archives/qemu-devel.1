Received: from eggs.gnu.org ([2001:4830:134:3::10]:54723)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJglb-0001sE-Jg
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:54:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fJgla-0003PN-JE
	for qemu-devel@nongnu.org; Fri, 18 May 2018 10:53:59 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180517174718.10107-1-alex.bennee@linaro.org>
	<20180517174718.10107-33-alex.bennee@linaro.org>
	<9ef2bc85-cead-080c-8313-bf0113d5019e@linaro.org>
	<927cd32b-6de1-3702-5125-e682fb2ffcd4@amsat.org>
	<87k1s1e5vd.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <80c70a91-5071-7784-f3cf-d175f4d7fffb@amsat.org>
Date: Fri, 18 May 2018 11:53:47 -0300
MIME-Version: 1.0
In-Reply-To: <87k1s1e5vd.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, cota@braap.org, famz@redhat.com, berrange@redhat.com, balrogg@gmail.com, aurelien@aurel32.net, agraf@suse.de, qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "open list:ARM" <qemu-arm@nongnu.org>

On 05/18/2018 05:16 AM, Alex Bennée wrote:
> 
> Philippe Mathieu-Daudé <f4bug@amsat.org> writes:
> 
>> On 05/17/2018 05:30 PM, Richard Henderson wrote:
>>> On 05/17/2018 10:47 AM, Alex Bennée wrote:
>>>> This runs through the usual float to float conversions and crucially
>>>> also runs with ARM Alternative Half Precision Format.
>>>>
>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>> [rth: tweak vcvtb.f16.f32/vctb.f32.f16 code and regen]
>>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>>>
>>>> ---
>>>> v4
>>>>   - add fcvt.ref and check results against it
>>>>   - fix single_to_half, single_to_double conversions
>>>>   - properly toggle AHP mode (fpsr->fpcr)
>>>>   - more values around the AHP margins
>>>>   - add INF/NAN/SNAN inputs
>>>>   - build for ARM and AArch64
>>>>   - fix bug for hex literals
>>>>   - add float-to-int
>>>>   - checkpatch fix
>>>> ---
>>>
>>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>>
>> Thanks Richard, I was not very motivated to review each line of the
>> fcvt.ref files =)
>>
>>> diff --git a/tests/tcg/arm/Makefile.target b/tests/tcg/arm/Makefile.target
>>> index 9d2b551732..7bb777f442 100644
>>> --- a/tests/tcg/arm/Makefile.target
>>> +++ b/tests/tcg/arm/Makefile.target
>>> @@ -8,7 +8,9 @@ ARM_SRC=$(SRC_PATH)/tests/tcg/arm
>>>  # Set search path for all sources
>>>  VPATH 		+= $(ARM_SRC)
>>>
>>> -TESTS += hello-arm test-arm-iwmmxt
>>> +ARM_TESTS=hello-arm test-arm-iwmmxt
>>> +
>>> +TESTS += $(ARM_TESTS) fcvt
>>>
>>>  hello-arm: CFLAGS+=-marm -ffreestanding
>>>  hello-arm: LDFLAGS+=-nostdlib
>>> @@ -24,3 +26,14 @@ run-test-mmap: test-mmap
>>>  	$(call quiet-command, $(QEMU) -p 8192 $< 8192 > test-mmap-8192.out,
>> "TEST", "$< (8k pages) on $(TARGET_NAME)")
>>>  	$(call quiet-command, $(QEMU) -p 16384 $< 16384 >
>> test-mmap-16384.out, "TEST", "$< (16k pages) on $(TARGET_NAME)")
>>>  endif
>>> +
>>> +ifeq ($(TARGET_NAME), arm)
>>> +fcvt: LDFLAGS+=-lm
>>> +# fcvt: CFLAGS+=-march=armv8.2-a+fp16 -mfpu=neon-fp-armv8
>>
>> Alex, What is your idea here, enable this later?
>> Maybe add some TODO comment around..
> 
> How about:
> 
> # AArch32 doesn't support all combinations of FP16<->FOO in it's base
> # profile. Once the AArch32 profile is caught up we should build an
> # additional binary and reference to test the additional combinations.
> 
> I backed the change out when I realised the stretch compiler didn't
> support the same range as my local (18.04) gcc's.

Fine by me, thanks.

>>
>> Except this nit, for both Makefile.target:
>> Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
