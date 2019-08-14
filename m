Return-Path: <SRS0=fB5B=WK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5EAC32753
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 13:00:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65A8620679
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2019 13:00:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65A8620679
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60458 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxstF-0000Bj-Ek
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 09:00:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52851)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <luoyifan@cmss.chinamobile.com>) id 1hxmYi-0007lP-OK
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 02:14:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <luoyifan@cmss.chinamobile.com>) id 1hxmYh-0004eO-1v
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 02:14:56 -0400
Received: from cmccmta1.chinamobile.com ([221.176.66.79]:2896)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <luoyifan@cmss.chinamobile.com>)
 id 1hxmYe-0004Gx-L7; Wed, 14 Aug 2019 02:14:54 -0400
Received: from spf.mail.chinamobile.com (unknown[172.16.121.9]) by
 rmmx-syy-dmz-app02-12002 (RichMail) with SMTP id 2ee25d53a6c413c-b41f4;
 Wed, 14 Aug 2019 14:14:29 +0800 (CST)
X-RM-TRANSID: 2ee25d53a6c413c-b41f4
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG: 00000000
Received: from LAPTOPBMTSOBR7 (unknown[112.25.154.148])
 by rmsmtp-syy-appsvr05-12005 (RichMail) with SMTP id 2ee55d53a6c3f51-8957c;
 Wed, 14 Aug 2019 14:14:28 +0800 (CST)
X-RM-TRANSID: 2ee55d53a6c3f51-8957c
From: <luoyifan@cmss.chinamobile.com>
To: <qemu-devel@nongnu.org>
Date: Wed, 14 Aug 2019 14:14:26 +0800
Message-ID: <02cf01d55267$86cf2850$946d78f0$@cmss.chinamobile.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AdVSZzdMb/mLdwi2R02S0a02zpe8VQ==
Content-Language: zh-cn
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 221.176.66.79
X-Mailman-Approved-At: Wed, 14 Aug 2019 08:58:51 -0400
Subject: [Qemu-devel] [PATCH] pc-bios/s390-ccw/net: fix a possible memory
 leak in get_uuid()
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
Cc: borntraeger@de.ibm.com, thuth@redhat.com, cohuck@redhat.com,
 qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

There is a possible memory leak in get_uuid(). Should free allocated mem
before 
return NULL.

Signed-off-by: Yifan Luo <luoyifan@cmss.chinamobile.com>
---
 pc-bios/s390-ccw/netmain.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index f3542cb2cf1..f2dcc01e272 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -269,6 +269,7 @@ static const char *get_uuid(void)
                  : "d" (r0), "d" (r1), [addr] "a" (buf)
                  : "cc", "memory");
     if (cc) {
+        free(mem);
         return NULL;
     }
 
-- 
2.21.0




