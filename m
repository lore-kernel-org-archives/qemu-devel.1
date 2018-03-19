Received: from eggs.gnu.org ([2001:4830:134:3::10]:49715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1exzbz-0002Kh-4d
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1exzby-0007fV-9e
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:34:23 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:40458)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1exzby-0007eR-2p
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 14:34:22 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1exzbx-00030v-4K
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 18:34:21 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Mar 2018 18:34:07 +0000
Message-Id: <20180319183415.1976-6-peter.maydell@linaro.org>
In-Reply-To: <20180319183415.1976-1-peter.maydell@linaro.org>
References: <20180319183415.1976-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 05/13] hw/arm/raspi: Don't do board-setup or
 secure-boot for raspi3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

For the rpi1 and 2 we want to boot the Linux kernel via some
custom setup code that makes sure that the SMC instruction
acts as a no-op, because it's used for cache maintenance.
The rpi3 boots AArch64 kernels, which don't need SMC for
cache maintenance and always expect to be booted non-secure.
Don't fill in the aarch32-specific parts of the binfo struct.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Andrew Baumann <Andrew.Baumann@microsoft.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Message-id: 20180313153458.26822-2-peter.maydell@linaro.org
---
 hw/arm/raspi.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/hw/arm/raspi.c b/hw/arm/raspi.c
index a37881433c..1ac0737149 100644
--- a/hw/arm/raspi.c
+++ b/hw/arm/raspi.c
@@ -82,10 +82,19 @@ static void setup_boot(MachineState *machine, int version, size_t ram_size)
     binfo.board_id = raspi_boardid[version];
     binfo.ram_size = ram_size;
     binfo.nb_cpus = smp_cpus;
-    binfo.board_setup_addr = BOARDSETUP_ADDR;
-    binfo.write_board_setup = write_board_setup;
-    binfo.secure_board_setup = true;
-    binfo.secure_boot = true;
+
+    if (version <= 2) {
+        /* The rpi1 and 2 require some custom setup code to run in Secure
+         * mode before booting a kernel (to set up the SMC vectors so
+         * that we get a no-op SMC; this is used by Linux to call the
+         * firmware for some cache maintenance operations.
+         * The rpi3 doesn't need this.
+         */
+        binfo.board_setup_addr = BOARDSETUP_ADDR;
+        binfo.write_board_setup = write_board_setup;
+        binfo.secure_board_setup = true;
+        binfo.secure_boot = true;
+    }
 
     /* Pi2 and Pi3 requires SMP setup */
     if (version >= 2) {
-- 
2.16.2
