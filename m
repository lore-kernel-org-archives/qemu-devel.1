Return-Path: <SRS0=LLOU=EL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DABFC00A89
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 09:05:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 31D3B206FB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2020 09:05:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 31D3B206FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=ispras.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kabCZ-0005J9-5m
	for qemu-devel@archiver.kernel.org; Thu, 05 Nov 2020 04:05:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35664)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kabBk-0004ss-QW
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 04:04:12 -0500
Received: from mail.ispras.ru ([83.149.199.84]:37300)
 by eggs.gnu.org with esmtps (TLS1.2:DHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pavel.dovgalyuk@ispras.ru>)
 id 1kabBi-0006of-Ew
 for qemu-devel@nongnu.org; Thu, 05 Nov 2020 04:04:12 -0500
Received: from [127.0.1.1] (unknown [62.118.151.149])
 by mail.ispras.ru (Postfix) with ESMTPSA id 3769A40A1DD8;
 Thu,  5 Nov 2020 09:04:07 +0000 (UTC)
Subject: [PATCH] target/alpha: fix icount handling for timer instructions
From: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
To: qemu-devel@nongnu.org
Date: Thu, 05 Nov 2020 12:04:06 +0300
Message-ID: <160456704692.16573.15665952713514406897.stgit@pasha-ThinkPad-X280>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=83.149.199.84;
 envelope-from=pavel.dovgalyuk@ispras.ru; helo=mail.ispras.ru
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/05 04:04:07
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: richard.henderson@linaro.org, pavel.dovgalyuk@ispras.ru
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This patch handles icount mode for timer read/write instructions,
because it is required to call gen_io_start in such cases.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgalyuk@ispras.ru>
---
 target/alpha/translate.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/target/alpha/translate.c b/target/alpha/translate.c
index 36be602179..b534b0579d 100644
--- a/target/alpha/translate.c
+++ b/target/alpha/translate.c
@@ -1330,7 +1330,7 @@ static DisasJumpType gen_mfpr(DisasContext *ctx, TCGv va, int regno)
     case 249: /* VMTIME */
         helper = gen_helper_get_vmtime;
     do_helper:
-        if (icount_enabled()) {
+        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
             gen_io_start();
             helper(va);
             return DISAS_PC_STALE;
@@ -1366,6 +1366,7 @@ static DisasJumpType gen_mfpr(DisasContext *ctx, TCGv va, int regno)
 static DisasJumpType gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
 {
     int data;
+    DisasJumpType ret = DISAS_NEXT;
 
     switch (regno) {
     case 255:
@@ -1395,6 +1396,10 @@ static DisasJumpType gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
 
     case 251:
         /* ALARM */
+        if (tb_cflags(ctx->base.tb) & CF_USE_ICOUNT) {
+            gen_io_start();
+            ret = DISAS_PC_STALE;
+        }
         gen_helper_set_alarm(cpu_env, vb);
         break;
 
@@ -1434,7 +1439,7 @@ static DisasJumpType gen_mtpr(DisasContext *ctx, TCGv vb, int regno)
         break;
     }
 
-    return DISAS_NEXT;
+    return ret;
 }
 #endif /* !USER_ONLY*/
 


