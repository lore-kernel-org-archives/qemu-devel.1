Received: from eggs.gnu.org ([2001:4830:134:3::10]:46206)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5x8D-0006vd-1B
	for qemu-devel@nongnu.org; Wed, 03 May 2017 12:28:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1d5x8C-0005rc-0l
	for qemu-devel@nongnu.org; Wed, 03 May 2017 12:28:01 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36519)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1d5x8B-0005rK-SL
	for qemu-devel@nongnu.org; Wed, 03 May 2017 12:27:59 -0400
Received: by mail-qk0-x242.google.com with SMTP id o4so3407801qkb.3
	for <qemu-devel@nongnu.org>; Wed, 03 May 2017 09:27:58 -0700 (PDT)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20170502192300.2124-1-rth@twiddle.net>
	<6d583a19-0134-3332-e116-dba4ed2e758e@twiddle.net>
	<20170503155107.GA13895@flamenco>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <5218784b-4657-85fe-9ea2-a898d4609ced@twiddle.net>
Date: Wed, 3 May 2017 09:27:54 -0700
MIME-Version: 1.0
In-Reply-To: <20170503155107.GA13895@flamenco>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 00/25] tcg cross-tb optimizations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: qemu-devel@nongnu.org

On 05/03/2017 08:51 AM, Emilio G. Cota wrote:
> On Tue, May 02, 2017 at 20:36:52 -0700, Richard Henderson wrote:
>> On 05/02/2017 12:22 PM, Richard Henderson wrote:
>>> Changes since v5:
>> ...
>>>    * Alpha frontend patch rewritten; the former patch appears to
>>>      drop clock interrupts, not exiting the kernel's idle loop.
>>>      I never *really* figured out why, since both patches seem
>>>      to annotate the same TBs in the same way.
>>
>> There's definitely something odd going on.
>>
>> With a rebuild from scratch, the same symptoms have re-appeared for Alpha.
>> So it really had nothing to do with the original patch.  I'm at a bit of a
>> loss...
> 
> I can reliably reproduce a freeze upon booting.

Oh good.  Sort of.  The oddly non-reproducible nature of this for me has been 
disconcerting.

> Not sure this can help much (this is the first time I run an Alpha
> guest), but here are some findings.
> 
> In my testing, if I disable the lookup for JMP/JSR/ret, I can boot OK.
> This works:
> 
> +++ b/target/alpha/translate.c
> @@ -2435,12 +2435,16 @@ static ExitStatus translate_one(DisasContext *ctx, uint32_t insn)
>           if (ra != 31) {
>               tcg_gen_movi_i64(ctx->ir[ra], ctx->pc);
>           }
> +#if 0
>           if (use_exit_tb(ctx)) {
>               ret = EXIT_PC_UPDATED;
>           } else {
>               tcg_gen_lookup_and_goto_ptr(cpu_pc);
>               ret = EXIT_GOTO_TB;
>           }
> +#else
> +        ret = EXIT_PC_UPDATED;
> +#endif
>           break;
> 
> However, this doesn't tell us much, since these jumps are pretty common.

Indeed.

> Interestingly, if I leave the lookup_and_goto_ptr above (s/#if 0/#if 1/), but
> change the lookup_ptr helper to bypass tb_jmp_cache and directly check the
> htable, it boots OK.

Now that *is* odd.  However ...

> Could it be that we're forgetting to clear (or set) tb_jmp_cache somewhere?

... even that should not affect the setting (or clearing) of 
cpu->icount_decr.u16.high.  Which should have been set by tcg_handle_interrupt. 
  We should have exited the chain of TBs at some point.

Which to me means there's some deeper issue.  I.e. the only reason it's been 
working to date so far is that previously we never put together chains of any 
great length.


r~
