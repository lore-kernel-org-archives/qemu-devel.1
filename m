Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDF91C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:15:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ECD020869
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:15:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lyDPLZjX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECD020869
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59300 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSM6H-00071T-M1
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 09:15:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55651)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iSM4y-0005wQ-Mw
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:14:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iSM4x-0001XW-J7
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:14:36 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:37992)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1iSM4x-0001Wt-CY
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:14:35 -0500
Received: by mail-wr1-x444.google.com with SMTP id j15so5329397wrw.5
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 06:14:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=YOFnaBxbupvfjJosEi5lm+iq/aAKSCbIVLDFBZUFVY0=;
 b=lyDPLZjXivwxFEdlNxsc7I020N8FJ0UayRKNTlcAlYJQkbqDsppoB29dHEwVL00b9o
 HM1EF+M2XLyB8qAXV8yIejt+xPH6NKLV9wIquIddI+eUGtQawEyewuM302dj7+icAV9d
 RcjWxeymTqfzTQO3SffvF1FN3yv/1ffRkMJrXJfBoMlT2WXrorBMAxNScOd7PNvSpsc/
 8RjsYTpc0aQLs7xQrjO1u0tS7TafDzfaVA1FONMaYXj/Cayri0x0xZDh1TjEYKJ3Fo06
 i9WXjDCYLFtN6+8z2kRVY+ZVNhwIe8ZdIbMYR/DTb6OSjNwujod0qpfIhWsl/AH+hXd5
 4iyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=YOFnaBxbupvfjJosEi5lm+iq/aAKSCbIVLDFBZUFVY0=;
 b=nyB4C6uusF4mabbDA2Lby0IetvIyOyfpScmo3aFfGCm8D7WaFVrJqs1IgbiBLndMVi
 8DTLOe07xL6rIp3yB/vGjiYxa957BkXVOm/PCSDU07ky4gvx2wTA1riWMaQfLLCz/Tz/
 9eszHVw5ylAKQ8aWFtvdB5esTE5xrBXVQQhXaweQpKeOL4jhAt37pk89hTOKWAAgJTF/
 IjEY4pAizp22ZlF9ooQ/CVnePOxmALPnGGd+iZu7yIhzzSnmFtWOMFWW3GG3AbYgPmz5
 ctmuYAuxNm+YZ8aQZg7QDX7nOJ/r26cwICABffDpyjopTK8RKd7vD5sX2flNecDjNdpz
 HgGQ==
X-Gm-Message-State: APjAAAX/MA3P3VovIRwoM4yg4cDRbRk5y1uz6jJAlSIbhChhJ/NxPvHD
 TC06BXF0qkv1OAiz+kkt5ND8OmuyKbw=
X-Google-Smtp-Source: APXvYqyI7qZ8UufrVuh2eKsY+C2yGGpMdXA/94xyhMdJE0qGWLaz2C2sOFmKrxkdaZBWLcIENhd5dw==
X-Received: by 2002:adf:f489:: with SMTP id l9mr2721646wro.337.1573049674045; 
 Wed, 06 Nov 2019 06:14:34 -0800 (PST)
Received: from localhost (ec2-34-244-242-0.eu-west-1.compute.amazonaws.com.
 [34.244.242.0])
 by smtp.gmail.com with ESMTPSA id x8sm2504975wmi.10.2019.11.06.06.14.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 06:14:33 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/3] target/microblaze: Plug temp leaks for loads/stores
Date: Wed,  6 Nov 2019 15:14:22 +0100
Message-Id: <20191106141424.27244-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191106141424.27244-1-edgar.iglesias@gmail.com>
References: <20191106141424.27244-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::444
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me,
 richard.henderson@linaro.org, frederic.konrad@adacore.com, philmd@redhat.com,
 luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Plug TCG temp leaks for loads/stores.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 30 ++++++++++++++++++++++++------
 1 file changed, 24 insertions(+), 6 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index 761f535357..ba143ede5f 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -967,12 +967,14 @@ static void dec_load(DisasContext *dc)
                    10 -> 10
                    11 -> 00 */
                 TCGv low = tcg_temp_new();
+                TCGv t3 = tcg_const_tl(3);
 
                 tcg_gen_andi_tl(low, addr, 3);
-                tcg_gen_sub_tl(low, tcg_const_tl(3), low);
+                tcg_gen_sub_tl(low, t3, low);
                 tcg_gen_andi_tl(addr, addr, ~3);
                 tcg_gen_or_tl(addr, addr, low);
                 tcg_temp_free(low);
+                tcg_temp_free(t3);
                 break;
             }
 
@@ -1006,9 +1008,16 @@ static void dec_load(DisasContext *dc)
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
@@ -1100,12 +1109,14 @@ static void dec_store(DisasContext *dc)
                    10 -> 10
                    11 -> 00 */
                 TCGv low = tcg_temp_new();
+                TCGv t3 = tcg_const_tl(3);
 
                 tcg_gen_andi_tl(low, addr, 3);
-                tcg_gen_sub_tl(low, tcg_const_tl(3), low);
+                tcg_gen_sub_tl(low, t3, low);
                 tcg_gen_andi_tl(addr, addr, ~3);
                 tcg_gen_or_tl(addr, addr, low);
                 tcg_temp_free(low);
+                tcg_temp_free(t3);
                 break;
             }
 
@@ -1124,6 +1135,10 @@ static void dec_store(DisasContext *dc)
 
     /* Verify alignment if needed.  */
     if ((dc->cpu->env.pvr.regs[2] & PVR2_UNALIGNED_EXC_MASK) && size > 1) {
+        TCGv_i32 t1 = tcg_const_i32(1);
+        TCGv_i32 treg = tcg_const_i32(dc->rd);
+        TCGv_i32 tsize = tcg_const_i32(size - 1);
+
         tcg_gen_movi_i64(cpu_SR[SR_PC], dc->pc);
         /* FIXME: if the alignment is wrong, we should restore the value
          *        in memory. One possible way to achieve this is to probe
@@ -1131,8 +1146,11 @@ static void dec_store(DisasContext *dc)
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


