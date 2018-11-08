Received: from eggs.gnu.org ([2001:4830:134:3::10]:41659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gKpir-00089M-6L
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 14:12:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <palmer@sifive.com>) id 1gKpin-0000RB-QI
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 14:12:09 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:44356)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <palmer@sifive.com>) id 1gKpin-0000O6-2m
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 14:12:05 -0500
Received: by mail-pf1-x442.google.com with SMTP id j13-v6so9717744pff.11
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 11:12:02 -0800 (PST)
Date: Thu, 08 Nov 2018 11:12:00 -0800 (PST)
In-Reply-To: <d6ec0bb8-1ea6-c032-5643-2248ce7647a6@mail.uni-paderborn.de>
From: Palmer Dabbelt <palmer@sifive.com>
Message-ID: <mhng-133c83c5-d4e7-402a-935f-3ed9ca6b44b3@palmer-si-x1c4>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 0/2] target/riscv: Bugfixes found in
 decodetree conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: richard.henderson@linaro.org, Michael Clark <mjc@sifive.com>, sagark@eecs.berkeley.edu, Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On Thu, 08 Nov 2018 09:29:26 PST (-0800), Bastian Koppelmann wrote:
>
> On 11/8/18 4:53 PM, Richard Henderson wrote:
>> On 11/8/18 1:06 PM, Bastian Koppelmann wrote:
>>> while going through the reviews of the riscv-decodetree patches, two bugs came
>>> up that I fix here. There is one more problem [1] mentioned by Richard but
>>> I don't have the time to investigate it further.
>>>
>>> [1] https://patchwork.kernel.org/patch/10650293/
>> That one's not a bug, but an optimization.
>>
>> The other bug mentioned is shrw and shaw not sign-extending the result.
>
>
> That was a bug I introduced during the conversion to decodetree.

My understand of that patch feedback is that there are two issues:

* We don't take advantage of the ordering bits on fences, which could allow us 
  to emit less conservative fences.  This would presumably increase 
  performance.
* We treat fences as NOPs under "#ifndef CONFIG_USER_ONLY", which is a bug.

Am I wrong about that second one?  I think the fix should look something like 
this, which I haven't even tried to compile

diff --git a/target/riscv/translate.c b/target/riscv/translate.c
index 18d7b6d1471d..624d1c679a84 100644
--- a/target/riscv/translate.c
+++ b/target/riscv/translate.c
@@ -1766,7 +1766,6 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
                      GET_RM(ctx->opcode));
         break;
     case OPC_RISC_FENCE:
-#ifndef CONFIG_USER_ONLY
         if (ctx->opcode & 0x1000) {
             /* FENCE_I is a no-op in QEMU,
              * however we need to end the translation block */
@@ -1777,7 +1776,6 @@ static void decode_RV32_64G(CPURISCVState *env, DisasContext *ctx)
             /* FENCE is a full memory barrier. */
             tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
         }
-#endif
         break;
     case OPC_RISC_SYSTEM:
         gen_system(env, ctx, MASK_OP_SYSTEM(ctx->opcode), rd, rs1,
