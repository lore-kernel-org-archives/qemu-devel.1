Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C056EC3A589
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 05:23:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C27621726
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 05:23:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kx+BhJyp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C27621726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i122n-0007Sl-69
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 01:23:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44715)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1i11rA-0003uT-3D
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:11:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1i11r8-0002Sx-RH
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 01:11:23 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:40562)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1i11r8-0002SO-Lu; Fri, 23 Aug 2019 01:11:22 -0400
Received: by mail-pf1-x443.google.com with SMTP id w16so5647341pfn.7;
 Thu, 22 Aug 2019 22:11:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:subject:date:message-id:in-reply-to:references;
 bh=+zzCHFZurXByfcVb0kzc2teMVzNfQuoZt/YP0jsSzy0=;
 b=Kx+BhJyp9dHE67BtPkaj1yMFQm2QNhsJg9tc1ORiTuCD50c4YAWyjecojOTGqp8BPm
 /jQ1UceGMRE6snV+rylAnlRebO1XKCy1uAfOk21W/0uhdBWlnsgjMuMlm0DMrTmk7UfS
 8Ak7VLTrk2tBIZgjFYotznM60yertKpoMNZvUvULgoUDFiab/xvsPxE04xYnd5Jtnnl6
 bh7InmYFVfg1vWlDFO4KPQuWxY05SZudH0PMDTTT8sU26NNb5NMHrh+1MmpoFgaS8Z+7
 f50ZJ6HvcjJN+L+PrjFJICYGiYvJ+xW3k7PEsPRlNfsfEFCwTE5zcP5qqY/dJ5VsSvJu
 VKxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references;
 bh=+zzCHFZurXByfcVb0kzc2teMVzNfQuoZt/YP0jsSzy0=;
 b=gwF5+aTbHDjHzEQA/DHoaygXmVbtfNmRmEd0ql+1zBXQu0BpMLoUXlxv9BlesFhLSx
 N/2yGRmda7Lsj0vRF76SsHmHYD5y8azDrxNIcLjO+TtDB8xaBao+CjatPU35CYA2Ceq4
 99nkBhL5fYWq2SfHXiYALX6AaTRrlhp/FtHBBb/eXPUnCdhr9iFVb6otKCEDG4SpCnu1
 M5e9Ns5kwG2fq7UG9qE4I7Fu0aMWLP8CkojUvFlgcUKHO7Kls9Ktfx6zsDF+qkmmq1e/
 xVHMqqsPdc9/5KVyTmN/P78JPLjt4NC2yQaMysNl4wmR1eFY4hKDKio+dpTHINoUAXJ+
 d/SA==
X-Gm-Message-State: APjAAAV3/0/ejMZgJ4TcI9+pjz9eEnJ/Sq8acss3hCMzmKGY4AZ/gk3Z
 QRirnPgbXM7JqPwoDxj6SXE=
X-Google-Smtp-Source: APXvYqwGA4rFUgzydq6BYm2YvpxbDQLyt/PulgO9b6WyiN/OdxS0JXOAYxfD/rhWi5nZrM/HrTUDbg==
X-Received: by 2002:a17:90a:9f46:: with SMTP id
 q6mr3223822pjv.110.1566537081918; 
 Thu, 22 Aug 2019 22:11:21 -0700 (PDT)
Received: from localhost.localdomain (unknown-224-80.windriver.com.
 [147.11.224.80])
 by smtp.gmail.com with ESMTPSA id v189sm1122527pfv.176.2019.08.22.22.11.20
 (version=TLS1 cipher=AES128-SHA bits=128/128);
 Thu, 22 Aug 2019 22:11:21 -0700 (PDT)
From: Bin Meng <bmeng.cn@gmail.com>
To: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Date: Thu, 22 Aug 2019 22:10:44 -0700
Message-Id: <1566537069-22741-6-git-send-email-bmeng.cn@gmail.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
References: <1566537069-22741-1-git-send-email-bmeng.cn@gmail.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: [Qemu-devel] [PATCH v5 05/30] riscv: hw: Change to use
 qemu_log_mask(LOG_GUEST_ERROR, ...) instead
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Replace the call to hw_error() with qemu_log_mask(LOG_GUEST_ERROR,...)
in various sifive models.

Signed-off-by: Bin Meng <bmeng.cn@gmail.com>

---

Changes in v5:
- new patch to change to use qemu_log_mask(LOG_GUEST_ERROR,...) instead
  in various sifive models

Changes in v4: None
Changes in v3: None
Changes in v2: None

 hw/riscv/sifive_prci.c | 8 +++++---
 hw/riscv/sifive_test.c | 5 +++--
 hw/riscv/sifive_uart.c | 9 +++++----
 3 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/hw/riscv/sifive_prci.c b/hw/riscv/sifive_prci.c
index f406682..1ab98d4 100644
--- a/hw/riscv/sifive_prci.c
+++ b/hw/riscv/sifive_prci.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "qemu/log.h"
 #include "qemu/module.h"
 #include "target/riscv/cpu.h"
 #include "hw/riscv/sifive_prci.h"
@@ -37,7 +38,8 @@ static uint64_t sifive_prci_read(void *opaque, hwaddr addr, unsigned int size)
     case SIFIVE_PRCI_PLLOUTDIV:
         return s->plloutdiv;
     }
-    hw_error("%s: read: addr=0x%x\n", __func__, (int)addr);
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: read: addr=0x%x\n",
+                  __func__, (int)addr);
     return 0;
 }
 
@@ -65,8 +67,8 @@ static void sifive_prci_write(void *opaque, hwaddr addr,
         s->plloutdiv = (uint32_t) val64;
         break;
     default:
-        hw_error("%s: bad write: addr=0x%x v=0x%x\n",
-                 __func__, (int)addr, (int)val64);
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write: addr=0x%x v=0x%x\n",
+                      __func__, (int)addr, (int)val64);
     }
 }
 
diff --git a/hw/riscv/sifive_test.c b/hw/riscv/sifive_test.c
index cd86831..655a3d7 100644
--- a/hw/riscv/sifive_test.c
+++ b/hw/riscv/sifive_test.c
@@ -20,6 +20,7 @@
 
 #include "qemu/osdep.h"
 #include "hw/sysbus.h"
+#include "qemu/log.h"
 #include "qemu/module.h"
 #include "sysemu/sysemu.h"
 #include "target/riscv/cpu.h"
@@ -48,8 +49,8 @@ static void sifive_test_write(void *opaque, hwaddr addr,
             break;
         }
     }
-    hw_error("%s: write: addr=0x%x val=0x%016" PRIx64 "\n",
-        __func__, (int)addr, val64);
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: write: addr=0x%x val=0x%016" PRIx64 "\n",
+                  __func__, (int)addr, val64);
 }
 
 static const MemoryRegionOps sifive_test_ops = {
diff --git a/hw/riscv/sifive_uart.c b/hw/riscv/sifive_uart.c
index 3b3f94f..cd74043 100644
--- a/hw/riscv/sifive_uart.c
+++ b/hw/riscv/sifive_uart.c
@@ -18,6 +18,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "qemu/log.h"
 #include "hw/sysbus.h"
 #include "chardev/char.h"
 #include "chardev/char-fe.h"
@@ -93,8 +94,8 @@ uart_read(void *opaque, hwaddr addr, unsigned int size)
         return s->div;
     }
 
-    hw_error("%s: bad read: addr=0x%x\n",
-        __func__, (int)addr);
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: bad read: addr=0x%x\n",
+                  __func__, (int)addr);
     return 0;
 }
 
@@ -125,8 +126,8 @@ uart_write(void *opaque, hwaddr addr,
         s->div = val64;
         return;
     }
-    hw_error("%s: bad write: addr=0x%x v=0x%x\n",
-        __func__, (int)addr, (int)value);
+    qemu_log_mask(LOG_GUEST_ERROR, "%s: bad write: addr=0x%x v=0x%x\n",
+                  __func__, (int)addr, (int)value);
 }
 
 static const MemoryRegionOps uart_ops = {
-- 
2.7.4


