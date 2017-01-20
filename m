Received: from eggs.gnu.org ([2001:4830:134:3::10]:39579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cUPYf-0000W3-4c
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:08:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1cUPYc-0002sY-DM
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:08:09 -0500
Received: from mx1.redhat.com ([209.132.183.28]:57178)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1cUPYc-0002ry-3r
	for qemu-devel@nongnu.org; Thu, 19 Jan 2017 22:08:06 -0500
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 20 Jan 2017 11:07:48 +0800
Message-Id: <1484881670-24237-5-git-send-email-jasowang@redhat.com>
In-Reply-To: <1484881670-24237-1-git-send-email-jasowang@redhat.com>
References: <1484881670-24237-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 4/6] hw/net/dp8393x: Avoid unintentional sign
 extensions on addresses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Jason Wang <jasowang@redhat.com>

From: Peter Maydell <peter.maydell@linaro.org>

The dp8393x has several 32-bit values which are formed by concatenating
two 16 bit device register values. Attempting to do these inline
with ((s->reg[HI] << 16) | s->reg[LO]) can result in an unintended
sign extension because "x << 16" is of type 'int' even though s->reg
is unsigned, and so if the expression is used in a context where
it is cast to uint64_t the value is incorrectly sign-extended.
Fix this by using accessor functions with a uint32_t return type;
this also makes the code a bit easier to read.

This should fix Coverity issues 1307765, 1307766, 1307767, 1307768.

(To avoid having a ctda read function only used in a DPRINTF,
we move the DPRINTF down slightly so it can use the ttda function.)

Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Tested-by: Laurent Vivier <laurent@vivier.eu>
Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/dp8393x.c | 95 ++++++++++++++++++++++++++++++++++++++++----------=
------
 1 file changed, 68 insertions(+), 27 deletions(-)

diff --git a/hw/net/dp8393x.c b/hw/net/dp8393x.c
index 17f0338..efa33ad 100644
--- a/hw/net/dp8393x.c
+++ b/hw/net/dp8393x.c
@@ -174,6 +174,52 @@ typedef struct dp8393xState {
     AddressSpace as;
 } dp8393xState;
=20
+/* Accessor functions for values which are formed by
+ * concatenating two 16 bit device registers. By putting these
+ * in their own functions with a uint32_t return type we avoid the
+ * pitfall of implicit sign extension where ((x << 16) | y) is a
+ * signed 32 bit integer that might get sign-extended to a 64 bit intege=
r.
+ */
+static uint32_t dp8393x_cdp(dp8393xState *s)
+{
+    return (s->regs[SONIC_URRA] << 16) | s->regs[SONIC_CDP];
+}
+
+static uint32_t dp8393x_crba(dp8393xState *s)
+{
+    return (s->regs[SONIC_CRBA1] << 16) | s->regs[SONIC_CRBA0];
+}
+
+static uint32_t dp8393x_crda(dp8393xState *s)
+{
+    return (s->regs[SONIC_URDA] << 16) | s->regs[SONIC_CRDA];
+}
+
+static uint32_t dp8393x_rbwc(dp8393xState *s)
+{
+    return (s->regs[SONIC_RBWC1] << 16) | s->regs[SONIC_RBWC0];
+}
+
+static uint32_t dp8393x_rrp(dp8393xState *s)
+{
+    return (s->regs[SONIC_URRA] << 16) | s->regs[SONIC_RRP];
+}
+
+static uint32_t dp8393x_tsa(dp8393xState *s)
+{
+    return (s->regs[SONIC_TSA1] << 16) | s->regs[SONIC_TSA0];
+}
+
+static uint32_t dp8393x_ttda(dp8393xState *s)
+{
+    return (s->regs[SONIC_UTDA] << 16) | s->regs[SONIC_TTDA];
+}
+
+static uint32_t dp8393x_wt(dp8393xState *s)
+{
+    return s->regs[SONIC_WT1] << 16 | s->regs[SONIC_WT0];
+}
+
 static void dp8393x_update_irq(dp8393xState *s)
 {
     int level =3D (s->regs[SONIC_IMR] & s->regs[SONIC_ISR]) ? 1 : 0;
@@ -203,8 +249,7 @@ static void dp8393x_do_load_cam(dp8393xState *s)
=20
     while (s->regs[SONIC_CDC] & 0x1f) {
         /* Fill current entry */
-        address_space_rw(&s->as,
-            (s->regs[SONIC_URRA] << 16) | s->regs[SONIC_CDP],
+        address_space_rw(&s->as, dp8393x_cdp(s),
             MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
         s->cam[index][0] =3D data[1 * width] & 0xff;
         s->cam[index][1] =3D data[1 * width] >> 8;
@@ -222,8 +267,7 @@ static void dp8393x_do_load_cam(dp8393xState *s)
     }
=20
     /* Read CAM enable */
-    address_space_rw(&s->as,
-        (s->regs[SONIC_URRA] << 16) | s->regs[SONIC_CDP],
+    address_space_rw(&s->as, dp8393x_cdp(s),
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
     s->regs[SONIC_CE] =3D data[0 * width];
     DPRINTF("load cam done. cam enable mask 0x%04x\n", s->regs[SONIC_CE]=
);
@@ -242,8 +286,7 @@ static void dp8393x_do_read_rra(dp8393xState *s)
     /* Read memory */
     width =3D (s->regs[SONIC_DCR] & SONIC_DCR_DW) ? 2 : 1;
     size =3D sizeof(uint16_t) * 4 * width;
-    address_space_rw(&s->as,
-        (s->regs[SONIC_URRA] << 16) | s->regs[SONIC_RRP],
+    address_space_rw(&s->as, dp8393x_rrp(s),
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
=20
     /* Update SONIC registers */
@@ -292,7 +335,7 @@ static void dp8393x_set_next_tick(dp8393xState *s)
         return;
     }
=20
-    ticks =3D s->regs[SONIC_WT1] << 16 | s->regs[SONIC_WT0];
+    ticks =3D dp8393x_wt(s);
     s->wt_last_update =3D qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
     delay =3D NANOSECONDS_PER_SECOND * ticks / 5000000;
     timer_mod(s->watchdog, s->wt_last_update + delay);
@@ -309,7 +352,7 @@ static void dp8393x_update_wt_regs(dp8393xState *s)
     }
=20
     elapsed =3D s->wt_last_update - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL=
);
-    val =3D s->regs[SONIC_WT1] << 16 | s->regs[SONIC_WT0];
+    val =3D dp8393x_wt(s);
     val -=3D elapsed / 5000000;
     s->regs[SONIC_WT1] =3D (val >> 16) & 0xffff;
     s->regs[SONIC_WT0] =3D (val >> 0)  & 0xffff;
@@ -356,12 +399,11 @@ static void dp8393x_do_transmit_packets(dp8393xStat=
e *s)
=20
     while (1) {
         /* Read memory */
-        DPRINTF("Transmit packet at %08x\n",
-                (s->regs[SONIC_UTDA] << 16) | s->regs[SONIC_CTDA]);
         size =3D sizeof(uint16_t) * 6 * width;
         s->regs[SONIC_TTDA] =3D s->regs[SONIC_CTDA];
+        DPRINTF("Transmit packet at %08x\n", dp8393x_ttda(s));
         address_space_rw(&s->as,
-            ((s->regs[SONIC_UTDA] << 16) | s->regs[SONIC_TTDA]) + sizeof=
(uint16_t) * width,
+            dp8393x_ttda(s) + sizeof(uint16_t) * width,
             MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
         tx_len =3D 0;
=20
@@ -386,8 +428,7 @@ static void dp8393x_do_transmit_packets(dp8393xState =
*s)
             if (tx_len + len > sizeof(s->tx_buffer)) {
                 len =3D sizeof(s->tx_buffer) - tx_len;
             }
-            address_space_rw(&s->as,
-                (s->regs[SONIC_TSA1] << 16) | s->regs[SONIC_TSA0],
+            address_space_rw(&s->as, dp8393x_tsa(s),
                 MEMTXATTRS_UNSPECIFIED, &s->tx_buffer[tx_len], len, 0);
             tx_len +=3D len;
=20
@@ -396,7 +437,7 @@ static void dp8393x_do_transmit_packets(dp8393xState =
*s)
                 /* Read next fragment details */
                 size =3D sizeof(uint16_t) * 3 * width;
                 address_space_rw(&s->as,
-                    ((s->regs[SONIC_UTDA] << 16) | s->regs[SONIC_TTDA]) =
+ sizeof(uint16_t) * (4 + 3 * i) * width,
+                    dp8393x_ttda(s) + sizeof(uint16_t) * (4 + 3 * i) * w=
idth,
                     MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
                 s->regs[SONIC_TSA0] =3D data[0 * width];
                 s->regs[SONIC_TSA1] =3D data[1 * width];
@@ -430,14 +471,16 @@ static void dp8393x_do_transmit_packets(dp8393xStat=
e *s)
         data[0 * width] =3D s->regs[SONIC_TCR] & 0x0fff; /* status */
         size =3D sizeof(uint16_t) * width;
         address_space_rw(&s->as,
-            (s->regs[SONIC_UTDA] << 16) | s->regs[SONIC_TTDA],
+            dp8393x_ttda(s),
             MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 1);
=20
         if (!(s->regs[SONIC_CR] & SONIC_CR_HTX)) {
             /* Read footer of packet */
             size =3D sizeof(uint16_t) * width;
             address_space_rw(&s->as,
-                ((s->regs[SONIC_UTDA] << 16) | s->regs[SONIC_TTDA]) + si=
zeof(uint16_t) * (4 + 3 * s->regs[SONIC_TFC]) * width,
+                dp8393x_ttda(s) +
+                             sizeof(uint16_t) *
+                             (4 + 3 * s->regs[SONIC_TFC]) * width,
                 MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
             s->regs[SONIC_CTDA] =3D data[0 * width] & ~0x1;
             if (data[0 * width] & 0x1) {
@@ -700,7 +743,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, co=
nst uint8_t * buf,
     if (s->regs[SONIC_LLFA] & 0x1) {
         /* Are we still in resource exhaustion? */
         size =3D sizeof(uint16_t) * 1 * width;
-        address =3D ((s->regs[SONIC_URDA] << 16) | s->regs[SONIC_CRDA]) =
+ sizeof(uint16_t) * 5 * width;
+        address =3D dp8393x_crda(s) + sizeof(uint16_t) * 5 * width;
         address_space_rw(&s->as, address, MEMTXATTRS_UNSPECIFIED,
                          (uint8_t *)data, size, 0);
         if (data[0 * width] & 0x1) {
@@ -719,8 +762,8 @@ static ssize_t dp8393x_receive(NetClientState *nc, co=
nst uint8_t * buf,
     checksum =3D cpu_to_le32(crc32(0, buf, rx_len));
=20
     /* Put packet into RBA */
-    DPRINTF("Receive packet at %08x\n", (s->regs[SONIC_CRBA1] << 16) | s=
->regs[SONIC_CRBA0]);
-    address =3D (s->regs[SONIC_CRBA1] << 16) | s->regs[SONIC_CRBA0];
+    DPRINTF("Receive packet at %08x\n", dp8393x_crba(s));
+    address =3D dp8393x_crba(s);
     address_space_rw(&s->as, address,
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)buf, rx_len, 1);
     address +=3D rx_len;
@@ -729,13 +772,13 @@ static ssize_t dp8393x_receive(NetClientState *nc, =
const uint8_t * buf,
     rx_len +=3D 4;
     s->regs[SONIC_CRBA1] =3D address >> 16;
     s->regs[SONIC_CRBA0] =3D address & 0xffff;
-    available =3D (s->regs[SONIC_RBWC1] << 16) | s->regs[SONIC_RBWC0];
+    available =3D dp8393x_rbwc(s);
     available -=3D rx_len / 2;
     s->regs[SONIC_RBWC1] =3D available >> 16;
     s->regs[SONIC_RBWC0] =3D available & 0xffff;
=20
     /* Update status */
-    if (((s->regs[SONIC_RBWC1] << 16) | s->regs[SONIC_RBWC0]) < s->regs[=
SONIC_EOBC]) {
+    if (dp8393x_rbwc(s) < s->regs[SONIC_EOBC]) {
         s->regs[SONIC_RCR] |=3D SONIC_RCR_LPKT;
     }
     s->regs[SONIC_RCR] |=3D packet_type;
@@ -746,20 +789,19 @@ static ssize_t dp8393x_receive(NetClientState *nc, =
const uint8_t * buf,
     }
=20
     /* Write status to memory */
-    DPRINTF("Write status at %08x\n", (s->regs[SONIC_URDA] << 16) | s->r=
egs[SONIC_CRDA]);
+    DPRINTF("Write status at %08x\n", dp8393x_crda(s));
     data[0 * width] =3D s->regs[SONIC_RCR]; /* status */
     data[1 * width] =3D rx_len; /* byte count */
     data[2 * width] =3D s->regs[SONIC_TRBA0]; /* pkt_ptr0 */
     data[3 * width] =3D s->regs[SONIC_TRBA1]; /* pkt_ptr1 */
     data[4 * width] =3D s->regs[SONIC_RSC]; /* seq_no */
     size =3D sizeof(uint16_t) * 5 * width;
-    address_space_rw(&s->as, (s->regs[SONIC_URDA] << 16) | s->regs[SONIC=
_CRDA],
+    address_space_rw(&s->as, dp8393x_crda(s),
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 1);
=20
     /* Move to next descriptor */
     size =3D sizeof(uint16_t) * width;
-    address_space_rw(&s->as,
-        ((s->regs[SONIC_URDA] << 16) | s->regs[SONIC_CRDA]) + sizeof(uin=
t16_t) * 5 * width,
+    address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 5 * wi=
dth,
         MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, size, 0);
     s->regs[SONIC_LLFA] =3D data[0 * width];
     if (s->regs[SONIC_LLFA] & 0x1) {
@@ -767,8 +809,7 @@ static ssize_t dp8393x_receive(NetClientState *nc, co=
nst uint8_t * buf,
         s->regs[SONIC_ISR] |=3D SONIC_ISR_RDE;
     } else {
         data[0 * width] =3D 0; /* in_use */
-        address_space_rw(&s->as,
-            ((s->regs[SONIC_URDA] << 16) | s->regs[SONIC_CRDA]) + sizeof=
(uint16_t) * 6 * width,
+        address_space_rw(&s->as, dp8393x_crda(s) + sizeof(uint16_t) * 6 =
* width,
             MEMTXATTRS_UNSPECIFIED, (uint8_t *)data, sizeof(uint16_t), 1=
);
         s->regs[SONIC_CRDA] =3D s->regs[SONIC_LLFA];
         s->regs[SONIC_ISR] |=3D SONIC_ISR_PKTRX;
--=20
2.7.4
