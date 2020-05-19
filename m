Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0AD7C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 14:58:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6A9FC207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 14:58:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YInCG51n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6A9FC207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58044 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb3hd-00071j-GI
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 10:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44938)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3ez-00016z-PD
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:01 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:20761
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jb3ey-0003UW-93
 for qemu-devel@nongnu.org; Tue, 19 May 2020 10:56:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589900159;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bvbipkYu05v0g5KMKrHpWYszU+I/zMGoEwJ4O/xE5Ik=;
 b=YInCG51nhYj/+SfmGPYWIud8SgLbsMEsKyRjI0FwE3Rvv1BodOOJ1fYutpgV1IbxmUKEbP
 G874o37KQGf4srOloOyhK8jqh2++j2Ywq4wpXEUuK2H2kCc9ydpYc4CwOciyizz4Z/Fh4P
 EBSNrhSwkuuwcDqvjCm4G6wCW+P7/iw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-382-tK_BQwp9PPWf5A-fXOujYQ-1; Tue, 19 May 2020 10:55:58 -0400
X-MC-Unique: tK_BQwp9PPWf5A-fXOujYQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DC0FF1009600
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 14:55:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AA2DA60BEC;
 Tue, 19 May 2020 14:55:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 006D511358D0; Tue, 19 May 2020 16:55:51 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 19/55] isa: Convert uses of isa_create(),
 isa_try_create() manually
Date: Tue, 19 May 2020 16:55:15 +0200
Message-Id: <20200519145551.22836-20-armbru@redhat.com>
In-Reply-To: <20200519145551.22836-1-armbru@redhat.com>
References: <20200519145551.22836-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
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

Same transformation as in the previous commit.  Manual, because
convincing Coccinelle to transform these cases is not worthwhile.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 include/hw/net/ne2000-isa.h | 5 +++--
 hw/block/fdc.c              | 4 ++--
 hw/i386/pc.c                | 4 ++--
 hw/ppc/pnv.c                | 9 ++++-----
 4 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/hw/net/ne2000-isa.h b/include/hw/net/ne2000-isa.h
index eef17a680d..af59ee0b02 100644
--- a/include/hw/net/ne2000-isa.h
+++ b/include/hw/net/ne2000-isa.h
@@ -13,6 +13,7 @@
 #include "hw/isa/isa.h"
 #include "hw/qdev-properties.h"
 #include "net/net.h"
+#include "qapi/error.h"
 
 #define TYPE_ISA_NE2000 "ne2k_isa"
 
@@ -23,14 +24,14 @@ static inline ISADevice *isa_ne2000_init(ISABus *bus, int base, int irq,
 
     qemu_check_nic_model(nd, "ne2k_isa");
 
-    d = isa_try_create(bus, TYPE_ISA_NE2000);
+    d = isa_try_new(TYPE_ISA_NE2000);
     if (d) {
         DeviceState *dev = DEVICE(d);
 
         qdev_prop_set_uint32(dev, "iobase", base);
         qdev_prop_set_uint32(dev, "irq",    irq);
         qdev_set_nic_properties(dev, nd);
-        qdev_init_nofail(dev);
+        isa_realize_and_unref(d, bus, &error_fatal);
     }
     return d;
 }
diff --git a/hw/block/fdc.c b/hw/block/fdc.c
index 5220ca61e4..da68d2ff58 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2546,7 +2546,7 @@ ISADevice *fdctrl_init_isa(ISABus *bus, DriveInfo **fds)
     DeviceState *dev;
     ISADevice *isadev;
 
-    isadev = isa_try_create(bus, TYPE_ISA_FDC);
+    isadev = isa_try_new(TYPE_ISA_FDC);
     if (!isadev) {
         return NULL;
     }
@@ -2560,7 +2560,7 @@ ISADevice *fdctrl_init_isa(ISABus *bus, DriveInfo **fds)
         qdev_prop_set_drive(dev, "driveB", blk_by_legacy_dinfo(fds[1]),
                             &error_fatal);
     }
-    qdev_init_nofail(dev);
+    isa_realize_and_unref(isadev, bus, &error_fatal);
 
     return isadev;
 }
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b549d0bbfc..280560f790 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1157,14 +1157,14 @@ static void pc_superio_init(ISABus *isa_bus, bool create_fdctrl, bool no_vmport)
     i8042 = isa_create_simple(isa_bus, "i8042");
     if (!no_vmport) {
         isa_create_simple(isa_bus, TYPE_VMPORT);
-        vmmouse = isa_try_create(isa_bus, "vmmouse");
+        vmmouse = isa_try_new("vmmouse");
     } else {
         vmmouse = NULL;
     }
     if (vmmouse) {
         object_property_set_link(OBJECT(vmmouse), OBJECT(i8042),
                                  "i8042", &error_abort);
-        qdev_init_nofail(DEVICE(vmmouse));
+        isa_realize_and_unref(vmmouse, isa_bus, &error_fatal);
     }
     port92 = isa_create_simple(isa_bus, TYPE_PORT92);
 
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index e7bf589ef5..7a995111df 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -694,12 +694,11 @@ static bool pnv_match_cpu(const char *default_type, const char *cpu_type)
 
 static void pnv_ipmi_bt_init(ISABus *bus, IPMIBmc *bmc, uint32_t irq)
 {
-    Object *obj;
+    ISADevice *dev = isa_new("isa-ipmi-bt");
 
-    obj = OBJECT(isa_create(bus, "isa-ipmi-bt"));
-    object_property_set_link(obj, OBJECT(bmc), "bmc", &error_fatal);
-    object_property_set_int(obj, irq, "irq", &error_fatal);
-    object_property_set_bool(obj, true, "realized", &error_fatal);
+    object_property_set_link(OBJECT(dev), OBJECT(bmc), "bmc", &error_fatal);
+    object_property_set_int(OBJECT(dev), irq, "irq", &error_fatal);
+    isa_realize_and_unref(dev, bus, &error_fatal);
 }
 
 static void pnv_chip_power10_pic_print_info(PnvChip *chip, Monitor *mon)
-- 
2.21.1


