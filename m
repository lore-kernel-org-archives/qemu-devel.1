Return-Path: <SRS0=ACoC=7J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 378D8C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:46:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0161120787
	for <qemu-devel@archiver.kernel.org>; Wed, 27 May 2020 05:46:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=gibson.dropbear.id.au header.i=@gibson.dropbear.id.au header.b="Mkzzrtoy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0161120787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=gibson.dropbear.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jdota-00007W-5T
	for qemu-devel@archiver.kernel.org; Wed, 27 May 2020 01:46:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46234)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jdolp-0001L9-OS; Wed, 27 May 2020 01:38:29 -0400
Received: from ozlabs.org ([203.11.71.1]:40021)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dgibson@ozlabs.org>)
 id 1jdolo-0001fs-M5; Wed, 27 May 2020 01:38:29 -0400
Received: by ozlabs.org (Postfix, from userid 1007)
 id 49X03r4RYPz9sTP; Wed, 27 May 2020 15:38:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=gibson.dropbear.id.au; s=201602; t=1590557896;
 bh=dETticln5jue/6C4D6AhTH9jzwfw913NTSrQRT2LqDk=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=MkzzrtoyFhGb7Hbgl8Zqx5M1RS4Tjht/EFle+/y5qqsCiONDI/cvBhDCcX/wMzb9i
 R8gaXdwfuWqYWFV21NRIs0KIPx/eTeVZWhy4olKhNvqsHKnUfHpGdCx+8yJHLXZEBv
 h6vpzMc0UTWT1XkGXgDPA1U1wXhwnpizONc8ZZj4=
From: David Gibson <david@gibson.dropbear.id.au>
To: peter.maydell@linaro.org
Subject: [PULL 13/15] hw/nvram/mac_nvram: Convert debug printf()s to trace
 events
Date: Wed, 27 May 2020 15:38:07 +1000
Message-Id: <20200527053809.356168-14-david@gibson.dropbear.id.au>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200527053809.356168-1-david@gibson.dropbear.id.au>
References: <20200527053809.356168-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=203.11.71.1; envelope-from=dgibson@ozlabs.org;
 helo=ozlabs.org
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/27 01:38:16
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic]
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
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
Cc: lvivier@redhat.com, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org, groug@kaod.org, qemu-ppc@nongnu.org, philmd@redhat.com,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

Convert NVR_DPRINTF() to trace events and remove ifdef'ry.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200524165126.13920-1-f4bug@amsat.org>
Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/nvram/mac_nvram.c  | 17 +++--------------
 hw/nvram/trace-events |  4 ++++
 2 files changed, 7 insertions(+), 14 deletions(-)

diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index ff5db03e6b..beec1c4e4d 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -30,18 +30,9 @@
 #include "migration/vmstate.h"
 #include "qemu/cutils.h"
 #include "qemu/module.h"
+#include "trace.h"
 #include <zlib.h>
 
-/* debug NVR */
-//#define DEBUG_NVR
-
-#ifdef DEBUG_NVR
-#define NVR_DPRINTF(fmt, ...)                                   \
-    do { printf("NVR: " fmt , ## __VA_ARGS__); } while (0)
-#else
-#define NVR_DPRINTF(fmt, ...)
-#endif
-
 #define DEF_SYSTEM_SIZE 0xc10
 
 /* macio style NVRAM device */
@@ -51,9 +42,8 @@ static void macio_nvram_writeb(void *opaque, hwaddr addr,
     MacIONVRAMState *s = opaque;
 
     addr = (addr >> s->it_shift) & (s->size - 1);
+    trace_macio_nvram_write(addr, value);
     s->data[addr] = value;
-    NVR_DPRINTF("writeb addr %04" HWADDR_PRIx " val %" PRIx64 "\n",
-                addr, value);
 }
 
 static uint64_t macio_nvram_readb(void *opaque, hwaddr addr,
@@ -64,8 +54,7 @@ static uint64_t macio_nvram_readb(void *opaque, hwaddr addr,
 
     addr = (addr >> s->it_shift) & (s->size - 1);
     value = s->data[addr];
-    NVR_DPRINTF("readb addr %04" HWADDR_PRIx " val %" PRIx32 "\n",
-                addr, value);
+    trace_macio_nvram_read(addr, value);
 
     return value;
 }
diff --git a/hw/nvram/trace-events b/hw/nvram/trace-events
index 0dea9260ce..e023193295 100644
--- a/hw/nvram/trace-events
+++ b/hw/nvram/trace-events
@@ -13,3 +13,7 @@ fw_cfg_add_string(uint16_t key_value, const char *key_name, const char *value) "
 fw_cfg_add_i16(uint16_t key_value, const char *key_name, uint16_t value) "key 0x%04" PRIx16 " '%s', value 0x%" PRIx16
 fw_cfg_add_i32(uint16_t key_value, const char *key_name, uint32_t value) "key 0x%04" PRIx16 " '%s', value 0x%" PRIx32
 fw_cfg_add_i64(uint16_t key_value, const char *key_name, uint64_t value) "key 0x%04" PRIx16 " '%s', value 0x%" PRIx64
+
+# mac_nvram.c
+macio_nvram_read(uint32_t addr, uint8_t val) "read addr=0x%04"PRIx32" val=0x%02x"
+macio_nvram_write(uint32_t addr, uint8_t val) "write addr=0x%04"PRIx32" val=0x%02x"
-- 
2.26.2


