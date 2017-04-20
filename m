Received: from eggs.gnu.org ([2001:4830:134:3::10]:43726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F92-0008PU-HK
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F90-00086e-7I
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:24 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:36886)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1d1F8z-00084S-Uf
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 12:41:22 -0400
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1d1F8w-0006x9-4Z
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 17:41:18 +0100
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Apr 2017 17:41:00 +0100
Message-Id: <1492706470-10921-15-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
References: <1492706470-10921-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 14/24] cadence_gem: Make the revision a property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Alistair Francis <alistair.francis@xilinx.com>

Expose the Cadence GEM revision as a property.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-id: 541324373cf87b50f8be0439a0cb89f5028b016f.1491947224.git.alistair.francis@xilinx.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 include/hw/net/cadence_gem.h | 1 +
 hw/net/cadence_gem.c         | 6 +++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
index c469ffe..35de622 100644
--- a/include/hw/net/cadence_gem.h
+++ b/include/hw/net/cadence_gem.h
@@ -50,6 +50,7 @@ typedef struct CadenceGEMState {
     uint8_t num_priority_queues;
     uint8_t num_type1_screeners;
     uint8_t num_type2_screeners;
+    uint32_t revision;
 
     /* GEM registers backing store */
     uint32_t regs[CADENCE_GEM_MAXREG];
diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index e1962e1..3943187 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -300,6 +300,8 @@
 #define DESC_1_RX_SOF 0x00004000
 #define DESC_1_RX_EOF 0x00008000
 
+#define GEM_MODID_VALUE 0x00020118
+
 static inline unsigned tx_desc_get_buffer(unsigned *desc)
 {
     return desc[0];
@@ -1223,7 +1225,7 @@ static void gem_reset(DeviceState *d)
     s->regs[GEM_TXPAUSE] = 0x0000ffff;
     s->regs[GEM_TXPARTIALSF] = 0x000003ff;
     s->regs[GEM_RXPARTIALSF] = 0x000003ff;
-    s->regs[GEM_MODID] = 0x00020118;
+    s->regs[GEM_MODID] = s->revision;
     s->regs[GEM_DESCONF] = 0x02500111;
     s->regs[GEM_DESCONF2] = 0x2ab13fff;
     s->regs[GEM_DESCONF5] = 0x002f2145;
@@ -1519,6 +1521,8 @@ static const VMStateDescription vmstate_cadence_gem = {
 
 static Property gem_properties[] = {
     DEFINE_NIC_PROPERTIES(CadenceGEMState, conf),
+    DEFINE_PROP_UINT32("revision", CadenceGEMState, revision,
+                       GEM_MODID_VALUE),
     DEFINE_PROP_UINT8("num-priority-queues", CadenceGEMState,
                       num_priority_queues, 1),
     DEFINE_PROP_UINT8("num-type1-screeners", CadenceGEMState,
-- 
2.7.4
