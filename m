Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7922CC49ED7
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 07:53:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4E093222CF
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 07:53:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4E093222CF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBDjm-0003Uv-PS
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 03:53:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60904)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tao3.xu@intel.com>) id 1iBDaS-0001oZ-4g
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 03:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tao3.xu@intel.com>) id 1iBDaQ-0005d3-QZ
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 03:44:15 -0400
Received: from mga17.intel.com ([192.55.52.151]:9881)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1iBDaQ-0005Yc-Fn
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 03:44:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 20 Sep 2019 00:44:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,527,1559545200"; d="scan'208";a="212495129"
Received: from tao-optiplex-7060.sh.intel.com ([10.239.159.36])
 by fmsmga004.fm.intel.com with ESMTP; 20 Sep 2019 00:44:12 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com,
	eblake@redhat.com,
	ehabkost@redhat.com
Subject: [PATCH v12 10/11] hmat acpi: Build Memory Side Cache Information
 Structure(s)
Date: Fri, 20 Sep 2019 15:43:48 +0800
Message-Id: <20190920074349.2616-11-tao3.xu@intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190920074349.2616-1-tao3.xu@intel.com>
References: <20190920074349.2616-1-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.151
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
Cc: jingqi.liu@intel.com, tao3.xu@intel.com, fan.du@intel.com,
 qemu-devel@nongnu.org, Daniel Black <daniel@linux.ibm.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, dan.j.williams@intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Jingqi <jingqi.liu@intel.com>

This structure describes memory side cache information for memory
proximity domains if the memory side cache is present and the
physical device forms the memory side cache.
The software could use this information to effectively place
the data in memory to maximize the performance of the system
memory that use the memory side cache.

Reviewed-by: Daniel Black <daniel@linux.ibm.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

No changes in v12.

Changes in v11:
    - Move numa option patches forward.
---
 hw/acpi/hmat.c | 64 +++++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 63 insertions(+), 1 deletion(-)

diff --git a/hw/acpi/hmat.c b/hw/acpi/hmat.c
index e7be849581..6b260eeef5 100644
--- a/hw/acpi/hmat.c
+++ b/hw/acpi/hmat.c
@@ -160,13 +160,62 @@ static void build_hmat_lb(GArray *table_data, HMAT_LB_Info *hmat_lb,
     }
 }
 
+/* ACPI 6.3: 5.2.27.5 Memory Side Cache Information Structure: Table 5-147 */
+static void build_hmat_cache(GArray *table_data, HMAT_Cache_Info *hmat_cache)
+{
+    /*
+     * Cache Attributes: Bits [3:0] – Total Cache Levels
+     * for this Memory Proximity Domain
+     */
+    uint32_t cache_attr = hmat_cache->total_levels & 0xF;
+
+    /* Bits [7:4] : Cache Level described in this structure */
+    cache_attr |= (hmat_cache->level & 0xF) << 4;
+
+    /* Bits [11:8] - Cache Associativity */
+    cache_attr |= (hmat_cache->associativity & 0xF) << 8;
+
+    /* Bits [15:12] - Write Policy */
+    cache_attr |= (hmat_cache->write_policy & 0xF) << 12;
+
+    /* Bits [31:16] - Cache Line size in bytes */
+    cache_attr |= (hmat_cache->line_size & 0xFFFF) << 16;
+
+    cache_attr = cpu_to_le32(cache_attr);
+
+    /* Type */
+    build_append_int_noprefix(table_data, 2, 2);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 2);
+    /* Length */
+    build_append_int_noprefix(table_data, 32, 4);
+    /* Proximity Domain for the Memory */
+    build_append_int_noprefix(table_data, hmat_cache->mem_proximity, 4);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 4);
+    /* Memory Side Cache Size */
+    build_append_int_noprefix(table_data, hmat_cache->size, 8);
+    /* Cache Attributes */
+    build_append_int_noprefix(table_data, cache_attr, 4);
+    /* Reserved */
+    build_append_int_noprefix(table_data, 0, 2);
+    /*
+     * Number of SMBIOS handles (n)
+     * Linux kernel uses Memory Side Cache Information Structure
+     * without SMBIOS entries for now, so set Number of SMBIOS handles
+     * as 0.
+     */
+    build_append_int_noprefix(table_data, 0, 2);
+}
+
 /* Build HMAT sub table structures */
 static void hmat_build_table_structs(GArray *table_data, NumaState *nstat)
 {
     uint16_t flags;
     uint32_t *initiator_list = NULL;
-    int i, j, hrchy, type;
+    int i, j, hrchy, type, level;
     HMAT_LB_Info *numa_hmat_lb;
+    HMAT_Cache_Info *numa_hmat_cache;
 
     for (i = 0; i < nstat->num_nodes; i++) {
         flags = 0;
@@ -205,6 +254,19 @@ static void hmat_build_table_structs(GArray *table_data, NumaState *nstat)
         }
     }
 
+    /*
+     * ACPI 6.3: 5.2.27.5 Memory Side Cache Information Structure:
+     * Table 5-147
+     */
+    for (i = 0; i < nstat->num_nodes; i++) {
+        for (level = 0; level <= MAX_HMAT_CACHE_LEVEL; level++) {
+            numa_hmat_cache = nstat->hmat_cache[i][level];
+            if (numa_hmat_cache) {
+                build_hmat_cache(table_data, numa_hmat_cache);
+            }
+        }
+    }
+
     g_free(initiator_list);
 }
 
-- 
2.20.1


