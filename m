Received: from eggs.gnu.org ([2001:4830:134:3::10]:39948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cYWqB-0002vB-NG
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 06:43:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cYWq6-0004cj-RD
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 06:43:15 -0500
Received: from mail.ispras.ru ([83.149.199.45]:56306)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pavel.dovgaluk@ispras.ru>) id 1cYWq6-0004cd-FR
	for qemu-devel@nongnu.org; Tue, 31 Jan 2017 06:43:10 -0500
From: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
Date: Tue, 31 Jan 2017 14:43:10 +0300
Message-ID: <20170131114310.6768.79416.stgit@PASHA-ISP>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: [Qemu-devel] [PATCH] integratorcp: adding vmstate for save/restore
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, dovgaluk@ispras.ru, peter.maydell@linaro.org

From: Pavel Dovgalyuk <Pavel.Dovgaluk@ispras.ru>

VMState added by this patch preserves correct
loading of the integratorcp device state.

Signed-off-by: Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>
---
 hw/arm/integratorcp.c |   62 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 62 insertions(+)

diff --git a/hw/arm/integratorcp.c b/hw/arm/integratorcp.c
index 039812a..ca06e1b 100644
--- a/hw/arm/integratorcp.c
+++ b/hw/arm/integratorcp.c
@@ -53,6 +53,27 @@ static uint8_t integrator_spd[128] = {
    0xe, 4, 0x1c, 1, 2, 0x20, 0xc0, 0, 0, 0, 0, 0x30, 0x28, 0x30, 0x28, 0x40
 };
 
+static const VMStateDescription vmstate_integratorcm = {
+    .name = "integratorcm",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .minimum_version_id_old = 1,
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
@@ -309,6 +330,19 @@ typedef struct icp_pic_state {
     qemu_irq parent_fiq;
 } icp_pic_state;
 
+static const VMStateDescription vmstate_icp_pic = {
+    .name = "icp_pic",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .minimum_version_id_old = 1,
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
@@ -438,6 +472,17 @@ typedef struct ICPCtrlRegsState {
 #define ICP_INTREG_WPROT        (1 << 0)
 #define ICP_INTREG_CARDIN       (1 << 3)
 
+static const VMStateDescription vmstate_icp_control = {
+    .name = "icp_control",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .minimum_version_id_old = 1,
+    .fields      = (VMStateField[]) {
+        VMSTATE_UINT32(intreg_state, ICPCtrlRegsState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static uint64_t icp_control_read(void *opaque, hwaddr offset,
                                  unsigned size)
 {
@@ -640,6 +685,21 @@ static void core_class_init(ObjectClass *klass, void *data)
 
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
@@ -655,6 +715,7 @@ static const TypeInfo icp_pic_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(icp_pic_state),
     .instance_init = icp_pic_init,
+    .class_init    = icp_pic_class_init,
 };
 
 static const TypeInfo icp_ctrl_regs_info = {
@@ -662,6 +723,7 @@ static const TypeInfo icp_ctrl_regs_info = {
     .parent        = TYPE_SYS_BUS_DEVICE,
     .instance_size = sizeof(ICPCtrlRegsState),
     .instance_init = icp_control_init,
+    .class_init    = icp_control_class_init,
 };
 
 static void integratorcp_register_types(void)
