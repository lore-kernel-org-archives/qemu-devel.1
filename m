Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INVALID_DATE,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D63EC4649B
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:06:43 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 33ECC218BB
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 10:06:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 33ECC218BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51216 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjL74-0001e5-9l
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 06:06:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48801)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <balaton@eik.bme.hu>) id 1hjL5H-0000Zc-6y
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hjL5F-0006kV-Iq
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:04:51 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001]:28857)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hjL5F-0006VR-5P
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 06:04:49 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 1C76C7461AE;
 Fri,  5 Jul 2019 12:04:19 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id F18C57461AA; Fri,  5 Jul 2019 12:04:18 +0200 (CEST)
Message-Id: <99bb800cba3596e47d2681642116756330dc6f63.1562320946.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Fri, 5 Jul 2019 12:00:09 +0200
Date: Fri, 05 Jul 2019 12:02:26 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2001:738:2001:2001::2001
Subject: [Qemu-devel] [PATCH] ati-vga: Add registers for getting apertures
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

Some drivers (e.g. Linux radeon drm and MacOS) access these to find
apertures to access card. Try to implement these but not sure these
are correct yet.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
---
 hw/display/ati.c      | 15 +++++++++++++++
 hw/display/ati_dbg.c  |  5 +++++
 hw/display/ati_regs.h |  5 +++++
 3 files changed, 25 insertions(+)

diff --git a/hw/display/ati.c b/hw/display/ati.c
index a747c4cc98..c8fc62505b 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -307,6 +307,21 @@ static uint64_t ati_mm_read(void *opaque, hwaddr add=
r, unsigned int size)
     case CNFG_MEMSIZE:
         val =3D s->vga.vram_size;
         break;
+    case CONFIG_APER_0_BASE:
+    case CONFIG_APER_1_BASE:
+        val =3D pci_default_read_config(&s->dev,
+                                      PCI_BASE_ADDRESS_0, size) & 0xffff=
fff0;
+        break;
+    case CONFIG_APER_SIZE:
+        val =3D s->vga.vram_size;
+        break;
+    case CONFIG_REG_1_BASE:
+        val =3D pci_default_read_config(&s->dev,
+                                      PCI_BASE_ADDRESS_2, size) & 0xffff=
fff0;
+        break;
+    case CONFIG_REG_APER_SIZE:
+        val =3D memory_region_size(&s->mm);
+        break;
     case MC_STATUS:
         val =3D 5;
         break;
diff --git a/hw/display/ati_dbg.c b/hw/display/ati_dbg.c
index 88b3a11315..cbc52025d0 100644
--- a/hw/display/ati_dbg.c
+++ b/hw/display/ati_dbg.c
@@ -28,6 +28,11 @@ static struct ati_regdesc ati_reg_names[] =3D {
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
diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index d7155c93d5..81fb5302c0 100644
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
--=20
2.13.7


