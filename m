Received: from eggs.gnu.org ([2001:4830:134:3::10]:32909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAeA-0007hM-Un
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAe9-0002pL-Jh
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:46 -0500
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:48440)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1cbAe9-0002gg-Bx
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 13:37:45 -0500
Received: from pm215 by orth.archaic.org.uk with local (Exim 4.84_2)
	(envelope-from <pm215@archaic.org.uk>) id 1cbAdq-0005Rk-QI
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:37:26 +0000
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  7 Feb 2017 18:37:13 +0000
Message-Id: <1486492645-27803-2-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
References: <1486492645-27803-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PULL 01/13] integratorcp: adding vmstate for
 save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

VMState added by this patch preserves correct
loading of the integratorcp device state.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Message-id: 20170131114310.6768.79416.stgit@PASHA-ISP
[PMM: removed unnecessary minimum_version_id_old lines]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/integratorcp.c | 59 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 59 insertions(+)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 039812a..f81634d 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -53,6 +53,26 @@ static uint8_t integrator_spd[128] = {
    0xe, 4, 0x1c, 1, 2, 0x20, 0xc0, 0, 0, 0, 0, 0x30, 0x28, 0x30, 0x28, 0x40
 };
 
+static const VMStateDescription vmstate_integratorcm = {
+    .name = "integratorcm",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_UINT32(cm_osc, IntegratorCMState),
+        VMSTATE_UINT32(cm_ctrl, IntegratorCMState),
+        VMSTATE_UINT32(cm_lock, IntegratorCMState),
+        VMSTATE_UINT32(cm_auxosc, IntegratorCMState),
+        VMSTATE_UINT32(cm_sdram, IntegratorCMState),
+        VMSTATE_UINT32(cm_init, IntegratorCMState),
+        VMSTATE_UINT32(cm_flags, IntegratorCMState),
+        VMSTATE_UINT32(cm_nvflags, IntegratorCMState),
+        VMSTATE_UINT32(int_level, IntegratorCMState),
+        VMSTATE_UINT32(irq_enabled, IntegratorCMState),
+        VMSTATE_UINT32(fiq_enabled, IntegratorCMState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static uint64_t integratorcm_read(void *opaque, hwaddr offset,
                                   unsigned size)
 {
@@ -309,6 +329,18 @@ typedef struct icp_pic_state {
     qemu_irq parent_fiq;
 } icp_pic_state;
 
+static const VMStateDescription vmstate_icp_pic = {
+    .name = "icp_pic",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_UINT32(level, icp_pic_state),
+        VMSTATE_UINT32(irq_enabled, icp_pic_state),
+        VMSTATE_UINT32(fiq_enabled, icp_pic_state),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void icp_pic_update(icp_pic_state *s)
 {
     uint32_t flags;
@@ -438,6 +470,16 @@ typedef struct ICPCtrlRegsState {
 #define ICP_INTREG_WPROT        (1 << 0)
 #define ICP_INTREG_CARDIN       (1 << 3)
 
+static const VMStateDescription vmstate_icp_control = {
+    .name = "icp_control",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_UINT32(intreg_state, ICPCtrlRegsState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static uint64_t icp_control_read(void *opaque, hwaddr offset,
                                  unsigned size)
 {
@@ -640,6 +682,21 @@ static void core_class_init(ObjectClass *klass, void *data)
 
     dc->props = core_properties;
     dc->realize = integratorcm_realize;
+    dc->vmsd = &vmstate_integratorcm;
+}
+
+static void icp_pic_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_icp_pic;
+}
+
+static void icp_control_class_init(ObjectClass *klass, void *data)
+{
+    DeviceClass *dc = DEVICE_CLASS(klass);
+
+    dc->vmsd = &vmstate_icp_control;
 }
 
 static const TypeInfo core_info = {
@@ -655,6 +712,7 @@ static const TypeInfo icp_pic_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(icp_pic_state),
     .instance_init = icp_pic_init,
+    .class_init    = icp_pic_class_init,
 };
 
 static const TypeInfo icp_ctrl_regs_info = {
@@ -662,6 +720,7 @@ static const TypeInfo icp_ctrl_regs_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(ICPCtrlRegsState),
     .instance_init = icp_control_init,
+    .class_init    = icp_control_class_init,
 };
 
 static void integratorcp_register_types(void)
-- 
2.7.4
