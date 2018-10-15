Received: from eggs.gnu.org ([2001:4830:134:3::10]:45845)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByXQ-0004gj-M1
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1gByXP-0004fg-FZ
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59468)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1gByXP-0004eo-6F
	for qemu-devel@nongnu.org; Mon, 15 Oct 2018 04:47:43 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 15 Oct 2018 16:46:25 +0800
Message-Id: <1539593186-32183-26-git-send-email-jasowang@redhat.com>
In-Reply-To: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
References: <1539593186-32183-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 25/26] e1000: indicate dropped packets in HW
 counters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Martin Wilck <mwilck@suse.com>, Jason Wang <jasowang@redhat.com>

From: Martin Wilck <mwilck@suse.com>

The e1000 emulation silently discards RX packets if there's
insufficient space in the ring buffer. This leads to errors
on higher-level protocols in the guest, with no indication
about the error cause.

This patch increments the "Missed Packets Count" (MPC) and
"Receive No Buffers Count" (RNBC) HW counters in this case.
As the emulation has no FIFO for buffering packets that can't
immediately be pushed to the guest, these two registers are
practically equivalent (see 10.2.7.4, 10.2.7.33 in
https://www.intel.com/content/www/us/en/embedded/products/networking/82574l-gbe-controller-datasheet.html).

On a Linux guest, the register content  will be reflected in
the "rx_missed_errors" and "rx_no_buffer_count" stats from
"ethtool -S", and in the "missed" stat from "ip -s -s link show",
giving at least some hint about the error cause inside the guest.

If the cause is known, problems like this can often be avoided
easily, by increasing the number of RX descriptors in the guest
e1000 driver (e.g under Linux, "e1000.RxDescriptors=1024").

The patch also adds a qemu trace message for this condition.

Signed-off-by: Martin Wilck <mwilck@suse.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 hw/net/e1000.c      | 16 +++++++++++++---
 hw/net/trace-events |  3 +++
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/hw/net/e1000.c b/hw/net/e1000.c
index 13a9494..5e144cb 100644
--- a/hw/net/e1000.c
+++ b/hw/net/e1000.c
@@ -36,6 +36,7 @@
 #include "qemu/range.h"
 
 #include "e1000x_common.h"
+#include "trace.h"
 
 static const uint8_t bcast[] = {0xff, 0xff, 0xff, 0xff, 0xff, 0xff};
 
@@ -847,6 +848,15 @@ static uint64_t rx_desc_base(E1000State *s)
     return (bah << 32) + bal;
 }
 
+static void
+e1000_receiver_overrun(E1000State *s, size_t size)
+{
+    trace_e1000_receiver_overrun(size, s->mac_reg[RDH], s->mac_reg[RDT]);
+    e1000x_inc_reg_if_not_full(s->mac_reg, RNBC);
+    e1000x_inc_reg_if_not_full(s->mac_reg, MPC);
+    set_ics(s, 0, E1000_ICS_RXO);
+}
+
 static ssize_t
 e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
 {
@@ -916,8 +926,8 @@ e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
     desc_offset = 0;
     total_size = size + e1000x_fcs_len(s->mac_reg);
     if (!e1000_has_rxbufs(s, total_size)) {
-            set_ics(s, 0, E1000_ICS_RXO);
-            return -1;
+        e1000_receiver_overrun(s, total_size);
+        return -1;
     }
     do {
         desc_size = total_size - desc_offset;
@@ -969,7 +979,7 @@ e1000_receive_iov(NetClientState *nc, const struct iovec *iov, int iovcnt)
             rdh_start >= s->mac_reg[RDLEN] / sizeof(desc)) {
             DBGOUT(RXERR, "RDH wraparound @%x, RDT %x, RDLEN %x\n",
                    rdh_start, s->mac_reg[RDT], s->mac_reg[RDLEN]);
-            set_ics(s, 0, E1000_ICS_RXO);
+            e1000_receiver_overrun(s, total_size);
             return -1;
         }
     } while (desc_offset < total_size);
diff --git a/hw/net/trace-events b/hw/net/trace-events
index c1dea4b..bdf63cf 100644
--- a/hw/net/trace-events
+++ b/hw/net/trace-events
@@ -98,6 +98,9 @@ net_rx_pkt_rss_ip6_ex(void) "Calculating IPv6/EX RSS  hash"
 net_rx_pkt_rss_hash(size_t rss_length, uint32_t rss_hash) "RSS hash for %zu bytes: 0x%X"
 net_rx_pkt_rss_add_chunk(void* ptr, size_t size, size_t input_offset) "Add RSS chunk %p, %zu bytes, RSS input offset %zu bytes"
 
+# hw/net/e1000.c
+e1000_receiver_overrun(size_t s, uint32_t rdh, uint32_t rdt) "Receiver overrun: dropped packet of %lu bytes, RDH=%u, RDT=%u"
+
 # hw/net/e1000x_common.c
 e1000x_rx_can_recv_disabled(bool link_up, bool rx_enabled, bool pci_master) "link_up: %d, rx_enabled %d, pci_master %d"
 e1000x_vlan_is_vlan_pkt(bool is_vlan_pkt, uint16_t eth_proto, uint16_t vet) "Is VLAN packet: %d, ETH proto: 0x%X, VET: 0x%X"
-- 
2.5.0
