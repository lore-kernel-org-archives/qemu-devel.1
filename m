Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 641ADC04AAD
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:34:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28B0921019
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 06:34:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28B0921019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60324 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOGA9-0001lB-Am
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 02:34:45 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40992)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hOFw9-0005GM-G4
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:20:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tao3.xu@intel.com>) id 1hOFw7-0000IF-Gl
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:20:17 -0400
Received: from mga05.intel.com ([192.55.52.43]:57366)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <tao3.xu@intel.com>) id 1hOFw5-0000EX-PF
	for qemu-devel@nongnu.org; Wed, 08 May 2019 02:20:14 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
	by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
	07 May 2019 23:20:11 -0700
X-ExtLoop1: 1
Received: from tao-optiplex-7060.sh.intel.com ([10.239.13.92])
	by fmsmga005.fm.intel.com with ESMTP; 07 May 2019 23:20:09 -0700
From: Tao Xu <tao3.xu@intel.com>
To: imammedo@redhat.com, mst@redhat.com, eblake@redhat.com,
	ehabkost@redhat.com, xiaoguangrong.eric@gmail.com
Date: Wed,  8 May 2019 14:17:24 +0800
Message-Id: <20190508061726.27631-10-tao3.xu@intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190508061726.27631-1-tao3.xu@intel.com>
References: <20190508061726.27631-1-tao3.xu@intel.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 192.55.52.43
Subject: [Qemu-devel] [PATCH v4 09/11] numa: Extend the command-line to
 provide memory side cache information
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: pbonzini@redhat.com, tao3.xu@intel.com, jingqi.liu@intel.com,
	qemu-devel@nongnu.org, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Liu Jingqi <jingqi.liu@intel.com>

Add -numa hmat-cache option to provide Memory Side Cache Information.
These memory attributes help to build Memory Side Cache Information
Structure(s) in ACPI Heterogeneous Memory Attribute Table (HMAT).

Signed-off-by: Liu Jingqi <jingqi.liu@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
---

Changes in v4 -> v3:
    - update the version tag from 4.0 to 4.1
---
 numa.c         | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++
 qapi/misc.json | 72 ++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 145 insertions(+), 2 deletions(-)

diff --git a/numa.c b/numa.c
index 1aecb7a2e9..4866736fc8 100644
--- a/numa.c
+++ b/numa.c
@@ -300,6 +300,75 @@ static void parse_numa_hmat_lb(MachineState *ms, NumaHmatLBOptions *node,
     }
 }
 
+static
+void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
+                            Error **errp)
+{
+    int nb_numa_nodes = ms->numa_state->num_nodes;
+    HMAT_Cache_Info *hmat_cache = NULL;
+
+    if (node->node_id >= nb_numa_nodes) {
+        error_setg(errp, "Invalid node-id=%" PRIu32
+                   ", it should be less than %d.",
+                   node->node_id, nb_numa_nodes);
+        return;
+    }
+    if (!ms->numa_state->nodes[node->node_id].is_target) {
+        error_setg(errp, "Invalid node-id=%" PRIu32
+                   ", it isn't a target proximity domain.",
+                   node->node_id);
+        return;
+    }
+
+    if (node->total > MAX_HMAT_CACHE_LEVEL) {
+        error_setg(errp, "Invalid total=%" PRIu8
+                   ", it should be less than or equal to %d.",
+                   node->total, MAX_HMAT_CACHE_LEVEL);
+        return;
+    }
+    if (node->level > node->total) {
+        error_setg(errp, "Invalid level=%" PRIu8
+                   ", it should be less than or equal to"
+                   " total=%" PRIu8 ".",
+                   node->level, node->total);
+        return;
+    }
+    if (ms->numa_state->hmat_cache[node->node_id][node->level]) {
+        error_setg(errp, "Duplicate configuration of the side cache for "
+                   "node-id=%" PRIu32 " and level=%" PRIu8 ".",
+                   node->node_id, node->level);
+        return;
+    }
+
+    if ((node->level > 1) &&
+        ms->numa_state->hmat_cache[node->node_id][node->level - 1] &&
+        (node->size >=
+            ms->numa_state->hmat_cache[node->node_id][node->level - 1]->size)) {
+        error_setg(errp, "Invalid size=0x%" PRIx64
+                   ", the size of level=%" PRIu8
+                   " should be less than the size(0x%" PRIx64
+                   ") of level=%" PRIu8 ".",
+                   node->size, node->level,
+                   ms->numa_state->hmat_cache[node->node_id]
+                                             [node->level - 1]->size,
+                   node->level - 1);
+        return;
+    }
+
+    hmat_cache = g_malloc0(sizeof(*hmat_cache));
+
+    hmat_cache->mem_proximity = node->node_id;
+    hmat_cache->size = node->size;
+    hmat_cache->total_levels = node->total;
+    hmat_cache->level = node->level;
+    hmat_cache->associativity = node->assoc;
+    hmat_cache->write_policy = node->policy;
+    hmat_cache->line_size = node->line;
+    hmat_cache->num_smbios_handles = 0;
+
+    ms->numa_state->hmat_cache[node->node_id][node->level] = hmat_cache;
+}
+
 static
 void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
 {
@@ -344,6 +413,12 @@ void set_numa_options(MachineState *ms, NumaOptions *object, Error **errp)
             goto end;
         }
         break;
+    case NUMA_OPTIONS_TYPE_HMAT_CACHE:
+        parse_numa_hmat_cache(ms, &object->u.hmat_cache, &err);
+        if (err) {
+            goto end;
+        }
+        break;
     default:
         abort();
     }
diff --git a/qapi/misc.json b/qapi/misc.json
index d7fce75702..2b7e34b469 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -2541,10 +2541,12 @@
 #
 # @hmat-lb: memory latency and bandwidth information (Since: 4.1)
 #
+# @hmat-cache: memory side cache information (Since: 4.1)
+#
 # Since: 2.1
 ##
 { 'enum': 'NumaOptionsType',
-  'data': [ 'node', 'dist', 'cpu', 'hmat-lb' ] }
+   'data': [ 'node', 'dist', 'cpu', 'hmat-lb', 'hmat-cache' ] }
 
 ##
 # @NumaOptions:
@@ -2560,7 +2562,8 @@
     'node': 'NumaNodeOptions',
     'dist': 'NumaDistOptions',
     'cpu': 'NumaCpuOptions',
-    'hmat-lb': 'NumaHmatLBOptions' }}
+    'hmat-lb': 'NumaHmatLBOptions',
+    'hmat-cache': 'NumaHmatCacheOptions' }}
 
 ##
 # @NumaNodeOptions:
@@ -2710,6 +2713,71 @@
    '*latency': 'uint16',
    '*bandwidth': 'uint16' }}
 
+##
+# @HmatCacheAssociativity:
+#
+# Cache associativity in the Memory Side Cache
+# Information Structure of HMAT
+#
+# @none: None
+#
+# @direct: Direct Mapped
+#
+# @complex: Complex Cache Indexing (implementation specific)
+#
+# Since: 4.1
+##
+{ 'enum': 'HmatCacheAssociativity',
+  'data': [ 'none', 'direct', 'complex' ] }
+
+##
+# @HmatCacheWritePolicy:
+#
+# Cache write policy in the Memory Side Cache
+# Information Structure of HMAT
+#
+# @none: None
+#
+# @write-back: Write Back (WB)
+#
+# @write-through: Write Through (WT)
+#
+# Since: 4.1
+##
+{ 'enum': 'HmatCacheWritePolicy',
+  'data': [ 'none', 'write-back', 'write-through' ] }
+
+##
+# @NumaHmatCacheOptions:
+#
+# Set the memory side cache information for a given memory domain.
+#
+# @node-id: the memory proximity domain to which the memory belongs.
+#
+# @size: the size of memory side cache in bytes.
+#
+# @total: the total cache levels for this memory proximity domain.
+#
+# @level: the cache level described in this structure.
+#
+# @assoc: the cache associativity, none/direct-mapped/complex(complex cache indexing).
+
+# @policy: the write policy, none/write-back/write-through.
+#
+# @line: the cache Line size in bytes.
+#
+# Since: 4.1
+##
+{ 'struct': 'NumaHmatCacheOptions',
+  'data': {
+   'node-id': 'uint32',
+   'size': 'size',
+   'total': 'uint8',
+   'level': 'uint8',
+   'assoc': 'HmatCacheAssociativity',
+   'policy': 'HmatCacheWritePolicy',
+   'line': 'uint16' }}
+
 ##
 # @HostMemPolicy:
 #
-- 
2.17.1


