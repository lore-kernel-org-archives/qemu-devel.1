Received: from eggs.gnu.org ([2001:4830:134:3::10]:59434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvRWW-0003Zl-I7
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:13:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvRWU-0003Xn-Lr
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:13:56 -0400
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:36708)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dvRWU-0003Wu-GZ
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 13:13:54 -0400
Received: by mail-qk0-x244.google.com with SMTP id i14so1025392qke.3
	for <qemu-devel@nongnu.org>; Fri, 22 Sep 2017 10:13:54 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 22 Sep 2017 14:13:21 -0300
Message-Id: <20170922171323.10348-6-f4bug@amsat.org>
In-Reply-To: <20170922171323.10348-1-f4bug@amsat.org>
References: <20170922171323.10348-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 5/7] hw/mdio: Refactor bitbanging state
 machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Grant Likely <grant.likely@arm.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

From: Grant Likely <grant.likely@arm.com>

The MDIO state machine has a moderate amount of duplicate code in the
state processing that can be consolidated. This patch does so and
reorganizes it a bit so that far less code is required. Most of the
states simply stream a fixed number of bits in as a single integer and
can be handled by a common processing function that checks for
completion of the state and returns the streamed in value.

Changes include:
- Move clock state change tracking into core code
- Use a common shift register for clocking data in and out
- Create separate mdc & mdio accessor functions
  - will be replaced with GPIO connection in a follow-on patch

Signed-off-by: Grant Likely <grant.likely@arm.com>
Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
[PMD: just rebased]
---
 include/hw/net/mdio.h |  41 ++++++++-------
 hw/net/etraxfs_eth.c  |  11 ++--
 hw/net/mdio.c         | 140 ++++++++++++++++++++++----------------------------
 3 files changed, 87 insertions(+), 105 deletions(-)

diff --git a/include/hw/net/mdio.h b/include/hw/net/mdio.h
index ed1879a728..7fca19784e 100644
--- a/include/hw/net/mdio.h
+++ b/include/hw/net/mdio.h
@@ -52,37 +52,33 @@
 #define PHY_ADVERTISE_100FULL   0x0100  /* Try for 100mbps full-duplex */
 
 struct qemu_phy {
-    uint32_t regs[NUM_PHY_REGS];
+    uint16_t regs[NUM_PHY_REGS];
     const uint16_t *regs_readonly_mask; /* 0=writable, 1=read-only */
 
-    int link;
+    bool link;
 
-    unsigned int (*read)(struct qemu_phy *phy, unsigned int req);
-    void (*write)(struct qemu_phy *phy, unsigned int req, unsigned int data);
+    uint16_t (*read)(struct qemu_phy *phy, unsigned int req);
+    void (*write)(struct qemu_phy *phy, unsigned int req, uint16_t data);
 };
 
 struct qemu_mdio {
-    /* bus. */
-    int mdc;
-    int mdio;
-
-    /* decoder.  */
+    /* bitbanging state machine */
+    bool mdc;
+    bool mdio;
     enum {
         PREAMBLE,
-        SOF,
         OPC,
         ADDR,
         REQ,
         TURNAROUND,
         DATA
     } state;
-    unsigned int drive;
 
-    unsigned int cnt;
-    unsigned int addr;
-    unsigned int opc;
-    unsigned int req;
-    unsigned int data;
+    uint16_t cnt; /* Bit count for current state */
+    uint16_t addr; /* PHY Address; retrieved during ADDR state */
+    uint16_t opc; /* Operation; 2:read */
+    uint16_t req; /* Register address */
+    uint32_t shiftreg; /* shift register; bits in to or out from PHY */
 
     struct qemu_phy *devs[32];
 };
@@ -91,7 +87,16 @@ void mdio_phy_init(struct qemu_phy *phy, uint16_t id1, uint16_t id2);
 void mdio_attach(struct qemu_mdio *bus, struct qemu_phy *phy,
                  unsigned int addr);
 uint16_t mdio_read_req(struct qemu_mdio *bus, uint8_t addr, uint8_t req);
-void mdio_write_req(struct qemu_mdio *bus, uint8_t addr, uint8_t req, uint16_t data);
-void mdio_cycle(struct qemu_mdio *bus);
+void mdio_write_req(struct qemu_mdio *bus, uint8_t addr, uint8_t req,
+                    uint16_t data);
+void mdio_bitbang_set_clk(struct qemu_mdio *bus, bool mdc);
+static inline void mdio_bitbang_set_data(struct qemu_mdio *bus, bool mdio)
+{
+    bus->mdio = mdio;
+}
+static inline bool mdio_bitbang_get_data(struct qemu_mdio *bus)
+{
+    return bus->mdio;
+}
 
 #endif
diff --git a/hw/net/etraxfs_eth.c b/hw/net/etraxfs_eth.c
index 4c5415771f..1b518ea16e 100644
--- a/hw/net/etraxfs_eth.c
+++ b/hw/net/etraxfs_eth.c
@@ -119,7 +119,7 @@ eth_read(void *opaque, hwaddr addr, unsigned int size)
 
     switch (addr) {
     case R_STAT:
-        r = eth->mdio_bus.mdio & 1;
+        r = mdio_bitbang_get_data(&eth->mdio_bus);
         break;
     default:
         r = eth->regs[addr];
@@ -177,13 +177,10 @@ eth_write(void *opaque, hwaddr addr,
     case RW_MGM_CTRL:
         /* Attach an MDIO/PHY abstraction.  */
         if (value & 2) {
-            eth->mdio_bus.mdio = value & 1;
+            mdio_bitbang_set_data(&eth->mdio_bus, value & 1);
         }
-        if (eth->mdio_bus.mdc != (value & 4)) {
-            mdio_cycle(&eth->mdio_bus);
-            eth_validate_duplex(eth);
-        }
-        eth->mdio_bus.mdc = !!(value & 4);
+        mdio_bitbang_set_clk(&eth->mdio_bus, value & 4);
+        eth_validate_duplex(eth);
         eth->regs[addr] = value;
         break;
 
diff --git a/hw/net/mdio.c b/hw/net/mdio.c
index 89a6a3a590..96e10fada0 100644
--- a/hw/net/mdio.c
+++ b/hw/net/mdio.c
@@ -43,7 +43,7 @@
  * linux driver (PHYID and Diagnostics reg).
  * TODO: Add friendly names for the register nums.
  */
-static unsigned int mdio_phy_read(struct qemu_phy *phy, unsigned int req)
+static uint16_t mdio_phy_read(struct qemu_phy *phy, unsigned int req)
 {
     int regnum;
     unsigned r = 0;
@@ -107,7 +107,8 @@ static unsigned int mdio_phy_read(struct qemu_phy *phy, unsigned int req)
     return r;
 }
 
-static void mdio_phy_write(struct qemu_phy *phy, unsigned int req, unsigned int data)
+static void mdio_phy_write(struct qemu_phy *phy, unsigned int req,
+                           uint16_t data)
 {
     int regnum = req & 0x1f;
     uint16_t mask = phy->regs_readonly_mask[regnum];
@@ -136,13 +137,14 @@ void mdio_phy_init(struct qemu_phy *phy, uint16_t id1, uint16_t id2)
     /* Autonegotiation advertisement reg. */
     phy->regs[PHY_AUTONEG_ADV] = 0x01e1;
     phy->regs_readonly_mask = default_readonly_mask;
-    phy->link = 1;
+    phy->link = true;
 
     phy->read = mdio_phy_read;
     phy->write = mdio_phy_write;
 }
 
-void mdio_attach(struct qemu_mdio *bus, struct qemu_phy *phy, unsigned int addr)
+void mdio_attach(struct qemu_mdio *bus, struct qemu_phy *phy,
+                 unsigned int addr)
 {
     bus->devs[addr & 0x1f] = phy;
 }
@@ -169,99 +171,77 @@ void mdio_write_req(struct qemu_mdio *bus, uint8_t addr, uint8_t req,
     }
 }
 
-void mdio_cycle(struct qemu_mdio *bus)
+/**
+ * mdio_bitbang_update() - internal function to check how many clocks have
+ * passed and move to the next state if necessary. Returns TRUE on state change.
+ */
+static bool mdio_bitbang_update(struct qemu_mdio *bus, int num_bits, int next,
+                                uint16_t *reg)
 {
+    if (bus->cnt < num_bits) {
+        return false;
+    }
+    if (reg) {
+        *reg = bus->shiftreg;
+    }
+    bus->state = next;
+    bus->cnt = 0;
+    bus->shiftreg = 0;
+    return true;
+}
+
+/**
+ * mdio_bitbang_set_clk() - set value of mdc signal and update state
+ */
+void mdio_bitbang_set_clk(struct qemu_mdio *bus, bool mdc)
+{
+    uint16_t tmp;
+
+    if (mdc == bus->mdc) {
+        return; /* Clock state hasn't changed; do nothing */
+    }
+
+    bus->mdc = mdc;
+    if (bus->mdc) {
+        /* Falling (inactive) clock edge */
+        if ((bus->state == DATA) && (bus->opc == 2)) {
+            bus->mdio = !!(bus->shiftreg & 0x8000);
+        }
+        return;
+    }
+
+    /* Rising clock Edge */
+    bus->shiftreg = (bus->shiftreg << 1) | bus->mdio;
     bus->cnt++;
-
     D(printf("mdc=%d mdio=%d state=%d cnt=%d drv=%d\n",
-             bus->mdc, bus->mdio, bus->state, bus->cnt, bus->drive));
+             bus->mdc, bus->mdio, bus->state, bus->cnt));
     switch (bus->state) {
     case PREAMBLE:
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
-            if (bus->cnt == 1 * 2) {
-                bus->cnt = 0;
-                bus->opc = 0;
-                bus->state = OPC;
-            }
+        /* MDIO must be 30 clocks high, 1 low, and 1 high to get out of
+           preamble */
+        if (bus->shiftreg == 0xfffffffd) {
+            mdio_bitbang_update(bus, 0, OPC, NULL);
         }
         break;
     case OPC:
-        if (bus->mdc) {
-            bus->opc <<= 1;
-            bus->opc |= bus->mdio & 1;
-            if (bus->cnt == 2 * 2) {
-                bus->cnt = 0;
-                bus->addr = 0;
-                bus->state = ADDR;
-            }
-        }
+        mdio_bitbang_update(bus, 2, ADDR, &bus->opc);
         break;
     case ADDR:
-        if (bus->mdc) {
-            bus->addr <<= 1;
-            bus->addr |= bus->mdio & 1;
-
-            if (bus->cnt == 5 * 2) {
-                bus->cnt = 0;
-                bus->req = 0;
-                bus->state = REQ;
-            }
-        }
+        mdio_bitbang_update(bus, 5, REQ, &bus->addr);
         break;
     case REQ:
-        if (bus->mdc) {
-            bus->req <<= 1;
-            bus->req |= bus->mdio & 1;
-            if (bus->cnt == 5 * 2) {
-                bus->cnt = 0;
-                bus->state = TURNAROUND;
-            }
-        }
+        mdio_bitbang_update(bus, 5, TURNAROUND, &bus->req);
         break;
     case TURNAROUND:
-        if (bus->mdc && bus->cnt == 2 * 2) {
-            bus->mdio = 0;
-            bus->cnt = 0;
-
-            if (bus->opc == 2) {
-                bus->drive = 1;
-                bus->data = mdio_read_req(bus, bus->addr, bus->req);
-                bus->mdio = bus->data & 1;
-            }
-            bus->state = DATA;
+        /* If beginning of DATA READ cycle, then read PHY into shift register */
+        if (mdio_bitbang_update(bus, 2, DATA, NULL) && (bus->opc == 2)) {
+            bus->shiftreg = mdio_read_req(bus, bus->addr, bus->req);
         }
         break;
     case DATA:
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
-                    mdio_write_req(bus, bus->addr, bus->req, bus->data);
-                }
-                bus->drive = 0;
-            }
+        /* If end of DATA WRITE cycle, then write shift register to PHY */
+        if (mdio_bitbang_update(bus, 16, PREAMBLE, &tmp) && (bus->opc == 1)) {
+            mdio_write_req(bus, bus->addr, bus->req, tmp);
         }
         break;
     default:
-- 
2.14.1
