Return-Path: <SRS0=1YIe=ZE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E12BC43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3840920679
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:06:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jTuwZGbq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3840920679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37124 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUYgj-0005Ca-Rz
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 11:06:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50191)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iUYf7-0004Cc-OD
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:05:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iUYf6-0007EX-HY
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:05:01 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330]:39890)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1iUYf6-0007Dw-BT
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:05:00 -0500
Received: by mail-wm1-x330.google.com with SMTP id t26so3536036wmi.4
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 08:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Cy8FCwl/18NJgZg+dGnngIhHgF8t6xiMbv5xqZVLuRU=;
 b=jTuwZGbqMZDC/hJFWPGZLnDKQxds3XxVUbXnPQSLGypmgZIjG2NsDOEw9U/LUgLcp8
 i3fEq5viT/KfA5iOoLGP6sVGh9vctzf6vzeZtoI+96ICH6g3ThJiq/QbxR80rCDyMspv
 tXjer71VHgPoRh24CqHOFE6Q5DBzyoiCE3AJ4PkYZSBfH/+5/48TLQPM+O7X2zjD6SWX
 pswy6hS+MS6blSYsxkLPoyEvU4jg9L/SWeXVHSmzMqa9Bpj+2qHzU9UaY28f052p3LyF
 crEAR2K0Z1SfYrvic8HPSnLLJJuMMdNpD2fF/LFG9tiz6bfQI7tmsBY6n5+j4J8u4UZH
 WRDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Cy8FCwl/18NJgZg+dGnngIhHgF8t6xiMbv5xqZVLuRU=;
 b=sXN5oio+iz9ZY1wdTLIpriBo01/vaEhORB+rWelvB4z3UvkKhNk9kVHGHRhTevDiW2
 xiYW98KMQ+xd14oNTE3coMYjkVspTG6uucZnvGuoPjHvABOXXCWQyuvE8uAacdX8XrhP
 Et3yUN3YZV2+N4bV4Q+Nn971o7KCgS0oKlTFEoF+TP343PE+RQUdjfh8lpyX8uiJRwqz
 ezGchYogWvXdEzu5ANhNMD8Vv/lqOZZRPMP+T853YxmCq91pfsNT5G2q3gNjlY9w6K1S
 8PT1E3o5GVNik1gt+OhXkGo5ZOvO65gwG6N616C6+dBWNfd0drwonAEaKZABgFsSqOsR
 AEHA==
X-Gm-Message-State: APjAAAWfEZak13iB+h6iAbtRMZwUlUzx+syEp9uTPu9Nn/GkSpDQgLl5
 Gnr5DbuB223JG5Ht5tqF18Vy5D55sMA=
X-Google-Smtp-Source: APXvYqyc9rbWbgzPWPxRYrFWA1H+y+kLxl9ovgIPpE4v3jcVaJoeXJK+qd6ZBQBBTvocRB3ghbifEw==
X-Received: by 2002:a05:600c:c3:: with SMTP id u3mr4321251wmm.35.1573574698710; 
 Tue, 12 Nov 2019 08:04:58 -0800 (PST)
Received: from localhost (ec2-34-244-242-0.eu-west-1.compute.amazonaws.com.
 [34.244.242.0])
 by smtp.gmail.com with ESMTPSA id t185sm5907182wmf.45.2019.11.12.08.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 08:04:58 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 1/3] target/microblaze: Plug temp leaks for loads/stores
Date: Tue, 12 Nov 2019 17:04:47 +0100
Message-Id: <20191112160449.29212-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191112160449.29212-1-edgar.iglesias@gmail.com>
References: <20191112160449.29212-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::330
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Simplify endian reversion of address also plugging TCG temp
leaks for loads/stores.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 46 +++++++++++++++--------------------
 1 file changed, 20 insertions(+), 26 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 761f535357..c8442b18e1 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -962,17 +962,7 @@ static void dec_load(DisasContext *dc)
         switch (size) {
             case 1:
             {
-                /* 00 -> 11
-                   01 -> 10
-                   10 -> 10
-                   11 -> 00 */
-                TCGv low = tcg_temp_new();
-
-                tcg_gen_andi_tl(low, addr, 3);
-                tcg_gen_sub_tl(low, tcg_const_tl(3), low);
-                tcg_gen_andi_tl(addr, addr, ~3);
-                tcg_gen_or_tl(addr, addr, low);
-                tcg_temp_free(low);
+                tcg_gen_xori_tl(addr, addr, 3);
                 break;
             }
 
@@ -1006,9 +996,16 @@ static void dec_load(DisasContext *dc)
     tcg_gen_qemu_ld_i32(v, addr, mem_index, mop);
 
     if ((dc->cpu->env.pvr.regs[2] & PVR2_UNALIGNED_EXC_MASK) && size > 1) {
+        TCGv_i32 t0 = tcg_const_i32(0);
+        TCGv_i32 treg = tcg_const_i32(dc->rd);
+        TCGv_i32 tsize = tcg_const_i32(size - 1);
+
         tcg_gen_movi_i64(cpu_SR[SR_PC], dc->pc);
-        gen_helper_memalign(cpu_env, addr, tcg_const_i32(dc->rd),
-                            tcg_const_i32(0), tcg_const_i32(size - 1));
+        gen_helper_memalign(cpu_env, addr, treg, t0, tsize);
+
+        tcg_temp_free_i32(t0);
+        tcg_temp_free_i32(treg);
+        tcg_temp_free_i32(tsize);
     }
 
     if (ex) {
@@ -1095,17 +1092,7 @@ static void dec_store(DisasContext *dc)
         switch (size) {
             case 1:
             {
-                /* 00 -> 11
-                   01 -> 10
-                   10 -> 10
-                   11 -> 00 */
-                TCGv low = tcg_temp_new();
-
-                tcg_gen_andi_tl(low, addr, 3);
-                tcg_gen_sub_tl(low, tcg_const_tl(3), low);
-                tcg_gen_andi_tl(addr, addr, ~3);
-                tcg_gen_or_tl(addr, addr, low);
-                tcg_temp_free(low);
+                tcg_gen_xori_tl(addr, addr, 3);
                 break;
             }
 
@@ -1124,6 +1111,10 @@ static void dec_store(DisasContext *dc)
 
     /* Verify alignment if needed.  */
     if ((dc->cpu->env.pvr.regs[2] & PVR2_UNALIGNED_EXC_MASK) && size > 1) {
+        TCGv_i32 t1 = tcg_const_i32(1);
+        TCGv_i32 treg = tcg_const_i32(dc->rd);
+        TCGv_i32 tsize = tcg_const_i32(size - 1);
+
         tcg_gen_movi_i64(cpu_SR[SR_PC], dc->pc);
         /* FIXME: if the alignment is wrong, we should restore the value
          *        in memory. One possible way to achieve this is to probe
@@ -1131,8 +1122,11 @@ static void dec_store(DisasContext *dc)
          *        the alignment checks in between the probe and the mem
          *        access.
          */
-        gen_helper_memalign(cpu_env, addr, tcg_const_i32(dc->rd),
-                            tcg_const_i32(1), tcg_const_i32(size - 1));
+        gen_helper_memalign(cpu_env, addr, treg, t1, tsize);
+
+        tcg_temp_free_i32(t1);
+        tcg_temp_free_i32(treg);
+        tcg_temp_free_i32(tsize);
     }
 
     if (ex) {
-- 
2.20.1


