Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3F6C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:11:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 68433207FB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:11:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dv3ED8MY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 68433207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb3td-0007Hs-It
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:11:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45086)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3fA-0001b4-Oy
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:12 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:57427
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3f3-0003Wn-91
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589900163;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jiCAW4AuwADcV0vSs2s4AlDAJ9nPkwi0DrgyT9skYbU=;
 b=dv3ED8MY54kYyZfQtUWekv7cfHM/+IgnYbs2LCC5l9JWTXiV0oKJwWpXNEnqtFd+kB+GY1
 s7r9vb84powcwhIPCMw9JwAGVfy0m/NJZPMamebE9+Iaxd2wHtO9OMr3kYbQH1w+ys+J+/
 7gLi1kdnRCKllidz1j67bPC0VwpuZpM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-168-0zp2TzLFPI6jTwSGX_kcGQ-1; Tue, 19 May 2020 10:56:01 -0400
X-MC-Unique: 0zp2TzLFPI6jTwSGX_kcGQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D3BC7464
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:56:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A3FE45C1D0;
 Tue, 19 May 2020 14:56:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 658CE113522D; Tue, 19 May 2020 16:55:52 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 48/55] sysbus: Convert qdev_set_parent_bus() use with
 Coccinelle, part 4
Date: Tue, 19 May 2020 16:55:44 +0200
Message-Id: <20200519145551.22836-49-armbru@redhat.com>
In-Reply-To: <20200519145551.22836-1-armbru@redhat.com>
References: <20200519145551.22836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/18 23:19:13
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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
Cc: pbonzini@redhat.com, berrange@redhat.com, ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is still the same transformation as in the previous commits, but
here the sysbus_init_child_obj() and its matching realize in are in
separate files.  Fortunately, there's just one realize left to
convert.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 hw/arm/aspeed_ast2600.c | 9 ++++-----
 hw/arm/aspeed_soc.c     | 4 ++--
 hw/sd/aspeed_sdhci.c    | 2 +-
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index a38b66de46..d7a063fd5a 100644
--- a/hw/arm/aspeed_ast2600.c
+++ b/hw/arm/aspeed_ast2600.c
@@ -200,9 +200,8 @@ static void aspeed_soc_ast2600_init(Object *obj)
 
     /* Init sd card slot class here so that they're under the correct parent */
     for (i = 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
-        sysbus_init_child_obj(obj, "sd-controller.sdhci[*]",
-                              &s->sdhci.slots[i],
-                              sizeof(s->sdhci.slots[i]), TYPE_SYSBUS_SDHCI);
+        object_initialize_child(obj, "sd-controller.sdhci[*]",
+                                &s->sdhci.slots[i], TYPE_SYSBUS_SDHCI);
     }
 
     object_initialize_child(obj, "emmc-controller", &s->emmc,
@@ -210,8 +209,8 @@ static void aspeed_soc_ast2600_init(Object *obj)
 
     object_property_set_int(OBJECT(&s->emmc), 1, "num-slots", &error_abort);
 
-    sysbus_init_child_obj(obj, "emmc-controller.sdhci",
-                          &s->emmc.slots[0], sizeof(s->emmc.slots[0]), TYPE_SYSBUS_SDHCI);
+    object_initialize_child(obj, "emmc-controller.sdhci", &s->emmc.slots[0],
+                            TYPE_SYSBUS_SDHCI);
 }
 
 /*
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index 175b220c97..9760b501c0 100644
--- a/hw/arm/aspeed_soc.c
+++ b/hw/arm/aspeed_soc.c
@@ -208,8 +208,8 @@ static void aspeed_soc_init(Object *obj)
 
     /* Init sd card slot class here so that they're under the correct parent */
     for (i = 0; i < ASPEED_SDHCI_NUM_SLOTS; ++i) {
-        sysbus_init_child_obj(obj, "sdhci[*]", &s->sdhci.slots[i],
-                              sizeof(s->sdhci.slots[i]), TYPE_SYSBUS_SDHCI);
+        object_initialize_child(obj, "sdhci[*]", &s->sdhci.slots[i],
+                                TYPE_SYSBUS_SDHCI);
     }
 }
 
diff --git a/hw/sd/aspeed_sdhci.c b/hw/sd/aspeed_sdhci.c
index 6a039a1d2f..538d3bad3d 100644
--- a/hw/sd/aspeed_sdhci.c
+++ b/hw/sd/aspeed_sdhci.c
@@ -145,7 +145,7 @@ static void aspeed_sdhci_realize(DeviceState *dev, Error **errp)
             return;
         }
 
-        object_property_set_bool(sdhci_slot, true, "realized", &err);
+        sysbus_realize(sbd_slot, &err);
         if (err) {
             error_propagate(errp, err);
             return;
-- 
2.21.1


