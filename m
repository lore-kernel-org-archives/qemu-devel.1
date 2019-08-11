Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34FAEC0650F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 21:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D33F20844
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 21:34:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D33F20844
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=eik.bme.hu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41856 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwvTq-0003kk-DD
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 17:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58179)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <balaton@eik.bme.hu>) id 1hwvSy-00020A-Qf
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 17:33:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <balaton@eik.bme.hu>) id 1hwvSw-00045z-V8
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 17:33:28 -0400
Received: from zero.eik.bme.hu ([152.66.115.2]:55461)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <balaton@eik.bme.hu>) id 1hwvSw-0003yO-NU
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 17:33:26 -0400
Received: from zero.eik.bme.hu (blah.eik.bme.hu [152.66.115.182])
 by localhost (Postfix) with SMTP id 6CA4874C9B2;
 Sun, 11 Aug 2019 23:33:12 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id D50387456E2; Sun, 11 Aug 2019 23:33:11 +0200 (CEST)
Message-Id: <b2df13655feecd63c0049ec45fd87d1026f67091.1565558093.git.balaton@eik.bme.hu>
In-Reply-To: <cover.1565558093.git.balaton@eik.bme.hu>
References: <cover.1565558093.git.balaton@eik.bme.hu>
From: BALATON Zoltan <balaton@eik.bme.hu>
Date: Sun, 11 Aug 2019 23:14:53 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: qemu-devel@nongnu.org
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: FreeBSD 9.x [fuzzy]
X-Received-From: 152.66.115.2
Subject: [Qemu-devel] [PATCH 1/7] ati-vga: Add registers for getting
 apertures
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


