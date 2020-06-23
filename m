Return-Path: <SRS0=Q9tF=AE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9DF0C433E1
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:30:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A37ED20716
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2020 14:30:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gOjZGnRo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A37ED20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47560 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnjw3-000390-R2
	for qemu-devel@archiver.kernel.org; Tue, 23 Jun 2020 10:30:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51646)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnjpv-0001qz-Dy
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:23:43 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50383
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnjpn-0007kg-9u
 for qemu-devel@nongnu.org; Tue, 23 Jun 2020 10:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592922214;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JW+K+F+cBl7Afy5FOM0LYsgEpF08Y8jYZE0qPWSBVWg=;
 b=gOjZGnRoVNyvNOu1wEWkqMDAcUn9lRfw3PVBWEaivQ1zHwhruL1NXYlILL42a8anIIaxKz
 tOv479RSSR5VJzNvBIIS52Phu8bNvRPTCk0Y8fSFrhglVYZ85zi6HS6B7PiZkn6AZCUCTw
 kizwUuv93bDgKJzZBBVF9hwJ09+rCrE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-Bq8BZVm2N-KUuXh2eHlgZg-1; Tue, 23 Jun 2020 10:23:32 -0400
X-MC-Unique: Bq8BZVm2N-KUuXh2eHlgZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 369DC805EE2;
 Tue, 23 Jun 2020 14:23:31 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3F9971688;
 Tue, 23 Jun 2020 14:23:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7271E113847E; Tue, 23 Jun 2020 16:23:26 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 16/16] sd/milkymist-memcard: Fix error API violation
Date: Tue, 23 Jun 2020 16:23:26 +0200
Message-Id: <20200623142326.2349416-17-armbru@redhat.com>
In-Reply-To: <20200623142326.2349416-1-armbru@redhat.com>
References: <20200623142326.2349416-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/23 02:55:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Michael Walle <michael@walle.cc>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The Error ** argument must be NULL, &error_abort, &error_fatal, or a
pointer to a variable containing NULL.  Passing an argument of the
latter kind twice without clearing it in between is wrong: if the
first call sets an error, it no longer points to NULL for the second
call.

milkymist_memcard_realize() is wrong that way: it passes &err to
qdev_prop_set_drive_err() and qdev_realize_and_unref().  Currently
harmless, because the latter uses it only as first argument of
error_propagate().

Making qdev_prop_set_drive_err() fail involves abuse of -global.
Leave handling that to qdev_prop_set_drive(), like we do elsewhere.

Cc: Michael Walle <michael@walle.cc>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20200622094227.1271650-17-armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/sd/milkymist-memcard.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/milkymist-memcard.c b/hw/sd/milkymist-memcard.c
index 1c23310715..482e97191e 100644
--- a/hw/sd/milkymist-memcard.c
+++ b/hw/sd/milkymist-memcard.c
@@ -279,7 +279,7 @@ static void milkymist_memcard_realize(DeviceState *dev, Error **errp)
     dinfo = drive_get_next(IF_SD);
     blk = dinfo ? blk_by_legacy_dinfo(dinfo) : NULL;
     carddev = qdev_new(TYPE_SD_CARD);
-    qdev_prop_set_drive_err(carddev, "drive", blk, &err);
+    qdev_prop_set_drive(carddev, "drive", blk);
     qdev_realize_and_unref(carddev, BUS(&s->sdbus), &err);
     if (err) {
         error_setg(errp, "failed to init SD card: %s", error_get_pretty(err));
-- 
2.26.2


