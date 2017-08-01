Received: from eggs.gnu.org ([2001:4830:134:3::10]:47540)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcX2H-0001Rl-GT
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:16:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dcX2D-0005Nt-Im
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:16:33 -0400
Received: from mx1.redhat.com ([209.132.183.28]:30573)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1dcX2D-0005NZ-Cx
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 09:16:29 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Tue,  1 Aug 2017 14:16:10 +0100
Message-Id: <20170801131618.27332-2-stefanha@redhat.com>
In-Reply-To: <20170801131618.27332-1-stefanha@redhat.com>
References: <20170801131618.27332-1-stefanha@redhat.com>
Subject: [Qemu-devel] [PULL 1/9] trace: ensure .stp files are rebuilt if
 trace tool source changes
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

The make rules for generating the .stp files forgot to add a dep
on $(tracetool-y) to trigger a rebuild if the trace tool source
changes.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
Message-id: 20170728133631.5449-1-berrange@redhat.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 Makefile.target | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index 2baec9252f..7f42c45db8 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -48,7 +48,10 @@ else
 TARGET_TYPE=system
 endif
 
-$(QEMU_PROG).stp-installed: $(BUILD_DIR)/trace-events-all
+tracetool-y = $(SRC_PATH)/scripts/tracetool.py
+tracetool-y += $(shell find $(SRC_PATH)/scripts/tracetool -name "*.py")
+
+$(QEMU_PROG).stp-installed: $(BUILD_DIR)/trace-events-all $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=all \
 		--format=stap \
@@ -58,7 +61,7 @@ $(QEMU_PROG).stp-installed: $(BUILD_DIR)/trace-events-all
 		--target-type=$(TARGET_TYPE) \
 		$< > $@,"GEN","$(TARGET_DIR)$(QEMU_PROG).stp-installed")
 
-$(QEMU_PROG).stp: $(BUILD_DIR)/trace-events-all
+$(QEMU_PROG).stp: $(BUILD_DIR)/trace-events-all $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=all \
 		--format=stap \
@@ -68,7 +71,7 @@ $(QEMU_PROG).stp: $(BUILD_DIR)/trace-events-all
 		--target-type=$(TARGET_TYPE) \
 		$< > $@,"GEN","$(TARGET_DIR)$(QEMU_PROG).stp")
 
-$(QEMU_PROG)-simpletrace.stp: $(BUILD_DIR)/trace-events-all
+$(QEMU_PROG)-simpletrace.stp: $(BUILD_DIR)/trace-events-all $(tracetool-y)
 	$(call quiet-command,$(TRACETOOL) \
 		--group=all \
 		--format=simpletrace-stap \
-- 
2.13.3
