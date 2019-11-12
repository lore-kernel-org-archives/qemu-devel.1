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
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDA49C43331
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:08:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB1E320679
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2019 16:08:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EMKEoD8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB1E320679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iUYiK-0007ZK-L5
	for qemu-devel@archiver.kernel.org; Tue, 12 Nov 2019 11:08:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50237)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iUYfG-0004Nc-3L
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:05:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <edgar.iglesias@gmail.com>) id 1iUYfB-0007I6-5J
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:05:10 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336]:53545)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <edgar.iglesias@gmail.com>)
 id 1iUYfA-0007HR-VX
 for qemu-devel@nongnu.org; Tue, 12 Nov 2019 11:05:05 -0500
Received: by mail-wm1-x336.google.com with SMTP id u18so3805207wmc.3
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2019 08:05:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=Rnzob+CMRQLWYBDPF8sebybDJvDCoUE2UV9qiBp+og0=;
 b=EMKEoD8+gI+V1ppQZi51XB0AikaVDO+bkJxUuZ8HOZRC4Rhk0XMySZI2PiKpTD+6Ss
 ML+rZ1wbXMn8w3fd2oQyP6zL5JC2ObDoQOTEkO9btSUVnD7CZsgoX+Qb6ogqBKkWzm7k
 pbnMwqMLX+g1Y00/kOUSuNd1lXbZZMXeIjwvYJlIGJMVBLFMU0oGWXgD4f0Peh+iImg3
 DsYlwm4twGrQxWrzXG1iwdfO23Nbblwxk1XvNo9eiwcrgSCi39binYwD20AEtjFcHayp
 wKXA3wooF1w2qOiJiybqrp1azSE96U3JoBdurAomoYJnvERHxSoPxPYgxg2L2UsyaLyM
 LuSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=Rnzob+CMRQLWYBDPF8sebybDJvDCoUE2UV9qiBp+og0=;
 b=kBSeUf/AfCoDzVc/q7N/9hoqzvT7luOP3H2iaeOkfyt20XMUQhG71Jjq8UY7x7HX47
 1/+Gn84GG399uc1HS5+3aN0J0v8RsPUJKrZmYT8B7wquIkpFi6oMSx0mH+Kl4CbdqRxd
 OOXJ5Gg9ArWe7o6546s6x2XMJuL+b6fSMWENoDvn3M50c1C58wEesW4HYhS1Z+pXYPqk
 2saNDtK4RgmPfhpKl49LL68ugQGctFofB7JOeO4GjXavgkeVJhvIJVQgfPnCg0mQ16f/
 RJv9V/1jV3PlOCatozBOb2tbCtLxWKPZ0iDpQSyXYMwTM3nd4F1VcrTHJgY7wjKOjI62
 MvCQ==
X-Gm-Message-State: APjAAAXIn98/X5cnccVznBav8HFnaez0VZUzZndVylU8MWxjed8nY4HT
 AVBCmHL8EL8Mb+VYQuf0ED+k+f4n6uc=
X-Google-Smtp-Source: APXvYqwBInl9Y13r9BSDDMtOCP7EqKV69gcjiaOy7lWDEUDXI8uKHfiYAtRO+vOUnu4IWNLeaLBj0w==
X-Received: by 2002:a1c:dd06:: with SMTP id u6mr4800727wmg.109.1573574703569; 
 Tue, 12 Nov 2019 08:05:03 -0800 (PST)
Received: from localhost (ec2-34-244-242-0.eu-west-1.compute.amazonaws.com.
 [34.244.242.0])
 by smtp.gmail.com with ESMTPSA id d13sm19698453wrq.51.2019.11.12.08.05.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2019 08:05:02 -0800 (PST)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 2/3] target/microblaze: Plug temp leaks with delay slot setup
Date: Tue, 12 Nov 2019 17:04:48 +0100
Message-Id: <20191112160449.29212-3-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191112160449.29212-1-edgar.iglesias@gmail.com>
References: <20191112160449.29212-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::336
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


