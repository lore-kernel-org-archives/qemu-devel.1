Received: from eggs.gnu.org ([2001:4830:134:3::10]:38839)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e9YL3-0000yU-Hq
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 11:20:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1e9YKv-0000bR-IS
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 11:20:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35778)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1e9YKv-0000al-83
	for qemu-devel@nongnu.org; Tue, 31 Oct 2017 11:20:17 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue, 31 Oct 2017 16:19:35 +0100
Message-Id: <20171031151938.14982-3-marcandre.lureau@redhat.com>
In-Reply-To: <20171031151938.14982-1-marcandre.lureau@redhat.com>
References: <20171031151938.14982-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 2/5] fw_cfg: add DMA register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: linux-kernel@vger.kernel.org
Cc: somlo@cmu.edu, qemu-devel@nongnu.org, mst@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Add an optional <dma_off> kernel module (or command line) parameter
using the following syntax:

      [qemu_fw_cfg.]ioport=3D<size>@<base>[:<ctrl_off>:<data_off>[:<dma_o=
ff>]]
 or
      [qemu_fw_cfg.]mmio=3D<size>@<base>[:<ctrl_off>:<data_off>[:<dma_off=
>]]

and initializes the register address using given or default offset.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 drivers/firmware/qemu_fw_cfg.c | 53 ++++++++++++++++++++++++++++++++----=
------
 1 file changed, 41 insertions(+), 12 deletions(-)

diff --git a/drivers/firmware/qemu_fw_cfg.c b/drivers/firmware/qemu_fw_cf=
g.c
index 5cfe39f7a45f..1f3e8545dab7 100644
--- a/drivers/firmware/qemu_fw_cfg.c
+++ b/drivers/firmware/qemu_fw_cfg.c
@@ -10,20 +10,21 @@
  * and select subsets of aarch64), a Device Tree node (on arm), or using
  * a kernel module (or command line) parameter with the following syntax=
:
  *
- *      [qemu_fw_cfg.]ioport=3D<size>@<base>[:<ctrl_off>:<data_off>]
+ *      [qemu_fw_cfg.]ioport=3D<size>@<base>[:<ctrl_off>:<data_off>[:<dm=
a_off>]]
  * or
- *      [qemu_fw_cfg.]mmio=3D<size>@<base>[:<ctrl_off>:<data_off>]
+ *      [qemu_fw_cfg.]mmio=3D<size>@<base>[:<ctrl_off>:<data_off>[:<dma_=
off>]]
  *
  * where:
  *      <size>     :=3D size of ioport or mmio range
  *      <base>     :=3D physical base address of ioport or mmio range
  *      <ctrl_off> :=3D (optional) offset of control register
  *      <data_off> :=3D (optional) offset of data register
+ *      <dma_off> :=3D (optional) offset of dma register
  *
  * e.g.:
- *      qemu_fw_cfg.ioport=3D2@0x510:0:1		(the default on x86)
+ *      qemu_fw_cfg.ioport=3D12@0x510:0:1:4	(the default on x86)
  * or
- *      qemu_fw_cfg.mmio=3D0xA@0x9020000:8:0	(the default on arm)
+ *      qemu_fw_cfg.mmio=3D16@0x9020000:8:0:16	(the default on arm)
  */
=20
 #include <linux/module.h>
@@ -63,6 +64,7 @@ static resource_size_t fw_cfg_p_size;
 static void __iomem *fw_cfg_dev_base;
 static void __iomem *fw_cfg_reg_ctrl;
 static void __iomem *fw_cfg_reg_data;
+static void __iomem *fw_cfg_reg_dma;
=20
 /* atomic access to fw_cfg device (potentially slow i/o, so using mutex)=
 */
 static DEFINE_MUTEX(fw_cfg_dev_lock);
@@ -118,12 +120,14 @@ static void fw_cfg_io_cleanup(void)
 # if (defined(CONFIG_ARM) || defined(CONFIG_ARM64))
 #  define FW_CFG_CTRL_OFF 0x08
 #  define FW_CFG_DATA_OFF 0x00
+#  define FW_CFG_DMA_OFF 0x10
 # elif (defined(CONFIG_PPC_PMAC) || defined(CONFIG_SPARC32)) /* ppc/mac,=
sun4m */
 #  define FW_CFG_CTRL_OFF 0x00
 #  define FW_CFG_DATA_OFF 0x02
 # elif (defined(CONFIG_X86) || defined(CONFIG_SPARC64)) /* x86, sun4u */
 #  define FW_CFG_CTRL_OFF 0x00
 #  define FW_CFG_DATA_OFF 0x01
+#  define FW_CFG_DMA_OFF 0x04
 # else
 #  error "QEMU FW_CFG not available on this architecture!"
 # endif
@@ -133,7 +137,7 @@ static void fw_cfg_io_cleanup(void)
 static int fw_cfg_do_platform_probe(struct platform_device *pdev)
 {
 	char sig[FW_CFG_SIG_SIZE];
-	struct resource *range, *ctrl, *data;
+	struct resource *range, *ctrl, *data, *dma;
=20
 	/* acquire i/o range details */
 	fw_cfg_is_mmio =3D false;
@@ -170,6 +174,7 @@ static int fw_cfg_do_platform_probe(struct platform_d=
evice *pdev)
 	/* were custom register offsets provided (e.g. on the command line)? */
 	ctrl =3D platform_get_resource_byname(pdev, IORESOURCE_REG, "ctrl");
 	data =3D platform_get_resource_byname(pdev, IORESOURCE_REG, "data");
+	dma =3D platform_get_resource_byname(pdev, IORESOURCE_REG, "dma");
 	if (ctrl && data) {
 		fw_cfg_reg_ctrl =3D fw_cfg_dev_base + ctrl->start;
 		fw_cfg_reg_data =3D fw_cfg_dev_base + data->start;
@@ -179,6 +184,13 @@ static int fw_cfg_do_platform_probe(struct platform_=
device *pdev)
 		fw_cfg_reg_data =3D fw_cfg_dev_base + FW_CFG_DATA_OFF;
 	}
=20
+	if (dma)
+		fw_cfg_reg_dma =3D fw_cfg_dev_base + dma->start;
+#ifdef FW_CFG_DMA_OFF
+	else
+		fw_cfg_reg_dma =3D fw_cfg_dev_base + FW_CFG_DMA_OFF;
+#endif
+
 	/* verify fw_cfg device signature */
 	fw_cfg_read_blob(FW_CFG_SIGNATURE, sig, 0, FW_CFG_SIG_SIZE);
 	if (memcmp(sig, "QEMU", FW_CFG_SIG_SIZE) !=3D 0) {
@@ -628,6 +640,7 @@ static struct platform_device *fw_cfg_cmdline_dev;
 /* use special scanf/printf modifier for phys_addr_t, resource_size_t */
 #define PH_ADDR_SCAN_FMT "@%" __PHYS_ADDR_PREFIX "i%n" \
 			 ":%" __PHYS_ADDR_PREFIX "i" \
+			 ":%" __PHYS_ADDR_PREFIX "i%n" \
 			 ":%" __PHYS_ADDR_PREFIX "i%n"
=20
 #define PH_ADDR_PR_1_FMT "0x%" __PHYS_ADDR_PREFIX "x@" \
@@ -637,12 +650,15 @@ static struct platform_device *fw_cfg_cmdline_dev;
 			 ":%" __PHYS_ADDR_PREFIX "u" \
 			 ":%" __PHYS_ADDR_PREFIX "u"
=20
+#define PH_ADDR_PR_4_FMT PH_ADDR_PR_3_FMT \
+			 ":%" __PHYS_ADDR_PREFIX "u"
+
 static int fw_cfg_cmdline_set(const char *arg, const struct kernel_param=
 *kp)
 {
-	struct resource res[3] =3D {};
+	struct resource res[4] =3D {};
 	char *str;
 	phys_addr_t base;
-	resource_size_t size, ctrl_off, data_off;
+	resource_size_t size, ctrl_off, data_off, dma_off;
 	int processed, consumed =3D 0;
=20
 	/* only one fw_cfg device can exist system-wide, so if one
@@ -658,19 +674,20 @@ static int fw_cfg_cmdline_set(const char *arg, cons=
t struct kernel_param *kp)
 	/* consume "<size>" portion of command line argument */
 	size =3D memparse(arg, &str);
=20
-	/* get "@<base>[:<ctrl_off>:<data_off>]" chunks */
+	/* get "@<base>[:<ctrl_off>:<data_off>[:<dma_off>]]" chunks */
 	processed =3D sscanf(str, PH_ADDR_SCAN_FMT,
 			   &base, &consumed,
-			   &ctrl_off, &data_off, &consumed);
+			   &ctrl_off, &data_off, &consumed,
+			   &dma_off, &consumed);
=20
-	/* sscanf() must process precisely 1 or 3 chunks:
+	/* sscanf() must process precisely 1, 3 or 4 chunks:
 	 * <base> is mandatory, optionally followed by <ctrl_off>
-	 * and <data_off>;
+	 * and <data_off>, and <dma_off>;
 	 * there must be no extra characters after the last chunk,
 	 * so str[consumed] must be '\0'.
 	 */
 	if (str[consumed] ||
-	    (processed !=3D 1 && processed !=3D 3))
+	    (processed !=3D 1 && processed !=3D 3 && processed !=3D 4))
 		return -EINVAL;
=20
 	res[0].start =3D base;
@@ -687,6 +704,11 @@ static int fw_cfg_cmdline_set(const char *arg, const=
 struct kernel_param *kp)
 		res[2].start =3D data_off;
 		res[2].flags =3D IORESOURCE_REG;
 	}
+	if (processed > 3) {
+		res[3].name =3D "dma";
+		res[3].start =3D dma_off;
+		res[3].flags =3D IORESOURCE_REG;
+	}
=20
 	/* "processed" happens to nicely match the number of resources
 	 * we need to pass in to this platform device.
@@ -721,6 +743,13 @@ static int fw_cfg_cmdline_get(char *buf, const struc=
t kernel_param *kp)
 				fw_cfg_cmdline_dev->resource[0].start,
 				fw_cfg_cmdline_dev->resource[1].start,
 				fw_cfg_cmdline_dev->resource[2].start);
+	case 4:
+		return snprintf(buf, PAGE_SIZE, PH_ADDR_PR_4_FMT,
+				resource_size(&fw_cfg_cmdline_dev->resource[0]),
+				fw_cfg_cmdline_dev->resource[0].start,
+				fw_cfg_cmdline_dev->resource[1].start,
+				fw_cfg_cmdline_dev->resource[2].start,
+				fw_cfg_cmdline_dev->resource[3].start);
 	}
=20
 	/* Should never get here */
--=20
2.15.0.rc0.40.gaefcc5f6f
