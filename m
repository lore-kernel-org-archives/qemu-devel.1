Return-Path: <SRS0=BhOf=WS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CE15C3A59D
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:09:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E649F21848
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Aug 2019 08:09:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E649F21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39088 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0iAQ-0003xi-2T
	for qemu-devel@archiver.kernel.org; Thu, 22 Aug 2019 04:09:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53915)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kraxel@redhat.com>) id 1i0i5l-0007Lx-L2
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kraxel@redhat.com>) id 1i0i5k-0005og-8m
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:05:09 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58602)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1i0i5j-0005nZ-MS
 for qemu-devel@nongnu.org; Thu, 22 Aug 2019 04:05:07 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E2E4F85539;
 Thu, 22 Aug 2019 08:05:06 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-116-60.ams2.redhat.com
 [10.36.116.60])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EA11A5DC1E;
 Thu, 22 Aug 2019 08:05:03 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 117257F; Thu, 22 Aug 2019 10:05:03 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Date: Thu, 22 Aug 2019 10:04:55 +0200
Message-Id: <20190822080503.12063-2-kraxel@redhat.com>
In-Reply-To: <20190822080503.12063-1-kraxel@redhat.com>
References: <20190822080503.12063-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.28]); Thu, 22 Aug 2019 08:05:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 1/8] ati-vga: Add registers for getting apertures
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
Cc: Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: BALATON Zoltan <balaton@eik.bme.hu>

Some drivers (e.g. Linux radeon drm and MacOS) access these to find
apertures to access card. Try to implement these but not sure these
are correct yet.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: b2df13655feecd63c0049ec45fd87d1026f67091.1565558093.git.balaton@eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ati_regs.h |  5 +++++
 hw/display/ati.c      | 15 +++++++++++++++
 hw/display/ati_dbg.c  |  5 +++++
 3 files changed, 25 insertions(+)

diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index d7155c93d53b..81fb5302c036 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -46,6 +46,11 @@
 #define CNFG_CNTL                               0x00e0
 #define GEN_RESET_CNTL                          0x00f0
 #define CNFG_MEMSIZE                            0x00f8
+#define CONFIG_APER_0_BASE                      0x0100
+#define CONFIG_APER_1_BASE                      0x0104
+#define CONFIG_APER_SIZE                        0x0108
+#define CONFIG_REG_1_BASE                       0x010c
+#define CONFIG_REG_APER_SIZE                    0x0110
 #define MEM_CNTL                                0x0140
 #define MC_FB_LOCATION                          0x0148
 #define MC_AGP_LOCATION                         0x014C
diff --git a/hw/display/ati.c b/hw/display/ati.c
index 35f49a591b7b..6cdcbef238fe 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -307,6 +307,21 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case CNFG_MEMSIZE:
         val = s->vga.vram_size;
         break;
+    case CONFIG_APER_0_BASE:
+    case CONFIG_APER_1_BASE:
+        val = pci_default_read_config(&s->dev,
+                                      PCI_BASE_ADDRESS_0, size) & 0xfffffff0;
+        break;
+    case CONFIG_APER_SIZE:
+        val = s->vga.vram_size;
+        break;
+    case CONFIG_REG_1_BASE:
+        val = pci_default_read_config(&s->dev,
+                                      PCI_BASE_ADDRESS_2, size) & 0xfffffff0;
+        break;
+    case CONFIG_REG_APER_SIZE:
+        val = memory_region_size(&s->mm);
+        break;
     case MC_STATUS:
         val = 5;
         break;
diff --git a/hw/display/ati_dbg.c b/hw/display/ati_dbg.c
index 88b3a11315d8..cbc52025d01c 100644
--- a/hw/display/ati_dbg.c
+++ b/hw/display/ati_dbg.c
@@ -28,6 +28,11 @@ static struct ati_regdesc ati_reg_names[] = {
     {"CNFG_CNTL", 0x00e0},
     {"GEN_RESET_CNTL", 0x00f0},
     {"CNFG_MEMSIZE", 0x00f8},
+    {"CONFIG_APER_0_BASE", 0x0100},
+    {"CONFIG_APER_1_BASE", 0x0104},
+    {"CONFIG_APER_SIZE", 0x0108},
+    {"CONFIG_REG_1_BASE", 0x010c},
+    {"CONFIG_REG_APER_SIZE", 0x0110},
     {"MEM_CNTL", 0x0140},
     {"MC_FB_LOCATION", 0x0148},
     {"MC_AGP_LOCATION", 0x014C},
-- 
2.18.1


