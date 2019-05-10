Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,T_HK_NAME_DR
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A8FAC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 19:06:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 14FC8217D7
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 19:06:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 14FC8217D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48694 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPAqs-0001V2-3b
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 15:06:38 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hPAmH-0006dM-1M
	for qemu-devel@nongnu.org; Fri, 10 May 2019 15:01:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hPAmE-00055u-Vp
	for qemu-devel@nongnu.org; Fri, 10 May 2019 15:01:52 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1hPAmD-000524-0R
	for qemu-devel@nongnu.org; Fri, 10 May 2019 15:01:49 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6F3E3307EAA2
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 19:01:43 +0000 (UTC)
Received: from dgilbert-t580.localhost (ovpn-117-163.ams2.redhat.com
	[10.36.117.163])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E267D60126
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 19:01:42 +0000 (UTC)
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
To: qemu-devel@nongnu.org
Date: Fri, 10 May 2019 20:01:40 +0100
Message-Id: <20190510190140.17589-1-dgilbert@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Fri, 10 May 2019 19:01:43 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH] monitor: Fix gva2gpa coverityism
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>

Coverity is complaining that while I'm checking the return
value of mon_get_cpu(), I'm not actually using the checked value,
I'm calling it again and thus it's worried I might get null;
I don't think that's actually possible since i'm under
lock anyway.
However, it's a sensible cleanup.

CID: 1401346

Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 monitor.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/monitor.c b/monitor.c
index bb48997913..f93c4b5c76 100644
--- a/monitor.c
+++ b/monitor.c
@@ -1685,7 +1685,7 @@ static void hmp_gva2gpa(Monitor *mon, const QDict *=
qdict)
         return;
     }
=20
-    gpa  =3D cpu_get_phys_page_attrs_debug(mon_get_cpu(),
+    gpa  =3D cpu_get_phys_page_attrs_debug(cs,
                                          addr & TARGET_PAGE_MASK, &attrs=
);
     if (gpa =3D=3D -1) {
         monitor_printf(mon, "Unmapped\n");
--=20
2.21.0


