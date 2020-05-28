Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B6D3C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:50:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 62614206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:50:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hkkgMXlb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 62614206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38992 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeHzM-0003rO-IY
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 08:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33714)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeHm0-0001w7-Ee
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:36:36 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:32554
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeHlt-0005Fd-Ex
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:36:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590669388;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vhaGpItVAJY0Kh28EoW+iZj4wIKFYfoIVL8Ul9ZNK3k=;
 b=hkkgMXlbdb0Oepm/iBUriTasZTFEI2ZdEAQG8t8l5O9NJLoB+GPaCg9YvpFAaU5+KY5pTG
 FkbIBaoCFLSfbz7NeI07SaKibkoBMRZO8vApL8YTaRyKXDzUmnWuaA0kGj0p8p6VewqAK1
 po8e/eHDmQ2sFof7fiV22b3pHwCel3o=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-441-613lVL-COoqGZLJCqhXdvQ-1; Thu, 28 May 2020 08:36:19 -0400
X-MC-Unique: 613lVL-COoqGZLJCqhXdvQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3D7DC8015CF;
 Thu, 28 May 2020 12:36:18 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D3242A102D;
 Thu, 28 May 2020 12:36:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id AE16D9D58; Thu, 28 May 2020 14:36:09 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 09/21] hw/display/xlnx_dp: Replace disabled DPRINTF() by
 error_report()
Date: Thu, 28 May 2020 14:35:57 +0200
Message-Id: <20200528123609.27362-10-kraxel@redhat.com>
In-Reply-To: <20200528123609.27362-1-kraxel@redhat.com>
References: <20200528123609.27362-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.81; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 02:50:32
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

DPRINTF() calls are disabled by default, so when unexpected
data is used, the whole process abort without information.

Display a bit of information with error_report() before crashing.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Message-id: 20200526062252.19852-10-f4bug@amsat.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/xlnx_dp.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/hw/display/xlnx_dp.c b/hw/display/xlnx_dp.c
index 3e5fb44e06ee..8d940cd8d1a5 100644
--- a/hw/display/xlnx_dp.c
+++ b/hw/display/xlnx_dp.c
@@ -1,5 +1,5 @@
 /*
- * xlnx_dp.c
+ * Xilinx Display Port
  *
  *  Copyright (C) 2015 : GreenSocs Ltd
  *      http://www.greensocs.com/ , email: info@greensocs.com
@@ -24,6 +24,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/error-report.h"
 #include "qemu/log.h"
 #include "qemu/module.h"
 #include "hw/display/xlnx_dp.h"
@@ -465,7 +466,7 @@ static uint8_t xlnx_dp_aux_pop_tx_fifo(XlnxDPState *s)
     uint8_t ret;
 
     if (fifo8_is_empty(&s->tx_fifo)) {
-        DPRINTF("tx_fifo underflow..\n");
+        error_report("%s: TX_FIFO underflow", __func__);
         abort();
     }
     ret = fifo8_pop(&s->tx_fifo);
@@ -525,6 +526,7 @@ static void xlnx_dp_aux_set_command(XlnxDPState *s, uint32_t value)
         qemu_log_mask(LOG_UNIMP, "xlnx_dp: Write i2c status not implemented\n");
         break;
     default:
+        error_report("%s: invalid command: %u", __func__, cmd);
         abort();
     }
 
@@ -631,8 +633,8 @@ static void xlnx_dp_change_graphic_fmt(XlnxDPState *s)
         s->g_plane.format = PIXMAN_b8g8r8;
         break;
     default:
-        DPRINTF("error: unsupported graphic format %u.\n",
-                s->avbufm_registers[AV_BUF_FORMAT] & DP_GRAPHIC_MASK);
+        error_report("%s: unsupported graphic format %u", __func__,
+                     s->avbufm_registers[AV_BUF_FORMAT] & DP_GRAPHIC_MASK);
         abort();
     }
 
@@ -647,8 +649,8 @@ static void xlnx_dp_change_graphic_fmt(XlnxDPState *s)
         s->v_plane.format = PIXMAN_x8b8g8r8;
         break;
     default:
-        DPRINTF("error: unsupported video format %u.\n",
-                s->avbufm_registers[AV_BUF_FORMAT] & DP_NL_VID_FMT_MASK);
+        error_report("%s: unsupported video format %u", __func__,
+                     s->avbufm_registers[AV_BUF_FORMAT] & DP_NL_VID_FMT_MASK);
         abort();
     }
 
-- 
2.18.4


