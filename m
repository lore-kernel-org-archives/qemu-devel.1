Received: from eggs.gnu.org ([2001:4830:134:3::10]:47272)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eS6Oo-000069-92
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:20:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1eS6Ol-0001dj-Io
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:20:58 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:63959)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1eS6Ol-0001bP-95
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 14:20:55 -0500
From: Laurent Vivier <laurent@vivier.eu>
References: <1513790098-9815-1-git-send-email-pbonzini@redhat.com>
	<CAFEAcA8J53A93+SQz01W13gRCX-ecw0v+8JTaRqwmrUeFjqaJA@mail.gmail.com>
	<51174e3a-12d3-f3e0-2d76-b776e0fe62b6@redhat.com>
	<e7994a8d-3a02-99c7-d919-c940aa4bc066@redhat.com>
	<40dbaff2-918c-bba6-2a70-7c5f9b19cb66@vivier.eu>
	<0d3d6598-608c-0079-426f-7455a92de7d8@vivier.eu>
	<64440fda-1799-f50d-21ed-dc898e08d82f@redhat.com>
	<8033acdb-f88a-2df3-83f3-e3e304c8eb51@vivier.eu>
	<183d1158-2aa3-7ecb-3372-4a206f4c5292@redhat.com>
	<3aee5f72-55ee-3653-d409-0f77e40cf90f@vivier.eu>
Message-ID: <172eed1f-4769-b3d5-e9f8-48dd834049d8@vivier.eu>
Date: Thu, 21 Dec 2017 20:20:40 +0100
MIME-Version: 1.0
In-Reply-To: <3aee5f72-55ee-3653-d409-0f77e40cf90f@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] out of bounds in set_cc_op()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Richard Henderson <rth@twiddle.net>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

Le 21/12/2017 à 15:36, Laurent Vivier a écrit :
> Le 21/12/2017 à 15:14, Paolo Bonzini a écrit :
>> On 21/12/2017 15:13, Laurent Vivier wrote:
>>> Le 21/12/2017 à 15:10, Paolo Bonzini a écrit :
>>>> On 21/12/2017 14:32, Laurent Vivier wrote:
>>>>> Le 21/12/2017 à 14:07, Laurent Vivier a écrit :
>>>>>> Le 21/12/2017 à 13:49, Thomas Huth a écrit :
>>>>>>> On 20.12.2017 22:56, Paolo Bonzini wrote:
>>>>>>>> On 20/12/2017 20:20, Peter Maydell wrote:
>>>>>>>>> On the x86/sanitizer build, new runtime errors:
>>>>>>>>>   GTESTER check-qtest-m68k
>>>>>>>>> /home/petmay01/linaro/qemu-for-merges/target/m68k/translate.c:230:12:
>>>>>>>>> runtime error: index -1 out of bounds for type 'const uint8_t [11]'
>>>>>>>>>
>>>>>>>>> ...and similar fails on one or two boards on most of the other
>>>>>>>>> guest architectures.
>>>>>>>>
>>>>>>>> These are preexisting bugs, now exposed by the boot-serial-test.
>>>>>>>> Thomas, can you identify the architectures that have a problem and
>>>>>>>> notify the maintainers?  In the meanwhile I'll keep the boot-serial-test
>>>>>>>> enhancements queued locally, and remove them from the pull request.
>>>>>>>
>>>>>>>  Laurent, Richard,
>>>>>>>
>>>>>>> looks like old_op is -1 when set_cc_op() is called here for the first
>>>>>>> time. The problem can be reproduced by running the mini-kernel directly.
>>>>>>> Just get http://people.redhat.com/~thuth/m68k-uart.bin and run QEMU like
>>>>>>> this:
>>>>>>>
>>>>>>>  qemu-system-m68k -nographic -kernel  ~/tmp/m68k-uart.bin -serial none
>>>>>>>
>>>>>>> That kernel only contains these few instructions:
>>>>>>>
>>>>>>>   0x41, 0xf9, 0xfc, 0x06, 0x00, 0x00,     /* lea 0xfc060000,%a0 */
>>>>>>>   0x10, 0x3c, 0x00, 0x54,                 /* move.b #'T',%d0 */
>>>>>>>   0x11, 0x7c, 0x00, 0x04, 0x00, 0x08,     /* move.b #4,8(%a0) */
>>>>>>>   0x11, 0x40, 0x00, 0x0c,                 /* move.b %d0,12(%a0) */
>>>>>>>   0x60, 0xfa                              /* bra.s  loop */
>>>>>>>
>>>>>>> The problem occurs during the second instruction (i.e. the first move.b).
>>>>>>>
>>>>>>> Do you have any ideas where this -1 in s->cc_op could come from?
>>>>>>
>>>>>> I think it comes from CCOp: it's the value of CC_OP_DYNAMIC.
>>>>>>
>>>>>> We should not use it to access cc_op_live[].
>>>>>>
>>>>>> I try to find a fix, but I think Richard knows this better than me.
>>>>>
>>>>> This should fix the problem, but I'd like Richard checks it...
>>>>>
>>>>> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
>>>>> index b60909222c..721b5801da 100644
>>>>> --- a/target/m68k/translate.c
>>>>> +++ b/target/m68k/translate.c
>>>>> @@ -225,6 +225,11 @@ static void set_cc_op(DisasContext *s, CCOp op)
>>>>>      s->cc_op = op;
>>>>>      s->cc_op_synced = 0;
>>>>>
>>>>> +    if (old_op == CC_OP_DYNAMIC) {
>>>>> +        tcg_gen_discard_i32(QREG_CC_OP);
>>>>> +        return;
>>>>> +    }
>>>>
>>>> This tcg_gen_discard_i32 is correct, but all flags were potentially live
>>>> and can be discarded if the new op uses it(*).  So I'd replace "return"
>>>> with "old_op = CC_OP_FLAGS".
>>>
>>> Yes, I agree, we can also have:
>>>
>>> iff --git a/target/m68k/cpu.h b/target/m68k/cpu.h
>>> index afae5f68ac..5d03764eab 100644
>>> --- a/target/m68k/cpu.h
>>> +++ b/target/m68k/cpu.h
>>> @@ -182,7 +182,7 @@ void cpu_m68k_set_fpcr(CPUM68KState *env, uint32_t val);
>>>   */
>>>  typedef enum {
>>>      /* Translator only -- use env->cc_op.  */
>>> -    CC_OP_DYNAMIC = -1,
>>> +    CC_OP_DYNAMIC,
>>>
>>>      /* Each flag bit computed into cc_[xcnvz].  */
>>>      CC_OP_FLAGS,
>>> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
>>> index b60909222c..61ac1a8e83 100644
>>> --- a/target/m68k/translate.c
>>> +++ b/target/m68k/translate.c
>>> @@ -207,6 +207,7 @@ typedef void (*disas_proc)(CPUM68KState *env,
>>> DisasContext *s, uint16_t insn);
>>>  #endif
>>>
>>>  static const uint8_t cc_op_live[CC_OP_NB] = {
>>> +    [CC_OP_DYNAMIC] = CCF_C | CCF_V | CCF_Z | CCF_N | CCF_X,
>>>      [CC_OP_FLAGS] = CCF_C | CCF_V | CCF_Z | CCF_N | CCF_X,
>>>      [CC_OP_ADDB ... CC_OP_ADDL] = CCF_X | CCF_N | CCF_V,
>>>      [CC_OP_SUBB ... CC_OP_SUBL] = CCF_X | CCF_N | CCF_V,
>>> @@ -237,6 +238,11 @@ static void set_cc_op(DisasContext *s, CCOp op)
>>>      if (dead & CCF_V) {
>>>          tcg_gen_discard_i32(QREG_CC_V);
>>>      }
>>> +
>>> +    /* Discard any computed CC_OP value */
>>> +    if (old_op == CC_OP_DYNAMIC) {
>>> +        tcg_gen_discard_i32(QREG_CC_OP);
>>> +    }
>>>  }
>>>
>>>  /* Update the CPU env CC_OP state.  */
>>>
>>>
>>
>> Yes, this is good too.  After my pull request is in, feel free to take
>> Thomas's m68k boot-serial-test patch in your tree.

And what about:

      tests/boot-serial-test: Add tests for microblaze boards
      tests/boot-serial-test: Add a test for the moxiesim machine
      tests/boot-serial-test: Add support for the raspi2 machine

?

Thanks,
Laurent
