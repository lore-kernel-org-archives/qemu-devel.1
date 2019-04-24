Received: from eggs.gnu.org ([209.51.188.92]:52715)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hJCha-0003k9-Ul
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 03:52:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <shmuel.eiderman@oracle.com>) id 1hJCek-00081W-O3
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 03:49:28 -0400
From: Sam Eiderman <shmuel.eiderman@oracle.com>
Date: Wed, 24 Apr 2019 10:49:00 +0300
Message-Id: <20190424074901.31430-2-shmuel.eiderman@oracle.com>
In-Reply-To: <20190424074901.31430-1-shmuel.eiderman@oracle.com>
References: <20190424074901.31430-1-shmuel.eiderman@oracle.com>
Subject: [Qemu-devel] [PATCH 1/2] vmdk: Fix comment regarding max l1_size
 coverage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: fam@euphon.net, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org
Cc: arbel.moshe@oracle.com, karl.heubaum@oracle.com, eyal.moscovici@oracle.com, liran.alon@oracle.com, qemu-devel@nongnu.org, shmuel.eiderman@oracle.com

Commit b0651b8c246d ("vmdk: Move l1_size check into vmdk_add_extent")
extended the l1_size check from VMDK4 to VMDK3 but did not update the
default coverage in the moved comment.

The previous vmdk4 calculation:

    (512 * 1024 * 1024) * 512(l2 entries) * 65536(grain) = 16PB

The added vmdk3 calculation:

    (512 * 1024 * 1024) * 4096(l2 entries) * 512(grain) = 1PB

Adding the calculation of vmdk3 to the comment.

In any case, VMware does not offer virtual disks more than 2TB for
vmdk4/vmdk3 or 64TB for the new undocumented seSparse format which is
not implemented yet in qemu.

Reviewed-by: Karl Heubaum <karl.heubaum@oracle.com>
Reviewed-by: Eyal Moscovici <eyal.moscovici@oracle.com>
Reviewed-by: Liran Alon <liran.alon@oracle.com>
Reviewed-by: Arbel Moshe <arbel.moshe@oracle.com>
Signed-off-by: Sam Eiderman <shmuel.eiderman@oracle.com>
---
 block/vmdk.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/vmdk.c b/block/vmdk.c
index de8cb859f8..fc7378da78 100644
--- a/block/vmdk.c
+++ b/block/vmdk.c
@@ -426,10 +426,15 @@ static int vmdk_add_extent(BlockDriverState *bs,
         return -EFBIG;
     }
     if (l1_size > 512 * 1024 * 1024) {
-        /* Although with big capacity and small l1_entry_sectors, we can get a
+        /*
+         * Although with big capacity and small l1_entry_sectors, we can get a
          * big l1_size, we don't want unbounded value to allocate the table.
-         * Limit it to 512M, which is 16PB for default cluster and L2 table
-         * size */
+         * Limit it to 512M, which is:
+         *     16PB - for default "Hosted Sparse Extent" (VMDK4)
+         *            cluster size: 64KB, L2 table size: 512 entries
+         *     1PB  - for default "ESXi Host Sparse Extent" (VMDK3/vmfsSparse)
+         *            cluster size: 512B, L2 table size: 4096 entries
+         */
         error_setg(errp, "L1 size too big");
         return -EFBIG;
     }
-- 
2.13.3
