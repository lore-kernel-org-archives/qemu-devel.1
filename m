Received: from eggs.gnu.org ([2001:4830:134:3::10]:60282)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1db5Rb-0007VF-Mg
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:36:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1db5RY-00023l-ML
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:36:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55342)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1db5RY-00022w-Fw
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 09:36:40 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6304A333A1E
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 13:36:39 +0000 (UTC)
From: "Daniel P. Berrange" <berrange@redhat.com>
Date: Fri, 28 Jul 2017 14:36:31 +0100
Message-Id: <20170728133631.5449-1-berrange@redhat.com>
Subject: [Qemu-devel] [PATCH for 2.10] trace: ensure .stp files are rebuilt
 if trace tool source changes
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

The make rules for generating the .stp files forgot to add a dep
on $(tracetool-y) to trigger a rebuild if the trace tool source
changes.

Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
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
