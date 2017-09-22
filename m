Received: from eggs.gnu.org ([2001:4830:134:3::10]:59354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvRWM-00039t-RB
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:13:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvRWJ-0003OR-Pu
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:13:46 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 14:13:17 -0300
Message-Id: <20170922171323.10348-2-f4bug@amsat.org>
In-Reply-To: <20170922171323.10348-1-f4bug@amsat.org>
References: <20170922171323.10348-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 1/7] hw/mdio: Generalize etraxfs MDIO
 bitbanging emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Grant Likely <grant.likely@arm.com>, Jason Wang <jasowang@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Alistair Francis <alistair.francis@xilinx.com>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Andreas=20F=C3=A4rber?= <afaerber@suse.de>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Grant Likely <grant.likely@arm.com>

The etraxfs and Xilinx axienet Ethernet models implement quite a nice
MDIO core that supports both bitbanging and direct register access. This
change factors the common code out into a separate file. There are no
functional changes here, just movement of code.

The etraxfs and axienet are slightly different. The etraxfs version
includes the bitbang state processing, but the axienet version has a
minor enhancement for read/write of phy registers without using bitbang
state variables.  This patch generalizes the etraxfs version, with the
axienet change backported in.

Signed-off-by: Grant Likely <grant.likely@arm.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: rebased with a minor checkpatch fix]
---
 include/hw/net/mdio.h   |  76 +++++++++++++
 hw/net/etraxfs_eth.c    | 278 +-----------------------------------------------
 hw/net/mdio.c           | 262 +++++++++++++++++++++++++++++++++++++++++++++
 hw/net/xilinx_axienet.c | 187 +-------------------------------
 hw/net/Makefile.objs    |   2 +
 5 files changed, 344 insertions(+), 461 deletions(-)
 create mode 100644 include/hw/net/mdio.h
 create mode 100644 hw/net/mdio.c

diff --git a/include/hw/net/mdio.h b/include/hw/net/mdio.h
new file mode 100644
index 0000000000..ac36aed3c3
--- /dev/null
+++ b/include/hw/net/mdio.h
@@ -0,0 +1,76 @@
+#ifndef BITBANG_MDIO_H
+#define BITBANG_MDIO_H
+
+/*
+ * QEMU Bitbang Ethernet MDIO bus & PHY controllers.
+ *
+ * Copyright (c) 2008 Edgar E. Iglesias, Axis Communications AB.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ */
+
+/* PHY Advertisement control register */
+#define PHY_ADVERTISE_10HALF    0x0020  /* Try for 10mbps half-duplex  */
+#define PHY_ADVERTISE_10FULL    0x0040  /* Try for 10mbps full-duplex  */
+#define PHY_ADVERTISE_100HALF   0x0080  /* Try for 100mbps half-duplex */
+#define PHY_ADVERTISE_100FULL   0x0100  /* Try for 100mbps full-duplex */
+
+struct qemu_phy {
+    uint32_t regs[32];
+
+    int link;
+
+    unsigned int (*read)(struct qemu_phy *phy, unsigned int req);
+    void (*write)(struct qemu_phy *phy, unsigned int req, unsigned int data);
+};
+
+struct qemu_mdio {
+    /* bus. */
+    int mdc;
+    int mdio;
+
+    /* decoder.  */
+    enum {
+        PREAMBLE,
+        SOF,
+        OPC,
+        ADDR,
+        REQ,
+        TURNAROUND,
+        DATA
+    } state;
+    unsigned int drive;
+
+    unsigned int cnt;
+    unsigned int addr;
+    unsigned int opc;
+    unsigned int req;
+    unsigned int data;
+
+    struct qemu_phy *devs[32];
+};
+
+void tdk_init(struct qemu_phy *phy);
+void mdio_attach(struct qemu_mdio *bus, struct qemu_phy *phy,
+                 unsigned int addr);
+uint16_t mdio_read_req(struct qemu_mdio *bus, uint8_t addr, uint8_t req);
+void mdio_write_req(struct qemu_mdio *bus, uint8_t addr, uint8_t req, uint16_t data);
+void mdio_cycle(struct qemu_mdio *bus);
+
+#endif
diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
index 013c8d0a41..f8d8f8441d 100644
--- a/hw/net/etraxfs_eth.c
+++ b/hw/net/etraxfs_eth.c
@@ -26,287 +26,11 @@
 #include "hw/sysbus.h"
 #include "net/net.h"
 #include "hw/cris/etraxfs.h"
+#include "hw/net/mdio.h"
 #include "qemu/error-report.h"
 
 #define D(x)
 
-/* Advertisement control register. */
-#define ADVERTISE_10HALF        0x0020  /* Try for 10mbps half-duplex  */
-#define ADVERTISE_10FULL        0x0040  /* Try for 10mbps full-duplex  */
-#define ADVERTISE_100HALF       0x0080  /* Try for 100mbps half-duplex */
-#define ADVERTISE_100FULL       0x0100  /* Try for 100mbps full-duplex */
-
-/*
- * The MDIO extensions in the TDK PHY model were reversed engineered from the
- * linux driver (PHYID and Diagnostics reg).
- * TODO: Add friendly names for the register nums.
- */
-struct qemu_phy
-{
-    uint32_t regs[32];
-
-    int link;
-
-    unsigned int (*read)(struct qemu_phy *phy, unsigned int req);
-    void (*write)(struct qemu_phy *phy, unsigned int req, unsigned int data);
-};
-
-static unsigned int tdk_read(struct qemu_phy *phy, unsigned int req)
-{
-    int regnum;
-    unsigned r = 0;
-
-    regnum = req & 0x1f;
-
-    switch (regnum) {
-    case 1:
-        if (!phy->link) {
-            break;
-        }
-        /* MR1.     */
-        /* Speeds and modes.  */
-        r |= (1 << 13) | (1 << 14);
-        r |= (1 << 11) | (1 << 12);
-        r |= (1 << 5); /* Autoneg complete.  */
-        r |= (1 << 3); /* Autoneg able.     */
-        r |= (1 << 2); /* link.     */
-        break;
-    case 5:
-        /* Link partner ability.
-           We are kind; always agree with whatever best mode
-           the guest advertises.  */
-        r = 1 << 14; /* Success.  */
-        /* Copy advertised modes.  */
-        r |= phy->regs[4] & (15 << 5);
-        /* Autoneg support.  */
-        r |= 1;
-        break;
-    case 18:
-    {
-        /* Diagnostics reg.  */
-        int duplex = 0;
-        int speed_100 = 0;
-
-        if (!phy->link) {
-            break;
-        }
-
-        /* Are we advertising 100 half or 100 duplex ? */
-        speed_100 = !!(phy->regs[4] & ADVERTISE_100HALF);
-        speed_100 |= !!(phy->regs[4] & ADVERTISE_100FULL);
-
-        /* Are we advertising 10 duplex or 100 duplex ? */
-        duplex = !!(phy->regs[4] & ADVERTISE_100FULL);
-        duplex |= !!(phy->regs[4] & ADVERTISE_10FULL);
-        r = (speed_100 << 10) | (duplex << 11);
-    }
-    break;
-
-    default:
-        r = phy->regs[regnum];
-        break;
-    }
-    D(printf("\n%s %x = reg[%d]\n", __func__, r, regnum));
-    return r;
-}
-
-static void
-tdk_write(struct qemu_phy *phy, unsigned int req, unsigned int data)
-{
-    int regnum;
-
-    regnum = req & 0x1f;
-    D(printf("%s reg[%d] = %x\n", __func__, regnum, data));
-    switch (regnum) {
-    default:
-        phy->regs[regnum] = data;
-        break;
-    }
-}
-
-static void
-tdk_init(struct qemu_phy *phy)
-{
-    phy->regs[0] = 0x3100;
-    /* PHY Id.  */
-    phy->regs[2] = 0x0300;
-    phy->regs[3] = 0xe400;
-    /* Autonegotiation advertisement reg.  */
-    phy->regs[4] = 0x01E1;
-    phy->link = 1;
-
-    phy->read = tdk_read;
-    phy->write = tdk_write;
-}
-
-struct qemu_mdio
-{
-    /* bus.     */
-    int mdc;
-    int mdio;
-
-    /* decoder.  */
-    enum {
-        PREAMBLE,
-        SOF,
-        OPC,
-        ADDR,
-        REQ,
-        TURNAROUND,
-        DATA
-    } state;
-    unsigned int drive;
-
-    unsigned int cnt;
-    unsigned int addr;
-    unsigned int opc;
-    unsigned int req;
-    unsigned int data;
-
-    struct qemu_phy *devs[32];
-};
-
-static void
-mdio_attach(struct qemu_mdio *bus, struct qemu_phy *phy, unsigned int addr)
-{
-    bus->devs[addr & 0x1f] = phy;
-}
-
-#ifdef USE_THIS_DEAD_CODE
-static void
-mdio_detach(struct qemu_mdio *bus, struct qemu_phy *phy, unsigned int addr)
-{
-    bus->devs[addr & 0x1f] = NULL;
-}
-#endif
-
-static void mdio_read_req(struct qemu_mdio *bus)
-{
-    struct qemu_phy *phy;
-
-    phy = bus->devs[bus->addr];
-    if (phy && phy->read) {
-        bus->data = phy->read(phy, bus->req);
-    } else {
-        bus->data = 0xffff;
-    }
-}
-
-static void mdio_write_req(struct qemu_mdio *bus)
-{
-    struct qemu_phy *phy;
-
-    phy = bus->devs[bus->addr];
-    if (phy && phy->write) {
-        phy->write(phy, bus->req, bus->data);
-    }
-}
-
-static void mdio_cycle(struct qemu_mdio *bus)
-{
-    bus->cnt++;
-
-    D(printf("mdc=%d mdio=%d state=%d cnt=%d drv=%d\n",
-        bus->mdc, bus->mdio, bus->state, bus->cnt, bus->drive));
-#if 0
-    if (bus->mdc) {
-        printf("%d", bus->mdio);
-    }
-#endif
-    switch (bus->state) {
-    case PREAMBLE:
-        if (bus->mdc) {
-            if (bus->cnt >= (32 * 2) && !bus->mdio) {
-                bus->cnt = 0;
-                bus->state = SOF;
-                bus->data = 0;
-            }
-        }
-        break;
-    case SOF:
-        if (bus->mdc) {
-            if (bus->mdio != 1) {
-                printf("WARNING: no SOF\n");
-            }
-            if (bus->cnt == 1*2) {
-                bus->cnt = 0;
-                bus->opc = 0;
-                bus->state = OPC;
-            }
-        }
-        break;
-    case OPC:
-        if (bus->mdc) {
-            bus->opc <<= 1;
-            bus->opc |= bus->mdio & 1;
-            if (bus->cnt == 2*2) {
-                bus->cnt = 0;
-                bus->addr = 0;
-                bus->state = ADDR;
-            }
-        }
-        break;
-    case ADDR:
-        if (bus->mdc) {
-            bus->addr <<= 1;
-            bus->addr |= bus->mdio & 1;
-
-            if (bus->cnt == 5*2) {
-                bus->cnt = 0;
-                bus->req = 0;
-                bus->state = REQ;
-            }
-        }
-        break;
-    case REQ:
-        if (bus->mdc) {
-            bus->req <<= 1;
-            bus->req |= bus->mdio & 1;
-            if (bus->cnt == 5*2) {
-                bus->cnt = 0;
-                bus->state = TURNAROUND;
-            }
-        }
-        break;
-    case TURNAROUND:
-        if (bus->mdc && bus->cnt == 2*2) {
-            bus->mdio = 0;
-            bus->cnt = 0;
-
-            if (bus->opc == 2) {
-                bus->drive = 1;
-                mdio_read_req(bus);
-                bus->mdio = bus->data & 1;
-            }
-            bus->state = DATA;
-        }
-        break;
-    case DATA:
-        if (!bus->mdc) {
-            if (bus->drive) {
-                bus->mdio = !!(bus->data & (1 << 15));
-                bus->data <<= 1;
-            }
-        } else {
-            if (!bus->drive) {
-                bus->data <<= 1;
-                bus->data |= bus->mdio;
-            }
-            if (bus->cnt == 16 * 2) {
-                bus->cnt = 0;
-                bus->state = PREAMBLE;
-                if (!bus->drive) {
-                    mdio_write_req(bus);
-                }
-                bus->drive = 0;
-            }
-        }
-        break;
-    default:
-        break;
-    }
-}
-
 /* ETRAX-FS Ethernet MAC block starts here.  */
 
 #define RW_MA0_LO      0x00
diff --git a/hw/net/mdio.c b/hw/net/mdio.c
new file mode 100644
index 0000000000..3763fcc8af
--- /dev/null
+++ b/hw/net/mdio.c
@@ -0,0 +1,262 @@
+/*
+ * QEMU Ethernet MDIO bus & PHY models
+ *
+ * Copyright (c) 2008 Edgar E. Iglesias, Axis Communications AB.
+ *
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this software and associated documentation files (the "Software"), to deal
+ * in the Software without restriction, including without limitation the rights
+ * to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
+ * copies of the Software, and to permit persons to whom the Software is
+ * furnished to do so, subject to the following conditions:
+ *
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
+ * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
+ * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
+ * THE SOFTWARE.
+ *
+ * This is a generic MDIO implementation.
+ *
+ * TODO:
+ * - Split PHYs out as separate device models so they can be defined and
+ *   instantiated separately from the MDIO bus.
+ * - Split out bitbang state machine into a separate model. Mostly this consists
+ *   of the mdio_cycle() routine and the bitbang state data in struct qemu_mdio
+ * - Use the GPIO interface for driving bitbang
+ */
+
+#include "qemu/osdep.h"
+#include "qemu-common.h"
+#include "qemu/log.h"
+#include "hw/net/mdio.h"
+
+#define D(x)
+
+/*
+ * The MDIO extensions in the TDK PHY model were reversed engineered from the
+ * linux driver (PHYID and Diagnostics reg).
+ * TODO: Add friendly names for the register nums.
+ */
+static unsigned int tdk_read(struct qemu_phy *phy, unsigned int req)
+{
+    int regnum;
+    unsigned r = 0;
+
+    regnum = req & 0x1f;
+
+    switch (regnum) {
+    case 1:
+        if (!phy->link) {
+            break;
+        }
+        /* MR1.     */
+        /* Speeds and modes.  */
+        r |= (1 << 13) | (1 << 14);
+        r |= (1 << 11) | (1 << 12);
+        r |= (1 << 5); /* Autoneg complete.  */
+        r |= (1 << 3); /* Autoneg able.     */
+        r |= (1 << 2); /* link.     */
+        r |= (1 << 1); /* link.     */
+        break;
+    case 5:
+        /* Link partner ability.
+           We are kind; always agree with whatever best mode
+           the guest advertises.  */
+        r = 1 << 14; /* Success.  */
+        /* Copy advertised modes.  */
+        r |= phy->regs[4] & (15 << 5);
+        /* Autoneg support.  */
+        r |= 1;
+        break;
+    case 17:
+        /* Marvel PHY on many xilinx boards. */
+        r = 0x8000; /* 1000Mb */
+        break;
+    case 18:
+    {
+        /* Diagnostics reg.  */
+        int duplex = 0;
+        int speed_100 = 0;
+
+        if (!phy->link) {
+            break;
+        }
+
+        /* Are we advertising 100 half or 100 duplex ? */
+        speed_100 = !!(phy->regs[4] & PHY_ADVERTISE_100HALF);
+        speed_100 |= !!(phy->regs[4] & PHY_ADVERTISE_100FULL);
+
+        /* Are we advertising 10 duplex or 100 duplex ? */
+        duplex = !!(phy->regs[4] & PHY_ADVERTISE_100FULL);
+        duplex |= !!(phy->regs[4] & PHY_ADVERTISE_10FULL);
+        r = (speed_100 << 10) | (duplex << 11);
+    }
+    break;
+
+    default:
+        r = phy->regs[regnum];
+        break;
+    }
+    D(printf("\n%s %x = reg[%d]\n", __func__, r, regnum));
+    return r;
+}
+
+static void tdk_write(struct qemu_phy *phy, unsigned int req, unsigned int data)
+{
+    int regnum;
+
+    regnum = req & 0x1f;
+    D(printf("%s reg[%d] = %x\n", __func__, regnum, data));
+    switch (regnum) {
+    default:
+        phy->regs[regnum] = data;
+        break;
+    }
+}
+
+void tdk_init(struct qemu_phy *phy)
+{
+    phy->regs[0] = 0x3100;
+    /* PHY Id. */
+    phy->regs[2] = 0x0300;
+    phy->regs[3] = 0xe400;
+    /* Autonegotiation advertisement reg. */
+    phy->regs[4] = 0x01e1;
+    phy->link = 1;
+
+    phy->read = tdk_read;
+    phy->write = tdk_write;
+}
+
+void mdio_attach(struct qemu_mdio *bus, struct qemu_phy *phy, unsigned int addr)
+{
+    bus->devs[addr & 0x1f] = phy;
+}
+
+uint16_t mdio_read_req(struct qemu_mdio *bus, uint8_t addr, uint8_t req)
+{
+    struct qemu_phy *phy;
+
+    phy = bus->devs[bus->addr];
+    if (phy && phy->read) {
+        return phy->read(phy, req);
+    }
+    return 0xffff;
+}
+
+void mdio_write_req(struct qemu_mdio *bus, uint8_t addr, uint8_t req,
+                    uint16_t data)
+{
+    struct qemu_phy *phy;
+
+    phy = bus->devs[bus->addr];
+    if (phy && phy->write) {
+        phy->write(phy, req, data);
+    }
+}
+
+void mdio_cycle(struct qemu_mdio *bus)
+{
+    bus->cnt++;
+
+    D(printf("mdc=%d mdio=%d state=%d cnt=%d drv=%d\n",
+             bus->mdc, bus->mdio, bus->state, bus->cnt, bus->drive));
+    switch (bus->state) {
+    case PREAMBLE:
+        if (bus->mdc) {
+            if (bus->cnt >= (32 * 2) && !bus->mdio) {
+                bus->cnt = 0;
+                bus->state = SOF;
+                bus->data = 0;
+            }
+        }
+        break;
+    case SOF:
+        if (bus->mdc) {
+            if (bus->mdio != 1) {
+                printf("WARNING: no SOF\n");
+            }
+            if (bus->cnt == 1 * 2) {
+                bus->cnt = 0;
+                bus->opc = 0;
+                bus->state = OPC;
+            }
+        }
+        break;
+    case OPC:
+        if (bus->mdc) {
+            bus->opc <<= 1;
+            bus->opc |= bus->mdio & 1;
+            if (bus->cnt == 2 * 2) {
+                bus->cnt = 0;
+                bus->addr = 0;
+                bus->state = ADDR;
+            }
+        }
+        break;
+    case ADDR:
+        if (bus->mdc) {
+            bus->addr <<= 1;
+            bus->addr |= bus->mdio & 1;
+
+            if (bus->cnt == 5 * 2) {
+                bus->cnt = 0;
+                bus->req = 0;
+                bus->state = REQ;
+            }
+        }
+        break;
+    case REQ:
+        if (bus->mdc) {
+            bus->req <<= 1;
+            bus->req |= bus->mdio & 1;
+            if (bus->cnt == 5 * 2) {
+                bus->cnt = 0;
+                bus->state = TURNAROUND;
+            }
+        }
+        break;
+    case TURNAROUND:
+        if (bus->mdc && bus->cnt == 2 * 2) {
+            bus->mdio = 0;
+            bus->cnt = 0;
+
+            if (bus->opc == 2) {
+                bus->drive = 1;
+                bus->data = mdio_read_req(bus, bus->addr, bus->req);
+                bus->mdio = bus->data & 1;
+            }
+            bus->state = DATA;
+        }
+        break;
+    case DATA:
+        if (!bus->mdc) {
+            if (bus->drive) {
+                bus->mdio = !!(bus->data & (1 << 15));
+                bus->data <<= 1;
+            }
+        } else {
+            if (!bus->drive) {
+                bus->data <<= 1;
+                bus->data |= bus->mdio;
+            }
+            if (bus->cnt == 16 * 2) {
+                bus->cnt = 0;
+                bus->state = PREAMBLE;
+                if (!bus->drive) {
+                    mdio_write_req(bus, bus->addr, bus->req, bus->data);
+                }
+                bus->drive = 0;
+            }
+        }
+        break;
+    default:
+        break;
+    }
+}
diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
index d4c2c89dc1..1e859fdaae 100644
--- a/hw/net/xilinx_axienet.c
+++ b/hw/net/xilinx_axienet.c
@@ -26,13 +26,12 @@
 #include "hw/sysbus.h"
 #include "qapi/error.h"
 #include "qemu/log.h"
+#include "hw/net/mdio.h"
 #include "net/net.h"
 #include "net/checksum.h"
 
 #include "hw/stream.h"
 
-#define DPHY(x)
-
 #define TYPE_XILINX_AXI_ENET "xlnx.axi-ethernet"
 #define TYPE_XILINX_AXI_ENET_DATA_STREAM "xilinx-axienet-data-stream"
 #define TYPE_XILINX_AXI_ENET_CONTROL_STREAM "xilinx-axienet-control-stream"
@@ -48,189 +47,9 @@
      OBJECT_CHECK(XilinxAXIEnetStreamSlave, (obj),\
      TYPE_XILINX_AXI_ENET_CONTROL_STREAM)
 
-/* Advertisement control register. */
-#define ADVERTISE_10HALF        0x0020  /* Try for 10mbps half-duplex  */
-#define ADVERTISE_10FULL        0x0040  /* Try for 10mbps full-duplex  */
-#define ADVERTISE_100HALF       0x0080  /* Try for 100mbps half-duplex */
-#define ADVERTISE_100FULL       0x0100  /* Try for 100mbps full-duplex */
-
 #define CONTROL_PAYLOAD_WORDS 5
 #define CONTROL_PAYLOAD_SIZE (CONTROL_PAYLOAD_WORDS * (sizeof(uint32_t)))
 
-struct PHY {
-    uint32_t regs[32];
-
-    int link;
-
-    unsigned int (*read)(struct PHY *phy, unsigned int req);
-    void (*write)(struct PHY *phy, unsigned int req,
-                  unsigned int data);
-};
-
-static unsigned int tdk_read(struct PHY *phy, unsigned int req)
-{
-    int regnum;
-    unsigned r = 0;
-
-    regnum = req & 0x1f;
-
-    switch (regnum) {
-        case 1:
-            if (!phy->link) {
-                break;
-            }
-            /* MR1.  */
-            /* Speeds and modes.  */
-            r |= (1 << 13) | (1 << 14);
-            r |= (1 << 11) | (1 << 12);
-            r |= (1 << 5); /* Autoneg complete.  */
-            r |= (1 << 3); /* Autoneg able.  */
-            r |= (1 << 2); /* link.  */
-            r |= (1 << 1); /* link.  */
-            break;
-        case 5:
-            /* Link partner ability.
-               We are kind; always agree with whatever best mode
-               the guest advertises.  */
-            r = 1 << 14; /* Success.  */
-            /* Copy advertised modes.  */
-            r |= phy->regs[4] & (15 << 5);
-            /* Autoneg support.  */
-            r |= 1;
-            break;
-        case 17:
-            /* Marvell PHY on many xilinx boards.  */
-            r = 0x8000; /* 1000Mb  */
-            break;
-        case 18:
-            {
-                /* Diagnostics reg.  */
-                int duplex = 0;
-                int speed_100 = 0;
-
-                if (!phy->link) {
-                    break;
-                }
-
-                /* Are we advertising 100 half or 100 duplex ? */
-                speed_100 = !!(phy->regs[4] & ADVERTISE_100HALF);
-                speed_100 |= !!(phy->regs[4] & ADVERTISE_100FULL);
-
-                /* Are we advertising 10 duplex or 100 duplex ? */
-                duplex = !!(phy->regs[4] & ADVERTISE_100FULL);
-                duplex |= !!(phy->regs[4] & ADVERTISE_10FULL);
-                r = (speed_100 << 10) | (duplex << 11);
-            }
-            break;
-
-        default:
-            r = phy->regs[regnum];
-            break;
-    }
-    DPHY(qemu_log("\n%s %x = reg[%d]\n", __func__, r, regnum));
-    return r;
-}
-
-static void
-tdk_write(struct PHY *phy, unsigned int req, unsigned int data)
-{
-    int regnum;
-
-    regnum = req & 0x1f;
-    DPHY(qemu_log("%s reg[%d] = %x\n", __func__, regnum, data));
-    switch (regnum) {
-        default:
-            phy->regs[regnum] = data;
-            break;
-    }
-
-    /* Unconditionally clear regs[BMCR][BMCR_RESET] */
-    phy->regs[0] &= ~0x8000;
-}
-
-static void
-tdk_init(struct PHY *phy)
-{
-    phy->regs[0] = 0x3100;
-    /* PHY Id.  */
-    phy->regs[2] = 0x0300;
-    phy->regs[3] = 0xe400;
-    /* Autonegotiation advertisement reg.  */
-    phy->regs[4] = 0x01E1;
-    phy->link = 1;
-
-    phy->read = tdk_read;
-    phy->write = tdk_write;
-}
-
-struct MDIOBus {
-    /* bus.  */
-    int mdc;
-    int mdio;
-
-    /* decoder.  */
-    enum {
-        PREAMBLE,
-        SOF,
-        OPC,
-        ADDR,
-        REQ,
-        TURNAROUND,
-        DATA
-    } state;
-    unsigned int drive;
-
-    unsigned int cnt;
-    unsigned int addr;
-    unsigned int opc;
-    unsigned int req;
-    unsigned int data;
-
-    struct PHY *devs[32];
-};
-
-static void
-mdio_attach(struct MDIOBus *bus, struct PHY *phy, unsigned int addr)
-{
-    bus->devs[addr & 0x1f] = phy;
-}
-
-#ifdef USE_THIS_DEAD_CODE
-static void
-mdio_detach(struct MDIOBus *bus, struct PHY *phy, unsigned int addr)
-{
-    bus->devs[addr & 0x1f] = NULL;
-}
-#endif
-
-static uint16_t mdio_read_req(struct MDIOBus *bus, unsigned int addr,
-                  unsigned int reg)
-{
-    struct PHY *phy;
-    uint16_t data;
-
-    phy = bus->devs[addr];
-    if (phy && phy->read) {
-        data = phy->read(phy, reg);
-    } else {
-        data = 0xffff;
-    }
-    DPHY(qemu_log("%s addr=%d reg=%d data=%x\n", __func__, addr, reg, data));
-    return data;
-}
-
-static void mdio_write_req(struct MDIOBus *bus, unsigned int addr,
-               unsigned int reg, uint16_t data)
-{
-    struct PHY *phy;
-
-    DPHY(qemu_log("%s addr=%d reg=%d data=%x\n", __func__, addr, reg, data));
-    phy = bus->devs[addr];
-    if (phy && phy->write) {
-        phy->write(phy, reg, data);
-    }
-}
-
 #define DENET(x)
 
 #define R_RAF      (0x000 / 4)
@@ -322,8 +141,8 @@ enum {
 
 /* Indirect registers.  */
 struct TEMAC  {
-    struct MDIOBus mdio_bus;
-    struct PHY phy;
+    struct qemu_mdio mdio_bus;
+    struct qemu_phy phy;
 
     void *parent;
 };
diff --git a/hw/net/Makefile.objs b/hw/net/Makefile.objs
index 4171af0b5d..a020963d10 100644
--- a/hw/net/Makefile.objs
+++ b/hw/net/Makefile.objs
@@ -30,6 +30,8 @@ common-obj-$(CONFIG_SUNHME) += sunhme.o
 common-obj-$(CONFIG_FTGMAC100) += ftgmac100.o
 common-obj-$(CONFIG_SUNGEM) += sungem.o
 
+common-obj-y += mdio.o
+
 obj-$(CONFIG_ETRAXFS) += etraxfs_eth.o
 obj-$(CONFIG_COLDFIRE) += mcf_fec.o
 obj-$(CONFIG_MILKYMIST) += milkymist-minimac2.o
-- 
2.14.1
