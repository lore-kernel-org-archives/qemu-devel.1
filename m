Received: from eggs.gnu.org ([209.51.188.92]:59600)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMDZW-0005uI-Gk
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:24:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hMDZV-00082B-15
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:24:30 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:38695)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hMDZT-00081q-TL
	for qemu-devel@nongnu.org; Thu, 02 May 2019 11:24:28 -0400
Received: by mail-pl1-x644.google.com with SMTP id a59so1188887pla.5
	for <qemu-devel@nongnu.org>; Thu, 02 May 2019 08:24:26 -0700 (PDT)
References: <20190501050536.15580-1-richard.henderson@linaro.org>
	<20190501050536.15580-10-richard.henderson@linaro.org>
	<87imut5h10.fsf@zen.linaroharston>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <2b019ad5-396f-c337-499f-b120aea2e4ad@linaro.org>
Date: Thu, 2 May 2019 08:24:21 -0700
MIME-Version: 1.0
In-Reply-To: <87imut5h10.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 09/29] tcg: Manually expand
 INDEX_op_dup_vec
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org

On 5/2/19 2:42 AM, Alex Bennée wrote:
>> +static void tcg_reg_alloc_dup(TCGContext *s, const TCGOp *op)
>> +{
>> +    const TCGLifeData arg_life = op->life;
>> +    TCGRegSet dup_out_regs, dup_in_regs;
>> +    TCGTemp *its, *ots;
>> +    TCGType itype, vtype;
>> +    unsigned vece;
>> +    bool ok;
>> +
>> +    ots = arg_temp(op->args[0]);
>> +    its = arg_temp(op->args[1]);
>> +
>> +    /* There should be no fixed vector registers.  */
>> +    tcg_debug_assert(!ots->fixed_reg);
> 
> This threw me slightly. I guess you only really duplicate vectors so I'm
> wondering if this should be called tcg_vec_reg_alloc_dup? Or maybe just
> a bit of verbiage in a block comment above the helper?

Perhaps just a bit more verbiage.

The convention so far is "tcg_reg_alloc_<opcode>", where so far mov, movi, and
call have specialized allocators.  Everything else happens in tcg_reg_alloc_op.
 So tcg_reg_alloc_dup is correct for handling dup.


>> +    case TEMP_VAL_MEM:
>> +        /* TODO: dup from memory */
>> +        tcg_out_ld(s, itype, ots->reg, its->mem_base->reg,
>> its->mem_offset);
> 
> Should we be aborting here? That said it looks like you are loading
> something directly from the register memory address here...

No, we should not abort.  We load the scalar value into a register that we have
allocated that matches the input constraint for dup.  We then fall through...

> 
>> +        break;
>> +
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +
>> +    /* We now have a vector input register, so dup must succeed. */
>> +    ok = tcg_out_dup_vec(s, vtype, vece, ots->reg, ots->reg);
>> +    tcg_debug_assert(ok);

... to here, where we duplicate the scalar across the vector.
Success.

The TODO comment is about duplicating directly from the memory slot, with a new
dupm primitive, which appears in the next patch.


r~
