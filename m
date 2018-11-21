Received: from eggs.gnu.org ([2001:4830:134:3::10]:36806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gPNG7-00017i-8B
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 02:49:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gPNAG-00056R-KE
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 02:43:15 -0500
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:53938)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gPNAG-00055e-Db
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 02:43:12 -0500
Received: by mail-wm1-x32b.google.com with SMTP id y1so1218582wmi.3
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 23:43:12 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<bd8f5c781f7086c5b26e1bd4c8e6570b5534b22d.1542321076.git.alistair.francis@wdc.com>
	<f56a1b1c-8cc8-7e85-c88b-3894e4628d6b@linaro.org>
	<CAKmqyKMJm-hcBLeP5-hWW-0Sru8ggFVWFZRCiHhZ4romx-ej4g@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <09e882be-660e-03e9-34cd-7f667f09d7af@linaro.org>
Date: Wed, 21 Nov 2018 08:43:08 +0100
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMJm-hcBLeP5-hWW-0Sru8ggFVWFZRCiHhZ4romx-ej4g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 16/23] riscv: tcg-target: Add slowpath
 load and store instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Alistair Francis <Alistair.Francis@wdc.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-riscv@nongnu.org

On 11/21/18 1:18 AM, Alistair Francis wrote:
> On Fri, Nov 16, 2018 at 1:24 AM Richard Henderson
> <richard.henderson@linaro.org> wrote:
>>
>> On 11/15/18 11:36 PM, Alistair Francis wrote:
>>> +static void tcg_out_mb(TCGContext *s, TCGArg a0)
>>> +{
>>> +    static const RISCVInsn fence[] = {
>>> +        [0 ... TCG_MO_ALL] = OPC_FENCE_RW_RW,
>>> +        [TCG_MO_LD_LD]     = OPC_FENCE_R_R,
>>> +        [TCG_MO_ST_LD]     = OPC_FENCE_W_R,
>>> +        [TCG_MO_LD_ST]     = OPC_FENCE_R_W,
>>> +        [TCG_MO_ST_ST]     = OPC_FENCE_W_W,
>>> +        [TCG_BAR_LDAQ]     = OPC_FENCE_R_RW,
>>> +        [TCG_BAR_STRL]     = OPC_FENCE_RW_W,
>>> +        [TCG_BAR_SC]       = OPC_FENCE_RW_RW,
>>> +    };
>>> +    tcg_out32(s, fence[a0 & TCG_MO_ALL]);
>>> +}
>>> +
>>
>> TCG_MO_* and TCG_BAR_* are two different bitmasks, or'ed together.
>> Which you've separated by "& TCG_MO_ALL".  Thus the TCG_BAR_* constants should
>> not appear in this table.
>>
>>
>>> +static void * const qemu_ld_helpers[16] = {
>>> +    [MO_UB]   = helper_ret_ldub_mmu,
>>> +    [MO_SB]   = helper_ret_ldsb_mmu,
>>> +    [MO_LEUW] = helper_le_lduw_mmu,
>>> +    [MO_LESW] = helper_le_ldsw_mmu,
>>> +    [MO_LEUL] = helper_le_ldul_mmu,
>>> +    [MO_LESL] = helper_le_ldsl_mmu,
>>> +    [MO_LEQ]  = helper_le_ldq_mmu,
>>> +    [MO_BEUW] = helper_be_lduw_mmu,
>>> +    [MO_BESW] = helper_be_ldsw_mmu,
>>> +    [MO_BEUL] = helper_be_ldul_mmu,
>>> +    [MO_BESL] = helper_be_ldsl_mmu,
>>> +    [MO_BEQ]  = helper_be_ldq_mmu,
>>> +};
>>
>> The LESL and BESL functions will not be present for rv32 -> link error.  Here
>> you do need an ifdef.
>>
>>> +        } else {
>>> +            adj = cmp_off - sextract32(cmp_off, 0, 12);
>>> +            tcg_debug_assert(add_off - adj >= -0x1000
>>> +                             && add_off - adj < 0x1000);
>>> +
>>> +            tcg_out_opc_upper(s, OPC_LUI, base, adj);
>>> +            tcg_out_opc_reg(s, OPC_ADD, base, TCG_REG_ZERO, TCG_AREG0);
>>
>> base, base, TCG_AREG0.
>>
>>> +    /* Compare masked address with the TLB entry. */
>>> +    label_ptr[0] = s->code_ptr;
>>> +    tcg_out_opc_branch(s, OPC_BNE, TCG_REG_TMP0, TCG_REG_TMP1, 0);
>>
>> Another case of a potential out-of-range branch.
>>
>> It might be worthwhile to move all of this out-of-line from the start, where
>> that branch will always be short.  See
>>
>> http://lists.nongnu.org/archive/html/qemu-devel/2018-11/msg02234.html
> 
> That does look cool, but it's not in the tree yet.

No, but it'll probably be in tree before this code is.  ;-)
I'll put it into my tcg-next-for-4.0 branch, and you can base off that.

> Otherwise can we directly just call tcg_out_brcond()?

Not quite, because there's no label structure.  But you can break out
subroutines and use those.

> PS: Thanks for your review. I have gone through most of your comments.
> I now don't see any segfaults when running. My guest still doesn't
> boot, but it's getting further then it used to :)

Excellent.


r~
