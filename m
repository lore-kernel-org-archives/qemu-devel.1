Return-Path: <SRS0=hUBF=7W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0A45C433E0
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:48:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 982CA20737
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2020 16:48:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hmmfycf/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 982CA20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37086 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jihQi-0007hW-Rg
	for qemu-devel@archiver.kernel.org; Tue, 09 Jun 2020 12:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48738)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihHn-000444-Np
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:39:39 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50149
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jihHm-0003Bl-Jg
 for qemu-devel@nongnu.org; Tue, 09 Jun 2020 12:39:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591720777;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m0fzEpYh7/eYbQh+/rk98/bJZKRSToE5BRJW6A+8ujI=;
 b=hmmfycf//L+6XWz3cdpeEquR9/40s57mw/yAUX+i6TJIv/3w6CSSSbL+efFN+Zhi09UhMa
 BR/7IxI62jXrRwG6uUzLiEWoaBnhyJkebBXOUbbEApZMRVWiOsJ1irnYDSUQmWB5xodvPt
 3GjyEPxuG0PYbEjvw10FMbOCtI3uFvk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-514-LoVIK0f8PGW2mfy0_uMeOQ-1; Tue, 09 Jun 2020 12:39:36 -0400
X-MC-Unique: LoVIK0f8PGW2mfy0_uMeOQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 552388014D9
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2020 16:39:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2502119D61;
 Tue,  9 Jun 2020 16:39:35 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 4ECE81138531; Tue,  9 Jun 2020 18:39:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v3 05/39] qdev: Put qdev_new() to use with Coccinelle
Date: Tue,  9 Jun 2020 18:38:58 +0200
Message-Id: <20200609163932.1566209-6-armbru@redhat.com>
In-Reply-To: <20200609163932.1566209-1-armbru@redhat.com>
References: <20200609163932.1566209-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 02:41:53
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Let's start simple and put qdev_new() to use.  Coccinelle script:

    @ depends on !(file in "hw/core/qdev.c")@
    expression type_name;
    @@
    -    DEVICE(object_new(type_name))
    +    qdev_new(type_name)

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/block/nand.c  | 2 +-
 hw/misc/auxbus.c | 2 +-
 qdev-monitor.c   | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/hw/block/nand.c b/hw/block/nand.c
index bba89688ba..cdf3429ce6 100644
--- a/hw/block/nand.c
+++ b/hw/block/nand.c
@@ -644,7 +644,7 @@ DeviceState *nand_init(BlockBackend *blk, int manf_id, int chip_id)
     if (nand_flash_ids[chip_id].size == 0) {
         hw_error("%s: Unsupported NAND chip ID.\n", __func__);
     }
-    dev = DEVICE(object_new(TYPE_NAND));
+    dev = qdev_new(TYPE_NAND);
     qdev_prop_set_uint8(dev, "manufacturer_id", manf_id);
     qdev_prop_set_uint8(dev, "chip_id", chip_id);
     if (blk) {
diff --git a/hw/misc/auxbus.c b/hw/misc/auxbus.c
index 5e4794f0ac..7fb020086f 100644
--- a/hw/misc/auxbus.c
+++ b/hw/misc/auxbus.c
@@ -273,7 +273,7 @@ DeviceState *aux_create_slave(AUXBus *bus, const char *type)
 {
     DeviceState *dev;
 
-    dev = DEVICE(object_new(type));
+    dev = qdev_new(type);
     assert(dev);
     qdev_set_parent_bus(dev, &bus->qbus);
     return dev;
diff --git a/qdev-monitor.c b/qdev-monitor.c
index a4735d3bb1..20cfa7615b 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -652,7 +652,7 @@ DeviceState *qdev_device_add(QemuOpts *opts, Error **errp)
     }
 
     /* create device */
-    dev = DEVICE(object_new(driver));
+    dev = qdev_new(driver);
 
     /* Check whether the hotplug is allowed by the machine */
     if (qdev_hotplug && !qdev_hotplug_allowed(dev, &err)) {
-- 
2.26.2


