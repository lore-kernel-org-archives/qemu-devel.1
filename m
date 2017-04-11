Received: from eggs.gnu.org ([2001:4830:134:3::10]:41085)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cy4LT-0000LS-U2
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 18:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistai@xilinx.com>) id 1cy4LP-0005fU-Tt
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 18:33:07 -0400
Received: from mail-by2nam03on0072.outbound.protection.outlook.com
	([104.47.42.72]:30064
	helo=NAM03-BY2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alistai@xilinx.com>) id 1cy4LP-0005fN-KX
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 18:33:03 -0400
From: Alistair Francis <alistair.francis@xilinx.com>
Date: Tue, 11 Apr 2017 15:30:25 -0700
Message-ID: <541324373cf87b50f8be0439a0cb89f5028b016f.1491947224.git.alistair.francis@xilinx.com>
In-Reply-To: <cover.1491947224.git.alistair.francis@xilinx.com>
References: <cover.1491947224.git.alistair.francis@xilinx.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 4/5] cadence_gem: Make the revision a
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
Cc: f4bug@amsat.org, alistair.francis@xilinx.com, alistair23@gmail.com

Expose the Cadence GEM revision as a property.

Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
---

 hw/net/cadence_gem.c         | 6 +++++-
 include/hw/net/cadence_gem.h | 1 +
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/hw/net/cadence_gem.c b/hw/net/cadence_gem.c
index e1962e1..3943187 100644
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
