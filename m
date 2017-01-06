Received: from eggs.gnu.org ([2001:4830:134:3::10]:47456)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWt3-0005CC-Hr
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:57:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWsy-0005RX-Ml
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:57:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59084)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWsy-0005RG-GW
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:56 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9A13961963
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:56 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:35 +0000
Message-Id: <20170106155543.12827-40-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 39/47] trace: switch target/sparc/ directory
 to modular trace.h file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Switch files in the target/sparc/ directory to include the
target/sparc/trace.h file instead of the global trace.h
file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs               | 2 +-
 target/sparc/Makefile.objs  | 2 ++
 target/sparc/int32_helper.c | 2 +-
 target/sparc/int64_helper.c | 2 +-
 target/sparc/mmu_helper.c   | 2 +-
 target/sparc/win_helper.c   | 2 +-
 6 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index a1161be..cc8f506 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -157,7 +157,7 @@ trace-events-subdirs += audio
 trace-events-subdirs += net
 trace-events-subdirs += target/arm
 trace-events-subdirs += target/i386
-trace-events-y += target/sparc/trace-events
+trace-events-subdirs += target/sparc
 trace-events-y += target/s390x/trace-events
 trace-events-y += target/ppc/trace-events
 trace-events-y += qom/trace-events
diff --git a/target/sparc/Makefile.objs b/target/sparc/Makefile.objs
index ec90569..0ca6e73 100644
--- a/target/sparc/Makefile.objs
+++ b/target/sparc/Makefile.objs
@@ -5,3 +5,5 @@ obj-$(TARGET_SPARC) += int32_helper.o
 obj-$(TARGET_SPARC64) += int64_helper.o
 obj-$(TARGET_SPARC64) += vis_helper.o
 obj-y += gdbstub.o
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/target/sparc/int32_helper.c b/target/sparc/int32_helper.c
index 09afe13..2838eda 100644
--- a/target/sparc/int32_helper.c
+++ b/target/sparc/int32_helper.c
@@ -19,7 +19,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "trace.h"
+#include "target/sparc/trace.h"
 #include "sysemu/sysemu.h"
 #include "exec/log.h"
 
diff --git a/target/sparc/int64_helper.c b/target/sparc/int64_helper.c
index 29360fa..ad0a16c 100644
--- a/target/sparc/int64_helper.c
+++ b/target/sparc/int64_helper.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "exec/helper-proto.h"
 #include "exec/log.h"
-#include "trace.h"
+#include "target/sparc/trace.h"
 
 #define DEBUG_PCALL
 
diff --git a/target/sparc/mmu_helper.c b/target/sparc/mmu_helper.c
index 044e88c..6f66c4a 100644
--- a/target/sparc/mmu_helper.c
+++ b/target/sparc/mmu_helper.c
@@ -20,7 +20,7 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "exec/exec-all.h"
-#include "trace.h"
+#include "target/sparc/trace.h"
 #include "exec/address-spaces.h"
 
 /* Sparc MMU emulation */
diff --git a/target/sparc/win_helper.c b/target/sparc/win_helper.c
index 2d5b546..3b6dd33 100644
--- a/target/sparc/win_helper.c
+++ b/target/sparc/win_helper.c
@@ -21,7 +21,7 @@
 #include "cpu.h"
 #include "exec/exec-all.h"
 #include "exec/helper-proto.h"
-#include "trace.h"
+#include "target/sparc/trace.h"
 
 static inline void memcpy32(target_ulong *dst, const target_ulong *src)
 {
-- 
2.9.3
