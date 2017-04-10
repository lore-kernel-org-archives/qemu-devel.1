Received: from eggs.gnu.org ([2001:4830:134:3::10]:59415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cxj0x-0001dA-S7
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 19:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cxj0u-0002Tk-Gu
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 19:46:31 -0400
Received: from mail-bn3nam01on0069.outbound.protection.outlook.com
	([104.47.33.69]:40425
	helo=NAM01-BN3-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1cxj0u-0002TL-BI
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 19:46:28 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Mon, 10 Apr 2017 16:43:51 -0700
Message-ID: <e390147004f3a3d3fb0642dc6c9d91be585cfd97.1491865973.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1491865973.git.alistair.francis@xilinx.com>
References: <cover.1491865973.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 4/5] cadence_gem: Make the revision a
 property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: alistair.francis@xilinx.com, alistair23@gmail.com, f4bug@amsat.org

Expose the Cadence GEM revision as a property.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---

 hw/net/cadence_gem.c         | 6 +++++-
 include/hw/net/cadence_gem.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index fc3a184..fe0a49f 100644
--- a/hw/net/cadence_gem.c
+++ b/hw/net/cadence_gem.c
@@ -300,6 +300,8 @@
 #define DESC_1_RX_SOF 0x00004000
 #define DESC_1_RX_EOF 0x00008000
=20
+#define GEM_MODID_VALUE 0x00020118
+
 static inline unsigned tx_desc_get_buffer(unsigned *desc)
 {
     return desc[0];
@@ -1223,7 +1225,7 @@ static void gem_reset(DeviceState *d)
     s->regs[GEM_TXPAUSE] =3D 0x0000ffff;
     s->regs[GEM_TXPARTIALSF] =3D 0x000003ff;
     s->regs[GEM_RXPARTIALSF] =3D 0x000003ff;
-    s->regs[GEM_MODID] =3D 0x00020118;
+    s->regs[GEM_MODID] =3D s->revision;
     s->regs[GEM_DESCONF] =3D 0x02500111;
     s->regs[GEM_DESCONF2] =3D 0x2ab13fff;
     s->regs[GEM_DESCONF5] =3D 0x002f2145;
@@ -1519,6 +1521,8 @@ static const VMStateDescription vmstate_cadence_gem =
=3D {
=20
 static Property gem_properties[] =3D {
     DEFINE_NIC_PROPERTIES(CadenceGEMState, conf),
+    DEFINE_PROP_UINT32("revision", CadenceGEMState, revision,
+                       GEM_MODID_VALUE),
     DEFINE_PROP_UINT8("num-priority-queues", CadenceGEMState,
                       num_priority_queues, 1),
     DEFINE_PROP_UINT8("num-type1-screeners", CadenceGEMState,
diff --git a/include/hw/net/cadence_gem.h b/include/hw/net/cadence_gem.h
index c469ffe..35de622 100644
--- a/include/hw/net/cadence_gem.h
+++ b/include/hw/net/cadence_gem.h
@@ -50,6 +50,7 @@ typedef struct CadenceGEMState {
     uint8_t num_priority_queues;
     uint8_t num_type1_screeners;
     uint8_t num_type2_screeners;
+    uint32_t revision;
=20
     /* GEM registers backing store */
     uint32_t regs[CADENCE_GEM_MAXREG];
--=20
2.9.3
