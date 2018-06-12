Received: from eggs.gnu.org ([2001:4830:134:3::10]:50200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSh0l-0003Rt-PS
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:58:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fSh0i-0007Az-QG
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:58:51 -0400
Received: from mout.kundenserver.de ([212.227.126.187]:36967)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fSh0i-0007A6-FB
	for qemu-devel@nongnu.org; Tue, 12 Jun 2018 06:58:48 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Tue, 12 Jun 2018 12:58:26 +0200
Message-Id: <20180612105831.25703-4-laurent@vivier.eu>
In-Reply-To: <20180612105831.25703-1-laurent@vivier.eu>
References: <20180612105831.25703-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 3/8] linux-user: disable qemu-bridge-helper and
 socket_scm_helper build
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>

linux-user targets don't need them, and if we ask to build statically
linked binaries, some static libraries they need are not available.

Signed-off-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20180605160958.5434-1-laurent@vivier.eu>
---
 Makefile               | 2 +-
 tests/Makefile.include | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index 023b3437ec..e4bc34a1cb 100644
--- a/Makefile
+++ b/Makefile
@@ -351,7 +351,7 @@ $(call set-vpath, $(SRC_PATH))
 
 LIBS+=-lz $(LIBS_TOOLS)
 
-HELPERS-$(CONFIG_LINUX) = qemu-bridge-helper$(EXESUF)
+HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) = qemu-bridge-helper$(EXESUF)
 
 ifdef BUILD_DOCS
 DOCS=qemu-doc.html qemu-doc.txt qemu.1 qemu-img.1 qemu-nbd.8 qemu-ga.8
diff --git a/tests/Makefile.include b/tests/Makefile.include
index d098a104bb..10397ed159 100644
--- a/tests/Makefile.include
+++ b/tests/Makefile.include
@@ -930,7 +930,7 @@ check-report.html: check-report.xml
 
 # Other tests
 
-QEMU_IOTESTS_HELPERS-$(CONFIG_LINUX) = tests/qemu-iotests/socket_scm_helper$(EXESUF)
+QEMU_IOTESTS_HELPERS-$(call land,$(CONFIG_SOFTMMU),$(CONFIG_LINUX)) = tests/qemu-iotests/socket_scm_helper$(EXESUF)
 
 .PHONY: check-tests/qemu-iotests-quick.sh
 check-tests/qemu-iotests-quick.sh: tests/qemu-iotests-quick.sh qemu-img$(EXESUF) qemu-io$(EXESUF) $(QEMU_IOTESTS_HELPERS-y)
-- 
2.14.4
