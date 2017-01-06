Received: from eggs.gnu.org ([2001:4830:134:3::10]:46837)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWrz-0003jk-8e
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:55:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWrv-0004mp-Vj
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:55:55 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWrv-0004mc-NA
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:55:51 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C725C8124A
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:55:51 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:54:57 +0000
Message-Id: <20170106155543.12827-2-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 01/47] trace: introduce some Makefile rules
 for module code gen
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

Introduce rules that are able to generate trace.[ch] files
in every subdirectory which has a trace-events file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 .gitignore                               |  6 +++
 Makefile                                 | 65 +++++++++++++++++++++++++++-----
 Makefile.objs                            |  5 +++
 Makefile.target                          |  7 +++-
 scripts/tracetool/backend/dtrace.py      |  7 +++-
 scripts/tracetool/backend/ust.py         |  7 +++-
 scripts/tracetool/format/ust_events_c.py |  2 +-
 scripts/tracetool/format/ust_events_h.py |  7 +++-
 tests/Makefile.include                   |  2 +-
 trace/Makefile.objs                      | 23 ++++++++---
 10 files changed, 109 insertions(+), 22 deletions(-)

diff --git a/.gitignore b/.gitignore
index e43c304..fe6add3 100644
--- a/.gitignore
+++ b/.gitignore
@@ -111,3 +111,9 @@ tags
 TAGS
 docker-src.*
 *~
+trace.h
+trace.c
+trace-events-common
+trace-ust.h
+trace-dtrace.h
+trace-dtrace.dtrace
diff --git a/Makefile b/Makefile
index 214cbad..181802b 100644
--- a/Makefile
+++ b/Makefile
@@ -70,11 +70,53 @@ GENERATED_SOURCES += trace/generated-helpers.c
 
 ifeq ($(findstring ust,$(TRACE_BACKENDS)),ust)
 GENERATED_HEADERS += trace/generated-ust-provider.h
+GENERATED_HEADERS += trace/generated-ust-provider-all.h
 GENERATED_SOURCES += trace/generated-ust.c
 endif
 
 GENERATED_HEADERS += module_block.h
 
+GENERATED_HEADERS += $(trace-events-subdirs:%=%/trace.h)
+GENERATED_SOURCES += $(trace-events-subdirs:%=%/trace.c)
+GENERATED_DTRACE =
+ifdef CONFIG_TRACE_DTRACE
+GENERATED_HEADERS += $(trace-events-subdirs:%=%/trace-dtrace.h)
+GENERATED_DTRACE += $(trace-events-subdirs:%=%/trace-dtrace.dtrace)
+endif
+ifdef CONFIG_TRACE_UST
+GENERATED_HEADERS += $(trace-events-subdirs:%=%/trace-ust.h)
+endif
+
+%/trace.h: $(SRC_PATH)/%/trace-events $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--format=h \
+		--backends=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$@")
+
+%/trace.c: $(SRC_PATH)/%/trace-events $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--format=c \
+		--backends=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$@")
+
+%/trace-ust.h: $(SRC_PATH)/%/trace-events $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--format=ust-events-h \
+		--backends=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$@")
+
+%/trace-dtrace.dtrace: $(SRC_PATH)/%/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--format=d \
+		--backends=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$@")
+
+%/trace-dtrace.h: %/trace-dtrace.dtrace $(tracetool-y)
+	$(call quiet-command,dtrace -o $@ -h -s $<, "GEN","$@")
+
+%/trace-dtrace.o: %/trace-dtrace.dtrace $(tracetool-y)
+
+
 # Don't try to regenerate Makefile or configure
 # We don't generate any of them
 Makefile: ;
@@ -157,7 +199,8 @@ dummy := $(call unnest-vars,, \
                 qom-obj-y \
                 io-obj-y \
                 common-obj-y \
-                common-obj-m)
+                common-obj-m \
+                trace-obj-y)
 
 ifneq ($(wildcard config-host.mak),)
 include $(SRC_PATH)/tests/Makefile.include
@@ -244,15 +287,17 @@ libqemuutil.a: $(util-obj-y)
 
 ######################################################################
 
+COMMON_LDADDS = $(trace-obj-y) libqemuutil.a libqemustub.a
+
 qemu-img.o: qemu-img-cmds.h
 
-qemu-img$(EXESUF): qemu-img.o $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) libqemuutil.a libqemustub.a
-qemu-nbd$(EXESUF): qemu-nbd.o $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) libqemuutil.a libqemustub.a
-qemu-io$(EXESUF): qemu-io.o $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) libqemuutil.a libqemustub.a
+qemu-img$(EXESUF): qemu-img.o $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+qemu-nbd$(EXESUF): qemu-nbd.o $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
+qemu-io$(EXESUF): qemu-io.o $(block-obj-y) $(crypto-obj-y) $(io-obj-y) $(qom-obj-y) $(COMMON_LDADDS)
 
-qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o libqemuutil.a libqemustub.a
+qemu-bridge-helper$(EXESUF): qemu-bridge-helper.o $(COMMON_LDADDS)
 
-fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal.o fsdev/9p-iov-marshal.o libqemuutil.a libqemustub.a
+fsdev/virtfs-proxy-helper$(EXESUF): fsdev/virtfs-proxy-helper.o fsdev/9p-marshal.o fsdev/9p-iov-marshal.o $(COMMON_LDADDS)
 fsdev/virtfs-proxy-helper$(EXESUF): LIBS += -lcap
 
 qemu-img-cmds.h: $(SRC_PATH)/qemu-img-cmds.hx $(SRC_PATH)/scripts/hxtool
@@ -316,7 +361,7 @@ $(qapi-modules) $(SRC_PATH)/scripts/qapi-introspect.py $(qapi-py)
 QGALIB_GEN=$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-visit.h qga-qmp-commands.h)
 $(qga-obj-y) qemu-ga.o: $(QGALIB_GEN)
 
-qemu-ga$(EXESUF): $(qga-obj-y) libqemuutil.a libqemustub.a
+qemu-ga$(EXESUF): $(qga-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 
 ifdef QEMU_GA_MSI_ENABLED
@@ -341,9 +386,9 @@ ifneq ($(EXESUF),)
 qemu-ga: qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
 endif
 
-ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) libqemuutil.a libqemustub.a
+ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
-ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) libqemuutil.a libqemustub.a
+ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
@@ -657,6 +702,8 @@ ifneq ($(filter-out $(UNCHECKED_GOALS),$(MAKECMDGOALS)),$(if $(MAKECMDGOALS),,fa
 Makefile: $(GENERATED_HEADERS)
 endif
 
+.SECONDARY: $(GENERATED_HEADERS) $(GENERATED_SOURCES) $(GENERATED_DTRACE)
+
 # Include automatically generated dependency files
 # Dependencies in Makefile.objs files come from our recursive subdir rules
 -include $(wildcard *.d tests/*.d)
diff --git a/Makefile.objs b/Makefile.objs
index 51c36a4..fc398d5 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -118,6 +118,7 @@ ivshmem-server-obj-y = contrib/ivshmem-server/
 
 
 ######################################################################
+trace-events-subdirs =
 trace-events-y = trace-events
 trace-events-y += util/trace-events
 trace-events-y += crypto/trace-events
@@ -162,3 +163,7 @@ trace-events-y += target/ppc/trace-events
 trace-events-y += qom/trace-events
 trace-events-y += linux-user/trace-events
 trace-events-y += qapi/trace-events
+
+trace-events-files = $(trace-events-y) $(trace-events-subdirs:%=%/trace-events)
+
+trace-obj-y = $(trace-events-subdirs:%=%/)
diff --git a/Makefile.target b/Makefile.target
index 8ae82cb..b14ab45 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -182,7 +182,8 @@ dummy := $(call unnest-vars,.., \
                qom-obj-y \
                io-obj-y \
                common-obj-y \
-               common-obj-m)
+               common-obj-m \
+               trace-obj-y)
 target-obj-y := $(target-obj-y-save)
 all-obj-y += $(common-obj-y)
 all-obj-y += $(target-obj-y)
@@ -194,8 +195,10 @@ all-obj-$(CONFIG_SOFTMMU) += $(io-obj-y)
 
 $(QEMU_PROG_BUILD): config-devices.mak
 
+COMMON_LDADDS = $(trace-obj-y) ../libqemuutil.a ../libqemustub.a
+
 # build either PROG or PROGW
-$(QEMU_PROG_BUILD): $(all-obj-y) ../libqemuutil.a ../libqemustub.a
+$(QEMU_PROG_BUILD): $(all-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $(filter-out %.mak, $^))
 ifdef CONFIG_DARWIN
 	$(call quiet-command,Rez -append $(SRC_PATH)/pc-bios/qemu.rsrc -o $@,"REZ","$(TARGET_DIR)$@")
diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backend/dtrace.py
index 79505c6..1319990 100644
--- a/scripts/tracetool/backend/dtrace.py
+++ b/scripts/tracetool/backend/dtrace.py
@@ -36,7 +36,12 @@ def binary():
 
 
 def generate_h_begin(events, group):
-    out('#include "trace/generated-tracers-dtrace.h"',
+    if group == "common":
+        include = "trace/generated-tracers-dtrace.h"
+    else:
+        include = "trace-dtrace.h"
+
+    out('#include "%s"' % include,
         '')
 
 
diff --git a/scripts/tracetool/backend/ust.py b/scripts/tracetool/backend/ust.py
index 4594db6..599c12e 100644
--- a/scripts/tracetool/backend/ust.py
+++ b/scripts/tracetool/backend/ust.py
@@ -20,8 +20,13 @@ PUBLIC = True
 
 
 def generate_h_begin(events, group):
+    if group == "common":
+        include = "trace/generated-ust-provider.h"
+    else:
+        include = "trace-ust.h"
+
     out('#include <lttng/tracepoint.h>',
-        '#include "trace/generated-ust-provider.h"',
+        '#include "%s"' % include,
         '')
 
 
diff --git a/scripts/tracetool/format/ust_events_c.py b/scripts/tracetool/format/ust_events_c.py
index cd87d8a..8be8116 100644
--- a/scripts/tracetool/format/ust_events_c.py
+++ b/scripts/tracetool/format/ust_events_c.py
@@ -32,4 +32,4 @@ def generate(events, backend, group):
         ' */',
         '#pragma GCC diagnostic ignored "-Wredundant-decls"',
         '',
-        '#include "generated-ust-provider.h"')
+        '#include "generated-ust-provider-all.h"')
diff --git a/scripts/tracetool/format/ust_events_h.py b/scripts/tracetool/format/ust_events_h.py
index d853155..6fbdb9f 100644
--- a/scripts/tracetool/format/ust_events_h.py
+++ b/scripts/tracetool/format/ust_events_h.py
@@ -20,13 +20,18 @@ def generate(events, backend, group):
     events = [e for e in events
               if "disabled" not in e.properties]
 
+    if group == "common":
+        include = "generated-ust-provider.h"
+    else:
+        include = "trace-ust.h"
+
     out('/* This file is autogenerated by tracetool, do not edit. */',
         '',
         '#undef TRACEPOINT_PROVIDER',
         '#define TRACEPOINT_PROVIDER qemu',
         '',
         '#undef TRACEPOINT_INCLUDE_FILE',
-        '#define TRACEPOINT_INCLUDE_FILE ./generated-ust-provider.h',
+        '#define TRACEPOINT_INCLUDE_FILE ./%s' % include,
         '',
         '#if !defined (TRACE_%s_GENERATED_UST_H) || \\'  % group.upper(),
         '     defined(TRACEPOINT_HEADER_MULTI_READ)',
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 4841d58..c255e65 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -470,7 +470,7 @@ QEMU_CFLAGS += -I$(SRC_PATH)/tests
 
 
 # Deps that are common to various different sets of tests below
-test-util-obj-y = libqemuutil.a libqemustub.a
+test-util-obj-y = $(trace-obj-y) libqemuutil.a libqemustub.a
 test-qom-obj-y = $(qom-obj-y) $(test-util-obj-y)
 test-qapi-obj-y = tests/test-qapi-visit.o tests/test-qapi-types.o \
 	tests/test-qapi-event.o tests/test-qmp-introspect.o \
diff --git a/trace/Makefile.objs b/trace/Makefile.objs
index 1e1ce74..4522914 100644
--- a/trace/Makefile.objs
+++ b/trace/Makefile.objs
@@ -8,9 +8,12 @@
 tracetool-y = $(SRC_PATH)/scripts/tracetool.py
 tracetool-y += $(shell find $(SRC_PATH)/scripts/tracetool -name "*.py")
 
-$(BUILD_DIR)/trace-events-all: $(trace-events-y:%=$(SRC_PATH)/%)
+$(BUILD_DIR)/trace-events-all: $(trace-events-files:%=$(SRC_PATH)/%)
 	$(call quiet-command,cat $^ > $@)
 
+$(BUILD_DIR)/trace-events-common: $(trace-events-y:%=$(SRC_PATH)/%) Makefile.objs
+	$(call quiet-command,cat $(trace-events-y:%=$(SRC_PATH)/%) > $@)
+
 ######################################################################
 # Auto-generated event descriptions for LTTng ust code
 
@@ -18,7 +21,15 @@ ifeq ($(findstring ust,$(TRACE_BACKENDS)),ust)
 
 $(obj)/generated-ust-provider.h: $(obj)/generated-ust-provider.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-ust-provider.h-timestamp: $(BUILD_DIR)/trace-events-all $(tracetool-y)
+$(obj)/generated-ust-provider.h-timestamp: $(BUILD_DIR)/trace-events-common $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--format=ust-events-h \
+		--backends=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
+
+$(obj)/generated-ust-provider-all.h: $(obj)/generated-ust-provider-all.h-timestamp
+	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
+$(obj)/generated-ust-provider-all.h-timestamp: $(BUILD_DIR)/trace-events-all $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--format=ust-events-h \
 		--backends=$(TRACE_BACKENDS) \
@@ -32,7 +43,7 @@ $(obj)/generated-ust.c-timestamp: $(BUILD_DIR)/trace-events-all $(tracetool-y)
 		--backends=$(TRACE_BACKENDS) \
 		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
 
-$(obj)/generated-tracers.h: $(obj)/generated-ust-provider.h
+$(obj)/generated-tracers.h: $(obj)/generated-ust-provider.h $(obj)/generated-ust-provider-all.h
 $(obj)/generated-tracers.c: $(obj)/generated-ust.c
 
 endif
@@ -46,7 +57,7 @@ endif
 
 $(obj)/generated-tracers.h: $(obj)/generated-tracers.h-timestamp
 	@cmp -s $< $@ || cp $< $@
-$(obj)/generated-tracers.h-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)/config-host.mak $(tracetool-y)
+$(obj)/generated-tracers.h-timestamp: $(BUILD_DIR)/trace-events-common $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--format=h \
 		--backends=$(TRACE_BACKENDS) \
@@ -57,7 +68,7 @@ $(obj)/generated-tracers.h-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)
 
 $(obj)/generated-tracers.c: $(obj)/generated-tracers.c-timestamp
 	@cmp -s $< $@ || cp $< $@
-$(obj)/generated-tracers.c-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)/config-host.mak $(tracetool-y)
+$(obj)/generated-tracers.c-timestamp: $(BUILD_DIR)/trace-events-common $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--format=c \
 		--backends=$(TRACE_BACKENDS) \
@@ -75,7 +86,7 @@ ifeq ($(findstring dtrace,$(TRACE_BACKENDS)),dtrace)
 
 $(obj)/generated-tracers-dtrace.dtrace: $(obj)/generated-tracers-dtrace.dtrace-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-tracers-dtrace.dtrace-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)/config-host.mak $(tracetool-y)
+$(obj)/generated-tracers-dtrace.dtrace-timestamp: $(BUILD_DIR)/trace-events-common $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--format=d \
 		--backends=$(TRACE_BACKENDS) \
-- 
2.9.3
