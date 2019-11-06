Return-Path: <SRS0=EylP=Y6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34365C5DF63
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:18:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F099C2173E
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2019 14:18:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q/Ndh+XF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F099C2173E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iSM8P-00016m-6T
	for qemu-devel@archiver.kernel.org; Wed, 06 Nov 2019 09:18:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55688)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iSM53-00064U-Pw
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:14:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iSM52-0001ap-Mv
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:14:41 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:32916)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1iSM52-0001aF-Gq
 for qemu-devel@nongnu.org; Wed, 06 Nov 2019 09:14:40 -0500
Received: by mail-wr1-x442.google.com with SMTP id w30so3278451wra.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2019 06:14:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=8PzveeQufMPdtS1Xqw/uA0eI9Y+6gGVjzLa9fBNFKzk=;
 b=q/Ndh+XFwEOV1AfNmeVt+oCNAmwTS4ARmfoX4VIBuTqX0GMP9bKkHu3uVmdfw3CxP5
 v8Yzdj8FbiZ6ZXlHwZlhSsjIxtBmDno9YfvfpkjB0Cr5/bFwMwGoY5WkWBLhp+15kwH6
 BYNmtV8URiUoZz63wnA22/+5xc54syKmtDm1XsfPYrQ1GHlh9f22BRTDen1QXPtkRH6P
 qRjRV3L+VQBL/AywY/M3MWayZJZ8QdvUjMrstlzDD2xz2KsKsI0GYt7IF0NSnu2lvk5k
 RFoJF+BEd/EAha4JQM4lTYnjv+LDQtzyJmjqjzgHvsq19a48S1zEn/H0C1q7HcgqHT1k
 SEUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=8PzveeQufMPdtS1Xqw/uA0eI9Y+6gGVjzLa9fBNFKzk=;
 b=C8bTnyx/qdoozF826H01VY1HtSI3rSGs7b2armKHarpYJJ5UwX6pgJylPQHZ9FsQHI
 owUDx1gtTEwbO1lEG6kG9ivqu2pAg8/jPFvxIZMgqRGfiejukCj2Ssmpd14kuiXHf3Qv
 JAGI4H2IUuSUWaDWQTQyI9wjliQyLvKi34GHk8mwn6QNN6DcOvVrG+P2Sc/W2rduS9Qw
 vu1jK53060+7tTIJl4dntCET5zG5ro10/lJPq+WrtOcsZiIL/xTg3Q33Rgv4WgZbET42
 gnLyaw6fjJb1kI3tORgkjzE86UH+G0jnxik0GiyreSPlmg2r43ntjxKxxFEOiuEOrhHz
 OTfA==
X-Gm-Message-State: APjAAAUWZryF8Vwha77HlXtGdBXkWIi+QLo9rhiuJesffzXLJBJiamOn
 JS+OXwEkVxU3qagAGIjg6nKwxOB0j/Q=
X-Google-Smtp-Source: APXvYqymy9f/4LcrewPw8N1yrf3Y/9nR0Oa/g5cPPXyChNbNz1XAKiXujkIj3FrXxVzbFtS4R+Y7Nw==
X-Received: by 2002:adf:b608:: with SMTP id f8mr2743381wre.99.1573049679085;
 Wed, 06 Nov 2019 06:14:39 -0800 (PST)
Received: from localhost (ec2-34-244-242-0.eu-west-1.compute.amazonaws.com.
 [34.244.242.0])
 by smtp.gmail.com with ESMTPSA id j3sm16558763wrs.70.2019.11.06.06.14.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 06 Nov 2019 06:14:38 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 2/3] target/microblaze: Plug temp leaks with delay slot
 setup
Date: Wed,  6 Nov 2019 15:14:23 +0100
Message-Id: <20191106141424.27244-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191106141424.27244-1-edgar.iglesias@gmail.com>
References: <20191106141424.27244-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::442
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

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 target/microblaze/translate.c | 26 ++++++++++++++------------
 1 file changed, 14 insertions(+), 12 deletions(-)

diff --git a/target/microblaze/translate.c b/target/microblaze/translate.c
index ba143ede5f..e9ff9e650d 100644
--- a/target/microblaze/translate.c
+++ b/target/microblaze/translate.c
@@ -1201,6 +1201,17 @@ static void eval_cond_jmp(DisasContext *dc, TCGv_i64 pc_true, TCGv_i64 pc_false)
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
@@ -1212,10 +1223,7 @@ static void dec_bcc(DisasContext *dc)
 
     dc->delayed_branch = 1;
     if (dslot) {
-        dc->delayed_branch = 2;
-        dc->tb_flags |= D_FLAG;
-        tcg_gen_st_i32(tcg_const_i32(dc->type_b && (dc->tb_flags & IMM_FLAG)),
-                      cpu_env, offsetof(CPUMBState, bimm));
+        dec_setup_dslot(dc);
     }
 
     if (dec_alu_op_b_is_small_imm(dc)) {
@@ -1274,10 +1282,7 @@ static void dec_br(DisasContext *dc)
 
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
@@ -1379,10 +1384,7 @@ static void dec_rts(DisasContext *dc)
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


