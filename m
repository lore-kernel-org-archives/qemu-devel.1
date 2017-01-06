Received: from eggs.gnu.org ([2001:4830:134:3::10]:47521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWt9-0005Hy-1d
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:57:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cPWt7-0005Vi-9r
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:57:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41878)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cPWt7-0005VF-0i
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:57:05 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 22D2C31B31F
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:57:05 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri,  6 Jan 2017 15:55:41 +0000
Message-Id: <20170106155543.12827-46-berrange@redhat.com>
In-Reply-To: <20170106155543.12827-1-berrange@redhat.com>
References: <20170106155543.12827-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v2 45/47] trace: remove the global
 include/trace.h file
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

Switch to generating top level trace.[hc] files, instead
of using include/trace.h with trace/generated-tracers.[ch],
so the top level directory works in the same manner as
all the sub-dirs.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 .gitignore                               | 10 ++--
 Makefile                                 | 64 +++++++++++++++++------
 Makefile.objs                            |  8 +--
 include/trace.h                          |  6 ---
 scripts/tracetool/backend/dtrace.py      |  7 +--
 scripts/tracetool/backend/ust.py         |  7 +--
 scripts/tracetool/format/ust_events_c.py |  2 +-
 scripts/tracetool/format/ust_events_h.py |  2 +-
 trace/Makefile.objs                      | 90 --------------------------------
 9 files changed, 61 insertions(+), 135 deletions(-)
 delete mode 100644 include/trace.h

diff --git a/.gitignore b/.gitignore
index fe6add3..79ae620 100644
--- a/.gitignore
+++ b/.gitignore
@@ -6,18 +6,14 @@
 /config.status
 /config-temp
 /trace-events-all
-/trace/generated-tracers.h
-/trace/generated-tracers.c
-/trace/generated-tracers-dtrace.h
-/trace/generated-tracers.dtrace
 /trace/generated-events.h
 /trace/generated-events.c
 /trace/generated-helpers-wrappers.h
 /trace/generated-helpers.h
 /trace/generated-helpers.c
 /trace/generated-tcg-tracers.h
-/trace/generated-ust-provider.h
-/trace/generated-ust.c
+/trace/trace-ust-all.h
+/trace/trace-ust-all.c
 /ui/shader/texture-blit-frag.h
 /ui/shader/texture-blit-vert.h
 *-timestamp
@@ -113,7 +109,7 @@ docker-src.*
 *~
 trace.h
 trace.c
-trace-events-common
+trace-ust.h
 trace-ust.h
 trace-dtrace.h
 trace-dtrace.dtrace
diff --git a/Makefile b/Makefile
index 181802b..c3bf6cd 100644
--- a/Makefile
+++ b/Makefile
@@ -56,35 +56,28 @@ GENERATED_SOURCES += qmp-marshal.c qapi-types.c qapi-visit.c qapi-event.c
 GENERATED_HEADERS += qmp-introspect.h
 GENERATED_SOURCES += qmp-introspect.c
 
-GENERATED_HEADERS += trace/generated-tracers.h
-ifeq ($(findstring dtrace,$(TRACE_BACKENDS)),dtrace)
-GENERATED_HEADERS += trace/generated-tracers-dtrace.h
-endif
-GENERATED_SOURCES += trace/generated-tracers.c
-
 GENERATED_HEADERS += trace/generated-tcg-tracers.h
 
 GENERATED_HEADERS += trace/generated-helpers-wrappers.h
 GENERATED_HEADERS += trace/generated-helpers.h
 GENERATED_SOURCES += trace/generated-helpers.c
 
-ifeq ($(findstring ust,$(TRACE_BACKENDS)),ust)
-GENERATED_HEADERS += trace/generated-ust-provider.h
-GENERATED_HEADERS += trace/generated-ust-provider-all.h
-GENERATED_SOURCES += trace/generated-ust.c
+ifdef CONFIG_TRACE_UST
+GENERATED_HEADERS += trace-ust-all.h
+GENERATED_SOURCES += trace-ust-all.c
 endif
 
 GENERATED_HEADERS += module_block.h
 
-GENERATED_HEADERS += $(trace-events-subdirs:%=%/trace.h)
-GENERATED_SOURCES += $(trace-events-subdirs:%=%/trace.c)
+GENERATED_HEADERS += trace.h $(trace-events-subdirs:%=%/trace.h)
+GENERATED_SOURCES += trace.c $(trace-events-subdirs:%=%/trace.c)
 GENERATED_DTRACE =
 ifdef CONFIG_TRACE_DTRACE
-GENERATED_HEADERS += $(trace-events-subdirs:%=%/trace-dtrace.h)
-GENERATED_DTRACE += $(trace-events-subdirs:%=%/trace-dtrace.dtrace)
+GENERATED_HEADERS += trace-dtrace.h $(trace-events-subdirs:%=%/trace-dtrace.h)
+GENERATED_DTRACE += trace-dtrace.dtrace $(trace-events-subdirs:%=%/trace-dtrace.dtrace)
 endif
 ifdef CONFIG_TRACE_UST
-GENERATED_HEADERS += $(trace-events-subdirs:%=%/trace-ust.h)
+GENERATED_HEADERS += trace-ust.h $(trace-events-subdirs:%=%/trace-ust.h)
 endif
 
 %/trace.h: $(SRC_PATH)/%/trace-events $(tracetool-y)
@@ -117,6 +110,47 @@ endif
 %/trace-dtrace.o: %/trace-dtrace.dtrace $(tracetool-y)
 
 
+trace.h: $(SRC_PATH)/trace-events $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--format=h \
+		--backends=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$@")
+
+trace.c: $(SRC_PATH)/trace-events $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--format=c \
+		--backends=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$@")
+
+trace-ust.h: $(SRC_PATH)/trace-events $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--format=ust-events-h \
+		--backends=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$@")
+
+trace-ust-all.h: $(BUILD_DIR)/trace-events-all $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--format=ust-events-h \
+		--backends=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$@")
+
+trace-ust-all.c: $(BUILD_DIR)/trace-events-all $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--format=ust-events-c \
+		--backends=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$@")
+
+trace-dtrace.dtrace: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--format=d \
+		--backends=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$@")
+
+trace-dtrace.h: trace-dtrace.dtrace
+	$(call quiet-command,dtrace -o $@ -h -s $<, "GEN","$@")
+
+trace-dtrace.o: trace-dtrace.dtrace
+
 # Don't try to regenerate Makefile or configure
 # We don't generate any of them
 Makefile: ;
diff --git a/Makefile.objs b/Makefile.objs
index e8cbaa2..b53a6fb 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -119,7 +119,6 @@ ivshmem-server-obj-y = contrib/ivshmem-server/
 
 ######################################################################
 trace-events-subdirs =
-trace-events-y = trace-events
 trace-events-subdirs += util
 trace-events-subdirs += crypto
 trace-events-subdirs += io
@@ -164,6 +163,9 @@ trace-events-subdirs += qom
 trace-events-subdirs += linux-user
 trace-events-subdirs += qapi
 
-trace-events-files = $(trace-events-y) $(trace-events-subdirs:%=%/trace-events)
+trace-events-files = trace-events $(trace-events-subdirs:%=%/trace-events)
 
-trace-obj-y = $(trace-events-subdirs:%=%/)
+trace-obj-y = trace.o
+trace-obj-$(CONFIG_TRACE_UST) += trace-ust-all.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace.o
+trace-obj-y += $(trace-events-subdirs:%=%/)
diff --git a/include/trace.h b/include/trace.h
deleted file mode 100644
index ac9ff3d..0000000
--- a/include/trace.h
+++ /dev/null
@@ -1,6 +0,0 @@
-#ifndef TRACE_H
-#define TRACE_H
-
-#include "trace/generated-tracers.h"
-
-#endif /* TRACE_H */
diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backend/dtrace.py
index 1319990..6df33fc 100644
--- a/scripts/tracetool/backend/dtrace.py
+++ b/scripts/tracetool/backend/dtrace.py
@@ -36,12 +36,7 @@ def binary():
 
 
 def generate_h_begin(events, group):
-    if group == "common":
-        include = "trace/generated-tracers-dtrace.h"
-    else:
-        include = "trace-dtrace.h"
-
-    out('#include "%s"' % include,
+    out('#include "trace-dtrace.h"',
         '')
 
 
diff --git a/scripts/tracetool/backend/ust.py b/scripts/tracetool/backend/ust.py
index 599c12e..92b2837 100644
--- a/scripts/tracetool/backend/ust.py
+++ b/scripts/tracetool/backend/ust.py
@@ -20,13 +20,8 @@ PUBLIC = True
 
 
 def generate_h_begin(events, group):
-    if group == "common":
-        include = "trace/generated-ust-provider.h"
-    else:
-        include = "trace-ust.h"
-
     out('#include <lttng/tracepoint.h>',
-        '#include "%s"' % include,
+        '#include "trace-ust.h"',
         '')
 
 
diff --git a/scripts/tracetool/format/ust_events_c.py b/scripts/tracetool/format/ust_events_c.py
index 8be8116..264784c 100644
--- a/scripts/tracetool/format/ust_events_c.py
+++ b/scripts/tracetool/format/ust_events_c.py
@@ -32,4 +32,4 @@ def generate(events, backend, group):
         ' */',
         '#pragma GCC diagnostic ignored "-Wredundant-decls"',
         '',
-        '#include "generated-ust-provider-all.h"')
+        '#include "trace-ust-all.h"')
diff --git a/scripts/tracetool/format/ust_events_h.py b/scripts/tracetool/format/ust_events_h.py
index 6fbdb9f..80574ed 100644
--- a/scripts/tracetool/format/ust_events_h.py
+++ b/scripts/tracetool/format/ust_events_h.py
@@ -21,7 +21,7 @@ def generate(events, backend, group):
               if "disabled" not in e.properties]
 
     if group == "common":
-        include = "generated-ust-provider.h"
+        include = "trace-ust-all.h"
     else:
         include = "trace-ust.h"
 
diff --git a/trace/Makefile.objs b/trace/Makefile.objs
index 4522914..5fb70b2 100644
--- a/trace/Makefile.objs
+++ b/trace/Makefile.objs
@@ -11,94 +11,6 @@ tracetool-y += $(shell find $(SRC_PATH)/scripts/tracetool -name "*.py")
 $(BUILD_DIR)/trace-events-all: $(trace-events-files:%=$(SRC_PATH)/%)
 	$(call quiet-command,cat $^ > $@)
 
-$(BUILD_DIR)/trace-events-common: $(trace-events-y:%=$(SRC_PATH)/%) Makefile.objs
-	$(call quiet-command,cat $(trace-events-y:%=$(SRC_PATH)/%) > $@)
-
-######################################################################
-# Auto-generated event descriptions for LTTng ust code
-
-ifeq ($(findstring ust,$(TRACE_BACKENDS)),ust)
-
-$(obj)/generated-ust-provider.h: $(obj)/generated-ust-provider.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-ust-provider.h-timestamp: $(BUILD_DIR)/trace-events-common $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--format=ust-events-h \
-		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-$(obj)/generated-ust-provider-all.h: $(obj)/generated-ust-provider-all.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-ust-provider-all.h-timestamp: $(BUILD_DIR)/trace-events-all $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--format=ust-events-h \
-		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-$(obj)/generated-ust.c: $(obj)/generated-ust.c-timestamp $(BUILD_DIR)/config-host.mak
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-ust.c-timestamp: $(BUILD_DIR)/trace-events-all $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--format=ust-events-c \
-		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-$(obj)/generated-tracers.h: $(obj)/generated-ust-provider.h $(obj)/generated-ust-provider-all.h
-$(obj)/generated-tracers.c: $(obj)/generated-ust.c
-
-endif
-
-
-######################################################################
-# Auto-generated tracing routines
-
-##################################################
-# Execution level
-
-$(obj)/generated-tracers.h: $(obj)/generated-tracers.h-timestamp
-	@cmp -s $< $@ || cp $< $@
-$(obj)/generated-tracers.h-timestamp: $(BUILD_DIR)/trace-events-common $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--format=h \
-		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-##############################
-# non-DTrace
-
-$(obj)/generated-tracers.c: $(obj)/generated-tracers.c-timestamp
-	@cmp -s $< $@ || cp $< $@
-$(obj)/generated-tracers.c-timestamp: $(BUILD_DIR)/trace-events-common $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--format=c \
-		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-$(obj)/generated-tracers.o: $(obj)/generated-tracers.c $(obj)/generated-tracers.h
-
-##############################
-# DTrace
-
-# Normal practice is to name DTrace probe file with a '.d' extension
-# but that gets picked up by QEMU's Makefile as an external dependency
-# rule file. So we use '.dtrace' instead
-ifeq ($(findstring dtrace,$(TRACE_BACKENDS)),dtrace)
-
-$(obj)/generated-tracers-dtrace.dtrace: $(obj)/generated-tracers-dtrace.dtrace-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-tracers-dtrace.dtrace-timestamp: $(BUILD_DIR)/trace-events-common $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--format=d \
-		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-$(obj)/generated-tracers-dtrace.h: $(obj)/generated-tracers-dtrace.dtrace
-	$(call quiet-command,dtrace -o $@ -h -s $<,"GEN","$@")
-
-$(obj)/generated-tracers-dtrace.o: $(obj)/generated-tracers-dtrace.dtrace
-
-util-obj-y += generated-tracers-dtrace.o
-endif
 
 ##################################################
 # Translation level
@@ -144,10 +56,8 @@ $(obj)/generated-tcg-tracers.h-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_
 ######################################################################
 # Backend code
 
-util-obj-y += generated-tracers.o
 util-obj-$(CONFIG_TRACE_SIMPLE) += simple.o
 util-obj-$(CONFIG_TRACE_FTRACE) += ftrace.o
-util-obj-$(CONFIG_TRACE_UST) += generated-ust.o
 util-obj-y += control.o
 target-obj-y += control-target.o
 util-obj-y += qmp.o
-- 
2.9.3
