Received: from eggs.gnu.org ([2001:4830:134:3::10]:59579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gPMtO-00041u-Vu
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 02:25:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gPMtK-0002pq-Ro
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 02:25:46 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f]:43902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gPMtK-0002mS-JV
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 02:25:42 -0500
Received: by mail-wr1-x42f.google.com with SMTP id r10so4474284wrs.10
	for <qemu-devel@nongnu.org>; Tue, 20 Nov 2018 23:25:42 -0800 (PST)
References: <cover.1542321076.git.alistair.francis@wdc.com>
	<1fe9630dd4ad73b8581684cd0ed6d5fa2918390f.1542321076.git.alistair.francis@wdc.com>
	<34cb4780-f35f-9bd5-7980-fae18e3e93dd@linaro.org>
	<CAKmqyKMh3T7w-NsP-i2HaRUHvR-0BhqeyTgd2mD0hnH9k8gZiQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ec2b5e9c-0e46-c7b9-f123-decfbafe996b@linaro.org>
Date: Wed, 21 Nov 2018 08:25:38 +0100
MIME-Version: 1.0
In-Reply-To: <CAKmqyKMh3T7w-NsP-i2HaRUHvR-0BhqeyTgd2mD0hnH9k8gZiQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC v1 11/23] riscv: tcg-target: Add the
 relocation functions
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

On 11/21/18 2:15 AM, Alistair Francis wrote:
>> Will the riscv-32 compiler use a FSTD insn to implement atomic_set for 64-bit?
>>  If not, you may be just better off using the indirect method.
> 
> I'm not sure. Is the indirect method just using atomic set, because
> that is what I have now?

It's controlled by TCG_TARGET_HAS_direct_jump, and goes through here:

> +    case INDEX_op_goto_tb:
> +        if (s->tb_jmp_insn_offset) {
> +            /* direct jump method */
> +            s->tb_jmp_insn_offset[a0] = tcg_current_code_size(s);
> +            /* should align on 64-bit boundary for atomic patching */
> +            tcg_out_opc_upper(s, OPC_AUIPC, TCG_REG_TMP0, 0);
> +            tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, TCG_REG_TMP0, 0);
> +        } else {
> +            /* indirect jump method */
> +            tcg_out_ld(s, TCG_TYPE_PTR, TCG_REG_TMP0, TCG_REG_ZERO,
> +                       (uintptr_t)(s->tb_jmp_target_addr + a0));
> +            tcg_out_opc_imm(s, OPC_JALR, TCG_REG_ZERO, TCG_REG_TMP0, 0);
> +        }
> +        s->tb_jmp_reset_offset[a0] = tcg_current_code_size(s);
> +        break;

where as you've correctly implemented, the indirect jump loads a destination
from memory (atomically, via a single load insn), and then branches to it.

The direct jump method avoids the load from memory, but then one has to be able
to modify the insn(s) that perform the jump with a single atomic_set.  Which in
this case, means that the two insns must be aligned so that we can perform a
single aligned 64-bit store.

I recommend at least starting with the indirect method because it's easier.


r~
