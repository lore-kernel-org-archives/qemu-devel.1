Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A64BC31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 05:11:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F131C20896
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 05:11:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F131C20896
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36974 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbI1l-00015X-9v
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 01:11:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44690)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <aik@ozlabs.ru>) id 1hbI0X-0000Yk-Ud
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 01:10:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1hbI0V-000345-Ml
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 01:10:41 -0400
Received: from ozlabs.ru ([107.173.13.209]:37775)
 by eggs.gnu.org with esmtp (Exim 4.71)
 (envelope-from <aik@ozlabs.ru>) id 1hbI0V-0002md-Df
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 01:10:39 -0400
Received: from fstn1-p1.ozlabs.ibm.com (localhost [IPv6:::1])
 by ozlabs.ru (Postfix) with ESMTP id 15EFDAE80020;
 Thu, 13 Jun 2019 01:09:42 -0400 (EDT)
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: qemu-devel@nongnu.org
Date: Thu, 13 Jun 2019 15:09:37 +1000
Message-Id: <20190613050937.124903-1-aik@ozlabs.ru>
X-Mailer: git-send-email 2.17.1
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 107.173.13.209
Subject: [Qemu-devel] [PATCH qemu] loader: Trace loaded images
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
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

This adds a trace point which prints every loaded image. This includes
bios/firmware/kernel/initradmdisk/pcirom.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---

The example for a pseries guest:

loader_write_rom slof.bin: @0x0 size=0xe22e0 ROM=0
loader_write_rom phdr #0: /home/aik/t/vml4120le: @0x400000 size=0x13df000 ROM=0
loader_write_rom /home/aik/t/le.cpio: @0x1ad0000 size=0x9463a00 ROM=0

Sadly "spapr-rtas.bin" does not show up because it is loaded from
the spapr machine reset handler rather than via rom_reset(), may be needs
to be fixed.

---
 Makefile.objs        | 1 +
 hw/core/loader.c     | 3 +++
 hw/core/trace-events | 2 ++
 3 files changed, 6 insertions(+)
 create mode 100644 hw/core/trace-events

diff --git a/Makefile.objs b/Makefile.objs
index c8337fa34be8..036ca6752908 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -200,6 +200,7 @@ trace-events-subdirs += target/riscv
 trace-events-subdirs += target/s390x
 trace-events-subdirs += target/sparc
 trace-events-subdirs += util
+trace-events-subdirs += hw/core
 
 trace-events-files = $(SRC_PATH)/trace-events $(trace-events-subdirs:%=$(SRC_PATH)/%/trace-events)
 
diff --git a/hw/core/loader.c b/hw/core/loader.c
index a097bbe30a74..7fe083af492f 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -44,6 +44,7 @@
 
 #include "qemu/osdep.h"
 #include "qapi/error.h"
+#include "trace.h"
 #include "hw/hw.h"
 #include "disas/disas.h"
 #include "monitor/monitor.h"
@@ -1114,6 +1115,8 @@ static void rom_reset(void *unused)
          * CPU definitely fetches its instructions from the just written data.
          */
         cpu_flush_icache_range(rom->addr, rom->datasize);
+
+        trace_loader_write_rom(rom->name, rom->addr, rom->datasize, rom->isrom);
     }
 }
 
diff --git a/hw/core/trace-events b/hw/core/trace-events
new file mode 100644
index 000000000000..fe47a9c8cb1f
--- /dev/null
+++ b/hw/core/trace-events
@@ -0,0 +1,2 @@
+# loader.c
+loader_write_rom(const char *name, uint64_t gpa, uint64_t size, bool isrom) "%s: @0x%"PRIx64" size=0x%"PRIx64" ROM=%d"
-- 
2.17.1


