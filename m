Return-Path: <SRS0=D+kF=7K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C17AC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:38:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C98C7206F1
	for <qemu-devel@archiver.kernel.org>; Thu, 28 May 2020 12:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Mf+tKORf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C98C7206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38212 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jeHni-00054f-QF
	for qemu-devel@archiver.kernel.org; Thu, 28 May 2020 08:38:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33542)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeHlq-0001Uv-RR
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:36:26 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:45129
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1jeHlp-00059v-CL
 for qemu-devel@nongnu.org; Thu, 28 May 2020 08:36:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1590669384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+afJjiLO1e/ioNxL9yvN1UMqnBe577QM6XrVyi3y+YM=;
 b=Mf+tKORfhqdFEv7b8UCiCiJwKKSLlKzXXcxRJlxTvUtmwnZ53AEynaok97GGuL3L8M2nrY
 Eh32JWJmMcGymK+C74UAigQNy6WnWUo8EhowhjaS96OwDsdRrRAkwpHPlsZ5dUjIXzCVZ/
 Gu69gI/USyCqwOlX/47ahZz+mZugC0A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-CyMFlhC2MRWfaQ5r7Euz5g-1; Thu, 28 May 2020 08:36:19 -0400
X-MC-Unique: CyMFlhC2MRWfaQ5r7Euz5g-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D2274474;
 Thu, 28 May 2020 12:36:17 +0000 (UTC)
Received: from sirius.home.kraxel.org (ovpn-113-50.ams2.redhat.com
 [10.36.113.50])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 76D147E467;
 Thu, 28 May 2020 12:36:17 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id A502A9D57; Thu, 28 May 2020 14:36:09 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 08/21] hw/display/dpcd: Convert debug printf()s to trace events
Date: Thu, 28 May 2020 14:35:56 +0200
Message-Id: <20200528123609.27362-9-kraxel@redhat.com>
In-Reply-To: <20200528123609.27362-1-kraxel@redhat.com>
References: <20200528123609.27362-1-kraxel@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=205.139.110.61; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/28 06:31:20
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Message-id: 20200526062252.19852-9-f4bug@amsat.org
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/dpcd.c       | 16 +++-------------
 hw/display/trace-events |  4 ++++
 2 files changed, 7 insertions(+), 13 deletions(-)

diff --git a/hw/display/dpcd.c b/hw/display/dpcd.c
index 0c1b7b35fbb4..64463654a1a0 100644
--- a/hw/display/dpcd.c
+++ b/hw/display/dpcd.c
@@ -32,16 +32,7 @@
 #include "hw/misc/auxbus.h"
 #include "migration/vmstate.h"
 #include "hw/display/dpcd.h"
-
-#ifndef DEBUG_DPCD
-#define DEBUG_DPCD 0
-#endif
-
-#define DPRINTF(fmt, ...) do {                                                 \
-    if (DEBUG_DPCD) {                                                          \
-        qemu_log("dpcd: " fmt, ## __VA_ARGS__);                                \
-    }                                                                          \
-} while (0)
+#include "trace.h"
 
 #define DPCD_READABLE_AREA                      0x600
 
@@ -70,8 +61,8 @@ static uint64_t dpcd_read(void *opaque, hwaddr offset, unsigned size)
                                        offset);
         ret = 0;
     }
+    trace_dpcd_read(offset, ret);
 
-    DPRINTF("read 0x%" PRIX8 " @0x%" HWADDR_PRIX "\n", ret, offset);
     return ret;
 }
 
@@ -80,8 +71,7 @@ static void dpcd_write(void *opaque, hwaddr offset, uint64_t value,
 {
     DPCDState *e = DPCD(opaque);
 
-    DPRINTF("write 0x%" PRIX8 " @0x%" HWADDR_PRIX "\n", (uint8_t)value, offset);
-
+    trace_dpcd_write(offset, value);
     if (offset < DPCD_READABLE_AREA) {
         e->dpcd_info[offset] = value;
     } else {
diff --git a/hw/display/trace-events b/hw/display/trace-events
index bb089a5f5e0c..72d4c9812c69 100644
--- a/hw/display/trace-events
+++ b/hw/display/trace-events
@@ -157,3 +157,7 @@ artist_draw_line(unsigned int start_x, unsigned int start_y, unsigned int end_x,
 # cg3.c
 cg3_read(uint32_t addr, uint32_t val, unsigned size) "read addr:0x%06"PRIx32" val:0x%08"PRIx32" size:%u"
 cg3_write(uint32_t addr, uint32_t val, unsigned size) "write addr:0x%06"PRIx32" val:0x%08"PRIx32" size:%u"
+
+# dpcd.c
+dpcd_read(uint32_t addr, uint8_t val) "read addr:0x%"PRIx32" val:0x%02x"
+dpcd_write(uint32_t addr, uint8_t val) "write addr:0x%"PRIx32" val:0x%02x"
-- 
2.18.4


