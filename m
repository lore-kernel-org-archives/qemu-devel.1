Received: from eggs.gnu.org ([2001:4830:134:3::10]:43611)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1cJRhW-0001i9-8x
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 16:11:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1cJRhV-0005En-2N
	for qemu-devel@nongnu.org; Tue, 20 Dec 2016 16:11:58 -0500
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Tue, 20 Dec 2016 13:11:40 -0800
Message-Id: <1482268300-10082-1-git-send-email-andrew.smirnov@gmail.com>
Subject: [Qemu-devel] [PATCH] fsl_etsec: Fix Tx BD ring wrapping handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: Alexander Graf <agraf@suse.de>, Scott Wood <scottwood@freescale.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>

Current code that handles Tx buffer desciprtor ring scanning employs the
following algorithm:

	1. Restore current buffer descriptor pointer from TBPTRn

	2. Process current descriptor

	3. If current descriptor has BD_WRAP flag set set current
	   descriptor pointer to start of the descriptor ring

	4. If current descriptor points to start of the ring exit the
	   loop, otherwise increment current descriptor pointer and go
	   to #2

	5. Store current descriptor in TBPTRn

As it can be seen the way the code is implemented results in buffer
descriptor ring being scanned starting at offset/descriptor #0. While
covering proverbial "99%" of the cases, this algorithm becomes
problematic for a number of edge cases.

Consider the following scenario: guest OS driver initializes descriptor
ring to N individual descriptors and starts sending data out. Depending
on the volume of traffic and probably guest OS driver implementation it
is possible that an edge case where a packet, spread across 2
descriptors is placed in descriptors N - 1 and 0 in that order(it is
easy to imagine similar examples involving more than 2 descriptors).

What happens then is aforementioned algorithm starts at descriptor 0,
sees a descriptor marked as BD_LAST, which it happily sends out as a
separate packet(very much malformed at this point) then the iteration
continues and the first part of the original packet is tacked to the
next transmission which ends up being bogus as well.

This behvaiour can be pretty reliably observed when scp'ing data from a
guest OS via TAP interface for files larger than 160K (every time for
700K+).

This patch changes the scanning algorithm to do the following:

	1. Restore "current" and "start" buffer descriptor pointer from
	   TBPTRn

	2. If "current" descriptor has BD_WRAP flag set "next"
	   descriptor pointer to start of the descriptor ring otherwise
	   set "next" to descriptor right after "current"

	3. Process current descriptor

	4. If current descriptore has BD_LAST(end of a packet) set save
	   "next" descriptor pointer in TBPTRn

	5. Set "current" descriptor pointer to "next"

	6. If "current" descriptor points to "start" (from #1) exit the loop
	   loop, otherwise go to #2

This way emulation code always keeps track where guest OS driver was
driving data to last while still going full "loop" over every descriptor
in a ring, which, hopefully, should fix any potential "wrapping" issues.

Signed-off-by: Andrey Smirnov <andrew.smirnov@gmail.com>
---
 hw/net/fsl_etsec/rings.c | 40 +++++++++++++++++++++++++---------------
 1 file changed, 25 insertions(+), 15 deletions(-)

diff --git a/hw/net/fsl_etsec/rings.c b/hw/net/fsl_etsec/rings.c
index 54c0127..3aebd59 100644
--- a/hw/net/fsl_etsec/rings.c
+++ b/hw/net/fsl_etsec/rings.c
@@ -332,7 +332,7 @@ static void process_tx_bd(eTSEC         *etsec,
 void etsec_walk_tx_ring(eTSEC *etsec, int ring_nbr)
 {
     hwaddr        ring_base = 0;
-    hwaddr        bd_addr   = 0;
+    hwaddr        bd_addr, bd_addr_start, bd_addr_next;
     eTSEC_rxtx_bd bd;
     uint16_t      bd_flags;
 
@@ -343,7 +343,7 @@ void etsec_walk_tx_ring(eTSEC *etsec, int ring_nbr)
 
     ring_base = (hwaddr)(etsec->regs[TBASEH].value & 0xF) << 32;
     ring_base += etsec->regs[TBASE0 + ring_nbr].value & ~0x7;
-    bd_addr    = etsec->regs[TBPTR0 + ring_nbr].value & ~0x7;
+    bd_addr_start = bd_addr = etsec->regs[TBPTR0 + ring_nbr].value & ~0x7;
 
     do {
         read_buffer_descriptor(etsec, bd_addr, &bd);
@@ -358,26 +358,36 @@ void etsec_walk_tx_ring(eTSEC *etsec, int ring_nbr)
         /* Save flags before BD update */
         bd_flags = bd.flags;
 
-        if (bd_flags & BD_TX_READY) {
-            process_tx_bd(etsec, &bd);
-
-            /* Write back BD after update */
-            write_buffer_descriptor(etsec, bd_addr, &bd);
-        }
-
         /* Wrap or next BD */
         if (bd_flags & BD_WRAP) {
-            bd_addr = ring_base;
+            bd_addr_next = ring_base;
         } else {
-            bd_addr += sizeof(eTSEC_rxtx_bd);
+            bd_addr_next = bd_addr + sizeof(eTSEC_rxtx_bd);
         }
 
-    } while (bd_addr != ring_base);
+        if (bd_flags & BD_TX_READY) {
+            if (bd_flags & BD_LAST) {
+                /* If we encounter a descriptor marking end of a
+                 * packet - save a pointer to descriptor after that as
+                 * a place to resume descriptor processing for next
+                 * time.
+                 *
+                 * As we iterate through a ring we progressively move
+                 * this point forward and at the end of one cycle end
+                 * up with the position right after the last packet we
+                 * encountered.
+                 */
+                etsec->regs[TBPTR0 + ring_nbr].value = bd_addr_next;
+            }
+
+            process_tx_bd(etsec, &bd);
 
-    bd_addr = ring_base;
+            /* Write back BD after update */
+            write_buffer_descriptor(etsec, bd_addr, &bd);
+        }
 
-    /* Save the Buffer Descriptor Pointers to current bd */
-    etsec->regs[TBPTR0 + ring_nbr].value = bd_addr;
+        bd_addr = bd_addr_next;
+    } while (bd_addr != bd_addr_start);
 
     /* Set transmit halt THLTx */
     etsec->regs[TSTAT].value |= 1 << (31 - ring_nbr);
-- 
2.5.5
