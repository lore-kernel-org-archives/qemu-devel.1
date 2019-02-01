Received: from eggs.gnu.org ([209.51.188.92]:49911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gpMsc-00051d-HH
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 19:40:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aik@ozlabs.ru>) id 1gpMsa-0002L2-IX
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 19:40:25 -0500
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Date: Fri,  1 Feb 2019 11:40:12 +1100
Message-Id: <20190201004012.13237-1-aik@ozlabs.ru>
Subject: [Qemu-devel] [PATCH qemu] spapr/rtas: Force big endian compile for
 rtas
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-ppc@nongnu.org

At the moment the rtas's Makefile uses generic QEMU rules which means
that when QEMU is compiled on a little endian system, the spapr-rtas.bin
is compiled as little endian too which is incorrect as it is always
executed in big endian mode.

This enforces -mbig by defining %.o:%.S rule as spapr-rtas.bin is
a standalone guest binary which should not depend on QEMU flags anyway.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 pc-bios/spapr-rtas/Makefile | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/pc-bios/spapr-rtas/Makefile b/pc-bios/spapr-rtas/Makefile
index f26dd42..4b9bb12 100644
--- a/pc-bios/spapr-rtas/Makefile
+++ b/pc-bios/spapr-rtas/Makefile
@@ -14,8 +14,11 @@ $(call set-vpath, $(SRC_PATH)/pc-bios/spapr-rtas)
 
 build-all: spapr-rtas.bin
 
+%.o: %.S
+	$(call quiet-command,$(CCAS) -mbig -c -o $@ $<,"CCAS","$(TARGET_DIR)$@")
+
 %.img: %.o
-	$(call quiet-command,$(CC) -nostdlib -o $@ $<,"Building","$(TARGET_DIR)$@")
+	$(call quiet-command,$(CC) -nostdlib -mbig -o $@ $<,"Building","$(TARGET_DIR)$@")
 
 %.bin: %.img
 	$(call quiet-command,$(OBJCOPY) -O binary -j .text $< $@,"Building","$(TARGET_DIR)$@")
-- 
2.17.1
