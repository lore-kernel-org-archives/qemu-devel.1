Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73D1C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:03:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4DB42081A
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 06:03:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GPAJAHgy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4DB42081A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jitpz-0007Mh-Rv
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 02:03:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42652)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitMT-0005Kv-Kq
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:33:17 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34790
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitMD-0003sj-Ns
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:33:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591767180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9nj3iCsfC2ylpNWibxTF+tnkvCfYJ5WptVOBoRmd8Es=;
 b=GPAJAHgybVD/e3RZiGMbQ1JbvGNszDfMvk4LZHCGMoKrPauoeo84JYAGk0dST0JuQSdMJM
 mCiLdJLj9yEiDaEf4/MXcVLQlFajGlBxlk8NbEouoTXyuFhBbJKkU9bd/wOSmmmPzzJmtw
 moWlqvHjRER07fOZ5B098RYhLUppQKA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-ahkLLzWCNdG4nEINR4TMxg-1; Wed, 10 Jun 2020 01:32:58 -0400
X-MC-Unique: ahkLLzWCNdG4nEINR4TMxg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A1E30800053
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 05:32:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 70CD15C1D2;
 Wed, 10 Jun 2020 05:32:57 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id F04421138488; Wed, 10 Jun 2020 07:32:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 50/58] sysbus: Convert qdev_set_parent_bus() use
 with Coccinelle, part 4
Date: Wed, 10 Jun 2020 07:32:39 +0200
Message-Id: <20200610053247.1583243-51-armbru@redhat.com>
In-Reply-To: <20200610053247.1583243-1-armbru@redhat.com>
References: <20200610053247.1583243-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=armbru@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 21:17:20
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
Cc: Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This is still the same transformation as in the previous commits, but
here the sysbus_init_child_obj() and its matching realize in are in
separate files.  Fortunately, there's just one realize left to
convert.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/arm/aspeed_ast2600.c | 10 ++++------
 hw/arm/aspeed_soc.c     |  4 ++--
 hw/sd/aspeed_sdhci.c    |  2 +-
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/hw/arm/aspeed_ast2600.c b/hw/arm/aspeed_ast2600.c
index 7c39adb272..d465743247 100644
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
@@ -210,9 +209,8 @@ static void aspeed_soc_ast2600_init(Object *obj)
 
     object_property_set_int(OBJECT(&s->emmc), 1, "num-slots", &error_abort);
 
-    sysbus_init_child_obj(obj, "emmc-controller.sdhci",
-                          &s->emmc.slots[0], sizeof(s->emmc.slots[0]),
-                          TYPE_SYSBUS_SDHCI);
+    object_initialize_child(obj, "emmc-controller.sdhci", &s->emmc.slots[0],
+                            TYPE_SYSBUS_SDHCI);
 }
 
 /*
diff --git a/hw/arm/aspeed_soc.c b/hw/arm/aspeed_soc.c
index c40839c1fb..d1e48b7a5d 100644
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
2.26.2


