Received: from eggs.gnu.org ([2001:4830:134:3::10]:42982)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1enfAU-0004jU-Hv
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:43:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bharata@linux.vnet.ibm.com>) id 1enfAR-0001df-Fp
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:43:18 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:49602
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bharata@linux.vnet.ibm.com>)
	id 1enfAR-0001dX-Bc
	for qemu-devel@nongnu.org; Mon, 19 Feb 2018 01:43:15 -0500
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w1J6cubw033891
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 01:43:13 -0500
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2g7s5hgtvs-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 19 Feb 2018 01:43:12 -0500
Received: from localhost
	by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bharata@linux.vnet.ibm.com>;
	Mon, 19 Feb 2018 06:43:11 -0000
From: Bharata B Rao <bharata@linux.vnet.ibm.com>
Date: Mon, 19 Feb 2018 12:12:53 +0530
In-Reply-To: <1519022574-6817-1-git-send-email-bharata@linux.vnet.ibm.com>
References: <1519022574-6817-1-git-send-email-bharata@linux.vnet.ibm.com>
Message-Id: <1519022574-6817-2-git-send-email-bharata@linux.vnet.ibm.com>
Subject: [Qemu-devel] [RFC PATCH v0 1/2] pc-dimm: Make pc_dimm_built_list()
 global
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, nfont@linux.vnet.ibm.com, mwb@linux.vnet.ibm.com, imammedo@redhat.com, Bharata B Rao <bharata@linux.vnet.ibm.com>

Making pc_dimm_built_list() global allows other parts of QEMU code
to build and walk through the DIMM list in address-sorted order.

This is needed in the next patch for sPAPR code to create
ibm,dynamic-memory-v2 device tree property that will have entries
for populated DIMMs as well as available hotpluggable areas.

CHECK: List of DIMMs is already available via qmp_pc_dimm_device_list(),
but that doesn't provide a sorted list.

Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>
---
 hw/mem/pc-dimm.c         | 2 +-
 include/hw/mem/pc-dimm.h | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
index 6e74b61..9bd61ca 100644
--- a/hw/mem/pc-dimm.c
+++ b/hw/mem/pc-dimm.c
@@ -261,7 +261,7 @@ static gint pc_dimm_addr_sort(gconstpointer a, gconstpointer b)
     return 0;
 }
 
-static int pc_dimm_built_list(Object *obj, void *opaque)
+int pc_dimm_built_list(Object *obj, void *opaque)
 {
     GSList **list = opaque;
 
diff --git a/include/hw/mem/pc-dimm.h b/include/hw/mem/pc-dimm.h
index d83b957..d880f5e 100644
--- a/include/hw/mem/pc-dimm.h
+++ b/include/hw/mem/pc-dimm.h
@@ -100,4 +100,5 @@ void pc_dimm_memory_plug(DeviceState *dev, MemoryHotplugState *hpms,
                          MemoryRegion *mr, uint64_t align, Error **errp);
 void pc_dimm_memory_unplug(DeviceState *dev, MemoryHotplugState *hpms,
                            MemoryRegion *mr);
+int pc_dimm_built_list(Object *obj, void *opaque);
 #endif
-- 
2.7.4
