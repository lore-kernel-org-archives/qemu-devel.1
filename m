Received: from eggs.gnu.org ([2001:4830:134:3::10]:50199)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fiPJ8-00044v-Oy
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 15:18:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1fiPJ5-0008CI-Ob
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 15:18:46 -0400
Received: from mail-pl0-x241.google.com ([2607:f8b0:400e:c01::241]:43170)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1fiPJ5-00089T-8O
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 15:18:43 -0400
Received: by mail-pl0-x241.google.com with SMTP id x6-v6so2004633plv.10
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 12:18:43 -0700 (PDT)
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
	<1532004912-13899-19-git-send-email-stefan.markovic@rt-rk.com>
	<17945e3f-9caf-b153-4c45-56d005f27a72@linaro.org>
	<BN7PR08MB48688FA533AD07279FC51B7CC6540@BN7PR08MB4868.namprd08.prod.outlook.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <78b80be3-047a-0114-9f01-82ec3a29a299@linaro.org>
Date: Wed, 25 Jul 2018 12:18:35 -0700
MIME-Version: 1.0
In-Reply-To: <BN7PR08MB48688FA533AD07279FC51B7CC6540@BN7PR08MB4868.namprd08.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 18/40] target/mips: Add emulation of
 nanoMIPS 32-bit load and store instructions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aleksandar Markovic <amarkovic@wavecomp.com>, Stefan Markovic <stefan.markovic@rt-rk.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "laurent@vivier.eu" <laurent@vivier.eu>, "riku.voipio@iki.fi" <riku.voipio@iki.fi>, "philippe.mathieu.daude@gmail.com" <philippe.mathieu.daude@gmail.com>, "aurelien@aurel32.net" <aurelien@aurel32.net>, Stefan Markovic <smarkovic@wavecomp.com>, Petar Jovanovic <pjovanovic@wavecomp.com>, Paul Burton <pburton@wavecomp.com>

On 07/25/2018 08:46 AM, Aleksandar Markovic wrote:
> Hello, Richard. Sorry for bothering you. One more question.
> 
>> On 07/19/2018 05:54 AM, Stefan Markovic wrote:
>>> +        case NM_ADDIUGP_B:
>>> +            gen_arith_imm(ctx, OPC_ADDIU, rt, 28, u);
>>> +            break;
>>
>> Use gen_op_addr_add, since behaves_like('DADDIU[GP.B]').
> 
> Did you perhaps mean an implementation similar to this would be appropriate:
> 
> case NM_ADDIUGP_B:
>     if (rt != 0) { 
>         uint32_t offset = extract32(ctx->opcode, 0, 18); 
>         if (offset == 0) { 
>             gen_load_gpr(cpu_gpr[rt], 28); 
>         } else { 
>             TCGv t0; 
>             t0 = tcg_temp_new(); 
>             tcg_gen_movi_tl(t0, offset); 
>             gen_op_addr_add(ctx, cpu_gpr[rt], cpu_gpr[28], t0); 
>             tcg_temp_free(t0); 
>         } 
>     }
>     break;
> 
> (this is like NM_ADDIUGP_W implementation)

I have suggested in the past (during v1 or v2 review?) creating

static void gen_op_addr_addi(DisasContext *ctx, TCGv ret, TCGv base,
                             target_long ofs)
{
    tcg_gen_addi_tl(ret, base, ofs);
#ifdef TARGET_MIPS64
    if (ctx->hflags & MIPS_HFLAG_AWRAP) {
        tcg_gen_ext32s_i64(ret, ret);
    }
#endif
}

so that

(1) You need not locally maintain the tcg temporary for offset
    at each such instance,
(2) The special case for offset == 0 is handled automatically
    within tcg_gen_addi_tl.
(3) You do not forget, as you just did here, that the extension
    for AWRAP must happen even for offset == 0.


r~
