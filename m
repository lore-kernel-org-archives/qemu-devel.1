Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FC59C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:54:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51260205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 21:54:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JmBJl4Dk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51260205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49600 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDxhB-0000Qv-Dx
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 17:54:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43121)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1jDxIA-0004JP-31
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1jDxI8-000757-U0
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:57 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:44600)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1jDxI8-000735-OH
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 17:28:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1584394135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xTf/P4Ei2kgvn4nYu5zgsi1sCPptHxi3UUHa2HfOsOI=;
 b=JmBJl4DkOIgjj3CQ9DCJEl0wu8PD6IU5keIMuUNJN0Q8hnLtsAU1LNZPKE6ug2Z9Zw6F3+
 P2XFV01abWjswu469sG9DVTeFUL3U1o6pW12SW2kwc9J8pmRzYhaWuCW12JWnru9TTjPR2
 5zxJss3K38JUGTMMesVwWspt3A93ilU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-483-MB3b7KkJMDCUbUltBVc0Gg-1; Mon, 16 Mar 2020 17:28:54 -0400
X-MC-Unique: MB3b7KkJMDCUbUltBVc0Gg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 16507100550E
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 21:28:53 +0000 (UTC)
Received: from 640k.localdomain.com (unknown [10.36.110.10])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 221DE19C4F;
 Mon, 16 Mar 2020 21:28:51 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 44/61] hw/net: Use memory_region_init_rom() with read-only
 regions
Date: Mon, 16 Mar 2020 22:27:11 +0100
Message-Id: <1584394048-44994-45-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
References: <1584394048-44994-1-git-send-email-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 216.205.24.74
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

This commit was produced with the Coccinelle script
scripts/coccinelle/memory-region-housekeeping.cocci.

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/net/dp8393x.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 81fc13e..1563c11 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -986,13 +986,12 @@ static void dp8393x_realize(DeviceState *dev, Error *=
*errp)
=20
     s->watchdog =3D timer_new_ns(QEMU_CLOCK_VIRTUAL, dp8393x_watchdog, s);
=20
-    memory_region_init_ram(&s->prom, OBJECT(dev),
-                           "dp8393x-prom", SONIC_PROM_SIZE, &local_err);
+    memory_region_init_rom(&s->prom, OBJECT(dev), "dp8393x-prom",
+                           SONIC_PROM_SIZE, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         return;
     }
-    memory_region_set_readonly(&s->prom, true);
     prom =3D memory_region_get_ram_ptr(&s->prom);
     checksum =3D 0;
     for (i =3D 0; i < 6; i++) {
--=20
1.8.3.1



