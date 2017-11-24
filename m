Received: from eggs.gnu.org ([2001:4830:134:3::10]:33281)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eI5Wf-0002Pg-7h
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 23:23:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sjitindarsingh@gmail.com>) id 1eI5We-0005W4-B6
	for qemu-devel@nongnu.org; Thu, 23 Nov 2017 23:23:41 -0500
From: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Date: Fri, 24 Nov 2017 15:23:24 +1100
Message-Id: <20171124042325.28012-2-sjitindarsingh@gmail.com>
In-Reply-To: <20171124042325.28012-1-sjitindarsingh@gmail.com>
References: <20171124042325.28012-1-sjitindarsingh@gmail.com>
Subject: [Qemu-devel] [QEMU-PPC] [PATCH 1/2] target/ppc: Move setting of
 patb_entry on hash table init
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, sjitindarsingh@gmail.com, groug@kaod.org

The patb_entry is used to store the location of the process table in
guest memory. The msb is also used to indicate the mmu mode of the
guest, that is patb_entry & 1 << 63 ? radix_mode : hash_mode.

Currently we set this to zero in spapr_setup_hpt_and_vrma() since if
this function gets called then we know we're hash. However some code
paths, such as setting up the hpt on incoming migration of a hash guest,
call spapr_reallocate_hpt() directly bypassing this higher level
function. Since we assume radix if the host is capable this results in
the msb in patb_entry being left set so in spapr_post_load() we call
kvmppc_configure_v3_mmu() and tell the host we're radix which as
expected means addresses cannot be translated once we actually run the cpu.

To fix this move the zeroing of patb_entry into spapr_reallocate_hpt().

Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
---
 hw/ppc/spapr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6841bd294b..e7af47bab0 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -1373,6 +1373,8 @@ void spapr_reallocate_hpt(sPAPRMachineState *spapr, int shift,
             DIRTY_HPTE(HPTE(spapr->htab, i));
         }
     }
+    /* We're setting up a hash table, so that means we're not radix */
+    spapr->patb_entry = 0;
 }
 
 void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr)
@@ -1392,8 +1394,6 @@ void spapr_setup_hpt_and_vrma(sPAPRMachineState *spapr)
         spapr->rma_size = kvmppc_rma_size(spapr_node0_size(MACHINE(spapr)),
                                           spapr->htab_shift);
     }
-    /* We're setting up a hash table, so that means we're not radix */
-    spapr->patb_entry = 0;
 }
 
 static void find_unknown_sysbus_device(SysBusDevice *sbdev, void *opaque)
-- 
2.13.6
