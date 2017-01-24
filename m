Received: from eggs.gnu.org ([2001:4830:134:3::10]:60673)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVyrf-0002mb-0F
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:02:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cVyrb-0008Si-2k
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:02:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53122)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cVyra-0008SS-N4
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 06:02:11 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Tue, 24 Jan 2017 11:01:49 +0000
Message-Id: <20170124110151.937-7-berrange@redhat.com>
In-Reply-To: <20170124110151.937-1-berrange@redhat.com>
References: <20170124110151.937-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v3 6/8] trace: switch to modular code
 generation for sub-directories
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Introduce rules in the top level Makefile that are able to generate
trace.[ch] files in every subdirectory which has a trace-events file.

The top level directory is handled specially, so instead of creating
trace.h, it creates trace-root.h. This allows sub-directories to
include the top level trace-root.h file, without ambiguity wrt to
the trace.g file in the current sub-dir.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 .gitignore                                |  22 +++--
 Makefile                                  | 156 ++++++++++++++++++++++++++----
 Makefile.objs                             | 102 ++++++++++---------
 Makefile.target                           |   7 +-
 aio-posix.c                               |   2 +-
 balloon.c                                 |   2 +-
 block.c                                   |   2 +-
 blockdev-nbd.c                            |   1 -
 blockdev.c                                |   2 +-
 blockjob.c                                |   1 -
 cpu-exec.c                                |   2 +-
 dma-helpers.c                             |   2 +-
 exec.c                                    |   2 +-
 hw/net/fsl_etsec/etsec.c                  |   1 -
 include/exec/cpu_ldst_template.h          |   2 +-
 include/exec/cpu_ldst_useronly_template.h |   2 +-
 include/hw/xen/xen_common.h               |   2 +-
 include/trace.h                           |   6 --
 ioport.c                                  |   2 +-
 kvm-all.c                                 |   2 +-
 memory.c                                  |   2 +-
 monitor.c                                 |   2 +-
 qom/cpu.c                                 |   2 +-
 scripts/tracetool.py                      |   8 +-
 scripts/tracetool/backend/dtrace.py       |   7 +-
 scripts/tracetool/backend/simple.py       |   1 -
 scripts/tracetool/backend/ust.py          |   7 +-
 scripts/tracetool/format/c.py             |   7 +-
 scripts/tracetool/format/tcg_h.py         |   6 +-
 scripts/tracetool/format/tcg_helper_c.py  |   6 +-
 scripts/tracetool/format/ust_events_c.py  |   2 +-
 scripts/tracetool/format/ust_events_h.py  |   7 +-
 spice-qemu-char.c                         |   2 +-
 tests/Makefile.include                    |   2 +-
 thread-pool.c                             |   2 +-
 trace/Makefile.objs                       |  94 +-----------------
 trace/control-target.c                    |   2 +-
 trace/control.c                           |   2 +-
 trace/ftrace.c                            |   2 +-
 trace/simple.c                            |   1 -
 translate-all.c                           |   2 +-
 vl.c                                      |   2 +-
 xen-hvm.c                                 |   2 +-
 xen-mapcache.c                            |   2 +-
 44 files changed, 283 insertions(+), 209 deletions(-)
 delete mode 100644 include/trace.h

diff --git a/.gitignore b/.gitignore
index 78f180a..c563dc1 100644
--- a/.gitignore
+++ b/.gitignore
@@ -6,18 +6,12 @@
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
 /ui/shader/texture-blit-frag.h
 /ui/shader/texture-blit-vert.h
 *-timestamp
@@ -120,3 +114,19 @@ tags
 TAGS
 docker-src.*
 *~
+trace.h
+trace.c
+trace-ust.h
+trace-ust.h
+trace-dtrace.h
+trace-dtrace.dtrace
+trace-root.h
+trace-root.c
+trace-ust-root.h
+trace-ust-root.h
+trace-ust-all.h
+trace-ust-all.c
+trace-dtrace-root.h
+trace-dtrace-root.dtrace
+trace-ust-all.h
+trace-ust-all.c
diff --git a/Makefile b/Makefile
index 9f8968d..a8fa28a 100644
--- a/Makefile
+++ b/Makefile
@@ -56,25 +56,136 @@ GENERATED_SOURCES += qmp-marshal.c qapi-types.c qapi-visit.c qapi-event.c
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
-GENERATED_SOURCES += trace/generated-ust.c
+ifdef CONFIG_TRACE_UST
+GENERATED_HEADERS += trace-ust-all.h
+GENERATED_SOURCES += trace-ust-all.c
 endif
 
 GENERATED_HEADERS += module_block.h
 
+TRACE_HEADERS = trace-root.h $(trace-events-subdirs:%=%/trace.h)
+TRACE_SOURCES = trace-root.c $(trace-events-subdirs:%=%/trace.c)
+TRACE_DTRACE =
+ifdef CONFIG_TRACE_DTRACE
+TRACE_HEADERS += trace-dtrace-root.h $(trace-events-subdirs:%=%/trace-dtrace.h)
+TRACE_DTRACE += trace-dtrace-root.dtrace $(trace-events-subdirs:%=%/trace-dtrace.dtrace)
+endif
+ifdef CONFIG_TRACE_UST
+TRACE_HEADERS += trace-ust-root.h $(trace-events-subdirs:%=%/trace-ust.h)
+endif
+
+GENERATED_HEADERS += $(TRACE_HEADERS)
+GENERATED_SOURCES += $(TRACE_SOURCES)
+
+trace-group-name = $(shell dirname $1 | sed -e 's/[^a-zA-Z0-9]/_/g')
+
+%/trace.h: %/trace.h-timestamp
+	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
+%/trace.h-timestamp: $(SRC_PATH)/%/trace-events $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--group=$(call trace-group-name,$@) \
+		--format=h \
+		--backends=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$(@:%-timestamp=%)")
+
+%/trace.c: %/trace.c-timestamp
+	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
+%/trace.c-timestamp: $(SRC_PATH)/%/trace-events $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--group=$(call trace-group-name,$@) \
+		--format=c \
+		--backends=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$(@:%-timestamp=%)")
+
+%/trace-ust.h: %/trace-ust.h-timestamp
+	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
+%/trace-ust.h-timestamp: $(SRC_PATH)/%/trace-events $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--group=$(call trace-group-name,$@) \
+		--format=ust-events-h \
+		--backends=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$(@:%-timestamp=%)")
+
+%/trace-dtrace.dtrace: %/trace-dtrace.dtrace-timestamp
+	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
+%/trace-dtrace.dtrace-timestamp: $(SRC_PATH)/%/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--group=$(call trace-group-name,$@) \
+		--format=d \
+		--backends=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$(@:%-timestamp=%)")
+
+%/trace-dtrace.h: %/trace-dtrace.dtrace $(tracetool-y)
+	$(call quiet-command,dtrace -o $@ -h -s $<, "GEN","$@")
+
+%/trace-dtrace.o: %/trace-dtrace.dtrace $(tracetool-y)
+
+
+trace-root.h: trace-root.h-timestamp
+	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
+trace-root.h-timestamp: $(SRC_PATH)/trace-events $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--group=root \
+		--format=h \
+		--backends=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$(@:%-timestamp=%)")
+
+trace-root.c: trace-root.c-timestamp
+	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
+trace-root.c-timestamp: $(SRC_PATH)/trace-events $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--group=root \
+		--format=c \
+		--backends=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$(@:%-timestamp=%)")
+
+trace-ust-root.h: trace-ust-root.h-timestamp
+	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
+trace-ust-root.h-timestamp: $(SRC_PATH)/trace-events $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--group=root \
+		--format=ust-events-h \
+		--backends=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$(@:%-timestamp=%)")
+
+trace-ust-all.h: trace-ust-all.h-timestamp
+	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
+trace-ust-all.h-timestamp: $(trace-events-files) $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--group=all \
+		--format=ust-events-h \
+		--backends=$(TRACE_BACKENDS) \
+		$(trace-events-files) > $@,"GEN","$(@:%-timestamp=%)")
+
+trace-ust-all.c: trace-ust-all.c-timestamp
+	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
+trace-ust-all.c-timestamp: $(trace-events-files) $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--group=all \
+		--format=ust-events-c \
+		--backends=$(TRACE_BACKENDS) \
+		$(trace-events-files) > $@,"GEN","$(@:%-timestamp=%)")
+
+trace-dtrace-root.dtrace: trace-dtrace-root.dtrace-timestamp
+	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
+trace-dtrace-root.dtrace-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
+	$(call quiet-command,$(TRACETOOL) \
+		--group=root \
+		--format=d \
+		--backends=$(TRACE_BACKENDS) \
+		$< > $@,"GEN","$(@:%-timestamp=%)")
+
+trace-dtrace-root.h: trace-dtrace-root.dtrace
+	$(call quiet-command,dtrace -o $@ -h -s $<, "GEN","$@")
+
+trace-dtrace-root.o: trace-dtrace-root.dtrace
+
 # Don't try to regenerate Makefile or configure
 # We don't generate any of them
 Makefile: ;
@@ -160,7 +271,8 @@ dummy := $(call unnest-vars,, \
                 qom-obj-y \
                 io-obj-y \
                 common-obj-y \
-                common-obj-m)
+                common-obj-m \
+                trace-obj-y)
 
 ifneq ($(wildcard config-host.mak),)
 include $(SRC_PATH)/tests/Makefile.include
@@ -223,7 +335,7 @@ subdir-dtc:dtc/libfdt dtc/tests
 dtc/%:
 	mkdir -p $@
 
-$(SUBDIR_RULES): libqemuutil.a libqemustub.a $(common-obj-y) $(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY))
+$(SUBDIR_RULES): libqemuutil.a libqemustub.a $(common-obj-y) $(qom-obj-y) $(crypto-aes-obj-$(CONFIG_USER_ONLY)) $(trace-obj-y)
 
 ROMSUBDIR_RULES=$(patsubst %,romsubdir-%, $(ROMS))
 # Only keep -O and -g cflags
@@ -247,15 +359,17 @@ libqemuutil.a: $(util-obj-y)
 
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
@@ -320,7 +434,7 @@ $(qapi-modules) $(SRC_PATH)/scripts/qapi-introspect.py $(qapi-py)
 QGALIB_GEN=$(addprefix qga/qapi-generated/, qga-qapi-types.h qga-qapi-visit.h qga-qmp-commands.h)
 $(qga-obj-y) qemu-ga.o: $(QGALIB_GEN)
 
-qemu-ga$(EXESUF): $(qga-obj-y) libqemuutil.a libqemustub.a
+qemu-ga$(EXESUF): $(qga-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 
 ifdef QEMU_GA_MSI_ENABLED
@@ -345,9 +459,9 @@ ifneq ($(EXESUF),)
 qemu-ga: qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
 endif
 
-ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) libqemuutil.a libqemustub.a
+ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
-ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) libqemuutil.a libqemustub.a
+ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 
 module_block.h: $(SRC_PATH)/scripts/modules/module_block.py config-host.mak
@@ -664,6 +778,10 @@ ifneq ($(filter-out $(UNCHECKED_GOALS),$(MAKECMDGOALS)),$(if $(MAKECMDGOALS),,fa
 Makefile: $(GENERATED_HEADERS)
 endif
 
+.SECONDARY: $(TRACE_HEADERS) $(TRACE_HEADERS:%=%-timestamp) \
+	$(TRACE_SOURCES) $(TRACE_SOURCES:%=%-timestamp) \
+	$(TRACE_DTRACE) $(TRACE_DTRACE:%=%-timestamp)
+
 # Include automatically generated dependency files
 # Dependencies in Makefile.objs files come from our recursive subdir rules
 -include $(wildcard *.d tests/*.d)
diff --git a/Makefile.objs b/Makefile.objs
index 6abe0b9..cf2f387 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -118,50 +118,58 @@ ivshmem-server-obj-y = contrib/ivshmem-server/
 libvhost-user-obj-y = contrib/libvhost-user/
 
 ######################################################################
-trace-events-y = trace-events
-trace-events-y += util/trace-events
-trace-events-y += crypto/trace-events
-trace-events-y += io/trace-events
-trace-events-y += migration/trace-events
-trace-events-y += block/trace-events
-trace-events-y += hw/block/trace-events
-trace-events-y += hw/block/dataplane/trace-events
-trace-events-y += hw/char/trace-events
-trace-events-y += hw/intc/trace-events
-trace-events-y += hw/net/trace-events
-trace-events-y += hw/virtio/trace-events
-trace-events-y += hw/audio/trace-events
-trace-events-y += hw/misc/trace-events
-trace-events-y += hw/usb/trace-events
-trace-events-y += hw/scsi/trace-events
-trace-events-y += hw/nvram/trace-events
-trace-events-y += hw/display/trace-events
-trace-events-y += hw/input/trace-events
-trace-events-y += hw/timer/trace-events
-trace-events-y += hw/dma/trace-events
-trace-events-y += hw/sparc/trace-events
-trace-events-y += hw/sd/trace-events
-trace-events-y += hw/isa/trace-events
-trace-events-y += hw/mem/trace-events
-trace-events-y += hw/i386/trace-events
-trace-events-y += hw/i386/xen/trace-events
-trace-events-y += hw/9pfs/trace-events
-trace-events-y += hw/ppc/trace-events
-trace-events-y += hw/pci/trace-events
-trace-events-y += hw/s390x/trace-events
-trace-events-y += hw/vfio/trace-events
-trace-events-y += hw/acpi/trace-events
-trace-events-y += hw/arm/trace-events
-trace-events-y += hw/alpha/trace-events
-trace-events-y += hw/xen/trace-events
-trace-events-y += ui/trace-events
-trace-events-y += audio/trace-events
-trace-events-y += net/trace-events
-trace-events-y += target/arm/trace-events
-trace-events-y += target/i386/trace-events
-trace-events-y += target/sparc/trace-events
-trace-events-y += target/s390x/trace-events
-trace-events-y += target/ppc/trace-events
-trace-events-y += qom/trace-events
-trace-events-y += linux-user/trace-events
-trace-events-y += qapi/trace-events
+trace-events-subdirs =
+trace-events-subdirs += util
+trace-events-subdirs += crypto
+trace-events-subdirs += io
+trace-events-subdirs += migration
+trace-events-subdirs += block
+trace-events-subdirs += hw/block
+trace-events-subdirs += hw/block/dataplane
+trace-events-subdirs += hw/char
+trace-events-subdirs += hw/intc
+trace-events-subdirs += hw/net
+trace-events-subdirs += hw/virtio
+trace-events-subdirs += hw/audio
+trace-events-subdirs += hw/misc
+trace-events-subdirs += hw/usb
+trace-events-subdirs += hw/scsi
+trace-events-subdirs += hw/nvram
+trace-events-subdirs += hw/display
+trace-events-subdirs += hw/input
+trace-events-subdirs += hw/timer
+trace-events-subdirs += hw/dma
+trace-events-subdirs += hw/sparc
+trace-events-subdirs += hw/sd
+trace-events-subdirs += hw/isa
+trace-events-subdirs += hw/mem
+trace-events-subdirs += hw/i386
+trace-events-subdirs += hw/i386/xen
+trace-events-subdirs += hw/9pfs
+trace-events-subdirs += hw/ppc
+trace-events-subdirs += hw/pci
+trace-events-subdirs += hw/s390x
+trace-events-subdirs += hw/vfio
+trace-events-subdirs += hw/acpi
+trace-events-subdirs += hw/arm
+trace-events-subdirs += hw/alpha
+trace-events-subdirs += hw/xen
+trace-events-subdirs += ui
+trace-events-subdirs += audio
+trace-events-subdirs += net
+trace-events-subdirs += target/arm
+trace-events-subdirs += target/i386
+trace-events-subdirs += target/sparc
+trace-events-subdirs += target/s390x
+trace-events-subdirs += target/ppc
+trace-events-subdirs += qom
+trace-events-subdirs += linux-user
+trace-events-subdirs += qapi
+
+trace-events-files = $(SRC_PATH)/trace-events $(trace-events-subdirs:%=$(SRC_PATH)/%/trace-events)
+
+trace-obj-y = trace-root.o
+trace-obj-y += $(trace-events-subdirs:%=%/trace.o)
+trace-obj-$(CONFIG_TRACE_UST) += trace-ust-all.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += trace-dtrace-root.o
+trace-obj-$(CONFIG_TRACE_DTRACE) += $(trace-events-subdirs:%=%/trace-dtrace.o)
diff --git a/Makefile.target b/Makefile.target
index fa6ae0c..9f2af5b 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -186,7 +186,8 @@ dummy := $(call unnest-vars,.., \
                qom-obj-y \
                io-obj-y \
                common-obj-y \
-               common-obj-m)
+               common-obj-m \
+               trace-obj-y)
 target-obj-y := $(target-obj-y-save)
 all-obj-y += $(common-obj-y)
 all-obj-y += $(target-obj-y)
@@ -198,8 +199,10 @@ all-obj-$(CONFIG_SOFTMMU) += $(io-obj-y)
 
 $(QEMU_PROG_BUILD): config-devices.mak
 
+COMMON_LDADDS = $(trace-obj-y) ../libqemuutil.a ../libqemustub.a
+
 # build either PROG or PROGW
-$(QEMU_PROG_BUILD): $(all-obj-y) ../libqemuutil.a ../libqemustub.a
+$(QEMU_PROG_BUILD): $(all-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $(filter-out %.mak, $^))
 ifdef CONFIG_DARWIN
 	$(call quiet-command,Rez -append $(SRC_PATH)/pc-bios/qemu.rsrc -o $@,"REZ","$(TARGET_DIR)$@")
diff --git a/aio-posix.c b/aio-posix.c
index 9453d83..804e03d 100644
--- a/aio-posix.c
+++ b/aio-posix.c
@@ -19,7 +19,7 @@
 #include "qemu/rcu_queue.h"
 #include "qemu/sockets.h"
 #include "qemu/cutils.h"
-#include "trace.h"
+#include "trace-root.h"
 #ifdef CONFIG_EPOLL_CREATE1
 #include <sys/epoll.h>
 #endif
diff --git a/balloon.c b/balloon.c
index f2ef50c..1d720ff 100644
--- a/balloon.c
+++ b/balloon.c
@@ -29,7 +29,7 @@
 #include "exec/cpu-common.h"
 #include "sysemu/kvm.h"
 #include "sysemu/balloon.h"
-#include "trace.h"
+#include "trace-root.h"
 #include "qmp-commands.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/qmp/qjson.h"
diff --git a/block.c b/block.c
index 39ddea3..19b68f8 100644
--- a/block.c
+++ b/block.c
@@ -22,7 +22,7 @@
  * THE SOFTWARE.
  */
 #include "qemu/osdep.h"
-#include "trace.h"
+#include "block/trace.h"
 #include "block/block_int.h"
 #include "block/blockjob.h"
 #include "block/nbd.h"
diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index 81bca17..7ea836b 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -16,7 +16,6 @@
 #include "qapi/qmp/qerror.h"
 #include "sysemu/sysemu.h"
 #include "qmp-commands.h"
-#include "trace.h"
 #include "block/nbd.h"
 #include "io/channel-socket.h"
 
diff --git a/blockdev.c b/blockdev.c
index 245e1e1..db82ac9 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -48,7 +48,7 @@
 #include "sysemu/sysemu.h"
 #include "block/block_int.h"
 #include "qmp-commands.h"
-#include "trace.h"
+#include "block/trace.h"
 #include "sysemu/arch_init.h"
 #include "qemu/cutils.h"
 #include "qemu/help_option.h"
diff --git a/blockjob.c b/blockjob.c
index 513620c..abee11b 100644
--- a/blockjob.c
+++ b/blockjob.c
@@ -25,7 +25,6 @@
 
 #include "qemu/osdep.h"
 #include "qemu-common.h"
-#include "trace.h"
 #include "block/block.h"
 #include "block/blockjob_int.h"
 #include "block/block_int.h"
diff --git a/cpu-exec.c b/cpu-exec.c
index 4188fed..8057432 100644
--- a/cpu-exec.c
+++ b/cpu-exec.c
@@ -18,7 +18,7 @@
  */
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "trace.h"
+#include "trace-root.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg.h"
diff --git a/dma-helpers.c b/dma-helpers.c
index 6f9d47c..97157cc 100644
--- a/dma-helpers.c
+++ b/dma-helpers.c
@@ -10,7 +10,7 @@
 #include "qemu/osdep.h"
 #include "sysemu/block-backend.h"
 #include "sysemu/dma.h"
-#include "trace.h"
+#include "trace-root.h"
 #include "qemu/thread.h"
 #include "qemu/main-loop.h"
 
diff --git a/exec.c b/exec.c
index f2bed92..f0d10a6 100644
--- a/exec.c
+++ b/exec.c
@@ -44,7 +44,7 @@
 #include "sysemu/dma.h"
 #include "exec/address-spaces.h"
 #include "sysemu/xen-mapcache.h"
-#include "trace.h"
+#include "trace-root.h"
 #endif
 #include "exec/cpu-all.h"
 #include "qemu/rcu_queue.h"
diff --git a/hw/net/fsl_etsec/etsec.c b/hw/net/fsl_etsec/etsec.c
index fadf9c8..aa2b0d5 100644
--- a/hw/net/fsl_etsec/etsec.c
+++ b/hw/net/fsl_etsec/etsec.c
@@ -29,7 +29,6 @@
 #include "qemu/osdep.h"
 #include "sysemu/sysemu.h"
 #include "hw/sysbus.h"
-#include "trace.h"
 #include "hw/ptimer.h"
 #include "etsec.h"
 #include "registers.h"
diff --git a/include/exec/cpu_ldst_template.h b/include/exec/cpu_ldst_template.h
index eaf69a1..4db2302 100644
--- a/include/exec/cpu_ldst_template.h
+++ b/include/exec/cpu_ldst_template.h
@@ -25,7 +25,7 @@
  */
 
 #if !defined(SOFTMMU_CODE_ACCESS)
-#include "trace.h"
+#include "trace-root.h"
 #endif
 
 #include "trace/mem.h"
diff --git a/include/exec/cpu_ldst_useronly_template.h b/include/exec/cpu_ldst_useronly_template.h
index b1378bf..7b8c7c5 100644
--- a/include/exec/cpu_ldst_useronly_template.h
+++ b/include/exec/cpu_ldst_useronly_template.h
@@ -24,7 +24,7 @@
  */
 
 #if !defined(CODE_ACCESS)
-#include "trace.h"
+#include "trace-root.h"
 #endif
 
 #include "trace/mem.h"
diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
index 8e1580d..dce76ee 100644
--- a/include/hw/xen/xen_common.h
+++ b/include/hw/xen/xen_common.h
@@ -18,7 +18,7 @@
 #include "hw/xen/xen.h"
 #include "hw/pci/pci.h"
 #include "qemu/queue.h"
-#include "trace.h"
+#include "hw/xen/trace.h"
 
 /*
  * We don't support Xen prior to 4.2.0.
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
diff --git a/ioport.c b/ioport.c
index 94e08ab..1a65add 100644
--- a/ioport.c
+++ b/ioport.c
@@ -29,7 +29,7 @@
 #include "qemu-common.h"
 #include "cpu.h"
 #include "exec/ioport.h"
-#include "trace.h"
+#include "trace-root.h"
 #include "exec/memory.h"
 #include "exec/address-spaces.h"
 
diff --git a/kvm-all.c b/kvm-all.c
index 330219e..a27c880 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -34,7 +34,7 @@
 #include "exec/ram_addr.h"
 #include "exec/address-spaces.h"
 #include "qemu/event_notifier.h"
-#include "trace.h"
+#include "trace-root.h"
 #include "hw/irq.h"
 
 #include "hw/boards.h"
diff --git a/memory.c b/memory.c
index 2bfc37f..5c27200 100644
--- a/memory.c
+++ b/memory.c
@@ -24,7 +24,7 @@
 #include "qemu/bitops.h"
 #include "qemu/error-report.h"
 #include "qom/object.h"
-#include "trace.h"
+#include "trace-root.h"
 
 #include "exec/memory-internal.h"
 #include "exec/ram_addr.h"
diff --git a/monitor.c b/monitor.c
index 8b06b63..e372559 100644
--- a/monitor.c
+++ b/monitor.c
@@ -59,7 +59,7 @@
 #include "qapi/qmp/json-streamer.h"
 #include "qapi/qmp/json-parser.h"
 #include "qom/object_interfaces.h"
-#include "trace.h"
+#include "trace-root.h"
 #include "trace/control.h"
 #include "monitor/hmp-target.h"
 #ifdef CONFIG_TRACE_SIMPLE
diff --git a/qom/cpu.c b/qom/cpu.c
index 7f57587..41d0c17 100644
--- a/qom/cpu.c
+++ b/qom/cpu.c
@@ -29,7 +29,7 @@
 #include "qemu/error-report.h"
 #include "sysemu/sysemu.h"
 #include "hw/qdev-properties.h"
-#include "trace.h"
+#include "trace-root.h"
 
 bool cpu_exists(int64_t id)
 {
diff --git a/scripts/tracetool.py b/scripts/tracetool.py
index 0c9d992..c55a215 100755
--- a/scripts/tracetool.py
+++ b/scripts/tracetool.py
@@ -137,10 +137,12 @@ def main(args):
         if probe_prefix is None:
             probe_prefix = ".".join(["qemu", target_type, target_name])
 
-    if len(args) != 1:
+    if len(args) < 1:
         error_opt("missing trace-events filepath")
-    with open(args[0], "r") as fh:
-        events = tracetool.read_events(fh)
+    events = []
+    for arg in args:
+        with open(arg, "r") as fh:
+            events.extend(tracetool.read_events(fh))
 
     try:
         tracetool.generate(events, arg_group, arg_format, arg_backends,
diff --git a/scripts/tracetool/backend/dtrace.py b/scripts/tracetool/backend/dtrace.py
index 79505c6..c469cbd 100644
--- a/scripts/tracetool/backend/dtrace.py
+++ b/scripts/tracetool/backend/dtrace.py
@@ -36,7 +36,12 @@ def binary():
 
 
 def generate_h_begin(events, group):
-    out('#include "trace/generated-tracers-dtrace.h"',
+    if group == "root":
+        header = "trace-dtrace-root.h"
+    else:
+        header = "trace-dtrace.h"
+
+    out('#include "%s"' % header,
         '')
 
 
diff --git a/scripts/tracetool/backend/simple.py b/scripts/tracetool/backend/simple.py
index 85f6102..4acc06e 100644
--- a/scripts/tracetool/backend/simple.py
+++ b/scripts/tracetool/backend/simple.py
@@ -44,7 +44,6 @@ def generate_h(event, group):
 
 def generate_c_begin(events, group):
     out('#include "qemu/osdep.h"',
-        '#include "trace.h"',
         '#include "trace/control.h"',
         '#include "trace/simple.h"',
         '')
diff --git a/scripts/tracetool/backend/ust.py b/scripts/tracetool/backend/ust.py
index 4594db6..52ce892 100644
--- a/scripts/tracetool/backend/ust.py
+++ b/scripts/tracetool/backend/ust.py
@@ -20,8 +20,13 @@ PUBLIC = True
 
 
 def generate_h_begin(events, group):
+    if group == "root":
+        header = "trace-ust-root.h"
+    else:
+        header = "trace-ust.h"
+
     out('#include <lttng/tracepoint.h>',
-        '#include "trace/generated-ust-provider.h"',
+        '#include "%s"' % header,
         '')
 
 
diff --git a/scripts/tracetool/format/c.py b/scripts/tracetool/format/c.py
index 47115ed..833c05a 100644
--- a/scripts/tracetool/format/c.py
+++ b/scripts/tracetool/format/c.py
@@ -20,10 +20,15 @@ def generate(events, backend, group):
     active_events = [e for e in events
                      if "disable" not in e.properties]
 
+    if group == "root":
+        header = "trace-root.h"
+    else:
+        header = "trace.h"
+
     out('/* This file is autogenerated by tracetool, do not edit. */',
         '',
         '#include "qemu/osdep.h"',
-        '#include "trace.h"',
+        '#include "%s"' % header,
         '')
 
     for e in events:
diff --git a/scripts/tracetool/format/tcg_h.py b/scripts/tracetool/format/tcg_h.py
index 5f213f6..7ddc4a5 100644
--- a/scripts/tracetool/format/tcg_h.py
+++ b/scripts/tracetool/format/tcg_h.py
@@ -28,13 +28,17 @@ def vcpu_transform_args(args):
 
 
 def generate(events, backend, group):
+    if group == "root":
+        header = "trace-root.h"
+    else:
+        header = "trace.h"
+
     out('/* This file is autogenerated by tracetool, do not edit. */',
         '/* You must include this file after the inclusion of helper.h */',
         '',
         '#ifndef TRACE_%s_GENERATED_TCG_TRACERS_H' % group.upper(),
         '#define TRACE_%s_GENERATED_TCG_TRACERS_H' % group.upper(),
         '',
-        '#include "trace.h"',
         '#include "exec/helper-proto.h"',
         '',
         )
diff --git a/scripts/tracetool/format/tcg_helper_c.py b/scripts/tracetool/format/tcg_helper_c.py
index cc26e03..7dccd8c 100644
--- a/scripts/tracetool/format/tcg_helper_c.py
+++ b/scripts/tracetool/format/tcg_helper_c.py
@@ -41,6 +41,11 @@ def vcpu_transform_args(args, mode):
 
 
 def generate(events, backend, group):
+    if group == "root":
+        header = "trace-root.h"
+    else:
+        header = "trace.h"
+
     events = [e for e in events
               if "disable" not in e.properties]
 
@@ -49,7 +54,6 @@ def generate(events, backend, group):
         '#include "qemu/osdep.h"',
         '#include "qemu-common.h"',
         '#include "cpu.h"',
-        '#include "trace.h"',
         '#include "exec/helper-proto.h"',
         '',
         )
diff --git a/scripts/tracetool/format/ust_events_c.py b/scripts/tracetool/format/ust_events_c.py
index cd87d8a..264784c 100644
--- a/scripts/tracetool/format/ust_events_c.py
+++ b/scripts/tracetool/format/ust_events_c.py
@@ -32,4 +32,4 @@ def generate(events, backend, group):
         ' */',
         '#pragma GCC diagnostic ignored "-Wredundant-decls"',
         '',
-        '#include "generated-ust-provider.h"')
+        '#include "trace-ust-all.h"')
diff --git a/scripts/tracetool/format/ust_events_h.py b/scripts/tracetool/format/ust_events_h.py
index d853155..514294c 100644
--- a/scripts/tracetool/format/ust_events_h.py
+++ b/scripts/tracetool/format/ust_events_h.py
@@ -20,13 +20,18 @@ def generate(events, backend, group):
     events = [e for e in events
               if "disabled" not in e.properties]
 
+    if group == "all":
+        include = "trace-ust-all.h"
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
diff --git a/spice-qemu-char.c b/spice-qemu-char.c
index 276c4ae..3a09be8 100644
--- a/spice-qemu-char.c
+++ b/spice-qemu-char.c
@@ -1,5 +1,5 @@
 #include "qemu/osdep.h"
-#include "trace.h"
+#include "trace-root.h"
 #include "ui/qemu-spice.h"
 #include "sysemu/char.h"
 #include <spice.h>
diff --git a/tests/Makefile.include b/tests/Makefile.include
index 22ea256..8c229ee 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -491,7 +491,7 @@ QEMU_CFLAGS += -I$(SRC_PATH)/tests
 
 
 # Deps that are common to various different sets of tests below
-test-util-obj-y = libqemuutil.a libqemustub.a
+test-util-obj-y = $(trace-obj-y) libqemuutil.a libqemustub.a
 test-qom-obj-y = $(qom-obj-y) $(test-util-obj-y)
 test-qapi-obj-y = tests/test-qapi-visit.o tests/test-qapi-types.o \
 	tests/test-qapi-event.o tests/test-qmp-introspect.o \
diff --git a/thread-pool.c b/thread-pool.c
index 6fba913..3847969 100644
--- a/thread-pool.c
+++ b/thread-pool.c
@@ -19,7 +19,7 @@
 #include "qemu/queue.h"
 #include "qemu/thread.h"
 #include "qemu/coroutine.h"
-#include "trace.h"
+#include "trace-root.h"
 #include "block/thread-pool.h"
 #include "qemu/main-loop.h"
 
diff --git a/trace/Makefile.objs b/trace/Makefile.objs
index d3b47da..7de840a 100644
--- a/trace/Makefile.objs
+++ b/trace/Makefile.objs
@@ -8,98 +8,16 @@
 tracetool-y = $(SRC_PATH)/scripts/tracetool.py
 tracetool-y += $(shell find $(SRC_PATH)/scripts/tracetool -name "*.py")
 
-$(BUILD_DIR)/trace-events-all: $(trace-events-y:%=$(SRC_PATH)/%)
+$(BUILD_DIR)/trace-events-all: $(trace-events-files)
 	$(call quiet-command,cat $^ > $@)
 
-######################################################################
-# Auto-generated event descriptions for LTTng ust code
-
-ifeq ($(findstring ust,$(TRACE_BACKENDS)),ust)
-
-$(obj)/generated-ust-provider.h: $(obj)/generated-ust-provider.h-timestamp
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-ust-provider.h-timestamp: $(BUILD_DIR)/trace-events-all $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=all \
-		--format=ust-events-h \
-		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-$(obj)/generated-ust.c: $(obj)/generated-ust.c-timestamp $(BUILD_DIR)/config-host.mak
-	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-ust.c-timestamp: $(BUILD_DIR)/trace-events-all $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=all \
-		--format=ust-events-c \
-		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-$(obj)/generated-tracers.h: $(obj)/generated-ust-provider.h
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
-$(obj)/generated-tracers.h-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=all \
-		--format=h \
-		--backends=$(TRACE_BACKENDS) \
-		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-
-##############################
-# non-DTrace
-
-$(obj)/generated-tracers.c: $(obj)/generated-tracers.c-timestamp
-	@cmp -s $< $@ || cp $< $@
-$(obj)/generated-tracers.c-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=all \
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
-$(obj)/generated-tracers-dtrace.dtrace-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)/config-host.mak $(tracetool-y)
-	$(call quiet-command,$(TRACETOOL) \
-		--group=all \
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
 
 $(obj)/generated-helpers-wrappers.h: $(obj)/generated-helpers-wrappers.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-helpers-wrappers.h-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)/config-host.mak $(tracetool-y)
+$(obj)/generated-helpers-wrappers.h-timestamp: $(trace-events-files) $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=all \
 		--format=tcg-helper-wrapper-h \
@@ -108,7 +26,7 @@ $(obj)/generated-helpers-wrappers.h-timestamp: $(BUILD_DIR)/trace-events-all $(B
 
 $(obj)/generated-helpers.h: $(obj)/generated-helpers.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-helpers.h-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)/config-host.mak $(tracetool-y)
+$(obj)/generated-helpers.h-timestamp: $(trace-events-files) $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=all \
 		--format=tcg-helper-h \
@@ -117,7 +35,7 @@ $(obj)/generated-helpers.h-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)
 
 $(obj)/generated-helpers.c: $(obj)/generated-helpers.c-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-helpers.c-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)/config-host.mak $(tracetool-y)
+$(obj)/generated-helpers.c-timestamp: $(trace-events-files) $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=all \
 		--format=tcg-helper-c \
@@ -131,7 +49,7 @@ target-obj-y += generated-helpers.o
 
 $(obj)/generated-tcg-tracers.h: $(obj)/generated-tcg-tracers.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-tcg-tracers.h-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)/config-host.mak $(tracetool-y)
+$(obj)/generated-tcg-tracers.h-timestamp: $(trace-events-files) $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=all \
 		--format=tcg-h \
@@ -142,10 +60,8 @@ $(obj)/generated-tcg-tracers.h-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_
 ######################################################################
 # Backend code
 
-util-obj-y += generated-tracers.o
 util-obj-$(CONFIG_TRACE_SIMPLE) += simple.o
 util-obj-$(CONFIG_TRACE_FTRACE) += ftrace.o
-util-obj-$(CONFIG_TRACE_UST) += generated-ust.o
 util-obj-y += control.o
 target-obj-y += control-target.o
 util-obj-y += qmp.o
diff --git a/trace/control-target.c b/trace/control-target.c
index e2e138a..6266e63 100644
--- a/trace/control-target.c
+++ b/trace/control-target.c
@@ -9,7 +9,7 @@
 
 #include "qemu/osdep.h"
 #include "cpu.h"
-#include "trace.h"
+#include "trace-root.h"
 #include "trace/control.h"
 #include "translate-all.h"
 
diff --git a/trace/control.c b/trace/control.c
index 56a2632..9b157b0 100644
--- a/trace/control.c
+++ b/trace/control.c
@@ -26,7 +26,7 @@
 #include "qemu/error-report.h"
 #include "qemu/config-file.h"
 #include "monitor/monitor.h"
-#include "trace.h"
+#include "trace-root.h"
 
 int trace_events_enabled_count;
 
diff --git a/trace/ftrace.c b/trace/ftrace.c
index 3588bb0..7de104d 100644
--- a/trace/ftrace.c
+++ b/trace/ftrace.c
@@ -10,8 +10,8 @@
  */
 
 #include "qemu/osdep.h"
-#include "trace.h"
 #include "trace/control.h"
+#include "trace/ftrace.h"
 
 int trace_marker_fd;
 
diff --git a/trace/simple.c b/trace/simple.c
index b263622..a221a3f 100644
--- a/trace/simple.c
+++ b/trace/simple.c
@@ -13,7 +13,6 @@
 #include <pthread.h>
 #endif
 #include "qemu/timer.h"
-#include "trace.h"
 #include "trace/control.h"
 #include "trace/simple.h"
 
diff --git a/translate-all.c b/translate-all.c
index 2026293..0a93474 100644
--- a/translate-all.c
+++ b/translate-all.c
@@ -25,7 +25,7 @@
 #include "qemu-common.h"
 #define NO_CPU_IO_DEFS
 #include "cpu.h"
-#include "trace.h"
+#include "trace-root.h"
 #include "disas/disas.h"
 #include "exec/exec-all.h"
 #include "tcg.h"
diff --git a/vl.c b/vl.c
index a260f30..4bf1e7a 100644
--- a/vl.c
+++ b/vl.c
@@ -110,7 +110,7 @@ int main(int argc, char **argv)
 
 #include "slirp/libslirp.h"
 
-#include "trace.h"
+#include "trace-root.h"
 #include "trace/control.h"
 #include "qemu/queue.h"
 #include "sysemu/arch_init.h"
diff --git a/xen-hvm.c b/xen-hvm.c
index 0892361..5043beb 100644
--- a/xen-hvm.c
+++ b/xen-hvm.c
@@ -22,7 +22,7 @@
 #include "qemu/error-report.h"
 #include "qemu/range.h"
 #include "sysemu/xen-mapcache.h"
-#include "trace.h"
+#include "trace-root.h"
 #include "exec/address-spaces.h"
 
 #include <xen/hvm/ioreq.h>
diff --git a/xen-mapcache.c b/xen-mapcache.c
index 31debdf..1a96d2e 100644
--- a/xen-mapcache.c
+++ b/xen-mapcache.c
@@ -19,7 +19,7 @@
 #include <xen/hvm/params.h>
 
 #include "sysemu/xen-mapcache.h"
-#include "trace.h"
+#include "trace-root.h"
 
 
 //#define MAPCACHE_DEBUG
-- 
2.9.3
