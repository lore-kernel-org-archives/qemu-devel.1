Return-Path: <SRS0=MBD3=C4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3907C43464
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:16:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 486F52084C
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Sep 2020 16:16:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CKalGhvK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 486F52084C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kJfXI-0007vM-6y
	for qemu-devel@archiver.kernel.org; Sat, 19 Sep 2020 12:16:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51282)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfH5-0005Jl-TX
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:59:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51261)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1kJfGx-0007N4-Lx
 for qemu-devel@nongnu.org; Sat, 19 Sep 2020 11:59:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600531174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DkVnEisYtmOwrQIYDZfd6rMi4o6Mmm1uKSWHiBuW3kE=;
 b=CKalGhvKhyVHVhIdj7st/UUCUcb79K2svaoCDh0YVwbswBtC7FBGQEAsmDzspAShNUjNRd
 xqERa382o/iYk1vFck/BpXj4w6mXD9mMWkOmMJTkQPVgHMcdPYjmbjM3ELt/xP7cA6f2i1
 RPBMx0xli4X5zbvGurczypb0noAT0fg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-q1kiYOfcNBicF96PA9cxSw-1; Sat, 19 Sep 2020 11:59:32 -0400
X-MC-Unique: q1kiYOfcNBicF96PA9cxSw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 67DB9186DD4B
 for <qemu-devel@nongnu.org>; Sat, 19 Sep 2020 15:59:31 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com
 (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2373D196F3;
 Sat, 19 Sep 2020 15:59:31 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 15/57] numa: drop support for '-numa node' (without memory
 specified)
Date: Sat, 19 Sep 2020 11:58:34 -0400
Message-Id: <20200919155916.1046398-16-pbonzini@redhat.com>
In-Reply-To: <20200919155916.1046398-1-pbonzini@redhat.com>
References: <20200919155916.1046398-1-pbonzini@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=pbonzini@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=63.128.21.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/19 11:03:07
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Igor Mammedov <imammedo@redhat.com>

it was deprecated since 4.1
commit 4bb4a2732e (numa: deprecate implict memory distribution between nodes)

Users of existing VMs, wishing to preserve the same RAM distribution,
should configure it explicitly using ``-numa node,memdev`` options.
Current RAM distribution can be retrieved using HMP command
`info numa` and if separate memory devices (pc|nv-dimm) are present
use `info memory-device` and subtract device memory from output of
`info numa`.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
Message-Id: <20200911084410.788171-2-imammedo@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/system/deprecated.rst | 23 +++++++++-------
 hw/core/machine.c          |  1 -
 hw/core/numa.c             | 55 --------------------------------------
 hw/i386/pc_piix.c          |  1 -
 hw/i386/pc_q35.c           |  1 -
 hw/ppc/spapr.c             |  1 -
 include/hw/boards.h        |  2 --
 include/sysemu/numa.h      |  4 ---
 8 files changed, 14 insertions(+), 74 deletions(-)

diff --git a/docs/system/deprecated.rst b/docs/system/deprecated.rst
index 0cb8b01424..bb59061c1b 100644
--- a/docs/system/deprecated.rst
+++ b/docs/system/deprecated.rst
@@ -104,15 +104,6 @@ error in the future.
 The ``-realtime mlock=on|off`` argument has been replaced by the
 ``-overcommit mem-lock=on|off`` argument.
 
-``-numa`` node (without memory specified) (since 4.1)
-'''''''''''''''''''''''''''''''''''''''''''''''''''''
-
-Splitting RAM by default between NUMA nodes has the same issues as ``mem``
-parameter described above with the difference that the role of the user plays
-QEMU using implicit generic or board specific splitting rule.
-Use ``memdev`` with *memory-backend-ram* backend or ``mem`` (if
-it's supported by used machine type) to define mapping explictly instead.
-
 ``-mem-path`` fallback to RAM (since 4.1)
 '''''''''''''''''''''''''''''''''''''''''
 
@@ -625,6 +616,20 @@ error when ``-u`` is not used.
 Command line options
 --------------------
 
+``-numa`` node (without memory specified) (removed 5.2)
+'''''''''''''''''''''''''''''''''''''''''''''''''''''''
+
+Splitting RAM by default between NUMA nodes had the same issues as ``mem``
+parameter with the difference that the role of the user plays QEMU using
+implicit generic or board specific splitting rule.
+Use ``memdev`` with *memory-backend-ram* backend or ``mem`` (if
+it's supported by used machine type) to define mapping explictly instead.
+Users of existing VMs, wishing to preserve the same RAM distribution, should
+configure it explicitly using ``-numa node,memdev`` options. Current RAM
+distribution can be retrieved using HMP command ``info numa`` and if separate
+memory devices (pc|nv-dimm) are present use ``info memory-device`` and subtract
+device memory from output of ``info numa``.
+
 ``-numa node,mem=``\ *size* (removed in 5.1)
 ''''''''''''''''''''''''''''''''''''''''''''
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index ea26d61237..f70d388e86 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -797,7 +797,6 @@ static void machine_class_init(ObjectClass *oc, void *data)
      * On Linux, each node's border has to be 8MB aligned
      */
     mc->numa_mem_align_shift = 23;
-    mc->numa_auto_assign_ram = numa_default_auto_assign_ram;
 
     object_class_property_add_str(oc, "kernel",
         machine_get_kernel, machine_set_kernel);
diff --git a/hw/core/numa.c b/hw/core/numa.c
index f9593ec716..706c1e84c6 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -611,42 +611,6 @@ static void complete_init_numa_distance(MachineState *ms)
     }
 }
 
-void numa_legacy_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
-                                 int nb_nodes, ram_addr_t size)
-{
-    int i;
-    uint64_t usedmem = 0;
-
-    /* Align each node according to the alignment
-     * requirements of the machine class
-     */
-
-    for (i = 0; i < nb_nodes - 1; i++) {
-        nodes[i].node_mem = (size / nb_nodes) &
-                            ~((1 << mc->numa_mem_align_shift) - 1);
-        usedmem += nodes[i].node_mem;
-    }
-    nodes[i].node_mem = size - usedmem;
-}
-
-void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
-                                  int nb_nodes, ram_addr_t size)
-{
-    int i;
-    uint64_t usedmem = 0, node_mem;
-    uint64_t granularity = size / nb_nodes;
-    uint64_t propagate = 0;
-
-    for (i = 0; i < nb_nodes - 1; i++) {
-        node_mem = (granularity + propagate) &
-                   ~((1 << mc->numa_mem_align_shift) - 1);
-        propagate = granularity + propagate - node_mem;
-        nodes[i].node_mem = node_mem;
-        usedmem += node_mem;
-    }
-    nodes[i].node_mem = size - usedmem;
-}
-
 static void numa_init_memdev_container(MachineState *ms, MemoryRegion *ram)
 {
     int i;
@@ -717,25 +681,6 @@ void numa_complete_configuration(MachineState *ms)
             ms->numa_state->num_nodes = MAX_NODES;
         }
 
-        /* If no memory size is given for any node, assume the default case
-         * and distribute the available memory equally across all nodes
-         */
-        for (i = 0; i < ms->numa_state->num_nodes; i++) {
-            if (numa_info[i].node_mem != 0) {
-                break;
-            }
-        }
-        if (i == ms->numa_state->num_nodes) {
-            assert(mc->numa_auto_assign_ram);
-            mc->numa_auto_assign_ram(mc, numa_info,
-                                     ms->numa_state->num_nodes, ram_size);
-            if (!qtest_enabled()) {
-                warn_report("Default splitting of RAM between nodes is deprecated,"
-                            " Use '-numa node,memdev' to explictly define RAM"
-                            " allocation per node");
-            }
-        }
-
         numa_total = 0;
         for (i = 0; i < ms->numa_state->num_nodes; i++) {
             numa_total += numa_info[i].node_mem;
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 33fa035fb7..1d45ab624c 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -565,7 +565,6 @@ static void pc_i440fx_2_9_machine_options(MachineClass *m)
     pc_i440fx_2_10_machine_options(m);
     compat_props_add(m->compat_props, hw_compat_2_9, hw_compat_2_9_len);
     compat_props_add(m->compat_props, pc_compat_2_9, pc_compat_2_9_len);
-    m->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
 }
 
 DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 0cb9c18cd4..4a37bc3e6d 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -494,7 +494,6 @@ static void pc_q35_2_10_machine_options(MachineClass *m)
     pc_q35_2_11_machine_options(m);
     compat_props_add(m->compat_props, hw_compat_2_10, hw_compat_2_10_len);
     compat_props_add(m->compat_props, pc_compat_2_10, pc_compat_2_10_len);
-    m->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
     m->auto_enable_numa_with_memhp = false;
 }
 
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 9bce1892b5..12fd92373d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4737,7 +4737,6 @@ static void spapr_machine_2_9_class_options(MachineClass *mc)
     spapr_machine_2_10_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_2_9, hw_compat_2_9_len);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-    mc->numa_auto_assign_ram = numa_legacy_auto_assign_ram;
     smc->pre_2_10_has_unused_icps = true;
     smc->resize_hpt_default = SPAPR_RESIZE_HPT_DISABLED;
 }
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 795910d01b..ade11eb627 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -204,8 +204,6 @@ struct MachineClass {
     strList *allowed_dynamic_sysbus_devices;
     bool auto_enable_numa_with_memhp;
     bool auto_enable_numa_with_memdev;
-    void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *nodes,
-                                 int nb_nodes, ram_addr_t size);
     bool ignore_boot_device_suffixes;
     bool smbus_no_migration_support;
     bool nvdimm_supported;
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index ad58ee88f7..4173ef2afa 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -106,10 +106,6 @@ void parse_numa_hmat_cache(MachineState *ms, NumaHmatCacheOptions *node,
 void numa_complete_configuration(MachineState *ms);
 void query_numa_node_mem(NumaNodeMem node_mem[], MachineState *ms);
 extern QemuOptsList qemu_numa_opts;
-void numa_legacy_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
-                                 int nb_nodes, ram_addr_t size);
-void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
-                                  int nb_nodes, ram_addr_t size);
 void numa_cpu_pre_plug(const struct CPUArchId *slot, DeviceState *dev,
                        Error **errp);
 bool numa_uses_legacy_mem(void);
-- 
2.26.2



