Received: from eggs.gnu.org ([209.51.188.92]:58744)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gtyLr-0005Ui-6L
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 12:29:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gtyLq-0006Ap-5J
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 12:29:39 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:51968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gtyLp-00065A-KD
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 12:29:38 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id
	x1DHTCXL020567
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 12:29:32 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2qmqan8yrb-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 13 Feb 2019 12:29:31 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Wed, 13 Feb 2019 17:29:31 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
Date: Wed, 13 Feb 2019 15:29:26 -0200
Message-Id: <20190213172926.21740-1-farosas@linux.ibm.com>
Subject: [Qemu-devel] [PATCH] spapr: fix out of bounds write in
 spapr_populate_drmem_v2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au

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
---
 hw/ppc/spapr.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 332cba89d4..7c4bf8ed8c 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -687,14 +687,14 @@ static int spapr_populate_drmem_v2(sPAPRMachineState *spapr, void *fdt,
                                    int offset, MemoryDeviceInfoList *dimms)
 {
     MachineState *machine = MACHINE(spapr);
-    uint8_t *int_buf, *cur_index, buf_len;
+    uint8_t *int_buf, *cur_index;
     int ret;
     uint64_t lmb_size = SPAPR_MEMORY_BLOCK_SIZE;
     uint64_t addr, cur_addr, size;
     uint32_t nr_boot_lmbs = (machine->device_memory->base / lmb_size);
     uint64_t mem_end = machine->device_memory->base +
                        memory_region_size(&machine->device_memory->mr);
-    uint32_t node, nr_entries = 0;
+    uint32_t node, buf_len, nr_entries = 0;
     sPAPRDRConnector *drc;
     DrconfCellQueue *elem, *next;
     MemoryDeviceInfoList *info;
-- 
2.17.1
