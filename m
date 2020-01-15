Return-Path: <SRS0=2fDQ=3E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DC0C33CB1
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:29:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47C84206D7
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2020 16:29:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RWjIBUg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47C84206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56774 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1irlXd-0000CQ-GL
	for qemu-devel@archiver.kernel.org; Wed, 15 Jan 2020 11:29:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50198)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1irkLV-0001wA-NE
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:12:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1irkLT-0000k4-DF
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:12:37 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:55131
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1irkLT-0000jt-8I
 for qemu-devel@nongnu.org; Wed, 15 Jan 2020 10:12:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1579101154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AKnjtOY8DUXUVwClu7/uWC5tmfKokrbQR3L8oGOQb20=;
 b=RWjIBUg8RVVTVzhFWCpO1zQsYGaRndXAFn3UWfhiue8ARncyRQzND3mUakhUbnILWt1yJI
 dp44jFalMLbXJOSHa9oXLX4TgI3kGk9vcYxWcvAuS7zjeMbxf3+szTicVCDppQhkIKinpz
 Uk9avITGGc6S7Keap5mEhv3iHbFemaQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-l4Zhg2g6N22otx7sOFzx9A-1; Wed, 15 Jan 2020 10:12:30 -0500
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5BB9C1005527;
 Wed, 15 Jan 2020 15:12:29 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 8A4C719757;
 Wed, 15 Jan 2020 15:12:27 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v2 86/86] numa: remove deprecated implicit RAM distribution
 between nodes
Date: Wed, 15 Jan 2020 16:07:41 +0100
Message-Id: <1579100861-73692-87-git-send-email-imammedo@redhat.com>
In-Reply-To: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
References: <1579100861-73692-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-MC-Unique: l4Zhg2g6N22otx7sOFzx9A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.120
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
Cc: ehabkost@redhat.com, mst@redhat.com, libvir-list@redhat.com,
 qemu-ppc@nongnu.org, pbonzini@redhat.com, rth@twiddle.net,
 david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Feature has been deprecated since 4.1 (4bb4a273),
remove it.

As result if RAM distribution wasn't specified explicitly,
the machine won't start and CLI should be changed to explicitly
assign RAM to nodes using options:
  -node node,memdev  (5.0 and newer machine types)
  -node node,mem     (4.2 and older machine types)
It's recommended to use "memdev" variant for new virtual machines
and use "mem" only when it's necessary to migrate already existing
virtual machine started with implicit RAM distribution.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: ehabkost@redhat.com
CC: marcel.apfelbaum@gmail.com
CC: mst@redhat.com
CC: pbonzini@redhat.com
CC: david@gibson.dropbear.id.au
CC: libvir-list@redhat.com
CC: qemu-ppc@nongnu.org
CC: rth@twiddle.net
---
 include/hw/boards.h   |  3 ---
 include/sysemu/numa.h |  4 ----
 hw/core/machine.c     |  6 -----
 hw/core/numa.c        | 61 +++++------------------------------------------=
----
 hw/i386/pc_piix.c     |  1 -
 hw/i386/pc_q35.c      |  1 -
 hw/ppc/spapr.c        |  7 ------
 qemu-deprecated.texi  |  8 -------
 qemu-options.hx       | 16 +++++++-------
 9 files changed, 13 insertions(+), 94 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index 7f09bc9..916bb50 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -192,12 +192,9 @@ struct MachineClass {
     int minimum_page_bits;
     bool has_hotpluggable_cpus;
     bool ignore_memory_transaction_failures;
-    int numa_mem_align_shift;
     const char **valid_cpu_types;
     strList *allowed_dynamic_sysbus_devices;
     bool auto_enable_numa_with_memhp;
-    void (*numa_auto_assign_ram)(MachineClass *mc, NodeInfo *nodes,
-                                 int nb_nodes, ram_addr_t size);
     bool ignore_boot_device_suffixes;
     bool smbus_no_migration_support;
     bool nvdimm_supported;
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index ad58ee8..4173ef2 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -106,10 +106,6 @@ void parse_numa_hmat_cache(MachineState *ms, NumaHmatC=
acheOptions *node,
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
diff --git a/hw/core/machine.c b/hw/core/machine.c
index d8fa45c..0862f45 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -747,12 +747,6 @@ static void machine_class_init(ObjectClass *oc, void *=
data)
     mc->rom_file_has_mr =3D true;
     mc->smp_parse =3D smp_parse;
=20
-    /* numa node memory size aligned on 8MB by default.
-     * On Linux, each node's border has to be 8MB aligned
-     */
-    mc->numa_mem_align_shift =3D 23;
-    mc->numa_auto_assign_ram =3D numa_default_auto_assign_ram;
-
     object_class_property_add_str(oc, "kernel",
         machine_get_kernel, machine_set_kernel, &error_abort);
     object_class_property_set_description(oc, "kernel",
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 47d5ea1..591e62a 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -627,42 +627,6 @@ static void complete_init_numa_distance(MachineState *=
ms)
     }
 }
=20
-void numa_legacy_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
-                                 int nb_nodes, ram_addr_t size)
-{
-    int i;
-    uint64_t usedmem =3D 0;
-
-    /* Align each node according to the alignment
-     * requirements of the machine class
-     */
-
-    for (i =3D 0; i < nb_nodes - 1; i++) {
-        nodes[i].node_mem =3D (size / nb_nodes) &
-                            ~((1 << mc->numa_mem_align_shift) - 1);
-        usedmem +=3D nodes[i].node_mem;
-    }
-    nodes[i].node_mem =3D size - usedmem;
-}
-
-void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
-                                  int nb_nodes, ram_addr_t size)
-{
-    int i;
-    uint64_t usedmem =3D 0, node_mem;
-    uint64_t granularity =3D size / nb_nodes;
-    uint64_t propagate =3D 0;
-
-    for (i =3D 0; i < nb_nodes - 1; i++) {
-        node_mem =3D (granularity + propagate) &
-                   ~((1 << mc->numa_mem_align_shift) - 1);
-        propagate =3D granularity + propagate - node_mem;
-        nodes[i].node_mem =3D node_mem;
-        usedmem +=3D node_mem;
-    }
-    nodes[i].node_mem =3D size - usedmem;
-}
-
 static void numa_init_memdev_container(MachineState *ms, MemoryRegion *ram=
)
 {
     int i;
@@ -732,30 +696,15 @@ void numa_complete_configuration(MachineState *ms)
             ms->numa_state->num_nodes =3D MAX_NODES;
         }
=20
-        /* If no memory size is given for any node, assume the default cas=
e
-         * and distribute the available memory equally across all nodes
-         */
-        for (i =3D 0; i < ms->numa_state->num_nodes; i++) {
-            if (numa_info[i].node_mem !=3D 0) {
-                break;
-            }
-        }
-        if (i =3D=3D ms->numa_state->num_nodes) {
-            assert(mc->numa_auto_assign_ram);
-            mc->numa_auto_assign_ram(mc, numa_info,
-                                     ms->numa_state->num_nodes, ram_size);
-            if (!qtest_enabled()) {
-                warn_report("Default splitting of RAM between nodes is dep=
recated,"
-                            " Use '-numa node,memdev' to explictly define =
RAM"
-                            " allocation per node");
-            }
-        }
-
         numa_total =3D 0;
         for (i =3D 0; i < ms->numa_state->num_nodes; i++) {
             numa_total +=3D numa_info[i].node_mem;
         }
-        if (numa_total !=3D ram_size) {
+        if (numa_total =3D=3D 0) {
+            error_report(" Use '-numa node,memdev' to explictly assign RAM=
"
+                         " to node");
+            exit(EXIT_FAILURE);
+        } else if (numa_total !=3D ram_size) {
             error_report("total memory for NUMA nodes (0x%" PRIx64 ")"
                          " should equal RAM size (0x" RAM_ADDR_FMT ")",
                          numa_total, ram_size);
diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
index 0a9b9e0..7941b0d 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -532,7 +532,6 @@ static void pc_i440fx_2_9_machine_options(MachineClass =
*m)
     pc_i440fx_2_10_machine_options(m);
     compat_props_add(m->compat_props, hw_compat_2_9, hw_compat_2_9_len);
     compat_props_add(m->compat_props, pc_compat_2_9, pc_compat_2_9_len);
-    m->numa_auto_assign_ram =3D numa_legacy_auto_assign_ram;
 }
=20
 DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index 4d6e2be..9715413 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -466,7 +466,6 @@ static void pc_q35_2_10_machine_options(MachineClass *m=
)
     pc_q35_2_11_machine_options(m);
     compat_props_add(m->compat_props, hw_compat_2_10, hw_compat_2_10_len);
     compat_props_add(m->compat_props, pc_compat_2_10, pc_compat_2_10_len);
-    m->numa_auto_assign_ram =3D numa_legacy_auto_assign_ram;
     m->auto_enable_numa_with_memhp =3D false;
 }
=20
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 2686b73..712548f 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4378,11 +4378,6 @@ static void spapr_machine_class_init(ObjectClass *oc=
, void *data)
     xic->ics_resend =3D spapr_ics_resend;
     xic->icp_get =3D spapr_icp_get;
     ispc->print_info =3D spapr_pic_print_info;
-    /* Force NUMA node memory size to be a multiple of
-     * SPAPR_MEMORY_BLOCK_SIZE (256M) since that's the granularity
-     * in which LMBs are represented and hot-added
-     */
-    mc->numa_mem_align_shift =3D 28;
     mc->auto_enable_numa =3D true;
=20
     smc->default_caps.caps[SPAPR_CAP_HTM] =3D SPAPR_CAP_OFF;
@@ -4635,7 +4630,6 @@ static void spapr_machine_2_9_class_options(MachineCl=
ass *mc)
     spapr_machine_2_10_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_2_9, hw_compat_2_9_len);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-    mc->numa_auto_assign_ram =3D numa_legacy_auto_assign_ram;
     smc->pre_2_10_has_unused_icps =3D true;
     smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_DISABLED;
 }
@@ -4655,7 +4649,6 @@ static void spapr_machine_2_8_class_options(MachineCl=
ass *mc)
     spapr_machine_2_9_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_2_8, hw_compat_2_8_len);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-    mc->numa_mem_align_shift =3D 23;
 }
=20
 DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index 17a0e1d..9ad6778 100644
--- a/qemu-deprecated.texi
+++ b/qemu-deprecated.texi
@@ -89,14 +89,6 @@ error in the future.
 The @code{-realtime mlock=3Don|off} argument has been replaced by the
 @code{-overcommit mem-lock=3Don|off} argument.
=20
-@subsection -numa node (without memory specified) (since 4.1)
-
-Splitting RAM by default between NUMA nodes has the same issues as @option=
{mem}
-parameter described above with the difference that the role of the user pl=
ays
-QEMU using implicit generic or board specific splitting rule.
-Use @option{memdev} with @var{memory-backend-ram} backend or @option{mem} =
(if
-it's supported by used machine type) to define mapping explictly instead.
-
 @subsection RISC-V -bios (since 4.1)
=20
 QEMU 4.1 introduced support for the -bios option in QEMU for RISC-V for th=
e
diff --git a/qemu-options.hx b/qemu-options.hx
index 55500bd..f959bbe 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -172,16 +172,16 @@ If any on the three values is given, the total number=
 of CPUs @var{n} can be omi
 ETEXI
=20
 DEF("numa", HAS_ARG, QEMU_OPTION_numa,
-    "-numa node[,mem=3Dsize][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode][,=
initiator=3Dnode]\n"
-    "-numa node[,memdev=3Did][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode][=
,initiator=3Dnode]\n"
+    "-numa node,mem=3Dsize[,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode][,in=
itiator=3Dnode]\n"
+    "-numa node,memdev=3Did[,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode][,i=
nitiator=3Dnode]\n"
     "-numa dist,src=3Dsource,dst=3Ddestination,val=3Ddistance\n"
     "-numa cpu,node-id=3Dnode[,socket-id=3Dx][,core-id=3Dy][,thread-id=3Dz=
]\n"
     "-numa hmat-lb,initiator=3Dnode,target=3Dnode,hierarchy=3Dmemory|first=
-level|second-level|third-level,data-type=3Daccess-latency|read-latency|wri=
te-latency[,latency=3Dlat][,bandwidth=3Dbw]\n"
     "-numa hmat-cache,node-id=3Dnode,size=3Dsize,level=3Dlevel[,associativ=
ity=3Dnone|direct|complex][,policy=3Dnone|write-back|write-through][,line=
=3Dsize]\n",
     QEMU_ARCH_ALL)
 STEXI
-@item -numa node[,mem=3D@var{size}][,cpus=3D@var{firstcpu}[-@var{lastcpu}]=
][,nodeid=3D@var{node}][,initiator=3D@var{initiator}]
-@itemx -numa node[,memdev=3D@var{id}][,cpus=3D@var{firstcpu}[-@var{lastcpu=
}]][,nodeid=3D@var{node}][,initiator=3D@var{initiator}]
+@item -numa node,mem=3D@var{size}[,cpus=3D@var{firstcpu}[-@var{lastcpu}]][=
,nodeid=3D@var{node}][,initiator=3D@var{initiator}]
+@itemx -numa node,memdev=3D@var{id}[,cpus=3D@var{firstcpu}[-@var{lastcpu}]=
][,nodeid=3D@var{node}][,initiator=3D@var{initiator}]
 @itemx -numa dist,src=3D@var{source},dst=3D@var{destination},val=3D@var{di=
stance}
 @itemx -numa cpu,node-id=3D@var{node}[,socket-id=3D@var{x}][,core-id=3D@va=
r{y}][,thread-id=3D@var{z}]
 @itemx -numa hmat-lb,initiator=3D@var{node},target=3D@var{node},hierarchy=
=3D@var{hierarchy},data-type=3D@var{tpye}[,latency=3D@var{lat}][,bandwidth=
=3D@var{bw}]
@@ -202,7 +202,7 @@ split between them.
 For example, the following option assigns VCPUs 0, 1, 2 and 5 to
 a NUMA node:
 @example
--numa node,cpus=3D0-2,cpus=3D5
+-numa node,cpus=3D0-2,cpus=3D5,memdev=3Dram-backend-id
 @end example
=20
 @samp{cpu} option is a new alternative to @samp{cpus} option
@@ -219,14 +219,14 @@ For example:
 @example
 -M pc \
 -smp 1,sockets=3D2,maxcpus=3D2 \
--numa node,nodeid=3D0 -numa node,nodeid=3D1 \
+-m 512M -object memory-backend-ram,id=3Dmem,size=3D512M \
+-numa node,nodeid=3D0,memdev=3Dmem -numa node,nodeid=3D1 \
 -numa cpu,node-id=3D0,socket-id=3D0 -numa cpu,node-id=3D1,socket-id=3D1
 @end example
=20
 Legacy @samp{mem} assigns a given RAM amount to a node (not supported for =
5.0
 and newer machine types). @samp{memdev} assigns RAM from a given memory ba=
ckend
-device to a node. If @samp{mem} and @samp{memdev} are omitted in all nodes=
, RAM
-is split equally between them.
+device to a node.
=20
 @samp{mem} and @samp{memdev} are mutually exclusive. Furthermore,
 if one node uses @samp{memdev}, all of them have to use it.
--=20
2.7.4


