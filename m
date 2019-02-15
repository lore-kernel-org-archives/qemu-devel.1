Received: from eggs.gnu.org ([209.51.188.92]:40854)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gubGX-0007eP-Iz
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:02:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1gub3h-0004bB-SJ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:49:32 -0500
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:41915)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1gub3Z-00043J-9z
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 05:49:23 -0500
Received: by mail-wr1-x442.google.com with SMTP id x10so9806819wrs.8
	for <qemu-devel@nongnu.org>; Fri, 15 Feb 2019 02:49:21 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 15 Feb 2019 11:49:15 +0100
Message-Id: <1550227757-10869-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH] build: get rid of target-obj-y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, stefanha@redhat.com, eblake@redhat.com

It is possible to specify the trace/ directory already in objs-y;
there is no need to have a separate unnest-vars invocation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs       | 1 -
 Makefile.target     | 7 ++-----
 trace/Makefile.objs | 4 ++--
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index b7aae33..c3a2354 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -112,7 +112,6 @@ version-obj-$(CONFIG_WIN32) += $(BUILD_DIR)/version.o
 ######################################################################
 # tracing
 util-obj-y +=  trace/
-target-obj-y += trace/
 
 ######################################################################
 # guest agent
diff --git a/Makefile.target b/Makefile.target
index bb82959..a56a72f 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -105,6 +105,8 @@ all: $(PROGS) stap
 # Dummy command so that make thinks it has done something
 	@true
 
+obj-y += trace/
+
 #########################################################
 # cpu emulator library
 obj-y += exec.o
@@ -172,14 +174,11 @@ endif # CONFIG_SOFTMMU
 dummy := $(call unnest-vars,,obj-y)
 all-obj-y := $(obj-y)
 
-target-obj-y :=
 block-obj-y :=
 common-obj-y :=
 chardev-obj-y :=
 slirp-obj-y :=
 include $(SRC_PATH)/Makefile.objs
-dummy := $(call unnest-vars,,target-obj-y)
-target-obj-y-save := $(target-obj-y)
 dummy := $(call unnest-vars,.., \
                block-obj-y \
                block-obj-m \
@@ -191,9 +190,7 @@ dummy := $(call unnest-vars,.., \
                common-obj-y \
                common-obj-m \
                slirp-obj-y)
-target-obj-y := $(target-obj-y-save)
 all-obj-y += $(common-obj-y)
-all-obj-y += $(target-obj-y)
 all-obj-y += $(qom-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(block-obj-y) $(chardev-obj-y)
 all-obj-$(CONFIG_USER_ONLY) += $(crypto-aes-obj-y)
diff --git a/trace/Makefile.objs b/trace/Makefile.objs
index afd571c..c544509 100644
--- a/trace/Makefile.objs
+++ b/trace/Makefile.objs
@@ -36,7 +36,7 @@ $(obj)/generated-helpers.c-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/conf
 
 $(obj)/generated-helpers.o: $(obj)/generated-helpers.c
 
-target-obj-y += generated-helpers.o
+obj-y += generated-helpers.o
 
 
 $(obj)/generated-tcg-tracers.h: $(obj)/generated-tcg-tracers.h-timestamp
@@ -55,5 +55,5 @@ $(obj)/generated-tcg-tracers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/
 util-obj-$(CONFIG_TRACE_SIMPLE) += simple.o
 util-obj-$(CONFIG_TRACE_FTRACE) += ftrace.o
 util-obj-y += control.o
-target-obj-y += control-target.o
+obj-y += control-target.o
 util-obj-y += qmp.o
-- 
1.8.3.1
