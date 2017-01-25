Received: from eggs.gnu.org ([2001:4830:134:3::10]:44734)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWQDX-00021S-O1
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:14:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1cWQDW-0003Vp-Ac
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:14:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53682)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1cWQDW-0003Vd-1p
	for qemu-devel@nongnu.org; Wed, 25 Jan 2017 11:14:38 -0500
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Wed, 25 Jan 2017 16:14:14 +0000
Message-Id: <20170125161417.31949-6-berrange@redhat.com>
In-Reply-To: <20170125161417.31949-1-berrange@redhat.com>
References: <20170125161417.31949-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH v4 5/8] trace: move setting of group name into
 Makefiles
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>

Having tracetool.py figure out the right group name from just
the input filename is not practical when considering the
different build vs src path combinations. Instead simply take
the group name as a command line arg from the Makefile, which
can trivially provide the right name.

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
---
 Makefile.target      |  3 +++
 scripts/tracetool.py | 23 +++++++++--------------
 trace/Makefile.objs  |  9 +++++++++
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index fa2b151..fa6ae0c 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -50,6 +50,7 @@ endif
 
 $(QEMU_PROG).stp-installed: $(BUILD_DIR)/trace-events-all
 	$(call quiet-command,$(TRACETOOL) \
+		--group=all \
 		--format=stap \
 		--backends=$(TRACE_BACKENDS) \
 		--binary=$(bindir)/$(QEMU_PROG) \
@@ -59,6 +60,7 @@ $(QEMU_PROG).stp-installed: $(BUILD_DIR)/trace-events-all
 
 $(QEMU_PROG).stp: $(BUILD_DIR)/trace-events-all
 	$(call quiet-command,$(TRACETOOL) \
+		--group=all \
 		--format=stap \
 		--backends=$(TRACE_BACKENDS) \
 		--binary=$(realpath .)/$(QEMU_PROG) \
@@ -68,6 +70,7 @@ $(QEMU_PROG).stp: $(BUILD_DIR)/trace-events-all
 
 $(QEMU_PROG)-simpletrace.stp: $(BUILD_DIR)/trace-events-all
 	$(call quiet-command,$(TRACETOOL) \
+		--group=all \
 		--format=simpletrace-stap \
 		--backends=$(TRACE_BACKENDS) \
 		--probe-prefix=qemu.$(TARGET_TYPE).$(TARGET_NAME) \
diff --git a/scripts/tracetool.py b/scripts/tracetool.py
index c9e4737..0c9d992 100755
--- a/scripts/tracetool.py
+++ b/scripts/tracetool.py
@@ -49,6 +49,7 @@ Options:
     --binary <path>          Full path to QEMU binary.
     --target-type <type>     QEMU emulator target type ('system' or 'user').
     --target-name <name>     QEMU emulator target name.
+    --group <name>           Name of the event group
     --probe-prefix <prefix>  Prefix for dtrace probe names
                              (default: qemu-<target-type>-<target-name>).\
 """ % {
@@ -62,22 +63,12 @@ Options:
     else:
         sys.exit(1)
 
-def make_group_name(filename):
-    dirname = os.path.realpath(os.path.dirname(filename))
-    basedir = os.path.join(os.path.dirname(__file__), os.pardir)
-    basedir = os.path.realpath(os.path.abspath(basedir))
-    dirname = dirname[len(basedir) + 1:]
-
-    if dirname == "":
-        return "common"
-    return "_" + re.sub(r"[^A-Za-z0-9]", "_", dirname)
-
 def main(args):
     global _SCRIPT
     _SCRIPT = args[0]
 
     long_opts = ["backends=", "format=", "help", "list-backends",
-                 "check-backends"]
+                 "check-backends", "group="]
     long_opts += ["binary=", "target-type=", "target-name=", "probe-prefix="]
 
     try:
@@ -88,6 +79,7 @@ def main(args):
     check_backends = False
     arg_backends = []
     arg_format = ""
+    arg_group = None
     binary = None
     target_type = None
     target_name = None
@@ -98,6 +90,8 @@ def main(args):
 
         elif opt == "--backends":
             arg_backends = arg.split(",")
+        elif opt == "--group":
+            arg_group = arg
         elif opt == "--format":
             arg_format = arg
 
@@ -129,6 +123,9 @@ def main(args):
                 sys.exit(1)
         sys.exit(0)
 
+    if arg_group is None:
+        error_opt("group name is required")
+
     if arg_format == "stap":
         if binary is None:
             error_opt("--binary is required for SystemTAP tapset generator")
@@ -145,10 +142,8 @@ def main(args):
     with open(args[0], "r") as fh:
         events = tracetool.read_events(fh)
 
-    group = make_group_name(args[0])
-
     try:
-        tracetool.generate(events, group, arg_format, arg_backends,
+        tracetool.generate(events, arg_group, arg_format, arg_backends,
                            binary=binary, probe_prefix=probe_prefix)
     except tracetool.TracetoolError as e:
         error_opt(str(e))
diff --git a/trace/Makefile.objs b/trace/Makefile.objs
index 1e1ce74..d3b47da 100644
--- a/trace/Makefile.objs
+++ b/trace/Makefile.objs
@@ -20,6 +20,7 @@ $(obj)/generated-ust-provider.h: $(obj)/generated-ust-provider.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
 $(obj)/generated-ust-provider.h-timestamp: $(BUILD_DIR)/trace-events-all $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
+		--group=all \
 		--format=ust-events-h \
 		--backends=$(TRACE_BACKENDS) \
 		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
@@ -28,6 +29,7 @@ $(obj)/generated-ust.c: $(obj)/generated-ust.c-timestamp $(BUILD_DIR)/config-hos
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
 $(obj)/generated-ust.c-timestamp: $(BUILD_DIR)/trace-events-all $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
+		--group=all \
 		--format=ust-events-c \
 		--backends=$(TRACE_BACKENDS) \
 		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
@@ -48,6 +50,7 @@ $(obj)/generated-tracers.h: $(obj)/generated-tracers.h-timestamp
 	@cmp -s $< $@ || cp $< $@
 $(obj)/generated-tracers.h-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
+		--group=all \
 		--format=h \
 		--backends=$(TRACE_BACKENDS) \
 		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
@@ -59,6 +62,7 @@ $(obj)/generated-tracers.c: $(obj)/generated-tracers.c-timestamp
 	@cmp -s $< $@ || cp $< $@
 $(obj)/generated-tracers.c-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
+		--group=all \
 		--format=c \
 		--backends=$(TRACE_BACKENDS) \
 		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
@@ -77,6 +81,7 @@ $(obj)/generated-tracers-dtrace.dtrace: $(obj)/generated-tracers-dtrace.dtrace-t
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
 $(obj)/generated-tracers-dtrace.dtrace-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
+		--group=all \
 		--format=d \
 		--backends=$(TRACE_BACKENDS) \
 		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
@@ -96,6 +101,7 @@ $(obj)/generated-helpers-wrappers.h: $(obj)/generated-helpers-wrappers.h-timesta
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
 $(obj)/generated-helpers-wrappers.h-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
+		--group=all \
 		--format=tcg-helper-wrapper-h \
 		--backend=$(TRACE_BACKENDS) \
 		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
@@ -104,6 +110,7 @@ $(obj)/generated-helpers.h: $(obj)/generated-helpers.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
 $(obj)/generated-helpers.h-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
+		--group=all \
 		--format=tcg-helper-h \
 		--backend=$(TRACE_BACKENDS) \
 		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
@@ -112,6 +119,7 @@ $(obj)/generated-helpers.c: $(obj)/generated-helpers.c-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
 $(obj)/generated-helpers.c-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
+		--group=all \
 		--format=tcg-helper-c \
 		--backend=$(TRACE_BACKENDS) \
 		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
@@ -125,6 +133,7 @@ $(obj)/generated-tcg-tracers.h: $(obj)/generated-tcg-tracers.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
 $(obj)/generated-tcg-tracers.h-timestamp: $(BUILD_DIR)/trace-events-all $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
+		--group=all \
 		--format=tcg-h \
 		--backend=$(TRACE_BACKENDS) \
 		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
-- 
2.9.3
