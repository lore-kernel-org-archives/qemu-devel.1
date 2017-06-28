Received: from eggs.gnu.org ([2001:4830:134:3::10]:41111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dQ8gx-0000eT-AR
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 04:51:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1dQ8gt-0006Mf-EZ
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 04:51:19 -0400
Received: from mail-wm0-x231.google.com ([2a00:1450:400c:c09::231]:35096)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1dQ8gt-0006MC-5k
	for qemu-devel@nongnu.org; Wed, 28 Jun 2017 04:51:15 -0400
Received: by mail-wm0-x231.google.com with SMTP id w126so46403568wme.0
	for <qemu-devel@nongnu.org>; Wed, 28 Jun 2017 01:51:13 -0700 (PDT)
References: <20170621024831.26019-1-rth@twiddle.net>
	<20170621024831.26019-7-rth@twiddle.net>
	<87y3sdx1rr.fsf@linaro.org>
	<5554273c-7858-9048-5c2c-4677884baff5@twiddle.net>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <5554273c-7858-9048-5c2c-4677884baff5@twiddle.net>
Date: Wed, 28 Jun 2017 09:52:04 +0100
Message-ID: <87mv8swl3f.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 06/16] tcg: Add temp_global bit to TCGTemp
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: qemu-devel@nongnu.org, aurelien@aurel32.net


Richard Henderson <rth@twiddle.net> writes:

> On 06/27/2017 01:39 AM, Alex Bennée wrote:
>>> +    /* If true, the temp is saved across both basic blocks and
>>> +       translation blocks.  */
>>> +    unsigned int temp_global:1;
>>> +    /* If true, the temp is saved across basic blocks but dead
>>> +       at the end of translation blocks.  If false, the temp is
>>> +       dead at the end of basic blocks.  */
>>> +    unsigned int temp_local:1;
>>> +    unsigned int temp_allocated:1;
>>
>> This is where my knowledge of the TCG internals gets slightly confused.
>> As far as I'm aware all our TranslationBlocks are Basic Blocks - they
>> don't have any branches until the end of the block. What is the
>> distinction here?
>>
>> Is a temp_global truly global? I thought the guest state was fully
>> rectified by the time we leave the basic block.
>
> TranslationBlocks are not basic blocks.  They normally stop at
> branches in the target instruction stream, but they certainly may have
> many branches in the tcg opcode stream (brcond and the like).
> Consider, for instance, our implementation of arm32's conditional
> instructions.

Right. Re-reading the tcg/README it does make the distinction but the
term "basic block" is overloaded depending on when talking about the
guest instructions or the generated code.

>
> Beyond that, I agree the language is confusing.
>
> A temp_global is created by tcg_global_mem_new_*, generally represents
> a cpu register, and is synced back to a slot in ENV.
>
> A temp_local is created by tcg_temp_local_new_*, and is synced to a
> slot in the local stack frame.

The language from the README:

  A TCG "temporary" is a variable only live in a basic
  block. Temporaries are allocated explicitly in each function.

  A TCG "local temporary" is a variable only live in a function. Local
  temporaries are allocated explicitly in each function.

I must admit I hadn't quite understood the distinction. In the ARM code
the only place where tcg_temp_local_new() over tcg_temp_new() is used is
in the ld/strex code. I guess because you need to preserve its value
over a potential TCG branch?

I guess in translate-a64/gen_store_exclusive() the key lines are:

  TCGv_i64 addr = tcg_temp_local_new_i64();

  /* Copy input into a local temp so it is not trashed when the
   * basic block ends at the branch insn.
   */
  tcg_gen_mov_i64(addr, inaddr);
  tcg_gen_brcond_i64(TCG_COND_NE, addr, cpu_exclusive_addr, fail_label);

> Something without either is simply declared dead at the end of a basic
> block, and is a source of confusion to those writing new front-ends.

I'll see if I can come up with some improved wording to help new
developers in the future.

> Anyway, we already have all of these concepts.  The change is that
> before the patch the only way to tell a temp_global is to compare the
> index against tcg_ctx.nb_global.

Indeed. As I have previously really only been a consumer of the TCG API
I'm taking the opportunity to learn more about the internals as the
vector work is likely to touch it ;-)

>
>
> r~


--
Alex Bennée
