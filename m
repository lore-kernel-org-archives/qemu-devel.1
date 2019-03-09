Received: from eggs.gnu.org ([209.51.188.92]:47346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wih-0003tJ-Dy
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1h2Wig-0000X1-Fd
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:35 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:34764)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1h2Wig-0000V3-5c
	for qemu-devel@nongnu.org; Sat, 09 Mar 2019 02:48:34 -0500
Received: by mail-wm1-x331.google.com with SMTP id o10so10308183wmc.1
	for <qemu-devel@nongnu.org>; Fri, 08 Mar 2019 23:48:33 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
	by smtp.gmail.com with ESMTPSA id 11sm5252294wmg.27.2019.03.08.23.48.31
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 08 Mar 2019 23:48:31 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Sat,  9 Mar 2019 08:48:06 +0100
Message-Id: <1552117698-12355-14-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
References: <1552117698-12355-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 13/25] build: get rid of target-obj-y
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

It is possible to specify the trace/ directory already in objs-y;
there is no need to have a separate unnest-vars invocation.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.objs       | 1 -
 Makefile.target     | 7 ++-----
 trace/Makefile.objs | 4 ++--
 3 files changed, 4 insertions(+), 8 deletions(-)

diff --git a/Makefile.objs b/Makefile.objs
index ef65a6c..acc53aa 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -101,7 +101,6 @@ version-obj-$(CONFIG_WIN32) += $(BUILD_DIR)/version.o
 ######################################################################
 # tracing
 util-obj-y +=  trace/
-target-obj-y += trace/
 
 ######################################################################
 # guest agent
diff --git a/Makefile.target b/Makefile.target
index 40830c5..a458506 100644
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
@@ -173,13 +175,10 @@ endif # CONFIG_SOFTMMU
 dummy := $(call unnest-vars,,obj-y)
 all-obj-y := $(obj-y)
 
-target-obj-y :=
 block-obj-y :=
 common-obj-y :=
 chardev-obj-y :=
 include $(SRC_PATH)/Makefile.objs
-dummy := $(call unnest-vars,,target-obj-y)
-target-obj-y-save := $(target-obj-y)
 dummy := $(call unnest-vars,.., \
                authz-obj-y \
                block-obj-y \
@@ -191,9 +190,7 @@ dummy := $(call unnest-vars,.., \
                io-obj-y \
                common-obj-y \
                common-obj-m)
-target-obj-y := $(target-obj-y-save)
 all-obj-y += $(common-obj-y)
-all-obj-y += $(target-obj-y)
 all-obj-y += $(qom-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(authz-obj-y)
 all-obj-$(CONFIG_SOFTMMU) += $(block-obj-y) $(chardev-obj-y)
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
