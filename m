Return-Path: <SRS0=4umr=AO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CF0DC433E0
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:34:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08ED620760
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Jul 2020 16:34:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=cam.ac.uk header.i=@cam.ac.uk header.b="icqvb5JC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08ED620760
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=cl.cam.ac.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40180 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jrOeN-0007gk-5I
	for qemu-devel@archiver.kernel.org; Fri, 03 Jul 2020 12:34:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36188)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alr48@hermes.cam.ac.uk>)
 id 1jrOM1-0007WT-8n; Fri, 03 Jul 2020 12:15:57 -0400
Received: from ppsw-32.csi.cam.ac.uk ([131.111.8.132]:60496)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alr48@hermes.cam.ac.uk>)
 id 1jrOLu-0003ph-UO; Fri, 03 Jul 2020 12:15:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cam.ac.uk; 
 s=20180806.ppsw;
 h=Sender:Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=nyUs57KD+/rwm24QCMUWSjfEn7hQD64IT/vc42otKB0=; b=icqvb5JCSpE+tTHqPm34NenHOC
 d1GdrtDFU3ovsUxWP1PiFogrqIz1kvvsef5qnxSz8Dn5I117B7x0cVQhowyOQwzNfFvylxPzR1H4h
 2qxGTF6aXGIMxy2UgByfH1WJlfVbU0K0Q6u9gl4gi/UBkbm/ydUGMkrJa3dhR9vLFPWw=;
X-Cam-AntiVirus: no malware found
X-Cam-ScannerInfo: http://help.uis.cam.ac.uk/email-scanner-virus
Received: from host86-181-137-242.range86-181.btcentralplus.com
 ([86.181.137.242]:53505 helo=Alexs-MBP-10.home)
 by ppsw-32.csi.cam.ac.uk (smtp.hermes.cam.ac.uk [131.111.8.156]:587)
 with esmtpsa (LOGIN:alr48) (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 id 1jrOLo-000TRi-2l (Exim 4.92.3)
 (return-path <alr48@hermes.cam.ac.uk>); Fri, 03 Jul 2020 17:15:44 +0100
From: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>
To: Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>
Subject: [PATCH] Fix MIPS add.s after 1ace099f2acb952eaaef0ba7725879949a7e4406
Date: Fri,  3 Jul 2020 17:15:15 +0100
Message-Id: <20200703161515.25966-1-Alexander.Richardson@cl.cam.ac.uk>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=131.111.8.132;
 envelope-from=alr48@hermes.cam.ac.uk; helo=ppsw-32.csi.cam.ac.uk
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/03 12:15:45
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -52
X-Spam_score: -5.3
X-Spam_bar: -----
X-Spam_report: (-5.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_MED=-2.3,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: qemu-trivial@nongnu.org, Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

After merging latest QEMU upstream into our CHERI fork, I noticed that
some of the FPU tests in our MIPS baremetal testsuite
(https://github.com/CTSRD-CHERI/cheritest) started failing. It turns out
this commit accidentally changed add.s into a subtract.

Signed-off-by: Alex Richardson <Alexander.Richardson@cl.cam.ac.uk>
---
 target/mips/fpu_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/mips/fpu_helper.c b/target/mips/fpu_helper.c
index 7a3a61cab3..56beda49d8 100644
--- a/target/mips/fpu_helper.c
+++ b/target/mips/fpu_helper.c
@@ -1221,7 +1221,7 @@ uint32_t helper_float_add_s(CPUMIPSState *env,
 {
     uint32_t wt2;
 
-    wt2 = float32_sub(fst0, fst1, &env->active_fpu.fp_status);
+    wt2 = float32_add(fst0, fst1, &env->active_fpu.fp_status);
     update_fcr31(env, GETPC());
     return wt2;
 }
-- 
2.27.0


