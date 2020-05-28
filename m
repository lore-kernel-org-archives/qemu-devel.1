Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAB56C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:41:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 843A0206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:41:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cM+eUoPi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 843A0206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeHqe-0003CV-KS
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 08:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33612)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeHlt-0001bn-CW
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:36:29 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:21498
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeHlp-0005AO-E7
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:36:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590669384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dbM4DIqFT/1AAo5DPEyqBeuBxBSshlvJ2pooOBfqays=;
 b=cM+eUoPiHcuG86Er4SIP9n+1RuZJ4NSNqnK+fxA0YZ9zdcNA2/J0cEWjXDTfiyQVGzhrKY
 Q5vleRdeyZcw79QAG7UTu6ZMw6z371Vh2gKWGOxz3TeLT56yV0Vim8FPf87bbhd7SCw8J7
 qksbnYSqUdCDP8jrNmyRBA7QhgetHcI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-117-xY18pM-pNsaKqZfQxmKmcw-1; Thu, 28 May 2020 08:36:20 -0400
X-MC-Unique: xY18pM-pNsaKqZfQxmKmcw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7FD41460;
 Thu, 28 May 2020 12:36:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 874475C1D6;
 Thu, 28 May 2020 12:36:16 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 6AD6A9DAE; Thu, 28 May 2020 14:36:09 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 02/21] hw/display/cg3: Convert debug printf()s to trace events
Date: Thu, 28 May 2020 14:35:50 +0200
Message-Id: <20200528123609.27362-3-kraxel@redhat.com>
In-Reply-To: <20200528123609.27362-1-kraxel@redhat.com>
References: <20200528123609.27362-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=kraxel@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 03:11:04
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Igor Mitsyanko <i.mitsyanko@gmail.com>,
 Alistair Francis <alistair@alistair23.me>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Convert DPRINTF() to trace events and remove ifdef'ry.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200526062252.19852-3-f4bug@amsat.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/cg3.c        | 14 ++++----------
 hw/display/trace-events |  4 ++++
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/hw/display/cg3.c b/hw/display/cg3.c
index f7f1c199ce54..7cbe6e56ff69 100644
--- a/hw/display/cg3.c
+++ b/hw/display/cg3.c
@@ -35,6 +35,7 @@
 #include "hw/qdev-properties.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
+#include "trace.h"
 
 /* Change to 1 to enable debugging */
 #define DEBUG_CG3 0
@@ -63,12 +64,6 @@
 #define CG3_VRAM_SIZE 0x100000
 #define CG3_VRAM_OFFSET 0x800000
 
-#define DPRINTF(fmt, ...) do { \
-    if (DEBUG_CG3) { \
-        printf("CG3: " fmt , ## __VA_ARGS__); \
-    } \
-} while (0)
-
 #define TYPE_CG3 "cgthree"
 #define CG3(obj) OBJECT_CHECK(CG3State, (obj), TYPE_CG3)
 
@@ -195,7 +190,8 @@ static uint64_t cg3_reg_read(void *opaque, hwaddr addr, unsigned size)
         val = 0;
         break;
     }
-    DPRINTF("read %02x from reg %" HWADDR_PRIx "\n", val, addr);
+    trace_cg3_read(addr, val, size);
+
     return val;
 }
 
@@ -206,9 +202,7 @@ static void cg3_reg_write(void *opaque, hwaddr addr, uint64_t val,
     uint8_t regval;
     int i;
 
-    DPRINTF("write %" PRIx64 " to reg %" HWADDR_PRIx " size %d\n",
-            val, addr, size);
-
+    trace_cg3_write(addr, val, size);
     switch (addr) {
     case CG3_REG_BT458_ADDR:
         s->dac_index = val;
diff --git a/hw/display/trace-events b/hw/display/trace-events
index e6e22bef8899..47b2b168ae15 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -151,3 +151,7 @@ artist_vram_write(unsigned int size, uint64_t addr, uint64_t val) "%u 0x%"PRIx64
 artist_fill_window(unsigned int start_x, unsigned int start_y, unsigned int width, unsigned int height, uint32_t op, uint32_t ctlpln) "start=%ux%u length=%ux%u op=0x%08x ctlpln=0x%08x"
 artist_block_move(unsigned int start_x, unsigned int start_y, unsigned int dest_x, unsigned int dest_y, unsigned int width, unsigned int height) "source %ux%u -> dest %ux%u size %ux%u"
 artist_draw_line(unsigned int start_x, unsigned int start_y, unsigned int end_x, unsigned int end_y) "%ux%u %ux%u"
+
+# cg3.c
+cg3_read(uint32_t addr, uint32_t val, unsigned size) "read addr:0x%06"PRIx32" val:0x%08"PRIx32" size:%u"
+cg3_write(uint32_t addr, uint32_t val, unsigned size) "write addr:0x%06"PRIx32" val:0x%08"PRIx32" size:%u"
-- 
2.18.4


