Received: from eggs.gnu.org ([2001:4830:134:3::10]:38449)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coPSk-0001uh-Do
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:04:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1coPSj-0005zi-9X
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:04:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1coPSj-0005zc-0m
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 03:04:41 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Thu, 16 Mar 2017 15:04:25 +0800
Message-Id: <20170316070427.17120-2-stefanha@redhat.com>
In-Reply-To: <20170316070427.17120-1-stefanha@redhat.com>
References: <20170316070427.17120-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 1/3] makefile: merge GENERATED_HEADERS &
 GENERATED_SOURCES variables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, "Daniel P. Berrange" <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>

From: "Daniel P. Berrange" <berrange@redhat.com>

The only functional difference between the GENERATED_HEADERS
and GENERATED_SOURCES variables is that 'Makefile' has a
dependancy on GENERATED_HEADERS, causing generated header files
to be created immediatey at the start of the build process.
There is no reason why this early creation should be restricted
to the .h files, and not include .c files too. Merge both of
the variables into a single GENERATED_FILES variable to make
it clear it is for any type of generated file.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Message-id: 20170228122901.24520-2-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile                   | 35 +++++++++++++++++------------------
 Makefile.target            |  6 +++---
 target/s390x/Makefile.objs |  2 +-
 tests/Makefile.include     |  2 +-
 4 files changed, 22 insertions(+), 23 deletions(-)

diff --git a/Makefile b/Makefile
index 1c4c04f..a8024c0 100644
--- a/Makefile
+++ b/Makefile
@@ -50,24 +50,24 @@ endif
 
 include $(SRC_PATH)/rules.mak
 
-GENERATED_HEADERS = qemu-version.h config-host.h qemu-options.def
-GENERATED_HEADERS += qmp-commands.h qapi-types.h qapi-visit.h qapi-event.h
-GENERATED_SOURCES += qmp-marshal.c qapi-types.c qapi-visit.c qapi-event.c
-GENERATED_HEADERS += qmp-introspect.h
-GENERATED_SOURCES += qmp-introspect.c
+GENERATED_FILES = qemu-version.h config-host.h qemu-options.def
+GENERATED_FILES += qmp-commands.h qapi-types.h qapi-visit.h qapi-event.h
+GENERATED_FILES += qmp-marshal.c qapi-types.c qapi-visit.c qapi-event.c
+GENERATED_FILES += qmp-introspect.h
+GENERATED_FILES += qmp-introspect.c
 
-GENERATED_HEADERS += trace/generated-tcg-tracers.h
+GENERATED_FILES += trace/generated-tcg-tracers.h
 
-GENERATED_HEADERS += trace/generated-helpers-wrappers.h
-GENERATED_HEADERS += trace/generated-helpers.h
-GENERATED_SOURCES += trace/generated-helpers.c
+GENERATED_FILES += trace/generated-helpers-wrappers.h
+GENERATED_FILES += trace/generated-helpers.h
+GENERATED_FILES += trace/generated-helpers.c
 
 ifdef CONFIG_TRACE_UST
-GENERATED_HEADERS += trace-ust-all.h
-GENERATED_SOURCES += trace-ust-all.c
+GENERATED_FILES += trace-ust-all.h
+GENERATED_FILES += trace-ust-all.c
 endif
 
-GENERATED_HEADERS += module_block.h
+GENERATED_FILES += module_block.h
 
 TRACE_HEADERS = trace-root.h $(trace-events-subdirs:%=%/trace.h)
 TRACE_SOURCES = trace-root.c $(trace-events-subdirs:%=%/trace.c)
@@ -80,8 +80,8 @@ ifdef CONFIG_TRACE_UST
 TRACE_HEADERS += trace-ust-root.h $(trace-events-subdirs:%=%/trace-ust.h)
 endif
 
-GENERATED_HEADERS += $(TRACE_HEADERS)
-GENERATED_SOURCES += $(TRACE_SOURCES)
+GENERATED_FILES += $(TRACE_HEADERS)
+GENERATED_FILES += $(TRACE_SOURCES)
 
 trace-group-name = $(shell dirname $1 | sed -e 's/[^a-zA-Z0-9]/_/g')
 
@@ -485,11 +485,10 @@ clean:
 	rm -f fsdev/*.pod
 	rm -f qemu-img-cmds.h
 	rm -f ui/shader/*-vert.h ui/shader/*-frag.h
-	@# May not be present in GENERATED_HEADERS
+	@# May not be present in GENERATED_FILES
 	rm -f trace/generated-tracers-dtrace.dtrace*
 	rm -f trace/generated-tracers-dtrace.h*
-	rm -f $(foreach f,$(GENERATED_HEADERS),$(f) $(f)-timestamp)
-	rm -f $(foreach f,$(GENERATED_SOURCES),$(f) $(f)-timestamp)
+	rm -f $(foreach f,$(GENERATED_FILES),$(f) $(f)-timestamp)
 	rm -rf qapi-generated
 	rm -rf qga/qapi-generated
 	for d in $(ALL_SUBDIRS); do \
@@ -784,7 +783,7 @@ endif # CONFIG_WIN
 # Add a dependency on the generated files, so that they are always
 # rebuilt before other object files
 ifneq ($(filter-out $(UNCHECKED_GOALS),$(MAKECMDGOALS)),$(if $(MAKECMDGOALS),,fail))
-Makefile: $(GENERATED_HEADERS)
+Makefile: $(GENERATED_FILES)
 endif
 
 .SECONDARY: $(TRACE_HEADERS) $(TRACE_HEADERS:%=%-timestamp) \
diff --git a/Makefile.target b/Makefile.target
index 924304c..7df2b8c 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -162,7 +162,7 @@ else
 obj-y += hw/$(TARGET_BASE_ARCH)/
 endif
 
-GENERATED_HEADERS += hmp-commands.h hmp-commands-info.h
+GENERATED_FILES += hmp-commands.h hmp-commands-info.h
 
 endif # CONFIG_SOFTMMU
 
@@ -238,5 +238,5 @@ ifdef CONFIG_TRACE_SYSTEMTAP
 	$(INSTALL_DATA) $(QEMU_PROG)-simpletrace.stp "$(DESTDIR)$(qemu_datadir)/../systemtap/tapset/$(QEMU_PROG)-simpletrace.stp"
 endif
 
-GENERATED_HEADERS += config-target.h
-Makefile: $(GENERATED_HEADERS)
+GENERATED_FILES += config-target.h
+Makefile: $(GENERATED_FILES)
diff --git a/target/s390x/Makefile.objs b/target/s390x/Makefile.objs
index c573633..46f6a8c 100644
--- a/target/s390x/Makefile.objs
+++ b/target/s390x/Makefile.objs
@@ -8,7 +8,7 @@ obj-$(CONFIG_KVM) += kvm.o
 feat-src = $(SRC_PATH)/target/$(TARGET_BASE_ARCH)/
 feat-dst = $(BUILD_DIR)/$(TARGET_DIR)
 ifneq ($(MAKECMDGOALS),clean)
-GENERATED_HEADERS += $(feat-dst)gen-features.h
+GENERATED_FILES += $(feat-dst)gen-features.h
 endif
 
 $(feat-dst)gen-features.h: $(feat-dst)gen-features.h-timestamp
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 346345e..479dcd9 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -482,7 +482,7 @@ qapi-schema += unknown-expr-key.json
 
 check-qapi-schema-y := $(addprefix tests/qapi-schema/, $(qapi-schema))
 
-GENERATED_HEADERS += tests/test-qapi-types.h tests/test-qapi-visit.h \
+GENERATED_FILES += tests/test-qapi-types.h tests/test-qapi-visit.h \
 	tests/test-qmp-commands.h tests/test-qapi-event.h \
 	tests/test-qmp-introspect.h
 
-- 
2.9.3
