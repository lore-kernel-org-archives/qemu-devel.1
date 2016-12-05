Received: from eggs.gnu.org ([2001:4830:134:3::10]:35276)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cE16v-0006og-GL
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:47:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eric.auger@redhat.com>) id 1cE16u-0002JF-Hh
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 16:47:45 -0500
From: Eric Auger <eric.auger@redhat.com>
Date: Mon,  5 Dec 2016 22:46:40 +0100
Message-Id: <1480974406-29345-10-git-send-email-eric.auger@redhat.com>
In-Reply-To: <1480974406-29345-1-git-send-email-eric.auger@redhat.com>
References: <1480974406-29345-1-git-send-email-eric.auger@redhat.com>
Subject: [Qemu-devel] [kvm-unit-tests RFC 09/15] arm/arm64: ITS: Parse the
 typer register
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

Parse the ITS TYPER and populates the associate its_data field.
Some of the info are needed for command handling, typically the
PTA bit which reports the target address encoding type.

Signed-off-by: Eric Auger <eric.auger@redhat.com>
---
 lib/arm/asm/gic-v3-its.h | 23 +++++++++++++++++++++++
 lib/arm/gic-v3-its.c     | 26 ++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/lib/arm/asm/gic-v3-its.h b/lib/arm/asm/gic-v3-its.h
index 3e36a2a..353db6f 100644
--- a/lib/arm/asm/gic-v3-its.h
+++ b/lib/arm/asm/gic-v3-its.h
@@ -33,11 +33,19 @@
 #define GICR_PROPBASER_InnerShareable                                   \
 	GIC_BASER_SHAREABILITY(GICR_PROPBASER, InnerShareable)
 
+#define GITS_TYPER                      0x0008
 #define GITS_CBASER                     0x0080
 #define GITS_CWRITER                    0x0088
 #define GITS_CREADR                     0x0090
 #define GITS_BASER                      0x0100
 
+#define GITS_TYPER_PLPIS                (1UL << 0)
+#define GITS_TYPER_IDBITS_SHIFT         8
+#define GITS_TYPER_DEVBITS_SHIFT        13
+#define GITS_TYPER_DEVBITS(r)           ((((r) >> GITS_TYPER_DEVBITS_SHIFT) & 0x1f) + 1)
+#define GITS_TYPER_PTA                  (1UL << 19)
+#define GITS_TYPER_HWCOLLCNT_SHIFT      24
+
 #define GITS_CBASER_VALID                       (1UL << 63)
 #define GITS_CBASER_SHAREABILITY_SHIFT          (10)
 #define GITS_CBASER_INNER_CACHEABILITY_SHIFT    (59)
@@ -130,12 +138,26 @@ struct its_cmd_block {
 	u64     raw_cmd[4];
 };
 
+struct its_typer {
+	unsigned int ite_size;
+	unsigned int event_id_bits;
+	unsigned int device_id_bits;
+	unsigned int collection_id_bits;
+	unsigned int hardware_collectionc_count;
+	bool pta;
+	bool cil;
+	bool cct;
+	bool phys_lpi;
+	bool virt_lpi;
+};
+
 struct its_data {
 	void *base;
 	struct its_cmd_block *cmd_base;
 	struct its_cmd_block *cmd_write;
 	struct its_cmd_block *cmd_readr;
 	struct its_baser baser[GITS_BASER_NR_REGS];
+	struct its_typer typer;
 	u64 flags;
 };
 
@@ -143,6 +165,7 @@ extern struct its_data its_data;
 
 #define gicv3_its_base()		(its_data.base)
 
+extern void its_parse_typer(void);
 extern int its_parse_baser(int i, struct its_baser *baser);
 extern void its_setup_baser(int i, struct its_baser *baser);
 extern void enable_lpi(u32 redist);
diff --git a/lib/arm/gic-v3-its.c b/lib/arm/gic-v3-its.c
index 7c768a5..c8ffa53 100644
--- a/lib/arm/gic-v3-its.c
+++ b/lib/arm/gic-v3-its.c
@@ -17,6 +17,32 @@ static const char * const its_base_type_string[] = {
 	[GITS_BASER_TYPE_RESERVED7]     = "Reserved (7)",
 };
 
+void its_parse_typer(void)
+{
+	u64 typer;
+
+	typer = gicv3_read_typer(gicv3_its_base() + GITS_TYPER);
+
+	its_data.typer.ite_size = ((typer >> 4) & 0xf) + 1;
+	its_data.typer.pta = typer & GITS_TYPER_PTA;
+	its_data.typer.event_id_bits =
+		((typer >> GITS_TYPER_IDBITS_SHIFT) & 0x1f) + 1;
+	its_data.typer.device_id_bits = GITS_TYPER_DEVBITS(typer)+1;
+
+	its_data.typer.cil = (typer >> 36) & 0x1;
+	if (its_data.typer.cil)
+		its_data.typer.collection_id_bits = ((typer >> 32) & 0xf) + 1;
+	else
+		its_data.typer.collection_id_bits = 16;
+
+	its_data.typer.hardware_collectionc_count =
+		(typer >> GITS_TYPER_HWCOLLCNT_SHIFT) & 0xff;
+
+	its_data.typer.cct = typer & 0x4;
+	its_data.typer.virt_lpi = typer & 0x2;
+	its_data.typer.phys_lpi = typer & GITS_TYPER_PLPIS;
+}
+
 int its_parse_baser(int i, struct its_baser *baser)
 {
 	void *reg_addr = gicv3_its_base() + GITS_BASER + i * 8;
-- 
2.5.5
