Received: from eggs.gnu.org ([2001:4830:134:3::10]:45445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cQclu-0001Gw-QY
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:26:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cQclq-0004NF-Ef
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:26:10 -0500
Received: from 8.mo178.mail-out.ovh.net ([46.105.74.227]:46951)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cQclq-0004Mm-5T
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:26:06 -0500
Received: from player714.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id ACFE2D0D9
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 17:26:04 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  9 Jan 2017 17:24:43 +0100
Message-Id: <1483979087-32663-8-git-send-email-clg@kaod.org>
In-Reply-To: <1483979087-32663-1-git-send-email-clg@kaod.org>
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 07/11] aspeed/smc: handle SPI flash Command
 mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org, Marcin Krzeminski <marcin.krzeminski@nokia.com>, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>

The Aspeed SMC controllers have a mode (Command mode) in which
accesses to the flash content are no different than doing MMIOs. The
controller generates all the necessary commands to load (or store)
data in memory.

However, accesses are restricted to the segment window assigned the
the flash module by the controller. This window is defined by the
Segment Address Register.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 hw/ssi/aspeed_smc.c         | 152 ++++++++++++++++++++++++++++++++++++++=
------
 include/hw/ssi/aspeed_smc.h |   2 +-
 2 files changed, 132 insertions(+), 22 deletions(-)

 Changes since v1:

 - removed use of some SPI commands. Firmware should make sure the
   chip is properly configured before using the command mode.

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 7103d0c5b64a..28d563a5800f 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -69,6 +69,7 @@
 #define R_CTRL0           (0x10 / 4)
 #define   CTRL_CMD_SHIFT           16
 #define   CTRL_CMD_MASK            0xff
+#define   CTRL_AST2400_SPI_4BYTE   (1 << 13)
 #define   CTRL_CE_STOP_ACTIVE      (1 << 2)
 #define   CTRL_CMD_MODE_MASK       0x3
 #define     CTRL_READMODE          0x0
@@ -138,6 +139,9 @@
 #define ASPEED_SOC_SPI_FLASH_BASE   0x30000000
 #define ASPEED_SOC_SPI2_FLASH_BASE  0x38000000
=20
+/* Flash opcodes. */
+#define SPI_OP_READ       0x03    /* Read data bytes (low frequency) */
+
 /*
  * Default segments mapping addresses and size for each slave per
  * controller. These can be changed when board is initialized with the
@@ -414,21 +418,123 @@ static inline bool aspeed_smc_is_writable(const As=
peedSMCFlash *fl)
     return s->regs[s->r_conf] & (1 << (s->conf_enable_w0 + fl->id));
 }
=20
+static inline int aspeed_smc_flash_cmd(const AspeedSMCFlash *fl)
+{
+    const AspeedSMCState *s =3D fl->controller;
+    int cmd =3D (s->regs[s->r_ctrl0 + fl->id] >> CTRL_CMD_SHIFT) & CTRL_=
CMD_MASK;
+
+    /* In read mode, the default SPI command is READ (0x3). In other
+     * modes, the command should necessarily be defined */
+    if (aspeed_smc_flash_mode(fl) =3D=3D CTRL_READMODE) {
+        cmd =3D SPI_OP_READ;
+    }
+
+    if (!cmd) {
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: no command defined for mode =
%d\n",
+                      __func__, aspeed_smc_flash_mode(fl));
+    }
+
+    return cmd;
+}
+
+static inline int aspeed_smc_flash_is_4byte(const AspeedSMCFlash *fl)
+{
+    const AspeedSMCState *s =3D fl->controller;
+
+    if (s->ctrl->segments =3D=3D aspeed_segments_spi) {
+        return s->regs[s->r_ctrl0] & CTRL_AST2400_SPI_4BYTE;
+    } else {
+        return s->regs[s->r_ce_ctrl] & (1 << (CTRL_EXTENDED0 + fl->id));
+    }
+}
+
+static inline bool aspeed_smc_is_ce_stop_active(const AspeedSMCFlash *fl=
)
+{
+    const AspeedSMCState *s =3D fl->controller;
+
+    return s->regs[s->r_ctrl0 + fl->id] & CTRL_CE_STOP_ACTIVE;
+}
+
+static void aspeed_smc_flash_select(AspeedSMCFlash *fl)
+{
+    AspeedSMCState *s =3D fl->controller;
+
+    s->regs[s->r_ctrl0 + fl->id] &=3D ~CTRL_CE_STOP_ACTIVE;
+    qemu_set_irq(s->cs_lines[fl->id], aspeed_smc_is_ce_stop_active(fl));
+}
+
+static void aspeed_smc_flash_unselect(AspeedSMCFlash *fl)
+{
+    AspeedSMCState *s =3D fl->controller;
+
+    s->regs[s->r_ctrl0 + fl->id] |=3D CTRL_CE_STOP_ACTIVE;
+    qemu_set_irq(s->cs_lines[fl->id], aspeed_smc_is_ce_stop_active(fl));
+}
+
+static uint32_t aspeed_smc_check_segment_addr(const AspeedSMCFlash *fl,
+                                              uint32_t addr)
+{
+    const AspeedSMCState *s =3D fl->controller;
+    AspeedSegments seg;
+
+    aspeed_smc_reg_to_segment(s->regs[R_SEG_ADDR0 + fl->id], &seg);
+    if ((addr & (seg.size - 1)) !=3D addr) {
+        qemu_log_mask(LOG_GUEST_ERROR,
+                      "%s: invalid address 0x%08x for CS%d segment : "
+                      "[ 0x%"HWADDR_PRIx" - 0x%"HWADDR_PRIx" ]\n",
+                      s->ctrl->name, addr, fl->id, seg.addr,
+                      seg.addr + seg.size);
+    }
+
+    addr &=3D seg.size - 1;
+    return addr;
+}
+
+static void aspeed_smc_flash_send_addr(AspeedSMCFlash *fl, uint32_t addr=
)
+{
+    const AspeedSMCState *s =3D fl->controller;
+    uint8_t cmd =3D aspeed_smc_flash_cmd(fl);
+
+    /* Flash access can not exceed CS segment */
+    addr =3D aspeed_smc_check_segment_addr(fl, addr);
+
+    ssi_transfer(s->spi, cmd);
+
+    if (aspeed_smc_flash_is_4byte(fl)) {
+        ssi_transfer(s->spi, (addr >> 24) & 0xff);
+    }
+    ssi_transfer(s->spi, (addr >> 16) & 0xff);
+    ssi_transfer(s->spi, (addr >> 8) & 0xff);
+    ssi_transfer(s->spi, (addr & 0xff));
+}
+
 static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr addr, unsigne=
d size)
 {
     AspeedSMCFlash *fl =3D opaque;
-    const AspeedSMCState *s =3D fl->controller;
+    AspeedSMCState *s =3D fl->controller;
     uint64_t ret =3D 0;
     int i;
=20
-    if (aspeed_smc_is_usermode(fl)) {
+    switch (aspeed_smc_flash_mode(fl)) {
+    case CTRL_USERMODE:
         for (i =3D 0; i < size; i++) {
             ret |=3D ssi_transfer(s->spi, 0x0) << (8 * i);
         }
-    } else {
-        qemu_log_mask(LOG_UNIMP, "%s: usermode not implemented\n",
-                      __func__);
-        ret =3D -1;
+        break;
+    case CTRL_READMODE:
+    case CTRL_FREADMODE:
+        aspeed_smc_flash_select(fl);
+        aspeed_smc_flash_send_addr(fl, addr);
+
+        for (i =3D 0; i < size; i++) {
+            ret |=3D ssi_transfer(s->spi, 0x0) << (8 * i);
+        }
+
+        aspeed_smc_flash_unselect(fl);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid flash mode %d\n",
+                      __func__, aspeed_smc_flash_mode(fl));
     }
=20
     return ret;
@@ -438,7 +544,7 @@ static void aspeed_smc_flash_write(void *opaque, hwad=
dr addr, uint64_t data,
                            unsigned size)
 {
     AspeedSMCFlash *fl =3D opaque;
-    const AspeedSMCState *s =3D fl->controller;
+    AspeedSMCState *s =3D fl->controller;
     int i;
=20
     if (!aspeed_smc_is_writable(fl)) {
@@ -447,14 +553,25 @@ static void aspeed_smc_flash_write(void *opaque, hw=
addr addr, uint64_t data,
         return;
     }
=20
-    if (!aspeed_smc_is_usermode(fl)) {
-        qemu_log_mask(LOG_UNIMP, "%s: usermode not implemented\n",
-                      __func__);
-        return;
-    }
+    switch (aspeed_smc_flash_mode(fl)) {
+    case CTRL_USERMODE:
+        for (i =3D 0; i < size; i++) {
+            ssi_transfer(s->spi, (data >> (8 * i)) & 0xff);
+        }
+        break;
+    case CTRL_WRITEMODE:
+        aspeed_smc_flash_select(fl);
+        aspeed_smc_flash_send_addr(fl, addr);
+
+        for (i =3D 0; i < size; i++) {
+            ssi_transfer(s->spi, (data >> (8 * i)) & 0xff);
+        }
=20
-    for (i =3D 0; i < size; i++) {
-        ssi_transfer(s->spi, (data >> (8 * i)) & 0xff);
+        aspeed_smc_flash_unselect(fl);
+        break;
+    default:
+        qemu_log_mask(LOG_GUEST_ERROR, "%s: invalid flash mode %d\n",
+                      __func__, aspeed_smc_flash_mode(fl));
     }
 }
=20
@@ -468,13 +585,6 @@ static const MemoryRegionOps aspeed_smc_flash_ops =3D=
 {
     },
 };
=20
-static inline bool aspeed_smc_is_ce_stop_active(const AspeedSMCFlash *fl=
)
-{
-    const AspeedSMCState *s =3D fl->controller;
-
-    return s->regs[s->r_ctrl0 + fl->id] & CTRL_CE_STOP_ACTIVE;
-}
-
 static void aspeed_smc_flash_update_cs(AspeedSMCFlash *fl)
 {
     const AspeedSMCState *s =3D fl->controller;
diff --git a/include/hw/ssi/aspeed_smc.h b/include/hw/ssi/aspeed_smc.h
index e811742728f8..1f557313fa93 100644
--- a/include/hw/ssi/aspeed_smc.h
+++ b/include/hw/ssi/aspeed_smc.h
@@ -49,7 +49,7 @@ typedef struct AspeedSMCController {
 } AspeedSMCController;
=20
 typedef struct AspeedSMCFlash {
-    const struct AspeedSMCState *controller;
+    struct AspeedSMCState *controller;
=20
     uint8_t id;
     uint32_t size;
--=20
2.7.4
