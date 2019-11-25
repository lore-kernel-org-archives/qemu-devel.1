Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC42EC432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 07:56:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EAD621739
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 07:56:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EAD621739
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46154 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaEeh-0004Xe-Ki
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 02:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:53266)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aaron@localhost>) id 1iaEai-0007x8-Az
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 02:51:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aaron@localhost>) id 1iaEag-0003Rb-Ct
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 02:51:55 -0500
Received: from [2406:7400:73:186d:af79:94fc:29ef:77e6] (port=56092
 helo=localhost) by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aaron@localhost>) id 1iaEaf-0003AC-VY
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 02:51:54 -0500
Received: by localhost (Postfix, from userid 1000)
 id B9524D41714; Mon, 25 Nov 2019 19:55:12 +0530 (IST)
From: aaron.zakhrov@gmail.com
To: qemu-devel@nongnu.org
Subject: [RFC 7/8] R300 fixes
Date: Mon, 25 Nov 2019 19:49:16 +0530
Message-Id: <20191125141908.5441-8-aaron.zakhrov@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191125141908.5441-1-aaron.zakhrov@gmail.com>
References: <20191125141908.5441-1-aaron.zakhrov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2406:7400:73:186d:af79:94fc:29ef:77e6
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
Cc: kraxel@redhat.com, Aaron Dominick <aaron.zakhrov@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Aaron Dominick <aaron.zakhrov@gmail.com>

---
 hw/display/r300.c | 9 +++++++++
 hw/display/r300.h | 6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/hw/display/r300.c b/hw/display/r300.c
index 653474c3aa..074dbf5b2d 100644
--- a/hw/display/r300.c
+++ b/hw/display/r300.c
@@ -878,6 +878,15 @@ static void r300_mm_write(void *opaque, hwaddr addr,
     case RADEON_DEFAULT_SC_BOTTOM_RIGHT:
         s->regs.default_sc_bottom_right =3D data & 0x3fff3fff;
         break;
+    case R300_GB_ENABLE:
+        s->regs.r300_gb_enable =3D data;
+        break;
+    case R300_GB_TILE_CONFIG:
+            s->regs.r300_gb_tile_config =3D data;
+            break;
+    case R300_GB_FIFO_SIZE:
+            s->regs.r300_gb_fifo_size =3D data;
+            break;
     default:
         break;
     }
diff --git a/hw/display/r300.h b/hw/display/r300.h
index a9e1db32be..19e3d97f8a 100644
--- a/hw/display/r300.h
+++ b/hw/display/r300.h
@@ -83,6 +83,12 @@ typedef struct RADVGARegs{
   uint32_t default_sc_bottom_right;
   uint32_t mc_status;
=20
+  //R300 GB Registers
+  uint32_t r300_gb_enable;
+  uint32_t r300_gb_tile_config;
+  uint32_t r300_gb_fifo_size;
+
+
 //Color Buffer RB3D
   uint32_t r300_rb3d_aaresolve_ctl;
   uint32_t r300_rb3d_aaresolve_offset;
--=20
2.24.0


