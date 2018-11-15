Received: from eggs.gnu.org ([2001:4830:134:3::10]:38023)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNPkz-0005Q7-9S
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:05:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gNPku-0002RW-AW
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:05:01 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:42783)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gNPkt-0002PK-Tm
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 17:04:56 -0500
Received: by mail-wr1-x441.google.com with SMTP id u5-v6so17544029wrn.9
	for <qemu-devel@nongnu.org>; Thu, 15 Nov 2018 14:04:54 -0800 (PST)
References: <20181112214503.22941-1-richard.henderson@linaro.org>
	<20181114010014.GA19024@flamenco>
	<d15fa143-ab52-3de9-29f0-ff794cec6ac3@linaro.org>
	<20181115184827.GA12024@flamenco>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <06e66024-1abb-e5b7-591c-3633b5cb3e31@linaro.org>
Date: Thu, 15 Nov 2018 23:04:50 +0100
MIME-Version: 1.0
In-Reply-To: <20181115184827.GA12024@flamenco>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH for-4.0 00/17] tcg: Move softmmu out-of-line
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

On 11/15/18 7:48 PM, Emilio G. Cota wrote:
> - Segfault in code_gen_buffer. This one I don't have a fix for,
>   but it's *much* easier to reproduce when -tb-size is very small,
>   e.g. "-tb-size 5 -smp 2" (BTW it crashes with x86_64 guests too.)
>   So at first I thought the code cache flushing was the problem,
>   but I don't see how that could be, at least from a TCGContext
>   viewpoint -- I agree that clearing the hash table in
>   tcg_region_assign is a good place to do so.

Ho hum.

diff --git a/accel/tcg/translate-all.c b/accel/tcg/translate-all.c
index 639f0b2728..115ea186e5 100644
--- a/accel/tcg/translate-all.c
+++ b/accel/tcg/translate-all.c
@@ -1831,10 +1831,6 @@ TranslationBlock *tb_gen_code(CPUState *cpu,
     existing_tb = tb_link_page(tb, phys_pc, phys_page2);
     /* if the TB already exists, discard what we just translated */
     if (unlikely(existing_tb != tb)) {
-        uintptr_t orig_aligned = (uintptr_t)gen_code_buf;
-
-        orig_aligned -= ROUND_UP(sizeof(*tb), qemu_icache_linesize);
-        atomic_set(&tcg_ctx->code_gen_ptr, (void *)orig_aligned);
         return existing_tb;
     }
     tcg_tb_insert(tb);

We can't easily undo the hash table insert, and for a relatively rare
occurrence it's not worth the effort.


r~
