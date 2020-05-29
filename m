Return-Path: <SRS0=UjLb=7L=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EBB8C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:02:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65951207F5
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2020 14:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AHHn9t/U"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65951207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56584 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jefav-0002IE-I6
	for qemu-devel@archiver.kernel.org; Fri, 29 May 2020 10:02:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49260)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKS-0002vG-Qq
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:44 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:44330
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jefKL-00075Z-Pv
 for qemu-devel@nongnu.org; Fri, 29 May 2020 09:45:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590759936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VKPyLhBbxmHbz87ztUwKi8sVXbHe1Gzl3RzNmXwgQsA=;
 b=AHHn9t/UuoymZ/C4tSxx/kH9NrlXA75sNZnBzLnBy1kaaKck99sMgwyZFeEwQUkYBwoDh/
 01DhRy+iaa2v50rsDL1BEDg2wyw0rthPBh92RlmBMOdXpHc7eZaUtG7YS82y6u0ENPFPh8
 ee1vXGgrNujPufNMBWnIK7hfQTUEA7E=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-414-WLniNmOOP022nUY_t2EnAA-1; Fri, 29 May 2020 09:45:31 -0400
X-MC-Unique: WLniNmOOP022nUY_t2EnAA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71ED0107ACCA
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 13:45:30 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-32.ams2.redhat.com
 [10.36.112.32])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 465615C1C8
 for <qemu-devel@nongnu.org>; Fri, 29 May 2020 13:45:30 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1F31711358D3; Fri, 29 May 2020 15:45:24 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 20/58] isa: Convert uses of isa_create(),
 isa_try_create() manually
Date: Fri, 29 May 2020 15:44:45 +0200
Message-Id: <20200529134523.8477-21-armbru@redhat.com>
In-Reply-To: <20200529134523.8477-1-armbru@redhat.com>
References: <20200529134523.8477-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/29 03:05:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
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
index 1feb398875..a3250f6fdb 100644
--- a/hw/block/fdc.c
+++ b/hw/block/fdc.c
@@ -2544,7 +2544,7 @@ ISADevice *fdctrl_init_isa(ISABus *bus, DriveInfo **fds)
     DeviceState *dev;
     ISADevice *isadev;
 
-    isadev = isa_try_create(bus, TYPE_ISA_FDC);
+    isadev = isa_try_new(TYPE_ISA_FDC);
     if (!isadev) {
         return NULL;
     }
@@ -2558,7 +2558,7 @@ ISADevice *fdctrl_init_isa(ISABus *bus, DriveInfo **fds)
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
index e0588285a2..ffaf12b006 100644
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
2.21.3


