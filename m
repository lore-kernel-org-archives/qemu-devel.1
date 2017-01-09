Received: from eggs.gnu.org ([2001:4830:134:3::10]:45329)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cQclL-0000h6-Gm
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:25:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1cQclH-0004EA-65
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:25:35 -0500
Received: from 3.mo178.mail-out.ovh.net ([46.105.44.197]:52272)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1cQclG-0004Dp-WB
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:25:31 -0500
Received: from player714.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id 85A02D1F4
	for <qemu-devel@nongnu.org>; Mon,  9 Jan 2017 17:25:29 +0100 (CET)
From: =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>
Date: Mon,  9 Jan 2017 17:24:39 +0100
Message-Id: <1483979087-32663-4-git-send-email-clg@kaod.org>
In-Reply-To: <1483979087-32663-1-git-send-email-clg@kaod.org>
References: <1483979087-32663-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 03/11] aspeed/smc: rework the prototype of
 the AspeedSMCFlash helper routines
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

Change the routines prototype to use a 'AspeedSMCFlash *' instead of
'AspeedSMCState *'. The result will help in making future changes
clearer.

Also change aspeed_smc_update_cs() which uselessly loops on all slave
devices to update their status.

Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Joel Stanley <joel@jms.id.au>
Reviewed-by: Andrew Jeffery <andrew@aj.id.au>
---
 hw/ssi/aspeed_smc.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

 Changes since v1:

 - moved reset changes in preliminary patches
 - merged in changes in aspeed_smc_update_cs()

diff --git a/hw/ssi/aspeed_smc.c b/hw/ssi/aspeed_smc.c
index 205c0abfae98..9b31d5d27012 100644
--- a/hw/ssi/aspeed_smc.c
+++ b/hw/ssi/aspeed_smc.c
@@ -328,19 +328,23 @@ static const MemoryRegionOps aspeed_smc_flash_defau=
lt_ops =3D {
     },
 };
=20
-static inline int aspeed_smc_flash_mode(const AspeedSMCState *s, int cs)
+static inline int aspeed_smc_flash_mode(const AspeedSMCFlash *fl)
 {
-    return s->regs[s->r_ctrl0 + cs] & CTRL_CMD_MODE_MASK;
+    const AspeedSMCState *s =3D fl->controller;
+
+    return s->regs[s->r_ctrl0 + fl->id] & CTRL_CMD_MODE_MASK;
 }
=20
-static inline bool aspeed_smc_is_usermode(const AspeedSMCState *s, int c=
s)
+static inline bool aspeed_smc_is_usermode(const AspeedSMCFlash *fl)
 {
-    return aspeed_smc_flash_mode(s, cs) =3D=3D CTRL_USERMODE;
+    return aspeed_smc_flash_mode(fl) =3D=3D CTRL_USERMODE;
 }
=20
-static inline bool aspeed_smc_is_writable(const AspeedSMCState *s, int c=
s)
+static inline bool aspeed_smc_is_writable(const AspeedSMCFlash *fl)
 {
-    return s->regs[s->r_conf] & (1 << (s->conf_enable_w0 + cs));
+    const AspeedSMCState *s =3D fl->controller;
+
+    return s->regs[s->r_conf] & (1 << (s->conf_enable_w0 + fl->id));
 }
=20
 static uint64_t aspeed_smc_flash_read(void *opaque, hwaddr addr, unsigne=
d size)
@@ -350,7 +354,7 @@ static uint64_t aspeed_smc_flash_read(void *opaque, h=
waddr addr, unsigned size)
     uint64_t ret =3D 0;
     int i;
=20
-    if (aspeed_smc_is_usermode(s, fl->id)) {
+    if (aspeed_smc_is_usermode(fl)) {
         for (i =3D 0; i < size; i++) {
             ret |=3D ssi_transfer(s->spi, 0x0) << (8 * i);
         }
@@ -370,13 +374,13 @@ static void aspeed_smc_flash_write(void *opaque, hw=
addr addr, uint64_t data,
     const AspeedSMCState *s =3D fl->controller;
     int i;
=20
-    if (!aspeed_smc_is_writable(s, fl->id)) {
+    if (!aspeed_smc_is_writable(fl)) {
         qemu_log_mask(LOG_GUEST_ERROR, "%s: flash is not writable at 0x%=
"
                       HWADDR_PRIx "\n", __func__, addr);
         return;
     }
=20
-    if (!aspeed_smc_is_usermode(s, fl->id)) {
+    if (!aspeed_smc_is_usermode(fl)) {
         qemu_log_mask(LOG_UNIMP, "%s: usermode not implemented\n",
                       __func__);
         return;
@@ -397,18 +401,18 @@ static const MemoryRegionOps aspeed_smc_flash_ops =3D=
 {
     },
 };
=20
-static bool aspeed_smc_is_ce_stop_active(const AspeedSMCState *s, int cs=
)
+static inline bool aspeed_smc_is_ce_stop_active(const AspeedSMCFlash *fl=
)
 {
-    return s->regs[s->r_ctrl0 + cs] & CTRL_CE_STOP_ACTIVE;
+    const AspeedSMCState *s =3D fl->controller;
+
+    return s->regs[s->r_ctrl0 + fl->id] & CTRL_CE_STOP_ACTIVE;
 }
=20
-static void aspeed_smc_update_cs(const AspeedSMCState *s)
+static void aspeed_smc_flash_update_cs(AspeedSMCFlash *fl)
 {
-    int i;
+    const AspeedSMCState *s =3D fl->controller;
=20
-    for (i =3D 0; i < s->num_cs; ++i) {
-        qemu_set_irq(s->cs_lines[i], aspeed_smc_is_ce_stop_active(s, i))=
;
-    }
+    qemu_set_irq(s->cs_lines[fl->id], aspeed_smc_is_ce_stop_active(fl));
 }
=20
 static void aspeed_smc_reset(DeviceState *d)
@@ -481,8 +485,9 @@ static void aspeed_smc_write(void *opaque, hwaddr add=
r, uint64_t data,
         addr =3D=3D s->r_ce_ctrl) {
         s->regs[addr] =3D value;
     } else if (addr >=3D s->r_ctrl0 && addr < s->r_ctrl0 + s->num_cs) {
+        int cs =3D addr - s->r_ctrl0;
         s->regs[addr] =3D value;
-        aspeed_smc_update_cs(s);
+        aspeed_smc_flash_update_cs(&s->flashes[cs]);
     } else if (addr >=3D R_SEG_ADDR0 &&
                addr < R_SEG_ADDR0 + s->ctrl->max_slaves) {
         int cs =3D addr - R_SEG_ADDR0;
--=20
2.7.4
