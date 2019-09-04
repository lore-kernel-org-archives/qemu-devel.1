Return-Path: <SRS0=c3jH=W7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36ECDC3A5A9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:31:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2D5921726
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Sep 2019 20:31:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oABczCk+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2D5921726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5bvp-0007hh-0C
	for qemu-devel@archiver.kernel.org; Wed, 04 Sep 2019 16:31:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41556)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b18-0005hD-Dp
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i5b17-0003Rx-5y
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:34 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43518)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i5b15-0003Mj-9d
 for qemu-devel@nongnu.org; Wed, 04 Sep 2019 15:32:33 -0400
Received: by mail-pg1-x543.google.com with SMTP id u72so7590058pgb.10
 for <qemu-devel@nongnu.org>; Wed, 04 Sep 2019 12:32:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=/PXkXzASKMcUQDbV6Hl9B5xocqfOCXTaxlqtgyWXLXY=;
 b=oABczCk+r1Ph0Tq2jPBo4ES/BfjeCyUc6xL4ploAXIPJzq/gYgpcgxyWnDR0wfZE3f
 rsVTU3KR+3UO9RS/YgdhiYCHZhs9EVm8Hg4cuGSgTd4da+HOwTrvsl8JeXkUrHk1RruX
 pJ2cakqWG4tSenbqapliTXOMKW1ZZgmGcBax4TfTppRZVfj9o2XSfetNh0Jb8m+itPVd
 TRJwvNONdH3NwCZdHyrsb0qRIjQumfxlRgOxEEkflKdL1nq/1owXSVtBbPVPtxcrsJ5f
 RJGfAgGhuHmsWIPNML5xTpV2CBiQjU5Juqvn066SjDs18JTatE2je8EkbRfW8BPI6J2v
 74AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=/PXkXzASKMcUQDbV6Hl9B5xocqfOCXTaxlqtgyWXLXY=;
 b=FQ8a0mP5aXvXe33l3RWLUAeRlOIuUBs5EszddrvVQVzoXfKBwfGGmR0SGACrHHOH6D
 WhNgBmZCxpfZ1vwu464ax1fZGVVLIHFQ82h11UszobRqk39iLwF7qpZYYitIVOjEDJ7b
 tovY0FCoXSrTUejWYc66I4g/clKUiw7k29rbquXs1PDvynN9YTjddQ8lJfNbdmjb/vbe
 SxLjT5QRqUqUkr/DguI2ms91MfPriPDCiFv1WR5e8CezSFrNB5WvaERX1UKkk43MCLVp
 uhxw0lOigrio/gQQCs/omnsgefnzM/UYdWUDmzpVAUb9WNIXHq0QHdkOwq2tXfklGAPh
 n5Rg==
X-Gm-Message-State: APjAAAWUFsMhz9DMXvrhcPYf+PjXKSXWZHph3Fq5f1F8tuYF5Vgqolt3
 vQF9Ax8ohoDePHDworomMocEcw8m2H0=
X-Google-Smtp-Source: APXvYqxD3a1G2MCmL8jFGOeZT09xJ3q4yvUpX6mX1baMUoOE5EwoofX4ykXyID8mriOwyVH230y0DA==
X-Received: by 2002:aa7:8556:: with SMTP id y22mr21009221pfn.252.1567625548160; 
 Wed, 04 Sep 2019 12:32:28 -0700 (PDT)
Received: from localhost.localdomain (97-113-7-119.tukw.qwest.net.
 [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id f6sm18999174pga.50.2019.09.04.12.32.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Sep 2019 12:32:27 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Date: Wed,  4 Sep 2019 12:30:59 -0700
Message-Id: <20190904193059.26202-70-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190904193059.26202-1-richard.henderson@linaro.org>
References: <20190904193059.26202-1-richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: [Qemu-devel] [PATCH v4 69/69] target/arm: Inline gen_bx_im into
 callers
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There are only two remaining uses of gen_bx_im.  In each case, we
know the destination mode -- not changing in the case of gen_jmp
or changing in the case of trans_BLX_i.  Use this to simplify the
surrounding code.

For trans_BLX_i, use gen_jmp for the actual branch.  For gen_jmp,
use gen_set_pc_im to set up the single-step.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 target/arm/translate.c | 26 +++++++-------------------
 1 file changed, 7 insertions(+), 19 deletions(-)

diff --git a/target/arm/translate.c b/target/arm/translate.c
index 2412dde631..34bb280e3d 100644
--- a/target/arm/translate.c
+++ b/target/arm/translate.c
@@ -765,21 +765,6 @@ static inline void gen_set_pc_im(DisasContext *s, target_ulong val)
     tcg_gen_movi_i32(cpu_R[15], val);
 }
 
-/* Set PC and Thumb state from an immediate address.  */
-static inline void gen_bx_im(DisasContext *s, uint32_t addr)
-{
-    TCGv_i32 tmp;
-
-    s->base.is_jmp = DISAS_JUMP;
-    if (s->thumb != (addr & 1)) {
-        tmp = tcg_temp_new_i32();
-        tcg_gen_movi_i32(tmp, addr & 1);
-        tcg_gen_st_i32(tmp, cpu_env, offsetof(CPUARMState, thumb));
-        tcg_temp_free_i32(tmp);
-    }
-    tcg_gen_movi_i32(cpu_R[15], addr & ~1);
-}
-
 /* Set PC and Thumb state from var.  var is marked as dead.  */
 static inline void gen_bx(DisasContext *s, TCGv_i32 var)
 {
@@ -2725,9 +2710,8 @@ static inline void gen_jmp (DisasContext *s, uint32_t dest)
 {
     if (unlikely(is_singlestepping(s))) {
         /* An indirect jump so that we still trigger the debug exception.  */
-        if (s->thumb)
-            dest |= 1;
-        gen_bx_im(s, dest);
+        gen_set_pc_im(s, dest);
+        s->base.is_jmp = DISAS_JUMP;
     } else {
         gen_goto_tb(s, 0, dest);
     }
@@ -10138,12 +10122,16 @@ static bool trans_BL(DisasContext *s, arg_i *a)
 
 static bool trans_BLX_i(DisasContext *s, arg_BLX_i *a)
 {
+    TCGv_i32 tmp;
+
     /* For A32, ARCH(5) is checked near the start of the uncond block. */
     if (s->thumb && (a->imm & 2)) {
         return false;
     }
     tcg_gen_movi_i32(cpu_R[14], s->base.pc_next | s->thumb);
-    gen_bx_im(s, (read_pc(s) & ~3) + a->imm + !s->thumb);
+    tmp = tcg_const_i32(!s->thumb);
+    store_cpu_field(tmp, thumb);
+    gen_jmp(s, (read_pc(s) & ~3) + a->imm);
     return true;
 }
 
-- 
2.17.1


