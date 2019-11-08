Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.4 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 985A5C5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:45:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6242B206A3
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 12:45:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ppY1d2fM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6242B206A3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53250 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT3eF-0004J2-VS
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 07:45:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45995)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iT3bI-0001dS-CG
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:42:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iT3bG-0000Sy-Ml
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:42:52 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441]:41487)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1iT3bG-0000RE-Dj
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 07:42:50 -0500
Received: by mail-wr1-x441.google.com with SMTP id p4so6895206wrm.8
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 04:42:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Rnzob+CMRQLWYBDPF8sebybDJvDCoUE2UV9qiBp+og0=;
 b=ppY1d2fMM0ZJPtgAd4+5sYEv06JGyJQI9aq0jHHj8jMSk8SyChkZm/DPG1vVs580Zx
 RSI9gmdO5GCsDlSckWGjtITeQMRT3fLvTTMr6w6+00bh604GSyPdb5tHb4P9HQ4fd4X2
 Ij5pFidqe7rXfX0BxqXSXOHYS5gxUfmCpB6eU1HM3dI6dW2Ks812iDLDGKrh0olHG8Jx
 bSCgVNQtZPnCV8E1tWKE96POC+5RKfBlNiWoVMxx2kwiBVGYAAQo4OaUF0FQaWRxphun
 g5E3V2EiV8Pbjs3LN9Kla9Ts9rhCuUAP+P5AoaVvyxLAAg+piB4Yv8H4fB4Ujs1ht1hz
 SUfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rnzob+CMRQLWYBDPF8sebybDJvDCoUE2UV9qiBp+og0=;
 b=EB/HU7s+NRLHCTu/3jxThe7q9kIkCwMvwAjz5xrnHGtFdVa8q1VafU119LaR7r1fQh
 J2UKdU5F+cETU4ZRhBwuv1KibNinbh5l4Y30/45sgV+3qzgpLTCK1qioTHEd0X6eU9b7
 ZuBK5IZHKbQyByefy5o7lx2885tzpo2arec5C03schlXhB7H6YAshdgYvX1VTPj1RDcw
 fPdQ0twx6vmSNJrAjQzXLj2MKBXvH4S6We2ynHe0tC5Gkrce7boB4zClgSA7u3P1sNr8
 Vwy+NTfgeBJ58kA2mQHA6EAECSSGIlaAzwryXUaey9cuJ+4WPatffIhXaRHG7PwFudU5
 /Pnw==
X-Gm-Message-State: APjAAAUD1PI8Nr9E0dTYU47Hwlmuj48Vtu8TLd/xjXNTXxPjf2hIC9BU
 ox8ngEU+uHi9+0373DJuHg32LdPxx1k=
X-Google-Smtp-Source: APXvYqx8Y3Ze/r/BXgbjLD3/lMk+zF7PqpiGFuzW0XMcEoFEmazkDymrw/1d4zarJpqvKb0ZrK3LHg==
X-Received: by 2002:a05:6000:12c4:: with SMTP id
 l4mr7890980wrx.110.1573216967513; 
 Fri, 08 Nov 2019 04:42:47 -0800 (PST)
Received: from localhost (ec2-34-244-242-0.eu-west-1.compute.amazonaws.com.
 [34.244.242.0])
 by smtp.gmail.com with ESMTPSA id h140sm7317035wme.22.2019.11.08.04.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 Nov 2019 04:42:46 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 2/3] target/microblaze: Plug temp leaks with delay slot
 setup
Date: Fri,  8 Nov 2019 13:42:18 +0100
Message-Id: <20191108124219.31348-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191108124219.31348-1-edgar.iglesias@gmail.com>
References: <20191108124219.31348-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::441
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

Plug temp leaks with delay slot setup.

Reviewed-by: Luc Michel <luc.michel@greensocs.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index c8442b18e1..7b4b66a622 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1177,6 +1177,17 @@ static void eval_cond_jmp(DisasContext *dc, TCGv_i64 pc_true, TCGv_i64 pc_false)
     tcg_temp_free_i64(tmp_zero);
 }
 
+static void dec_setup_dslot(DisasContext *dc)
+{
+        TCGv_i32 tmp = tcg_const_i32(dc->type_b && (dc->tb_flags & IMM_FLAG));
+
+        dc->delayed_branch = 2;
+        dc->tb_flags |= D_FLAG;
+
+        tcg_gen_st_i32(tmp, cpu_env, offsetof(CPUMBState, bimm));
+        tcg_temp_free_i32(tmp);
+}
+
 static void dec_bcc(DisasContext *dc)
 {
     unsigned int cc;
@@ -1188,10 +1199,7 @@ static void dec_bcc(DisasContext *dc)
 
     dc->delayed_branch = 1;
     if (dslot) {
-        dc->delayed_branch = 2;
-        dc->tb_flags |= D_FLAG;
-        tcg_gen_st_i32(tcg_const_i32(dc->type_b && (dc->tb_flags & IMM_FLAG)),
-                      cpu_env, offsetof(CPUMBState, bimm));
+        dec_setup_dslot(dc);
     }
 
     if (dec_alu_op_b_is_small_imm(dc)) {
@@ -1250,10 +1258,7 @@ static void dec_br(DisasContext *dc)
 
     dc->delayed_branch = 1;
     if (dslot) {
-        dc->delayed_branch = 2;
-        dc->tb_flags |= D_FLAG;
-        tcg_gen_st_i32(tcg_const_i32(dc->type_b && (dc->tb_flags & IMM_FLAG)),
-                      cpu_env, offsetof(CPUMBState, bimm));
+        dec_setup_dslot(dc);
     }
     if (link && dc->rd)
         tcg_gen_movi_i32(cpu_R[dc->rd], dc->pc);
@@ -1355,10 +1360,7 @@ static void dec_rts(DisasContext *dc)
         return;
     }
 
-    dc->delayed_branch = 2;
-    dc->tb_flags |= D_FLAG;
-    tcg_gen_st_i32(tcg_const_i32(dc->type_b && (dc->tb_flags & IMM_FLAG)),
-                  cpu_env, offsetof(CPUMBState, bimm));
+    dec_setup_dslot(dc);
 
     if (i_bit) {
         LOG_DIS("rtid ir=%x\n", dc->ir);
-- 
2.20.1


