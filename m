Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A418FC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 19:03:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A0C217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 19:03:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A0C217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48630 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPAnn-0007O9-Jl
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 15:03:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51107)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hPAh2-0000nv-3N
	for qemu-devel@nongnu.org; Fri, 10 May 2019 14:56:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hPAh0-0000VU-4R
	for qemu-devel@nongnu.org; Fri, 10 May 2019 14:56:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hPAgz-0000Rq-V2
	for qemu-devel@nongnu.org; Fri, 10 May 2019 14:56:26 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 19ACA307DAC8
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 18:56:22 +0000 (UTC)
Received: from localhost (ovpn-116-40.gru2.redhat.com [10.97.116.40])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9B7615ED46;
	Fri, 10 May 2019 18:56:21 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 15:56:20 -0300
Message-Id: <20190510185620.15757-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.42]);
	Fri, 10 May 2019 18:56:22 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] monitor: Call mon_get_cpu() only once at
 hmp_gva2gpa()
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

hmp_gva2gpa() calls mon_get_cpu() twice, which is unnecessary.
Not an actual bug, but this is reported as a defect by Coverity
Scan (CID 1401346).

Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 monitor.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/monitor.c b/monitor.c
index bb48997913..6428eb3b7e 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1685,8 +1685,7 @@ static void hmp_gva2gpa(Monitor *mon, const QDict *qdict)
         return;
     }
 
-    gpa  = cpu_get_phys_page_attrs_debug(mon_get_cpu(),
-                                         addr & TARGET_PAGE_MASK, &attrs);
+    gpa  = cpu_get_phys_page_attrs_debug(cs, addr & TARGET_PAGE_MASK, &attrs);
     if (gpa == -1) {
         monitor_printf(mon, "Unmapped\n");
     } else {
-- 
2.18.0.rc1.1.g3f1ff2140


