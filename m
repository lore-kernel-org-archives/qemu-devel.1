Received: from eggs.gnu.org ([209.51.188.92]:60958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gkQ4I-0004T4-Jn
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:04:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gkQ4G-0006YJ-My
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:04:02 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38241)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gkQ4E-0006VW-Pe
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 04:04:00 -0500
Received: by mail-wr1-f68.google.com with SMTP id v13so14074384wrw.5
	for <qemu-devel@nongnu.org>; Fri, 18 Jan 2019 01:03:58 -0800 (PST)
References: <20190117132703.17790-1-alex.bennee@linaro.org>
	<CAFEAcA_E2Lf9Zh2WhVDddJiD5TPPyLk1RvT7_Asn4vXnao1NjQ@mail.gmail.com>
	<20190117183002.GA21582@flamenco>
	<CAFEAcA_RN-68EXsfFqkXDp5BUB4QD01KqzCAX9=7VWPYN0NAvA@mail.gmail.com>
	<871s5byriy.fsf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <e655e325-15ad-9e97-eb27-8a15ea77a889@redhat.com>
Date: Fri, 18 Jan 2019 10:03:55 +0100
MIME-Version: 1.0
In-Reply-To: <871s5byriy.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Emilio G. Cota" <cota@braap.org>, QEMU Developers <qemu-devel@nongnu.org>

Hi Alex,

On 1/17/19 9:10 PM, Alex Bennée wrote:
> 
> Peter Maydell <peter.maydell@linaro.org> writes:
> 
>> On Thu, 17 Jan 2019 at 18:30, Emilio G. Cota <cota@braap.org> wrote:
>>>
>>> On Thu, Jan 17, 2019 at 17:37:54 +0000, Peter Maydell wrote:
>>>> On Thu, 17 Jan 2019 at 13:27, Alex Bennée <alex.bennee@linaro.org> wrote:
>>>>>
>>>>> The following changes since commit 4b9f0b0f7c84eea2dfb0d5be3e0254bc91319dbc:
>>>>>
>>>>>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2019-01-15 17:24:00 +0000)
>>>>>
>>>>> are available in the Git repository at:
>>>>>
>>>>>   https://github.com/stsquad/qemu.git tags/pull-fpu-next-170119-1
>>> (snip)
>>>>
>>>> FreeBSD, OSX, x86-64 Linux clang builds:
>>> (snip)
>>>> PPC64, AArch64:
>>> (snip)
>>>> NetBSD:
>>> (snip)
>>>
>>> I have added a few commits to fix these -- diff below.
>>> Note that one fix requires a small change in the testfloat
>>> submodule, which I'm pulling here.
>>>
>>> Alex, can you cherry-pick the commits in this branch?
>>>
>>>   https://github.com/cota/qemu/tree/bennee-pull
>>>
>>> They should go in before adding fp-test to the automated build,
>>> of course. I left them at the top to make it easier for
>>> you to cherry-pick.
>>>
>>> Also, since this will require a respin, you might want to fix the
>>> "Makfile" typo in patch 7's title.
>>>
>>>> S390X host:
>>>> Looks like a failure running the tests, but no diagnostics about
>>>> what exactly went wrong or clear "test failed" indicator:
>>>>
>>>> cd /home/linux1/qemu/build/all/tests/fp && ./fp-test -s -l 1
>>>> i32_to_f16 i64_to_f16 i32_to_f32 i64_t
>>>> o_f32 i32_to_f64 i64_to_f64 i32_to_f128 i64_to_f128 >
>>>> int-to-float.out 2>  int-to-float.err
>>>> /home/linux1/qemu/tests/Makefile.include:913: recipe for target
>>>> 'check-softfloat-conv' failed
>>>> make: *** [check-softfloat-conv] Error 1
>>>
>>> What are the contents of "int-to-float.err"?

Can you modify the Makefile.include to use:
 "fp-test ... 2>int-to-float.err || {cat int-to-float.err && exit 1;}"

Thanks!

Phil.

>>
> <snip>
>>>> Testing i32_to_f128
>> 372 tests total.
>> 21 tests performed; 20 errors found.
> 
> It's probably not a regression but a failure in the old f128 code. When
> I was enabling the tests I basically turned them all on and then
> disabled what failed (all of which was exercising non-refactored code).
> But of course this was all on x86_64 (although I also ran them on a
> aarch64 host). It looks like more errors come out on a s390x host for
> some reason. You can run manually for a more complete test with more
> coverage:
> 
>   ./fp-test -l 2 -r all i32_to_f128
> 
>>
>>
>>> diff --git a/tests/fp/Makefile b/tests/fp/Makefile
>>> index 5019dcdca0..5a35e7c210 100644
>>> --- a/tests/fp/Makefile
>>> +++ b/tests/fp/Makefile
>>> @@ -65,8 +65,7 @@ QEMU_CFLAGS += $(TF_OPTS)
>>>  TF_CFLAGS :=
>>>  TF_CFLAGS += -Wno-strict-prototypes
>>>  TF_CFLAGS += -Wno-unknown-pragmas
>>> -TF_CFLAGS += -Wno-discarded-qualifiers
>>> -TF_CFLAGS += -Wno-maybe-uninitialized
>>> +TF_CFLAGS += -Wno-uninitialized
>>>  TF_CFLAGS += -Wno-missing-prototypes
>>>  TF_CFLAGS += -Wno-return-type
>>>  TF_CFLAGS += -Wno-unused-function
>>
>> configure has logic to check whether it can use particular
>> warning enable/disable flags. Newer gcc (and I hope clang
>> but forget) will happily silently allow -Wno-random-new-thing
>> even if they don't support -Wrandom-new-thing) but I'm not
>> sure our minimum compiler version is yet new enough to
>> be able to rely on that (indeed the warning messages suggest
>> it is not).
>>
>>> diff --git a/tests/fp/berkeley-testfloat-3 b/tests/fp/berkeley-testfloat-3
>>> index ca9fa2ba05..5a59dcec19 160000
>>> --- a/tests/fp/berkeley-testfloat-3
>>> +++ b/tests/fp/berkeley-testfloat-3
>>> @@ -1 +1 @@
>>> -Subproject commit ca9fa2ba05625ba929958f163b01747e07dd39cc
>>> +Subproject commit 5a59dcec19327396a011a17fd924aed4fec416b3
>>> diff --git a/tests/fp/fp-test.c b/tests/fp/fp-test.c
>>> index fca576309c..2a35ef601d 100644
>>> --- a/tests/fp/fp-test.c
>>> +++ b/tests/fp/fp-test.c
>>> @@ -789,7 +789,7 @@ static int set_init_flags(const char *flags)
>>>      return 0;
>>>  }
>>>
>>> -static uint8_t slow_clear_flags(void)
>>> +static uint_fast8_t slow_clear_flags(void)
>>>  {
>>>      uint8_t prev = slowfloat_exceptionFlags;
>>>
>>> @@ -797,7 +797,7 @@ static uint8_t slow_clear_flags(void)
>>>      return prev;
>>>  }
>>>
>>> -static uint8_t qemu_clear_flags(void)
>>> +static uint_fast8_t qemu_clear_flags(void)
>>>  {
>>>      uint8_t prev = qemu_flags_to_sf(qsf.float_exception_flags);
>>
>> Why are we using uint_fast8_t here anyway? We switched
>> softfloat to using plain old uint8_t everywhere a while
>> back.
>>
>> thanks
>> -- PMM
> 
> 
> --
> Alex Bennée
> 
