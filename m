Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D7A5C433E7
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:59:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F237A20758
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 11:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I9RHFAK/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F237A20758
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDRQi-0006ii-4G
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 07:59:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDRKr-0002Zv-GT
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:53:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:54046
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <ehabkost@redhat.com>)
 id 1kDRKo-0006wv-PS
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 07:53:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599047629;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vZT4vT1KTfiJzyEdqzjUQKjy3WpckfF7lscstkt1d2M=;
 b=I9RHFAK/cZk+Dqy1PQqASCfHuSb3UCZZD6hgblejTHJXQZnP4md0++Db3+t0PAGt62fScF
 krdNJkCUbCUbYU3CxSLzEYrnjoNJMmgaYLSj5DdjY+JfUJZcooovYgDicQ317ktp9NSWFv
 UuP1DqThj7W/cZwxL6vVjQMNhvQbvYY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-251-lQ6pl8hINZ2osAMGEPxx-g-1; Wed, 02 Sep 2020 07:53:47 -0400
X-MC-Unique: lQ6pl8hINZ2osAMGEPxx-g-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4AF9C10ABDC2;
 Wed,  2 Sep 2020 11:53:46 +0000 (UTC)
Received: from localhost (ovpn-66-226.rdu2.redhat.com [10.10.66.226])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 186765D9CC;
 Wed,  2 Sep 2020 11:53:46 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: qemu-devel@nongnu.org,
	Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 15/20] Revert "target/i386: Cleanup and use the EPYC mode
 topology functions"
Date: Wed,  2 Sep 2020 07:53:18 -0400
Message-Id: <20200902115323.850385-16-ehabkost@redhat.com>
In-Reply-To: <20200902115323.850385-1-ehabkost@redhat.com>
References: <20200902115323.850385-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=ehabkost@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=207.211.31.120; envelope-from=ehabkost@redhat.com;
 helo=us-smtp-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/02 02:07:24
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Babu Moger <babu.moger@amd.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Babu Moger <babu.moger@amd.com>

This reverts commit dd08ef0318e2b61d14bc069590d174913f7f437a.

Remove the EPYC specific apicid decoding and use the generic
default decoding.

Signed-off-by: Babu Moger <babu.moger@amd.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <159889936257.21294.1786224705357428082.stgit@naples-babu.amd.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 target/i386/cpu.c | 161 ++++++++++++++++++++++++++++++++++++----------
 1 file changed, 127 insertions(+), 34 deletions(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index b72b4b08ac..256bfa669f 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -338,15 +338,68 @@ static void encode_cache_cpuid80000006(CPUCacheInfo *l2,
     }
 }
 
+/*
+ * Definitions used for building CPUID Leaf 0x8000001D and 0x8000001E
+ * Please refer to the AMD64 Architecture Programmer’s Manual Volume 3.
+ * Define the constants to build the cpu topology. Right now, TOPOEXT
+ * feature is enabled only on EPYC. So, these constants are based on
+ * EPYC supported configurations. We may need to handle the cases if
+ * these values change in future.
+ */
+/* Maximum core complexes in a node */
+#define MAX_CCX 2
+/* Maximum cores in a core complex */
+#define MAX_CORES_IN_CCX 4
+/* Maximum cores in a node */
+#define MAX_CORES_IN_NODE 8
+/* Maximum nodes in a socket */
+#define MAX_NODES_PER_SOCKET 4
+
+/*
+ * Figure out the number of nodes required to build this config.
+ * Max cores in a node is 8
+ */
+static int nodes_in_socket(int nr_cores)
+{
+    int nodes;
+
+    nodes = DIV_ROUND_UP(nr_cores, MAX_CORES_IN_NODE);
+
+   /* Hardware does not support config with 3 nodes, return 4 in that case */
+    return (nodes == 3) ? 4 : nodes;
+}
+
+/*
+ * Decide the number of cores in a core complex with the given nr_cores using
+ * following set constants MAX_CCX, MAX_CORES_IN_CCX, MAX_CORES_IN_NODE and
+ * MAX_NODES_PER_SOCKET. Maintain symmetry as much as possible
+ * L3 cache is shared across all cores in a core complex. So, this will also
+ * tell us how many cores are sharing the L3 cache.
+ */
+static int cores_in_core_complex(int nr_cores)
+{
+    int nodes;
+
+    /* Check if we can fit all the cores in one core complex */
+    if (nr_cores <= MAX_CORES_IN_CCX) {
+        return nr_cores;
+    }
+    /* Get the number of nodes required to build this config */
+    nodes = nodes_in_socket(nr_cores);
+
+    /*
+     * Divide the cores accros all the core complexes
+     * Return rounded up value
+     */
+    return DIV_ROUND_UP(nr_cores, nodes * MAX_CCX);
+}
+
 /* Encode cache info for CPUID[8000001D] */
-static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
-                                       X86CPUTopoInfo *topo_info,
-                                       uint32_t *eax, uint32_t *ebx,
-                                       uint32_t *ecx, uint32_t *edx)
+static void encode_cache_cpuid8000001d(CPUCacheInfo *cache, CPUState *cs,
+                                uint32_t *eax, uint32_t *ebx,
+                                uint32_t *ecx, uint32_t *edx)
 {
     uint32_t l3_cores;
-    unsigned nodes = MAX(topo_info->nodes_per_pkg, 1);
-
     assert(cache->size == cache->line_size * cache->associativity *
                           cache->partitions * cache->sets);
 
@@ -355,13 +408,10 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
 
     /* L3 is shared among multiple cores */
     if (cache->level == 3) {
-        l3_cores = DIV_ROUND_UP((topo_info->dies_per_pkg *
-                                 topo_info->cores_per_die *
-                                 topo_info->threads_per_core),
-                                 nodes);
-        *eax |= (l3_cores - 1) << 14;
+        l3_cores = cores_in_core_complex(cs->nr_cores);
+        *eax |= ((l3_cores * cs->nr_threads) - 1) << 14;
     } else {
-        *eax |= ((topo_info->threads_per_core - 1) << 14);
+        *eax |= ((cs->nr_threads - 1) << 14);
     }
 
     assert(cache->line_size > 0);
@@ -381,17 +431,55 @@ static void encode_cache_cpuid8000001d(CPUCacheInfo *cache,
            (cache->complex_indexing ? CACHE_COMPLEX_IDX : 0);
 }
 
+/* Data structure to hold the configuration info for a given core index */
+struct core_topology {
+    /* core complex id of the current core index */
+    int ccx_id;
+    /*
+     * Adjusted core index for this core in the topology
+     * This can be 0,1,2,3 with max 4 cores in a core complex
+     */
+    int core_id;
+    /* Node id for this core index */
+    int node_id;
+    /* Number of nodes in this config */
+    int num_nodes;
+};
+
+/*
+ * Build the configuration closely match the EPYC hardware. Using the EPYC
+ * hardware configuration values (MAX_CCX, MAX_CORES_IN_CCX, MAX_CORES_IN_NODE)
+ * right now. This could change in future.
+ * nr_cores : Total number of cores in the config
+ * core_id  : Core index of the current CPU
+ * topo     : Data structure to hold all the config info for this core index
+ */
+static void build_core_topology(int nr_cores, int core_id,
+                                struct core_topology *topo)
+{
+    int nodes, cores_in_ccx;
+
+    /* First get the number of nodes required */
+    nodes = nodes_in_socket(nr_cores);
+
+    cores_in_ccx = cores_in_core_complex(nr_cores);
+
+    topo->node_id = core_id / (cores_in_ccx * MAX_CCX);
+    topo->ccx_id = (core_id % (cores_in_ccx * MAX_CCX)) / cores_in_ccx;
+    topo->core_id = core_id % cores_in_ccx;
+    topo->num_nodes = nodes;
+}
+
 /* Encode cache info for CPUID[8000001E] */
-static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
+static void encode_topo_cpuid8000001e(CPUState *cs, X86CPU *cpu,
                                        uint32_t *eax, uint32_t *ebx,
                                        uint32_t *ecx, uint32_t *edx)
 {
-    X86CPUTopoIDs topo_ids = {0};
-    unsigned long nodes = MAX(topo_info->nodes_per_pkg, 1);
+    struct core_topology topo = {0};
+    unsigned long nodes;
     int shift;
 
-    x86_topo_ids_from_apicid_epyc(cpu->apic_id, topo_info, &topo_ids);
-
+    build_core_topology(cs->nr_cores, cpu->core_id, &topo);
     *eax = cpu->apic_id;
     /*
      * CPUID_Fn8000001E_EBX
@@ -408,8 +496,12 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
      *             3 Core complex id
      *           1:0 Core id
      */
-    *ebx = ((topo_info->threads_per_core - 1) << 8) | (topo_ids.node_id << 3) |
-            (topo_ids.core_id);
+    if (cs->nr_threads - 1) {
+        *ebx = ((cs->nr_threads - 1) << 8) | (topo.node_id << 3) |
+                (topo.ccx_id << 2) | topo.core_id;
+    } else {
+        *ebx = (topo.node_id << 4) | (topo.ccx_id << 3) | topo.core_id;
+    }
     /*
      * CPUID_Fn8000001E_ECX
      * 31:11 Reserved
@@ -418,8 +510,9 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
      *         2  Socket id
      *       1:0  Node id
      */
-    if (nodes <= 4) {
-        *ecx = ((nodes - 1) << 8) | (topo_ids.pkg_id << 2) | topo_ids.node_id;
+    if (topo.num_nodes <= 4) {
+        *ecx = ((topo.num_nodes - 1) << 8) | (cpu->socket_id << 2) |
+                topo.node_id;
     } else {
         /*
          * Node id fix up. Actual hardware supports up to 4 nodes. But with
@@ -434,10 +527,10 @@ static void encode_topo_cpuid8000001e(X86CPUTopoInfo *topo_info, X86CPU *cpu,
          * number of nodes. find_last_bit returns last set bit(0 based). Left
          * shift(+1) the socket id to represent all the nodes.
          */
-        nodes -= 1;
+        nodes = topo.num_nodes - 1;
         shift = find_last_bit(&nodes, 8);
-        *ecx = (nodes << 8) | (topo_ids.pkg_id << (shift + 1)) |
-               topo_ids.node_id;
+        *ecx = ((topo.num_nodes - 1) << 8) | (cpu->socket_id << (shift + 1)) |
+                topo.node_id;
     }
     *edx = 0;
 }
@@ -5471,7 +5564,6 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
     uint32_t signature[3];
     X86CPUTopoInfo topo_info;
 
-    topo_info.nodes_per_pkg = env->nr_nodes;
     topo_info.dies_per_pkg = env->nr_dies;
     topo_info.cores_per_die = cs->nr_cores;
     topo_info.threads_per_core = cs->nr_threads;
@@ -5902,20 +5994,20 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         }
         switch (count) {
         case 0: /* L1 dcache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache,
-                                       &topo_info, eax, ebx, ecx, edx);
+            encode_cache_cpuid8000001d(env->cache_info_amd.l1d_cache, cs,
+                                       eax, ebx, ecx, edx);
             break;
         case 1: /* L1 icache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache,
-                                       &topo_info, eax, ebx, ecx, edx);
+            encode_cache_cpuid8000001d(env->cache_info_amd.l1i_cache, cs,
+                                       eax, ebx, ecx, edx);
             break;
         case 2: /* L2 cache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache,
-                                       &topo_info, eax, ebx, ecx, edx);
+            encode_cache_cpuid8000001d(env->cache_info_amd.l2_cache, cs,
+                                       eax, ebx, ecx, edx);
             break;
         case 3: /* L3 cache info */
-            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache,
-                                       &topo_info, eax, ebx, ecx, edx);
+            encode_cache_cpuid8000001d(env->cache_info_amd.l3_cache, cs,
+                                       eax, ebx, ecx, edx);
             break;
         default: /* end of info */
             *eax = *ebx = *ecx = *edx = 0;
@@ -5924,7 +6016,8 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
         break;
     case 0x8000001E:
         assert(cpu->core_id <= 255);
-        encode_topo_cpuid8000001e(&topo_info, cpu, eax, ebx, ecx, edx);
+        encode_topo_cpuid8000001e(cs, cpu,
+                                  eax, ebx, ecx, edx);
         break;
     case 0xC0000000:
         *eax = env->cpuid_xlevel2;
-- 
2.26.2


