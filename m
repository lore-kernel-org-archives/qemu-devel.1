Received: from eggs.gnu.org ([2001:4830:134:3::10]:46591)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1eoACC-0006qN-Q5
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:51:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1eoACC-0001xX-0v
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:51:08 -0500
Received: from mail.uni-paderborn.de ([131.234.142.9]:58886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1eoACB-0001xC-PW
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 10:51:07 -0500
References: <20180219061827.2112-1-david.brenken@efs-auto.org>
	<20180219061827.2112-2-david.brenken@efs-auto.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <3b604800-0973-8c59-7d60-680bcc11ab4c@mail.uni-paderborn.de>
Date: Tue, 20 Feb 2018 16:48:18 +0100
MIME-Version: 1.0
In-Reply-To: <20180219061827.2112-2-david.brenken@efs-auto.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 1/5] tricore: added some missing cpu
 instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Brenken <david.brenken@efs-auto.org>, qemu-devel@nongnu.org
Cc: Florian Artmeier <florian.artmeier@efs-auto.de>, David Brenken <david.brenken@efs-auto.de>, Georg Hofstetter <georg.hofstetter@efs-auto.de>

On 02/19/2018 07:18 AM, David Brenken wrote:
> From: David Brenken <david.brenken@efs-auto.de>
> 
> +    case OPC1_16_SBR_JEQ2:
> +        gen_branch_cond(ctx, TCG_COND_EQ, cpu_gpr_d[r1], cpu_gpr_d[15],
> +                        offset + 16);
> +        break;

This is a 1.6+ instruction and you need to add a check, like with
OPC2_32_RR_MOVS_64.

>      case OPC1_16_SBR_JNE:
>          gen_branch_cond(ctx, TCG_COND_NE, cpu_gpr_d[r1], cpu_gpr_d[15],
>                          offset);
>          break;
> +    case OPC1_16_SBR_JNE2:
> +        gen_branch_cond(ctx, TCG_COND_NE, cpu_gpr_d[r1], cpu_gpr_d[15],
> +                        offset + 16);
> +        break;

Likewise.

>      case OPC1_16_SBR_JNZ:
>          gen_branch_condi(ctx, TCG_COND_NE, cpu_gpr_d[r1], 0, offset);
>          break;
> @@ -4089,6 +4097,10 @@ static void decode_16Bit_opc(CPUTriCoreState *env, DisasContext *ctx)
>          gen_offset_ld(ctx, cpu_gpr_d[r1], cpu_gpr_a[15], const16 * 4, MO_LESL);
>          break;
>  /* SB-format */
> +    case OPC1_16_SB_JNE:
> +        address = MASK_OP_SBC_DISP4(ctx->opcode);
> +        gen_compute_branch(ctx, op1, 0, 0, 0, address);
> +        break;

Why duplicate the code here? First, OPC1_16_SB_JNE is the same opcode as
OPC1_16_SBR_JNE2. Second, you can just add your case below
OPC1_16_SBR_JNE in decode_16Bit_opc().

> @@ -321,11 +322,13 @@ enum {
>      OPC1_16_SBC_JNE                                  = 0x5e,
>      OPC1_16_SBC_JNE2                                 = 0xde,
>      OPC1_16_SBR_JNE                                  = 0x7e,
> +    OPC1_16_SBR_JNE2                                 = 0xfe,
>      OPC1_16_SB_JNZ                                   = 0xee,
>      OPC1_16_SBR_JNZ                                  = 0xf6,
>      OPC1_16_SBR_JNZ_A                                = 0x7c,
>      OPC1_16_SBRN_JNZ_T                               = 0xae,
>      OPC1_16_SB_JZ                                    = 0x6e,
> +    OPC1_16_SB_JNE                                   = 0xfe,

This is the same opcode as OPC1_16_SBR_JNE2. Don't duplicate it.
