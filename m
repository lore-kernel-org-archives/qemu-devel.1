Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0142C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 19:08:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C306D21D81
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 19:08:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=suse.com header.i=@suse.com header.b="CINA5H5T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C306D21D81
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44036 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT8cB-0003sS-GM
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 15:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1kT8bR-0003R7-On
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 15:07:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:38386)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brogers@suse.com>) id 1kT8bQ-0001w6-5i
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 15:07:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
 t=1602788871;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=PBGEOQNan7Kx35cpMtw3DSU6w+Dcs2+o43RLNpFGCmA=;
 b=CINA5H5TH98Qg//tut2XxcKoNM7L9KxaeFWJ/3C5albjAdowpSe+A63h//8eLofk0J7+8k
 6wpxvM8mW/Um07EP7Dk+jSG1PFlOuWDlTq5kyQe81a2HnDCAS5VezxVtQstcmn/LKclS4f
 d2zGt+/69VJL7r7gKRcCLq3Ba8AE8DA=
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id EE35DACB5;
 Thu, 15 Oct 2020 19:07:50 +0000 (UTC)
From: Bruce Rogers <brogers@suse.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] configure: fix handling of --docdir parameter
Date: Thu, 15 Oct 2020 13:07:42 -0600
Message-Id: <20201015190742.270629-1-brogers@suse.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=195.135.220.15; envelope-from=brogers@suse.com;
 helo=mx2.suse.de
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/12 01:21:00
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x (no timestamps) [generic]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: marcandre.lureau@redhat.com, Bruce Rogers <brogers@suse.com>,
 pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit ca8c0909f01 changed qemu_docdir to be docdir, then later uses the
qemu_docdir name in the final assignment. Unfortunately, one instance of
qemu_docdir was missed: the one which comes from the --docdir parameter.
This patch restores the proper handling of the --docdir parameter.

Fixes: ca8c0909f01 ("configure: build docdir like other suffixed
directories")

Signed-off-by: Bruce Rogers <brogers@suse.com>
---
 configure | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/configure b/configure
index f839c2a557..07acd01a25 100755
--- a/configure
+++ b/configure
@@ -971,7 +971,7 @@ for opt do
   ;;
   --with-suffix=*) qemu_suffix="$optarg"
   ;;
-  --docdir=*) qemu_docdir="$optarg"
+  --docdir=*) docdir="$optarg"
   ;;
   --sysconfdir=*) sysconfdir="$optarg"
   ;;
-- 
2.28.0


