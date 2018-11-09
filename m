Received: from eggs.gnu.org ([2001:4830:134:3::10]:45943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gL04A-0008TZ-5h
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 01:14:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gL046-0007y3-Sx
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 01:14:50 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:40221)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gL044-0007SM-7N
	for qemu-devel@nongnu.org; Fri, 09 Nov 2018 01:14:45 -0500
Received: by mail-ot1-x341.google.com with SMTP id s5so681663oth.7
	for <qemu-devel@nongnu.org>; Thu, 08 Nov 2018 22:14:36 -0800 (PST)
References: <mhng-133c83c5-d4e7-402a-935f-3ed9ca6b44b3@palmer-si-x1c4>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1012b899-dc7d-fd87-7a87-cf5abba77754@linaro.org>
Date: Fri, 9 Nov 2018 07:14:24 +0100
MIME-Version: 1.0
In-Reply-To: <mhng-133c83c5-d4e7-402a-935f-3ed9ca6b44b3@palmer-si-x1c4>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: Palmer Dabbelt <palmer@sifive.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: Michael Clark <mjc@sifive.com>, sagark@eecs.berkeley.edu, Alistair Francis <Alistair.Francis@wdc.com>, qemu-riscv@nongnu.org, qemu-devel@nongnu.org

On 11/8/18 8:12 PM, Palmer Dabbelt wrote:
> * We don't take advantage of the ordering bits on fences, which could allow us
>  to emit less conservative fences.  This would presumably increase  performance.

Yes.

> * We treat fences as NOPs under "#ifndef CONFIG_USER_ONLY", which is a bug.

Ah yes, I'd forgotten this one.  This is a bug, in that multi-threaded user
programs do not get the memory ordering that they requested.

Hard to see, obviously, since the emulator has its own memory operations,
barriers, and locks.  But once we have a lot of the hot path of the user
program compiled, there's a lot less of that.


>     case OPC_RISC_FENCE:
> -#ifndef CONFIG_USER_ONLY
>         if (ctx->opcode & 0x1000) {
>             /* FENCE_I is a no-op in QEMU,
>              * however we need to end the translation block */
> @@ -1777,7 +1776,6 @@ static void decode_RV32_64G(CPURISCVState *env,
> DisasContext *ctx)
>             /* FENCE is a full memory barrier. */
>             tcg_gen_mb(TCG_MO_ALL | TCG_BAR_SC);
>         }
> -#endif
>         break;

Yes, this is minimally correct.


r~
