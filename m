Return-Path: <SRS0=TEh4=AD=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B16BEC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:56:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DC08206F1
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Jun 2020 09:56:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xyo1oQkV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DC08206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jnJBI-00067x-Nu
	for qemu-devel@archiver.kernel.org; Mon, 22 Jun 2020 05:56:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54130)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnIyW-0001xs-7C
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:42:48 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42323
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jnIyM-0003xj-6h
 for qemu-devel@nongnu.org; Mon, 22 Jun 2020 05:42:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1592818957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a4siptWoDZuGpwrrvt98Vfg4/h8SgZLNu0DV6Qu0HXA=;
 b=Xyo1oQkVfL5ZmafUKp32RqjTlu14oJTg9hgVAeXx5jTTNOAvqzzmRaNopDmbaiz6Aw36mC
 axtEIfxhH77UEKH+D9sfTz8w84wv0cc6Pz2vJ6+6E0iMYkHgmUYVM+Ela5D+7nxdaoZSZj
 VpZ7cJx9jBJa40cnNjiiJ3kiekJ8qhI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-461-KorycQmEPdKVajFaO7nEMA-1; Mon, 22 Jun 2020 05:42:33 -0400
X-MC-Unique: KorycQmEPdKVajFaO7nEMA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0D358064D8;
 Mon, 22 Jun 2020 09:42:32 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 69CD75D9D5;
 Mon, 22 Jun 2020 09:42:32 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 222C9113847D; Mon, 22 Jun 2020 11:42:28 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 15/16] sd/pxa2xx_mmci: Don't crash on pxa2xx_mmci_init()
 error
Date: Mon, 22 Jun 2020 11:42:26 +0200
Message-Id: <20200622094227.1271650-16-armbru@redhat.com>
In-Reply-To: <20200622094227.1271650-1-armbru@redhat.com>
References: <20200622094227.1271650-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/22 02:57:26
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
Cc: kwolf@redhat.com, Peter Maydell <peter.maydell@linaro.org>,
 berrange@redhat.com, ehabkost@redhat.com, qemu-block@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 mreitz@redhat.com, qemu-arm@nongnu.org, pbonzini@redhat.com, jsnow@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On error, pxa2xx_mmci_init() reports to stderr and returns NULL.
Callers don't check for errors.  Machines akita, borzoi, mainstone,
spitz, terrier, tosa, and z2 crash shortly after, like this:

    $ qemu-system-aarch64 -M akita -drive if=sd,readonly=on
    qemu-system-aarch64: failed to init SD card: Cannot use read-only drive as SD card
    Segmentation fault (core dumped)

Machines connex and verdex reach the check for orphaned drives first:

    $ aarch64-softmmu/qemu-system-aarch64 -M connex -drive if=sd,readonly=on -accel qtest
    qemu-system-aarch64: failed to init SD card: Cannot use read-only drive as SD card
    qemu-system-aarch64: -drive if=sd,readonly=on: machine type does not support if=sd,bus=0,unit=0

Make pxa2xx_mmci_init() fail cleanly right away.

Cc: Andrzej Zaborowski <balrogg@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
---
 hw/sd/pxa2xx_mmci.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/hw/sd/pxa2xx_mmci.c b/hw/sd/pxa2xx_mmci.c
index 3407617afc..68bed24480 100644
--- a/hw/sd/pxa2xx_mmci.c
+++ b/hw/sd/pxa2xx_mmci.c
@@ -18,7 +18,6 @@
 #include "hw/arm/pxa.h"
 #include "hw/sd/sd.h"
 #include "hw/qdev-properties.h"
-#include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "trace.h"
@@ -483,7 +482,6 @@ PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysmem,
     DeviceState *dev, *carddev;
     SysBusDevice *sbd;
     PXA2xxMMCIState *s;
-    Error *err = NULL;
 
     dev = qdev_new(TYPE_PXA2XX_MMCI);
     s = PXA2XX_MMCI(dev);
@@ -496,16 +494,9 @@ PXA2xxMMCIState *pxa2xx_mmci_init(MemoryRegion *sysmem,
 
     /* Create and plug in the sd card */
     carddev = qdev_new(TYPE_SD_CARD);
-    qdev_prop_set_drive_err(carddev, "drive", blk, &err);
-    if (err) {
-        error_reportf_err(err, "failed to init SD card: ");
-        return NULL;
-    }
-    qdev_realize_and_unref(carddev, qdev_get_child_bus(dev, "sd-bus"), &err);
-    if (err) {
-        error_reportf_err(err, "failed to init SD card: ");
-        return NULL;
-    }
+    qdev_prop_set_drive_err(carddev, "drive", blk, &error_fatal);
+    qdev_realize_and_unref(carddev, qdev_get_child_bus(dev, "sd-bus"),
+                           &error_fatal);
 
     return s;
 }
-- 
2.26.2


