Return-Path: <SRS0=qPFU=AM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E5F0C433DF
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:13:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F841206C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2020 15:13:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XTDEn4ni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F841206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48468 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqeQl-0000EG-GD
	for qemu-devel@archiver.kernel.org; Wed, 01 Jul 2020 11:13:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49952)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqeHx-0003JT-7v
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:04:41 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:23706
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jqeHu-0001C1-94
 for qemu-devel@nongnu.org; Wed, 01 Jul 2020 11:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1593615877;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:in-reply-to:in-reply-to:
 references:references; bh=11vTNjprUDxxF42ZXFtBkVL+ye/l4xtYd5YtU/dXpDI=;
 b=XTDEn4nivQe5/JV5q/6cbfowRX7zxu9T+y4+pnRK9FAaigfdXbizWATKhSHu0kvEUtbUk5
 CZIC/Gz3DuvjPiLNNFPXdjUF2qVVL6ziuI/mKuGLeiCiazINa/MkZqFzepb3oY9X0vOro1
 7aUaTOosbRjP1vH3r1XAsWBAKT7xwxg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-287-C8k0ieCYOUG2oLstJRqdow-1; Wed, 01 Jul 2020 11:04:35 -0400
X-MC-Unique: C8k0ieCYOUG2oLstJRqdow-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5DD49800D5C;
 Wed,  1 Jul 2020 15:04:34 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-112-62.ams2.redhat.com
 [10.36.112.62])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3D25E7BEAC;
 Wed,  1 Jul 2020 15:04:31 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id BC24431E93; Wed,  1 Jul 2020 17:04:25 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/13] ati-vga: Add dummy MEM_SDRAM_MODE_REG
Date: Wed,  1 Jul 2020 17:04:24 +0200
Message-Id: <20200701150425.13739-13-kraxel@redhat.com>
In-Reply-To: <20200701150425.13739-1-kraxel@redhat.com>
References: <20200701150425.13739-1-kraxel@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=kraxel@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/01 00:56:58
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
Cc: qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: BALATON Zoltan <balaton@eik.bme.hu>

Radeon chips have an SDRAM mode reg that is accessed by some drivers.
We don't emulate the memory controller but provide some default value
to prevent drivers getting unexpected 0.

Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
Message-id: cc1324b9ef06beb8ae233ddc77dedd8bab9b8624.1592737958.git.balaton@eik.bme.hu
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/ati_regs.h | 1 +
 hw/display/ati.c      | 5 +++++
 hw/display/ati_dbg.c  | 1 +
 3 files changed, 7 insertions(+)

diff --git a/hw/display/ati_regs.h b/hw/display/ati_regs.h
index ebd37ee30d3f..d6282b2ef210 100644
--- a/hw/display/ati_regs.h
+++ b/hw/display/ati_regs.h
@@ -60,6 +60,7 @@
 #define MC_FB_LOCATION                          0x0148
 #define MC_AGP_LOCATION                         0x014C
 #define MC_STATUS                               0x0150
+#define MEM_SDRAM_MODE_REG                      0x0158
 #define MEM_POWER_MISC                          0x015c
 #define AGP_BASE                                0x0170
 #define AGP_CNTL                                0x0174
diff --git a/hw/display/ati.c b/hw/display/ati.c
index 95fc443cac83..4c3ad8f47b0d 100644
--- a/hw/display/ati.c
+++ b/hw/display/ati.c
@@ -361,6 +361,11 @@ static uint64_t ati_mm_read(void *opaque, hwaddr addr, unsigned int size)
     case MC_STATUS:
         val = 5;
         break;
+    case MEM_SDRAM_MODE_REG:
+        if (s->dev_id != PCI_DEVICE_ID_ATI_RAGE128_PF) {
+            val = BIT(28) | BIT(20);
+        }
+        break;
     case RBBM_STATUS:
     case GUI_STAT:
         val = 64; /* free CMDFIFO entries */
diff --git a/hw/display/ati_dbg.c b/hw/display/ati_dbg.c
index 0ebbd36f1477..bd0ecd48c7a7 100644
--- a/hw/display/ati_dbg.c
+++ b/hw/display/ati_dbg.c
@@ -42,6 +42,7 @@ static struct ati_regdesc ati_reg_names[] = {
     {"MC_FB_LOCATION", 0x0148},
     {"MC_AGP_LOCATION", 0x014C},
     {"MC_STATUS", 0x0150},
+    {"MEM_SDRAM_MODE_REG", 0x0158},
     {"MEM_POWER_MISC", 0x015c},
     {"AGP_BASE", 0x0170},
     {"AGP_CNTL", 0x0174},
-- 
2.18.4


