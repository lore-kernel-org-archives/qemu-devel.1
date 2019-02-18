Received: from eggs.gnu.org ([209.51.188.92]:39083)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxl-0006NC-ED
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gvjxh-00032a-UH
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 09:32:03 -0500
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 19 Feb 2019 01:30:20 +1100
Message-Id: <20190218143049.17142-15-david@gibson.dropbear.id.au>
In-Reply-To: <20190218143049.17142-1-david@gibson.dropbear.id.au>
References: <20190218143049.17142-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/43] spapr: fix out of bounds write in
 spapr_populate_drmem_v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, clg@kaod.org, Fabiano Rosas <farosas@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>

From: Fabiano Rosas <farosas@linux.ibm.com>

buf_len is uint8_t which is not large enough to hold the result of:

  nr_entries * sizeof(struct sPAPRDrconfCellV2) + sizeof(uint32_t);

for a nr_entries greater than 10.

This causes the allocated buffer 'int_buf' to be smaller than expected
and we eventually overwrite some of glibc's control structures (see
"chunk" in https://sourceware.org/glibc/wiki/MallocInternals)

The following error is seen while trying to free int_buf:

  "free(): invalid next size (fast)"

Fixes: a324d6f166 "spapr: Support ibm,dynamic-memory-v2 property"
Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>
Message-Id: <20190213172926.21740-1-farosas@linux.ibm.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/ppc/spapr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 850cfe28c4..abf9ebce59 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -687,14 +687,14 @@ static int spapr_populate_drmem_v2(sPAPRMachineStat=
e *spapr, void *fdt,
                                    int offset, MemoryDeviceInfoList *dim=
ms)
 {
     MachineState *machine =3D MACHINE(spapr);
-    uint8_t *int_buf, *cur_index, buf_len;
+    uint8_t *int_buf, *cur_index;
     int ret;
     uint64_t lmb_size =3D SPAPR_MEMORY_BLOCK_SIZE;
     uint64_t addr, cur_addr, size;
     uint32_t nr_boot_lmbs =3D (machine->device_memory->base / lmb_size);
     uint64_t mem_end =3D machine->device_memory->base +
                        memory_region_size(&machine->device_memory->mr);
-    uint32_t node, nr_entries =3D 0;
+    uint32_t node, buf_len, nr_entries =3D 0;
     sPAPRDRConnector *drc;
     DrconfCellQueue *elem, *next;
     MemoryDeviceInfoList *info;
--=20
2.20.1
