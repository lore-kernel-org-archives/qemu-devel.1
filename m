Return-Path: <SRS0=wemX=7X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CDBDC433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:49:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FB62207ED
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2020 05:49:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c2/WIjht"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FB62207ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jitc4-00044y-Hy
	for qemu-devel@archiver.kernel.org; Wed, 10 Jun 2020 01:49:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42650)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitMT-0005KE-9C
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:33:17 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:45763
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1jitMD-0003sC-4T
 for qemu-devel@nongnu.org; Wed, 10 Jun 2020 01:33:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1591767180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1/YQNXz89AxNUXTP2N7xYBSFf7y0PnZztsI0Z06ww9c=;
 b=c2/WIjhtXq0isK5iQgZVKW+aNylGtes9wIMI3rj6qiEl5fKVDG60YUHF9OLkpkF0NKBLSg
 NcifmtYqz6aE2/jUdPNh9j3fOw2MkYDrBTTmkEJnAwbzhgtx3GWChOxTMCnuyByOXK2x9T
 JtxlQ38D/WDotBM/og0b20tc4oC9LXk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-275-v_zi_85JPSmABr-h7_DuKw-1; Wed, 10 Jun 2020 01:32:57 -0400
X-MC-Unique: v_zi_85JPSmABr-h7_DuKw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0AAF9835B49
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2020 05:32:57 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-112-121.ams2.redhat.com
 [10.36.112.121])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id AB2C978B3A;
 Wed, 10 Jun 2020 05:32:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C0C171138481; Wed, 10 Jun 2020 07:32:48 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v3 43/58] sysbus: Tidy up sysbus_init_child_obj()'s
 @childsize arg, part 2
Date: Wed, 10 Jun 2020 07:32:32 +0200
Message-Id: <20200610053247.1583243-44-armbru@redhat.com>
In-Reply-To: <20200610053247.1583243-1-armbru@redhat.com>
References: <20200610053247.1583243-1-armbru@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/06/09 23:22:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The callers of sysbus_init_child_obj() commonly pass either &child,
sizeof(child), or pchild, sizeof(*pchild).  Tidy up the few that use
something else instead, mostly to keep future commits simpler.

Coccinelle script:

    @@
    expression parent, propname, type;
    expression child;
    type T;
    T proxy;
    @@
    (
         sysbus_init_child_obj(parent, propname, &child, sizeof(child), type)
    |
         sysbus_init_child_obj(parent, propname, child, sizeof(*child), type)
    |
    -    sysbus_init_child_obj(parent, propname, child, sizeof(proxy), type)
    +    sysbus_init_child_obj(parent, propname, child, sizeof(*child), type)
    )

This script is *unsound*: for each change we need to verify the
@childsize argument stays the same.  I did.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/arm/mps2-tz.c | 15 +++++++--------
 hw/arm/musca.c   |  7 +++----
 2 files changed, 10 insertions(+), 12 deletions(-)

diff --git a/hw/arm/mps2-tz.c b/hw/arm/mps2-tz.c
index ad0bc9365a..90f4449b9d 100644
--- a/hw/arm/mps2-tz.c
+++ b/hw/arm/mps2-tz.c
@@ -193,7 +193,7 @@ static MemoryRegion *make_uart(MPS2TZMachineState *mms, void *opaque,
     SysBusDevice *s;
     DeviceState *orgate_dev = DEVICE(&mms->uart_irq_orgate);
 
-    sysbus_init_child_obj(OBJECT(mms), name, uart, sizeof(mms->uart[0]),
+    sysbus_init_child_obj(OBJECT(mms), name, uart, sizeof(*uart),
                           TYPE_CMSDK_APB_UART);
     qdev_prop_set_chr(DEVICE(uart), "chardev", serial_hd(i));
     qdev_prop_set_uint32(DEVICE(uart), "pclk-frq", SYSCLK_FRQ);
@@ -214,8 +214,8 @@ static MemoryRegion *make_scc(MPS2TZMachineState *mms, void *opaque,
     DeviceState *sccdev;
     MPS2TZMachineClass *mmc = MPS2TZ_MACHINE_GET_CLASS(mms);
 
-    sysbus_init_child_obj(OBJECT(mms), "scc", scc,
-                          sizeof(mms->scc), TYPE_MPS2_SCC);
+    sysbus_init_child_obj(OBJECT(mms), "scc", scc, sizeof(*scc),
+                          TYPE_MPS2_SCC);
     sccdev = DEVICE(scc);
     qdev_prop_set_uint32(sccdev, "scc-cfg4", 0x2);
     qdev_prop_set_uint32(sccdev, "scc-aid", 0x00200008);
@@ -229,8 +229,8 @@ static MemoryRegion *make_fpgaio(MPS2TZMachineState *mms, void *opaque,
 {
     MPS2FPGAIO *fpgaio = opaque;
 
-    sysbus_init_child_obj(OBJECT(mms), "fpgaio", fpgaio,
-                          sizeof(mms->fpgaio), TYPE_MPS2_FPGAIO);
+    sysbus_init_child_obj(OBJECT(mms), "fpgaio", fpgaio, sizeof(*fpgaio),
+                          TYPE_MPS2_FPGAIO);
     object_property_set_bool(OBJECT(fpgaio), true, "realized", &error_fatal);
     return sysbus_mmio_get_region(SYS_BUS_DEVICE(fpgaio), 0);
 }
@@ -267,7 +267,7 @@ static MemoryRegion *make_mpc(MPS2TZMachineState *mms, void *opaque,
 
     memory_region_init_ram(ssram, NULL, name, ramsize[i], &error_fatal);
 
-    sysbus_init_child_obj(OBJECT(mms), mpcname, mpc, sizeof(mms->ssram_mpc[0]),
+    sysbus_init_child_obj(OBJECT(mms), mpcname, mpc, sizeof(*mpc),
                           TYPE_TZ_MPC);
     object_property_set_link(OBJECT(mpc), OBJECT(ssram),
                              "downstream", &error_fatal);
@@ -363,8 +363,7 @@ static MemoryRegion *make_spi(MPS2TZMachineState *mms, void *opaque,
     int i = spi - &mms->spi[0];
     SysBusDevice *s;
 
-    sysbus_init_child_obj(OBJECT(mms), name, spi, sizeof(mms->spi[0]),
-                          TYPE_PL022);
+    sysbus_init_child_obj(OBJECT(mms), name, spi, sizeof(*spi), TYPE_PL022);
     object_property_set_bool(OBJECT(spi), true, "realized", &error_fatal);
     s = SYS_BUS_DEVICE(spi);
     sysbus_connect_irq(s, 0, get_sse_irq_in(mms, 51 + i));
diff --git a/hw/arm/musca.c b/hw/arm/musca.c
index b7f1c4e128..a1a6e887ed 100644
--- a/hw/arm/musca.c
+++ b/hw/arm/musca.c
@@ -256,7 +256,7 @@ static MemoryRegion *make_mpc(MuscaMachineState *mms, void *opaque,
         g_assert_not_reached();
     }
 
-    sysbus_init_child_obj(OBJECT(mms), mpcname, mpc, sizeof(mms->mpc[0]),
+    sysbus_init_child_obj(OBJECT(mms), mpcname, mpc, sizeof(*mpc),
                           TYPE_TZ_MPC);
     object_property_set_link(OBJECT(mpc), OBJECT(downstream),
                              "downstream", &error_fatal);
@@ -279,7 +279,7 @@ static MemoryRegion *make_rtc(MuscaMachineState *mms, void *opaque,
 {
     PL031State *rtc = opaque;
 
-    sysbus_init_child_obj(OBJECT(mms), name, rtc, sizeof(mms->rtc), TYPE_PL031);
+    sysbus_init_child_obj(OBJECT(mms), name, rtc, sizeof(*rtc), TYPE_PL031);
     object_property_set_bool(OBJECT(rtc), true, "realized", &error_fatal);
     sysbus_connect_irq(SYS_BUS_DEVICE(rtc), 0, get_sse_irq_in(mms, 39));
     return sysbus_mmio_get_region(SYS_BUS_DEVICE(rtc), 0);
@@ -293,8 +293,7 @@ static MemoryRegion *make_uart(MuscaMachineState *mms, void *opaque,
     int irqbase = 7 + i * 6;
     SysBusDevice *s;
 
-    sysbus_init_child_obj(OBJECT(mms), name, uart, sizeof(mms->uart[0]),
-                          TYPE_PL011);
+    sysbus_init_child_obj(OBJECT(mms), name, uart, sizeof(*uart), TYPE_PL011);
     qdev_prop_set_chr(DEVICE(uart), "chardev", serial_hd(i));
     object_property_set_bool(OBJECT(uart), true, "realized", &error_fatal);
     s = SYS_BUS_DEVICE(uart);
-- 
2.26.2


