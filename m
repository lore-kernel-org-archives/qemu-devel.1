Return-Path: <SRS0=brme=YQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99397CA9EB6
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 17:14:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6CD9E2086D
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Oct 2019 17:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6CD9E2086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNKDc-0005A1-GA
	for qemu-devel@archiver.kernel.org; Wed, 23 Oct 2019 13:14:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <xiajidong@cmss.chinamobile.com>) id 1iNDMH-0000V0-3J
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 05:55:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <xiajidong@cmss.chinamobile.com>) id 1iNDMF-0001Oa-Mq
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 05:55:12 -0400
Received: from cmccmta3.chinamobile.com ([221.176.66.81]:16160)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <xiajidong@cmss.chinamobile.com>) id 1iNDMF-0001An-2Q
 for qemu-devel@nongnu.org; Wed, 23 Oct 2019 05:55:11 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by
 rmmx-syy-dmz-app11-12011 (RichMail) with SMTP id 2eeb5db02367365-317e1;
 Wed, 23 Oct 2019 17:54:47 +0800 (CST)
X-RM-TRANSID: 2eeb5db02367365-317e1
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from xiajidong001.localdomain (unknown[223.105.0.241])
 by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee55db0235dfb2-71dfc;
 Wed, 23 Oct 2019 17:54:47 +0800 (CST)
X-RM-TRANSID: 2ee55db0235dfb2-71dfc
From: Jidong Xia <xiajidong@cmss.chinamobile.com>
To: qemu-devel@nongnu.org
Subject: [PATCH] hw/audio: fix a memory leak in OPLCreate()
Date: Wed, 23 Oct 2019 17:53:40 +0800
Message-Id: <1571824420-24893-1-git-send-email-xiajidong@cmss.chinamobile.com>
X-Mailer: git-send-email 1.8.3.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [fuzzy]
X-Received-From: 221.176.66.81
X-Mailman-Approved-At: Wed, 23 Oct 2019 13:09:41 -0400
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
Cc: Jidong Xia <xiajidong@cmss.chinamobile.com>, kraxel@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a memory leak in OPLCreate(),Should free allocated mem
before return.

Signed-off-by: Jidong Xia <xiajidong@cmss.chinamobile.com>
---
 hw/audio/fmopl.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/audio/fmopl.c b/hw/audio/fmopl.c
index 9f50a89..ca9825b 100644
--- a/hw/audio/fmopl.c
+++ b/hw/audio/fmopl.c
@@ -1112,6 +1112,7 @@ FM_OPL *OPLCreate(int clock, int rate)
 		opl_dbg_maxchip++;
 	}
 #endif
+	free(ptr);
 	return OPL;
 }
 
-- 
1.8.3.1




