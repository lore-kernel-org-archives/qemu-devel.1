Received: from eggs.gnu.org ([2001:4830:134:3::10]:47607)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK7s-0006Th-BG
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cFK7q-00032u-RB
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42752)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1cFK7q-00032h-MR
	for qemu-devel@nongnu.org; Fri, 09 Dec 2016 07:18:06 -0500
From: Thomas Huth <thuth@redhat.com>
Date: Fri,  9 Dec 2016 13:17:31 +0100
Message-Id: <1481285870-3396-2-git-send-email-thuth@redhat.com>
In-Reply-To: <1481285870-3396-1-git-send-email-thuth@redhat.com>
References: <1481285870-3396-1-git-send-email-thuth@redhat.com>
Subject: [Qemu-devel] [PATCH 01/20] Makefile: Allow CPU targets to reside in
 target/ folder, too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Aurelien Jarno <aurelien@aurel32.net>, Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Michael Walle <michael@walle.cc>, Laurent Vivier <laurent@vivier.eu>, Yongbok Kim <yongbok.kim@imgtec.com>, Anthony Green <green@moxielogic.com>, Jia Liu <proljc@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Eduardo Habkost <ehabkost@redhat.com>, Max Filippov <jcmvbkbc@gmail.com>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, James Hogan <james.hogan@imgtec.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, Marcelo Tosatti <mtosatti@redhat.com>

To be able to compile the CPU targets from within a subfolder
of the target/ folder, we've got to adapt the Makefile.target
a little bit first. After this change, target CPUs can either
reside in a target/xxx folder or continue to use the target-xxx
scheme. The latter will be disabled once all targets have been
moved.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 Makefile.target | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/Makefile.target b/Makefile.target
index 7a5080e..90b25ae 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -7,11 +7,17 @@ include config-target.mak
 include config-devices.mak
 include $(SRC_PATH)/rules.mak
 
+ifneq ($(wildcard $(SRC_PATH)/target/$(TARGET_BASE_ARCH)),)
+TARGET_FOLDER=target/$(TARGET_BASE_ARCH)
+else
+TARGET_FOLDER=target-$(TARGET_BASE_ARCH)
+endif
+
 $(call set-vpath, $(SRC_PATH):$(BUILD_DIR))
 ifdef CONFIG_LINUX
 QEMU_CFLAGS += -I../linux-headers
 endif
-QEMU_CFLAGS += -I.. -I$(SRC_PATH)/target-$(TARGET_BASE_ARCH) -DNEED_CPU_H
+QEMU_CFLAGS += -I.. -I$(SRC_PATH)/$(TARGET_FOLDER) -DNEED_CPU_H
 
 QEMU_CFLAGS+=-I$(SRC_PATH)/include
 
@@ -92,7 +98,7 @@ obj-$(CONFIG_TCG_INTERPRETER) += tci.o
 obj-y += tcg/tcg-common.o
 obj-$(CONFIG_TCG_INTERPRETER) += disas/tci.o
 obj-y += fpu/softfloat.o
-obj-y += target-$(TARGET_BASE_ARCH)/
+obj-y += $(TARGET_FOLDER)/
 obj-y += disas.o
 obj-y += tcg-runtime.o
 obj-$(call notempty,$(TARGET_XML_FILES)) += gdbstub-xml.o
-- 
1.8.3.1
