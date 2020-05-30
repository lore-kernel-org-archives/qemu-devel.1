Return-Path: <SRS0=1N+K=7M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C235AC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 07:54:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5538120723
	for <qemu-devel@archiver.kernel.org>; Sat, 30 May 2020 07:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5538120723
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=tuxfamily.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33120 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jewKD-0005gW-B9
	for qemu-devel@archiver.kernel.org; Sat, 30 May 2020 03:54:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37906)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1jewJS-0004c1-Mp
 for qemu-devel@nongnu.org; Sat, 30 May 2020 03:53:51 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:43171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>) id 1jewJR-0006os-FU
 for qemu-devel@nongnu.org; Sat, 30 May 2020 03:53:50 -0400
Received: by mail-wr1-f54.google.com with SMTP id l10so6340441wrr.10
 for <qemu-devel@nongnu.org>; Sat, 30 May 2020 00:53:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rXpt1atwYsZQSvHYiYaAf0ITGoKRArSH72PL8D8w22s=;
 b=DNkkYtNQuzitRc4VNVHbKJr3IL7zQZdl7r3ciNmKXxNep1w0ujDhLcembadwq7+7HC
 ScxQQHEPUUY455b3qoq3NTW/cevZUvadRKOlL7XkFpbTXm4F/4ei94/CIpoLxcK4rw98
 lSoltAdt56MnzQSF76/WfJS3S9aSHILSAElhtRP05jxATBfpaw0pCsMfTDQSM3xgls1x
 fad8DniShXoY41J8R0ttMmckY8++2dZw/4SA3bHUMcOF09S9Nspv4HY4z0Osi2TMBSMg
 aowHFZ4i8aa4WpXSwPAepEbbG6sPZjDcjRwf6LAeV94GCacp8XiqV5HJlMOZTLacAB2H
 kJkg==
X-Gm-Message-State: AOAM533t0b7GELW6/oJbJZH/pU2xC9urUKnfyS+8hsFllH/De1YPckxc
 E49lbp0tmkApe2imW9awGHqFL0sj
X-Google-Smtp-Source: ABdhPJy4HLSCs0Or0Rn3VOBzMsOXPsSsWBRkNJZVY76VKtkvu9jca6PHygUBesKfmvSqNarKceeu/Q==
X-Received: by 2002:adf:f5c2:: with SMTP id k2mr12124075wrp.111.1590825227174; 
 Sat, 30 May 2020 00:53:47 -0700 (PDT)
Received: from localhost.localdomain (x590fef72.dyn.telefonica.de.
 [89.15.239.114])
 by smtp.gmail.com with ESMTPSA id o20sm13139310wra.29.2020.05.30.00.53.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 30 May 2020 00:53:46 -0700 (PDT)
From: Thomas Huth <huth@tuxfamily.org>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 2/2] hw/m68k/mcf52xx: Replace hw_error() by qemu_log_mask()
Date: Sat, 30 May 2020 09:53:20 +0200
Message-Id: <20200530075320.18854-3-huth@tuxfamily.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200530075320.18854-1-huth@tuxfamily.org>
References: <20200530075320.18854-1-huth@tuxfamily.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=209.85.221.54; envelope-from=th.huth@gmail.com;
 helo=mail-wr1-f54.google.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/05/30 03:53:47
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -15
X-Spam_score: -1.6
X-Spam_bar: -
X-Spam_report: (-1.6 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_PASS=-0.001,
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <f4bug@amsat.org>

hw_error() calls exit(). This a bit overkill when we can log
the accesses as unimplemented or guest error.

When fuzzing the devices, we don't want the whole process to
exit. Replace some hw_error() calls by qemu_log_mask().

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-Id: <20200526094052.1723-3-f4bug@amsat.org>
Reviewed-by: Thomas Huth <huth@tuxfamily.org>
Signed-off-by: Thomas Huth <huth@tuxfamily.org>
---
 hw/m68k/mcf5206.c  | 10 +++++++---
 hw/m68k/mcf5208.c  | 16 ++++++++++------
 hw/m68k/mcf_intc.c | 10 +++++++---
 hw/net/mcf_fec.c   |  9 ++++++---
 4 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/hw/m68k/mcf5206.c b/hw/m68k/mcf5206.c
index 187291e1f6..a2fef04f8e 100644
--- a/hw/m68k/mcf5206.c
+++ b/hw/m68k/mcf5206.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/error-report.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
@@ -225,7 +226,8 @@ static void m5206_mbar_update(m5206_mbar_state *s)
                 break;
             default:
                 /* Unknown vector.  */
-                error_report("Unhandled vector for IRQ %d", irq);
+                qemu_log_mask(LOG_UNIMP, "%s: Unhandled vector for IRQ %d\n",
+                              __func__, irq);
                 vector = 0xf;
                 break;
             }
@@ -306,7 +308,8 @@ static uint64_t m5206_mbar_read(m5206_mbar_state *s,
     case 0x170: return s->uivr[0];
     case 0x1b0: return s->uivr[1];
     }
-    hw_error("Bad MBAR read offset 0x%"PRIx16, offset);
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad MBAR offset 0x%"PRIx16"\n",
+                  __func__, offset);
     return 0;
 }
 
@@ -360,7 +363,8 @@ static void m5206_mbar_write(m5206_mbar_state *s, uint16_t offset,
         s->uivr[1] = value;
         break;
     default:
-        hw_error("Bad MBAR write offset 0x%"PRIx16, offset);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad MBAR offset 0x%"PRIx16"\n",
+                      __func__, offset);
         break;
     }
 }
diff --git a/hw/m68k/mcf5208.c b/hw/m68k/mcf5208.c
index b84c152ce3..2ab9701ad6 100644
--- a/hw/m68k/mcf5208.c
+++ b/hw/m68k/mcf5208.c
@@ -9,10 +9,10 @@
 #include "qemu/osdep.h"
 #include "qemu/units.h"
 #include "qemu/error-report.h"
+#include "qemu/log.h"
 #include "qapi/error.h"
 #include "qemu-common.h"
 #include "cpu.h"
-#include "hw/hw.h"
 #include "hw/irq.h"
 #include "hw/m68k/mcf.h"
 #include "hw/m68k/mcf_fec.h"
@@ -111,8 +111,9 @@ static void m5208_timer_write(void *opaque, hwaddr offset,
     case 4:
         break;
     default:
-        hw_error("m5208_timer_write: Bad offset 0x%x\n", (int)offset);
-        break;
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                      __func__, offset);
+        return;
     }
     m5208_timer_update(s);
 }
@@ -136,7 +137,8 @@ static uint64_t m5208_timer_read(void *opaque, hwaddr addr,
     case 4:
         return ptimer_get_count(s->timer);
     default:
-        hw_error("m5208_timer_read: Bad offset 0x%x\n", (int)addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                      __func__, addr);
         return 0;
     }
 }
@@ -164,7 +166,8 @@ static uint64_t m5208_sys_read(void *opaque, hwaddr addr,
         return 0;
 
     default:
-        hw_error("m5208_sys_read: Bad offset 0x%x\n", (int)addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                      __func__, addr);
         return 0;
     }
 }
@@ -172,7 +175,8 @@ static uint64_t m5208_sys_read(void *opaque, hwaddr addr,
 static void m5208_sys_write(void *opaque, hwaddr addr,
                             uint64_t value, unsigned size)
 {
-    hw_error("m5208_sys_write: Bad offset 0x%x\n", (int)addr);
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%" HWADDR_PRIX "\n",
+                  __func__, addr);
 }
 
 static const MemoryRegionOps m5208_sys_ops = {
diff --git a/hw/m68k/mcf_intc.c b/hw/m68k/mcf_intc.c
index d9e03a06ab..bc20742d9a 100644
--- a/hw/m68k/mcf_intc.c
+++ b/hw/m68k/mcf_intc.c
@@ -8,6 +8,7 @@
 
 #include "qemu/osdep.h"
 #include "qemu/module.h"
+#include "qemu/log.h"
 #include "cpu.h"
 #include "hw/hw.h"
 #include "hw/irq.h"
@@ -80,7 +81,9 @@ static uint64_t mcf_intc_read(void *opaque, hwaddr addr,
     case 0xe1: case 0xe2: case 0xe3: case 0xe4:
     case 0xe5: case 0xe6: case 0xe7:
         /* LnIACK */
-        hw_error("mcf_intc_read: LnIACK not implemented\n");
+        qemu_log_mask(LOG_UNIMP, "%s: LnIACK not implemented (offset 0x%02x)\n",
+                      __func__, offset);
+        /* fallthru */
     default:
         return 0;
     }
@@ -127,8 +130,9 @@ static void mcf_intc_write(void *opaque, hwaddr addr,
         }
         break;
     default:
-        hw_error("mcf_intc_write: Bad write offset %d\n", offset);
-        break;
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad offset 0x%02x\n",
+                      __func__, offset);
+        return;
     }
     mcf_intc_update(s);
 }
diff --git a/hw/net/mcf_fec.c b/hw/net/mcf_fec.c
index 9327ac8a30..281345862c 100644
--- a/hw/net/mcf_fec.c
+++ b/hw/net/mcf_fec.c
@@ -7,7 +7,7 @@
  */
 
 #include "qemu/osdep.h"
-#include "hw/hw.h"
+#include "qemu/log.h"
 #include "hw/irq.h"
 #include "net/net.h"
 #include "qemu/module.h"
@@ -392,7 +392,8 @@ static uint64_t mcf_fec_read(void *opaque, hwaddr addr,
     case 0x188: return s->emrbr;
     case 0x200 ... 0x2e0: return s->mib[(addr & 0x1ff) / 4];
     default:
-        hw_error("mcf_fec_read: Bad address 0x%x\n", (int)addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address 0x%" HWADDR_PRIX "\n",
+                      __func__, addr);
         return 0;
     }
 }
@@ -492,7 +493,9 @@ static void mcf_fec_write(void *opaque, hwaddr addr,
         s->mib[(addr & 0x1ff) / 4] = value;
         break;
     default:
-        hw_error("mcf_fec_write Bad address 0x%x\n", (int)addr);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: Bad address 0x%" HWADDR_PRIX "\n",
+                      __func__, addr);
+        return;
     }
     mcf_fec_update(s);
 }
-- 
2.26.2


