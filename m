Received: from eggs.gnu.org ([2001:4830:134:3::10]:35458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cE17A-00072a-G3
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:48:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cE178-0002Ng-OD
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:48:00 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  5 Dec 2016 22:46:44 +0100
Message-Id: <1480974406-29345-14-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1480974406-29345-1-git-send-email-eric.auger@redhat.com>
References: <1480974406-29345-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests RFC 13/15] arm/arm64: ITS: commands
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: eric.auger.pro@gmail.com, eric.auger@redhat.com, kvm@vger.kernel.org, kvmarm@lists.cs.columbia.edu, qemu-devel@nongnu.org, qemu-arm@nongnu.org, drjones@redhat.com, marc.zyngier@arm.com, christoffer.dall@linaro.org
Cc: andre.przywara@arm.com, peter.maydell@linaro.org, alex.bennee@linaro.org, pbonzini@redhat.com

Implement main ITS commands. The code is largely inherited from
the ITS driver.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 arm/Makefile.common      |   2 +-
 lib/arm/asm/gic-v3-its.h |  31 ++++
 lib/arm/gic-v3-its-cmd.c | 399 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 431 insertions(+), 1 deletion(-)
 create mode 100644 lib/arm/gic-v3-its-cmd.c

diff --git a/arm/Makefile.common b/arm/Makefile.common
index 070f349..4c91215 100644
--- a/arm/Makefile.common
+++ b/arm/Makefile.common
@@ -47,7 +47,7 @@ cflatobjs += lib/arm/bitops.o
 cflatobjs += lib/arm/psci.o
 cflatobjs += lib/arm/smp.o
 cflatobjs += lib/arm/gic.o lib/arm/gic-v2.o lib/arm/gic-v3.o
-cflatobjs += lib/arm/gic-v3-its.o
+cflatobjs += lib/arm/gic-v3-its.o lib/arm/gic-v3-its-cmd.o
 
 libeabi = lib/arm/libeabi.a
 eabiobjs = lib/arm/eabi_compat.o
diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
index af82b32..6130605 100644
--- a/lib/arm/asm/gic-v3-its.h
+++ b/lib/arm/asm/gic-v3-its.h
@@ -126,6 +126,24 @@
 
 #define GITS_MAX_DEVICES		8
 
+/*
+ * ITS commands
+ */
+#define GITS_CMD_MAPD                   0x08
+#define GITS_CMD_MAPC                   0x09
+#define GITS_CMD_MAPTI                  0x0a
+/* older GIC documentation used MAPVI for this command */
+#define GITS_CMD_MAPVI                  GITS_CMD_MAPTI
+#define GITS_CMD_MAPI                   0x0b
+#define GITS_CMD_MOVI                   0x01
+#define GITS_CMD_DISCARD                0x0f
+#define GITS_CMD_INV                    0x0c
+#define GITS_CMD_MOVALL                 0x0e
+#define GITS_CMD_INVALL                 0x0d
+#define GITS_CMD_INT                    0x03
+#define GITS_CMD_CLEAR                  0x04
+#define GITS_CMD_SYNC                   0x05
+
 struct its_baser {
 	unsigned int index;
 	int type;
@@ -192,6 +210,19 @@ extern void its_enable_defaults(void);
 extern struct its_device *its_create_device(u32 dev_id, int nvecs);
 extern struct its_collection *its_create_collection(u32 col_id, u32 target);
 
+extern void its_send_mapd(struct its_device *dev, int valid);
+extern void its_send_mapc(struct its_collection *col, int valid);
+extern void its_send_mapti(struct its_device *dev, u32 irq_id,
+			   u32 event_id, struct its_collection *col);
+extern void its_send_int(struct its_device *dev, u32 event_id);
+extern void its_send_movi(struct its_device *dev,
+			  struct its_collection *col, u32 id);
+extern void its_send_sync(struct its_collection *col);
+extern void its_print_cmd_state(void);
+
+#define ITS_FLAGS_CMDQ_NEEDS_FLUSHING           (1ULL << 0)
+#define ITS_FLAGS_WORKAROUND_CAVIUM_22375       (1ULL << 1)
+#define ITS_FLAGS_WORKAROUND_CAVIUM_23144       (1ULL << 2)
 
 #endif /* !__ASSEMBLY__ */
 #endif /* _ASMARM_GIC_V3_ITS_H_ */
diff --git a/lib/arm/gic-v3-its-cmd.c b/lib/arm/gic-v3-its-cmd.c
new file mode 100644
index 0000000..2559cc7
--- /dev/null
+++ b/lib/arm/gic-v3-its-cmd.c
@@ -0,0 +1,399 @@
+/*
+ * Copyright (C) 2016, Red Hat Inc, Eric Auger <eric.auger@redhat.com>
+ *
+ *  Most of the code is copy-pasted from:
+ * drivers/irqchip/irq-gic-v3-its.c
+ * This work is licensed under the terms of the GNU LGPL, version 2.
+ */
+#include <asm/io.h>
+#include <asm/gic.h>
+
+#define ITS_ITT_ALIGN           SZ_256
+
+static const char * const its_cmd_string[] = {
+	[GITS_CMD_MAPD]		= "MAPD",
+	[GITS_CMD_MAPC]		= "MAPC",
+	[GITS_CMD_MAPTI]	= "MAPTI",
+	[GITS_CMD_MAPI]		= "MAPI",
+	[GITS_CMD_MOVI]		= "MOVI",
+	[GITS_CMD_DISCARD]	= "DISCARD",
+	[GITS_CMD_INV]		= "INV",
+	[GITS_CMD_MOVALL]	= "MOVALL",
+	[GITS_CMD_INVALL]	= "INVALL",
+	[GITS_CMD_INT]		= "INT",
+	[GITS_CMD_CLEAR]	= "CLEAR",
+	[GITS_CMD_SYNC]		= "SYNC",
+};
+
+static void report_processed_cmd(struct its_cmd_block *cmd, bool pass)
+{
+	unsigned int cmd_id = cmd->raw_cmd[0] & 0xFF;
+
+	if (cmd_id > 0xf)
+		report("Unknown command", false);
+	else
+		report("%s processed", pass, its_cmd_string[cmd_id]);
+}
+
+
+struct its_cmd_desc {
+	union {
+		struct {
+			struct its_device *dev;
+			u32 event_id;
+		} its_inv_cmd;
+
+		struct {
+			struct its_device *dev;
+			u32 event_id;
+		} its_int_cmd;
+
+		struct {
+			struct its_device *dev;
+			int valid;
+		} its_mapd_cmd;
+
+		struct {
+			struct its_collection *col;
+			int valid;
+		} its_mapc_cmd;
+
+		struct {
+			struct its_device *dev;
+			u32 phys_id;
+			u32 event_id;
+			u32 col_id;
+		} its_mapti_cmd;
+
+		struct {
+			struct its_device *dev;
+			struct its_collection *col;
+			u32 event_id;
+		} its_movi_cmd;
+
+		struct {
+			struct its_device *dev;
+			u32 event_id;
+		} its_discard_cmd;
+
+		struct {
+			struct its_collection *col;
+		} its_invall_cmd;
+
+		struct {
+			struct its_collection *col;
+		} its_sync_cmd;
+	};
+};
+
+typedef struct its_collection *(*its_cmd_builder_t)(struct its_cmd_block *,
+						    struct its_cmd_desc *);
+
+/* ITS COMMANDS */
+
+static void its_encode_cmd(struct its_cmd_block *cmd, u8 cmd_nr)
+{
+	cmd->raw_cmd[0] &= ~0xffUL;
+	cmd->raw_cmd[0] |= cmd_nr;
+}
+
+static void its_encode_devid(struct its_cmd_block *cmd, u32 devid)
+{
+	cmd->raw_cmd[0] &= BIT_ULL(32) - 1;
+	cmd->raw_cmd[0] |= ((u64)devid) << 32;
+}
+
+static void its_encode_event_id(struct its_cmd_block *cmd, u32 id)
+{
+	cmd->raw_cmd[1] &= ~0xffffffffUL;
+	cmd->raw_cmd[1] |= id;
+}
+
+static void its_encode_phys_id(struct its_cmd_block *cmd, u32 phys_id)
+{
+	cmd->raw_cmd[1] &= 0xffffffffUL;
+	cmd->raw_cmd[1] |= ((u64)phys_id) << 32;
+}
+
+static void its_encode_size(struct its_cmd_block *cmd, u8 size)
+{
+	cmd->raw_cmd[1] &= ~0x1fUL;
+	cmd->raw_cmd[1] |= size & 0x1f;
+}
+
+static void its_encode_itt(struct its_cmd_block *cmd, u64 itt_addr)
+{
+	cmd->raw_cmd[2] &= ~0xffffffffffffUL;
+	cmd->raw_cmd[2] |= itt_addr & 0xffffffffff00UL;
+}
+
+static void its_encode_valid(struct its_cmd_block *cmd, int valid)
+{
+	cmd->raw_cmd[2] &= ~(1UL << 63);
+	cmd->raw_cmd[2] |= ((u64)!!valid) << 63;
+}
+
+static void its_encode_target(struct its_cmd_block *cmd, u64 target_addr)
+{
+	cmd->raw_cmd[2] &= ~(0xfffffffffUL << 16);
+	cmd->raw_cmd[2] |= (target_addr & (0xffffffffUL << 16));
+}
+
+static void its_encode_collection(struct its_cmd_block *cmd, u16 col)
+{
+	cmd->raw_cmd[2] &= ~0xffffUL;
+	cmd->raw_cmd[2] |= col;
+}
+
+static inline void its_fixup_cmd(struct its_cmd_block *cmd)
+{
+	/* Let's fixup BE commands */
+	cmd->raw_cmd[0] = cpu_to_le64(cmd->raw_cmd[0]);
+	cmd->raw_cmd[1] = cpu_to_le64(cmd->raw_cmd[1]);
+	cmd->raw_cmd[2] = cpu_to_le64(cmd->raw_cmd[2]);
+	cmd->raw_cmd[3] = cpu_to_le64(cmd->raw_cmd[3]);
+}
+
+static u64 its_cmd_ptr_to_offset(struct its_cmd_block *ptr)
+{
+	return (ptr - its_data.cmd_base) * sizeof(*ptr);
+}
+
+static struct its_cmd_block *its_post_commands()
+{
+	u64 wr = its_cmd_ptr_to_offset(its_data.cmd_write);
+
+	writeq(wr, its_data.base + GITS_CWRITER);
+	return its_data.cmd_write;
+}
+
+
+/* We just assume the queue is large enough */
+static struct its_cmd_block *its_allocate_entry()
+{
+	struct its_cmd_block *cmd;
+
+	cmd = its_data.cmd_write++;
+	return cmd;
+}
+
+//TODO: clarify flush implementation
+static void its_flush_cmd(struct its_cmd_block *cmd)
+{
+	if (its_data.flags & ITS_FLAGS_CMDQ_NEEDS_FLUSHING)
+		printf("%s unimplemented command queue flush %p\n",
+			__func__, cmd);
+}
+
+static void its_wait_for_range_completion(struct its_cmd_block *from,
+					  struct its_cmd_block *to)
+{
+	u64 rd_idx, from_idx, to_idx;
+	u32 count = 1000000;    /* 1s! */
+
+	from_idx = its_cmd_ptr_to_offset(from);
+	to_idx = its_cmd_ptr_to_offset(to);
+	while (1) {
+		rd_idx = readq(its_data.base + GITS_CREADR);
+		if (rd_idx >= to_idx || rd_idx < from_idx)
+			break;
+
+		count--;
+		if (!count) {
+			report_processed_cmd(from, false);
+			return;
+		}
+		cpu_relax();
+		udelay(1);
+	}
+	report_processed_cmd(from, true);
+}
+
+void its_print_cmd_state(void)
+{
+	u64 rd, wr;
+
+	rd = readq(its_data.base + GITS_CREADR);
+	wr = readq(its_data.base + GITS_CWRITER);
+	printf("GITS_CREADR=0x%lx GITS_CWRITER=0x%lx\n", rd, wr);
+}
+
+static void its_send_single_command(its_cmd_builder_t builder,
+				    struct its_cmd_desc *desc)
+{
+	struct its_cmd_block *cmd, *next_cmd;
+
+	cmd = its_allocate_entry();
+	builder(cmd, desc);
+	its_flush_cmd(cmd);
+	next_cmd = its_post_commands();
+
+	its_wait_for_range_completion(cmd, next_cmd);
+}
+
+
+static struct its_collection *its_build_mapd_cmd(struct its_cmd_block *cmd,
+						 struct its_cmd_desc *desc)
+{
+	unsigned long itt_addr;
+	u8 size = 12; //TODO ilog2(desc->its_mapd_cmd.dev->nr_ites);
+
+	itt_addr = (unsigned long)desc->its_mapd_cmd.dev->itt;
+	itt_addr = ALIGN(itt_addr, ITS_ITT_ALIGN);
+
+	printf("MAPD devid=%d size = 0x%x itt=0x%lx valid=%d\n",
+		desc->its_mapd_cmd.dev->device_id,
+		size, itt_addr, desc->its_mapd_cmd.valid);
+
+	its_encode_cmd(cmd, GITS_CMD_MAPD);
+	its_encode_devid(cmd, desc->its_mapd_cmd.dev->device_id);
+	its_encode_size(cmd, size - 1);
+	its_encode_itt(cmd, itt_addr);
+	its_encode_valid(cmd, desc->its_mapd_cmd.valid);
+
+	its_fixup_cmd(cmd);
+
+	return NULL;
+}
+
+static struct its_collection *its_build_mapc_cmd(struct its_cmd_block *cmd,
+						 struct its_cmd_desc *desc)
+{
+	its_encode_cmd(cmd, GITS_CMD_MAPC);
+	its_encode_collection(cmd, desc->its_mapc_cmd.col->col_id);
+	its_encode_target(cmd, desc->its_mapc_cmd.col->target_address);
+	its_encode_valid(cmd, desc->its_mapc_cmd.valid);
+
+	its_fixup_cmd(cmd);
+	printf("MAPC col_id=%d target_addr = 0x%lx valid=%d\n",
+		desc->its_mapc_cmd.col->col_id,
+		desc->its_mapc_cmd.col->target_address,
+		desc->its_mapc_cmd.valid);
+	return desc->its_mapc_cmd.col;
+}
+
+static struct its_collection *its_build_mapti_cmd(struct its_cmd_block *cmd,
+						  struct its_cmd_desc *desc)
+{
+	its_encode_cmd(cmd, GITS_CMD_MAPTI);
+	its_encode_devid(cmd, desc->its_mapti_cmd.dev->device_id);
+	its_encode_event_id(cmd, desc->its_mapti_cmd.event_id);
+	its_encode_phys_id(cmd, desc->its_mapti_cmd.phys_id);
+	its_encode_collection(cmd, desc->its_mapti_cmd.col_id);
+
+	its_fixup_cmd(cmd);
+	printf("MAPTI dev_id=%d event_id=%d -> phys_id=%d, col_id=%d\n",
+		desc->its_mapti_cmd.dev->device_id,
+		desc->its_mapti_cmd.event_id,
+		desc->its_mapti_cmd.phys_id,
+		desc->its_mapti_cmd.col_id);
+
+	return NULL;
+}
+
+static struct its_collection *its_build_int_cmd(struct its_cmd_block *cmd,
+						struct its_cmd_desc *desc)
+{
+	its_encode_cmd(cmd, GITS_CMD_INT);
+	its_encode_devid(cmd, desc->its_int_cmd.dev->device_id);
+	its_encode_event_id(cmd, desc->its_int_cmd.event_id);
+
+	its_fixup_cmd(cmd);
+	printf("INT dev_id=%d event_id=%d\n",
+		desc->its_int_cmd.dev->device_id, desc->its_int_cmd.event_id);
+	return NULL;
+}
+
+static struct its_collection *its_build_sync_cmd(struct its_cmd_block *cmd,
+						 struct its_cmd_desc *desc)
+{
+	its_encode_cmd(cmd, GITS_CMD_SYNC);
+	its_encode_target(cmd, desc->its_sync_cmd.col->target_address);
+	its_fixup_cmd(cmd);
+	printf("SYNC target_addr = 0x%lx\n",
+		desc->its_sync_cmd.col->target_address);
+	return NULL;
+}
+
+static struct its_collection *its_build_movi_cmd(struct its_cmd_block *cmd,
+						 struct its_cmd_desc *desc)
+{
+	its_encode_cmd(cmd, GITS_CMD_MOVI);
+	its_encode_devid(cmd, desc->its_movi_cmd.dev->device_id);
+	its_encode_event_id(cmd, desc->its_movi_cmd.event_id);
+	its_encode_collection(cmd, desc->its_movi_cmd.col->col_id);
+
+	its_fixup_cmd(cmd);
+	printf("MOVI dev_id=%d event_id = %d col_id=%d\n",
+		desc->its_movi_cmd.dev->device_id,
+		desc->its_movi_cmd.event_id,
+		desc->its_movi_cmd.col->col_id);
+
+	return NULL;
+}
+
+void its_send_mapd(struct its_device *dev, int valid)
+{
+	struct its_cmd_desc desc;
+
+	desc.its_mapd_cmd.dev = dev;
+	desc.its_mapd_cmd.valid = !!valid;
+
+	its_send_single_command(its_build_mapd_cmd, &desc);
+}
+
+void its_send_mapc(struct its_collection *col, int valid)
+{
+	struct its_cmd_desc desc;
+
+	desc.its_mapc_cmd.col = col;
+	desc.its_mapc_cmd.valid = !!valid;
+
+	its_send_single_command(its_build_mapc_cmd, &desc);
+}
+
+void its_send_mapti(struct its_device *dev, u32 irq_id,
+		    u32 event_id, struct its_collection *col)
+{
+	struct its_cmd_desc desc;
+
+	desc.its_mapti_cmd.dev = dev;
+	desc.its_mapti_cmd.phys_id = irq_id;
+	desc.its_mapti_cmd.event_id = event_id;
+	desc.its_mapti_cmd.col_id = col->col_id;
+
+	its_send_single_command(its_build_mapti_cmd, &desc);
+}
+
+void its_send_int(struct its_device *dev, u32 event_id)
+{
+	struct its_cmd_desc desc;
+
+	desc.its_int_cmd.dev = dev;
+	desc.its_int_cmd.event_id = event_id;
+
+	its_send_single_command(its_build_int_cmd, &desc);
+}
+
+void its_send_movi(struct its_device *dev,
+		   struct its_collection *col, u32 id)
+{
+	struct its_cmd_desc desc;
+
+	desc.its_movi_cmd.dev = dev;
+	desc.its_movi_cmd.col = col;
+	desc.its_movi_cmd.event_id = id;
+
+	its_send_single_command(its_build_movi_cmd, &desc);
+}
+
+
+void its_send_sync(struct its_collection *col)
+{
+	struct its_cmd_desc desc;
+
+	desc.its_sync_cmd.col = col;
+
+	its_send_single_command(its_build_sync_cmd, &desc);
+}
+
-- 
2.5.5
