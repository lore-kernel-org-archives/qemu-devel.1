Received: from eggs.gnu.org ([2001:4830:134:3::10]:48156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1css2f-0002a7-8C
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 10:24:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1css2Z-0006nt-4g
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 10:24:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40250)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1css2Y-0006nh-Sc
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 10:24:07 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue, 28 Mar 2017 15:23:46 +0100
Message-Id: <20170328142346.3899-2-stefanha@redhat.com>
In-Reply-To: <20170328142346.3899-1-stefanha@redhat.com>
References: <20170328142346.3899-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL for-2.9 1/1] trace: fix tcg tracing build
 breakage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>

Commit 0ab8ed18a6fe98bfc82705b0f041fbf2a8ca5b60 ("trace: switch to
modular code generation for sub-directories") forgot to convert "tcg"
trace events to the modular code generation approach where each
sub-directory has its own trace-events file.

This patch fixes compilation for "tcg" trace events.  Currently they are
only used in the root ./trace-events file.

"tcg" trace events can only be used in the root ./trace-events file for
the time being.

Reported-by: Peter Maydell <peter.maydell@linaro.org>
Tested-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20170327131718.18268-1-stefanha@redhat.com
Suggested-by: Emilio G. Cota <cota@braap.org>
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 docs/tracing.txt                         |  3 +++
 trace/Makefile.objs                      | 16 ++++++++--------
 scripts/tracetool/format/tcg_h.py        |  1 +
 scripts/tracetool/format/tcg_helper_c.py |  1 +
 4 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/docs/tracing.txt b/docs/tracing.txt
index e14bb6d..8c0029b 100644
--- a/docs/tracing.txt
+++ b/docs/tracing.txt
@@ -405,6 +405,9 @@ information. If used together with the "tcg" property, it adds a second
 "TCGv_env" argument that must point to the per-target global TCG register that
 points to the vCPU when guest code is executed (usually the "cpu_env" variable).
 
+The "tcg" and "vcpu" properties are currently only honored in the root
+./trace-events file.
+
 The following example events:
 
     foo(uint32_t a) "a=%x"
diff --git a/trace/Makefile.objs b/trace/Makefile.objs
index 1b8eb4a..afd571c 100644
--- a/trace/Makefile.objs
+++ b/trace/Makefile.objs
@@ -9,27 +9,27 @@ $(BUILD_DIR)/trace-events-all: $(trace-events-files)
 
 $(obj)/generated-helpers-wrappers.h: $(obj)/generated-helpers-wrappers.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-helpers-wrappers.h-timestamp: $(trace-events-files) $(BUILD_DIR)/config-host.mak $(tracetool-y)
+$(obj)/generated-helpers-wrappers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
-		--group=all \
+		--group=root \
 		--format=tcg-helper-wrapper-h \
 		--backend=$(TRACE_BACKENDS) \
 		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
 
 $(obj)/generated-helpers.h: $(obj)/generated-helpers.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-helpers.h-timestamp: $(trace-events-files) $(BUILD_DIR)/config-host.mak $(tracetool-y)
+$(obj)/generated-helpers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
-		--group=all \
+		--group=root \
 		--format=tcg-helper-h \
 		--backend=$(TRACE_BACKENDS) \
 		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
 
 $(obj)/generated-helpers.c: $(obj)/generated-helpers.c-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-helpers.c-timestamp: $(trace-events-files) $(BUILD_DIR)/config-host.mak $(tracetool-y)
+$(obj)/generated-helpers.c-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
-		--group=all \
+		--group=root \
 		--format=tcg-helper-c \
 		--backend=$(TRACE_BACKENDS) \
 		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
@@ -41,9 +41,9 @@ target-obj-y += generated-helpers.o
 
 $(obj)/generated-tcg-tracers.h: $(obj)/generated-tcg-tracers.h-timestamp
 	@cmp $< $@ >/dev/null 2>&1 || cp $< $@
-$(obj)/generated-tcg-tracers.h-timestamp: $(trace-events-files) $(BUILD_DIR)/config-host.mak $(tracetool-y)
+$(obj)/generated-tcg-tracers.h-timestamp: $(SRC_PATH)/trace-events $(BUILD_DIR)/config-host.mak $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
-		--group=all \
+		--group=root \
 		--format=tcg-h \
 		--backend=$(TRACE_BACKENDS) \
 		$< > $@,"GEN","$(patsubst %-timestamp,%,$@)")
diff --git a/scripts/tracetool/format/tcg_h.py b/scripts/tracetool/format/tcg_h.py
index 7ddc4a5..db55f52 100644
--- a/scripts/tracetool/format/tcg_h.py
+++ b/scripts/tracetool/format/tcg_h.py
@@ -40,6 +40,7 @@ def generate(events, backend, group):
         '#define TRACE_%s_GENERATED_TCG_TRACERS_H' % group.upper(),
         '',
         '#include "exec/helper-proto.h"',
+        '#include "%s"' % header,
         '',
         )
 
diff --git a/scripts/tracetool/format/tcg_helper_c.py b/scripts/tracetool/format/tcg_helper_c.py
index 7dccd8c..ec7acbe 100644
--- a/scripts/tracetool/format/tcg_helper_c.py
+++ b/scripts/tracetool/format/tcg_helper_c.py
@@ -55,6 +55,7 @@ def generate(events, backend, group):
         '#include "qemu-common.h"',
         '#include "cpu.h"',
         '#include "exec/helper-proto.h"',
+        '#include "%s"' % header,
         '',
         )
 
-- 
2.9.3
