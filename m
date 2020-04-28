Return-Path: <SRS0=buBk=6M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D0ADC83003
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 01:29:44 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E731206D9
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2020 01:29:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E731206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38346 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jTF4A-0000hI-Av
	for qemu-devel@archiver.kernel.org; Mon, 27 Apr 2020 21:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34618)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <vishal.l.verma@intel.com>) id 1jTF3B-0007Rq-BX
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 21:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <vishal.l.verma@intel.com>) id 1jTF39-0005Uw-3V
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 21:28:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:49894)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishal.l.verma@intel.com>)
 id 1jTF38-0005UB-IZ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2020 21:28:38 -0400
IronPort-SDR: CxPSMYUxbzzmuZJnG7PDBV4ag/jUOYiAR9o1ByYvhHvKTNTkS+kFahtkmii8GycRB3XfKH7kx3
 BIE0yvWFqeVw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Apr 2020 18:28:30 -0700
IronPort-SDR: Ly4nRymyRR4Doa49tDPOcQJW1ufQtx3byE0b0ZZKSlBi7UvvqdOmrtOgZBZVtNHsgDGN6SIrKs
 1RLpNVq4jzZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; d="scan'208";a="249040066"
Received: from vverma7-mobl4.lm.intel.com ([10.254.191.96])
 by fmsmga008.fm.intel.com with ESMTP; 27 Apr 2020 18:28:29 -0700
From: Vishal Verma <vishal.l.verma@intel.com>
To: <qemu-devel@nongnu.org>
Subject: [PATCH 2/3] hw/acpi-build: account for NVDIMM numa nodes in SRAT
Date: Mon, 27 Apr 2020 19:28:09 -0600
Message-Id: <20200428012810.10877-3-vishal.l.verma@intel.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200428012810.10877-1-vishal.l.verma@intel.com>
References: <20200428012810.10877-1-vishal.l.verma@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=192.55.52.136;
 envelope-from=vishal.l.verma@intel.com; helo=mga12.intel.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/27 21:28:28
X-ACL-Warn: Detected OS   = FreeBSD 9.x or newer [fuzzy]
X-Received-From: 192.55.52.136
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: jingqi.liu@intel.com, Dan Williams <dan.j.williams@intel.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Vishal Verma <vishal.l.verma@intel.com>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

NVDIMMs can belong to their own proximity domains, as described by the
NFIT. In such cases, the SRAT needs to have Memory Affinity structures
in the SRAT for these NVDIMMs, otherwise Linux doesn't populate node
data structures properly during NUMA initialization. See the following
for an example failure case.

https://lore.kernel.org/linux-nvdimm/20200416225438.15208-1-vishal.l.verma@intel.com/

Fix this by adding device address range and node information from
NVDIMMs to the SRAT in build_srat().

The relevant command line options to exercise this are below. Nodes 0-1
contain CPUs and regular memory, and nodes 2-3 are the NVDIMM address
space.

  -numa node,nodeid=0,mem=2048M,
  -numa node,nodeid=1,mem=2048M,
  -numa node,nodeid=2,mem=0,
  -object memory-backend-file,id=nvmem0,share,mem-path=nvdimm-0,size=16384M,align=128M
  -device nvdimm,memdev=nvmem0,id=nv0,label-size=2M,node=2
  -numa node,nodeid=3,mem=0,
  -object memory-backend-file,id=nvmem1,share,mem-path=nvdimm-1,size=16384M,align=128M
  -device nvdimm,memdev=nvmem1,id=nv1,label-size=2M,node=3

Cc: Jingqi Liu <jingqi.liu@intel.com>
Cc: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Vishal Verma <vishal.l.verma@intel.com>
---
 hw/i386/acpi-build.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/hw/i386/acpi-build.c b/hw/i386/acpi-build.c
index 23c77eeb95..b0da67de0e 100644
--- a/hw/i386/acpi-build.c
+++ b/hw/i386/acpi-build.c
@@ -48,6 +48,7 @@
 #include "migration/vmstate.h"
 #include "hw/mem/memory-device.h"
 #include "hw/mem/nvdimm.h"
+#include "qemu/nvdimm-utils.h"
 #include "sysemu/numa.h"
 #include "sysemu/reset.h"
 
@@ -2429,6 +2430,25 @@ build_srat(GArray *table_data, BIOSLinker *linker, MachineState *machine)
                               MEM_AFFINITY_ENABLED);
         }
     }
+
+    if (machine->nvdimms_state->is_enabled) {
+        GSList *device_list = nvdimm_get_device_list();
+
+        for (; device_list; device_list = device_list->next) {
+            DeviceState *dev = device_list->data;
+            int node = object_property_get_int(OBJECT(dev), PC_DIMM_NODE_PROP,
+                                               NULL);
+            uint64_t addr = object_property_get_uint(OBJECT(dev),
+                                                     PC_DIMM_ADDR_PROP, NULL);
+            uint64_t size = object_property_get_uint(OBJECT(dev),
+                                                     PC_DIMM_SIZE_PROP, NULL);
+
+            numamem = acpi_data_push(table_data, sizeof *numamem);
+            build_srat_memory(numamem, addr, size, node,
+                              MEM_AFFINITY_ENABLED | MEM_AFFINITY_NON_VOLATILE);
+        }
+    }
+
     slots = (table_data->len - numa_start) / sizeof *numamem;
     for (; slots < pcms->numa_nodes + 2; slots++) {
         numamem = acpi_data_push(table_data, sizeof *numamem);
-- 
2.25.4


