Received: from eggs.gnu.org ([2001:4830:134:3::10]:60278)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gJzh2-0008If-BN
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:38:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1gJzh1-0004PE-FJ
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:38:48 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:52310)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1gJzh1-00049H-9E
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 06:38:47 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.89)
	(envelope-from <pm215@archaic.org.uk>) id 1gJzgl-0007cp-7j
	for qemu-devel@nongnu.org; Tue, 06 Nov 2018 11:38:31 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  6 Nov 2018 11:38:23 +0000
Message-Id: <20181106113826.25810-3-peter.maydell@linaro.org>
In-Reply-To: <20181106113826.25810-1-peter.maydell@linaro.org>
References: <20181106113826.25810-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 2/5] milkymist: Check for failure trying to load
 BIOS image
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Check the return value from load_image_targphys(), which tells us
whether our attempt to load the BIOS image into RAM failed.
(Spotted by Coverity, CID 1190305.)

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Michael Walle <michael@walle.cc>
Message-id: 20181030170032.1844-1-peter.maydell@linaro.org
---
 hw/lm32/milkymist.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/hw/lm32/milkymist.c b/hw/lm32/milkymist.c
index 321f184595e..63c6894c955 100644
--- a/hw/lm32/milkymist.c
+++ b/hw/lm32/milkymist.c
@@ -138,7 +138,10 @@ milkymist_init(MachineState *machine)
     bios_filename = qemu_find_file(QEMU_FILE_TYPE_BIOS, bios_name);
 
     if (bios_filename) {
-        load_image_targphys(bios_filename, BIOS_OFFSET, BIOS_SIZE);
+        if (load_image_targphys(bios_filename, BIOS_OFFSET, BIOS_SIZE) < 0) {
+            error_report("could not load bios '%s'", bios_filename);
+            exit(1);
+        }
     }
 
     reset_info->bootstrap_pc = BIOS_OFFSET;
-- 
2.19.1
