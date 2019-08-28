Return-Path: <SRS0=QQWF=WY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21281C3A5A6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:36:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEAEB2189D
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Aug 2019 12:36:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEAEB2189D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35942 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2xBQ-0003KO-59
	for qemu-devel@archiver.kernel.org; Wed, 28 Aug 2019 08:36:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52929)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1i2x99-0002QC-UZ
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:33:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1i2x95-000206-IC
 for qemu-devel@nongnu.org; Wed, 28 Aug 2019 08:33:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51560)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1i2x95-0001yd-DE; Wed, 28 Aug 2019 08:33:51 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id BAFE118C8917;
 Wed, 28 Aug 2019 12:33:48 +0000 (UTC)
Received: from thuth.com (ovpn-116-90.ams2.redhat.com [10.36.116.90])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 640CE5D70D;
 Wed, 28 Aug 2019 12:33:47 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>,
	qemu-devel@nongnu.org
Date: Wed, 28 Aug 2019 14:33:43 +0200
Message-Id: <20190828123343.8343-1-thuth@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.70]); Wed, 28 Aug 2019 12:33:48 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] pc-bios/s390-ccw: Do not pre-initialize empty
 array
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

We're clearing the BSS in start.S now, so there is no need to
pre-initialize the loadparm_str array with zeroes anymore.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 pc-bios/s390-ccw/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/pc-bios/s390-ccw/main.c b/pc-bios/s390-ccw/main.c
index a69c73349e..a21b386280 100644
--- a/pc-bios/s390-ccw/main.c
+++ b/pc-bios/s390-ccw/main.c
@@ -17,7 +17,7 @@
 
 char stack[PAGE_SIZE * 8] __attribute__((__aligned__(PAGE_SIZE)));
 static SubChannelId blk_schid = { .one = 1 };
-static char loadparm_str[LOADPARM_LEN + 1] = { 0, 0, 0, 0, 0, 0, 0, 0, 0 };
+static char loadparm_str[LOADPARM_LEN + 1];
 QemuIplParameters qipl;
 IplParameterBlock iplb __attribute__((__aligned__(PAGE_SIZE)));
 static bool have_iplb;
-- 
2.18.1


