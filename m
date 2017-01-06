Received: from eggs.gnu.org ([2001:4830:134:3::10]:47457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWt3-0005CD-Hk
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:57:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWt0-0005SB-GG
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:57:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41010)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWt0-0005Rw-7F
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:56:58 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 4B5067F76D
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:56:58 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:36 +0000
Message-Id: <20170106155543.12827-41-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 40/47] trace: switch target/s390x/ directory
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

Switch files in the target/s390x/ directory to include the
target/s390x/trace.h file instead of the global trace.h
file.

The make rules for gen-features.{h,c} need to be moved
out into the top level Makefile.objs, otherwise make
complains about the rules being defined multiple times
due to target/s390x/Makefile.objs being included
multiple times when expanding different subdir object
lists.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.objs              |  2 +-
 Makefile.target            | 23 +++++++++++++++++++++++
 target/s390x/Makefile.objs | 21 ++-------------------
 target/s390x/cpu.c         |  2 +-
 target/s390x/ioinst.c      |  2 +-
 target/s390x/kvm.c         |  2 +-
 target/s390x/mmu_helper.c  |  2 +-
 7 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index cc8f506..5d50645 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -158,7 +158,7 @@ trace-events-subdirs += net
 trace-events-subdirs += target/arm
 trace-events-subdirs += target/i386
 trace-events-subdirs += target/sparc
-trace-events-y += target/s390x/trace-events
+trace-events-subdirs += target/s390x
 trace-events-y += target/ppc/trace-events
 trace-events-y += qom/trace-events
 trace-events-y += linux-user/trace-events
diff --git a/Makefile.target b/Makefile.target
index b14ab45..38ef518 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -162,6 +162,29 @@ GENERATED_HEADERS += hmp-commands.h hmp-commands-info.h
 
 endif # CONFIG_SOFTMMU
 
+ifeq ($(TARGET_BASE_ARCH),s390x)
+# build and run feature list generator
+feat-src = $(SRC_PATH)/target/$(TARGET_BASE_ARCH)/
+feat-dst = $(BUILD_DIR)/$(TARGET_DIR)
+ifneq ($(MAKECMDGOALS),clean)
+GENERATED_HEADERS += $(feat-dst)gen-features.h
+endif
+
+$(feat-dst)gen-features.h: $(feat-dst)gen-features.h-timestamp
+	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
+$(feat-dst)gen-features.h-timestamp: $(feat-dst)gen-features
+	$(call quiet-command,$< >$@,"GEN","$(TARGET_DIR)gen-features.h")
+
+$(feat-dst)gen-features: $(feat-src)gen-features.c
+	$(call quiet-command,$(HOST_CC) $(QEMU_INCLUDES) -o $@ $<,"CC","$(TARGET_DIR)gen-features")
+
+clean-target:
+	rm -f gen-features.h-timestamp
+	rm -f gen-features.h
+	rm -f gen-features
+
+endif
+
 # Workaround for http://gcc.gnu.org/PR55489, see configure.
 %/translate.o: QEMU_CFLAGS += $(TRANSLATE_OPT_CFLAGS)
 
diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
index c573633..98f6f95 100644
--- a/target/s390x/Makefile.objs
+++ b/target/s390x/Makefile.objs
@@ -4,22 +4,5 @@ obj-y += gdbstub.o cpu_models.o cpu_features.o
 obj-$(CONFIG_SOFTMMU) += machine.o ioinst.o arch_dump.o mmu_helper.o
 obj-$(CONFIG_KVM) += kvm.o
 
-# build and run feature list generator
-feat-src = $(SRC_PATH)/target/$(TARGET_BASE_ARCH)/
-feat-dst = $(BUILD_DIR)/$(TARGET_DIR)
-ifneq ($(MAKECMDGOALS),clean)
-GENERATED_HEADERS += $(feat-dst)gen-features.h
-endif
-
-$(feat-dst)gen-features.h: $(feat-dst)gen-features.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(feat-dst)gen-features.h-timestamp: $(feat-dst)gen-features
-	$(call quiet-command,$< >$@,"GEN","$(TARGET_DIR)gen-features.h")
-
-$(feat-dst)gen-features: $(feat-src)gen-features.c
-	$(call quiet-command,$(HOST_CC) $(QEMU_INCLUDES) -o $@ $<,"CC","$(TARGET_DIR)gen-features")
-
-clean-target:
-	rm -f gen-features.h-timestamp
-	rm -f gen-features.h
-	rm -f gen-features
+trace-obj-y += trace.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index 0a39d31..db92ea1 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -30,7 +30,7 @@
 #include "qemu/cutils.h"
 #include "qemu/timer.h"
 #include "qemu/error-report.h"
-#include "trace.h"
+#include "target/s390x/trace.h"
 #include "qapi/visitor.h"
 #include "migration/vmstate.h"
 #include "exec/exec-all.h"
diff --git a/target/s390x/ioinst.c b/target/s390x/ioinst.c
index 590bfa4..b2ff2fc 100644
--- a/target/s390x/ioinst.c
+++ b/target/s390x/ioinst.c
@@ -13,7 +13,7 @@
 
 #include "cpu.h"
 #include "hw/s390x/ioinst.h"
-#include "trace.h"
+#include "target/s390x/trace.h"
 #include "hw/s390x/s390-pci-bus.h"
 
 int ioinst_disassemble_sch_ident(uint32_t value, int *m, int *cssid, int *ssid,
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 97afe02..c861a58 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -38,7 +38,7 @@
 #include "qapi/qmp/qjson.h"
 #include "exec/gdbstub.h"
 #include "exec/address-spaces.h"
-#include "trace.h"
+#include "target/s390x/trace.h"
 #include "qapi-event.h"
 #include "hw/s390x/s390-pci-inst.h"
 #include "hw/s390x/s390-pci-bus.h"
diff --git a/target/s390x/mmu_helper.c b/target/s390x/mmu_helper.c
index b11a027..100f888 100644
--- a/target/s390x/mmu_helper.c
+++ b/target/s390x/mmu_helper.c
@@ -20,7 +20,7 @@
 #include "exec/address-spaces.h"
 #include "cpu.h"
 #include "sysemu/kvm.h"
-#include "trace.h"
+#include "target/s390x/trace.h"
 #include "hw/s390x/storage-keys.h"
 
 /* #define DEBUG_S390 */
-- 
2.9.3
