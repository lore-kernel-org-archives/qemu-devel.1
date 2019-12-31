Return-Path: <SRS0=eTrL=2V=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2744CC2D0C2
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 14:07:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5BE92064B
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Dec 2019 14:07:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cHbPbx7/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5BE92064B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42994 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1imIB5-0001xS-Bw
	for qemu-devel@archiver.kernel.org; Tue, 31 Dec 2019 09:07:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58002)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1imHCt-0006Ow-Cx
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:05:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1imHCr-0005ig-9R
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:05:07 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:43629
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1imHCr-0005fm-29
 for qemu-devel@nongnu.org; Tue, 31 Dec 2019 08:05:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1577797501;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qI2saWSvHRrQAnnEAcsLYuH7nBnNpOoycj1p6rhDCNY=;
 b=cHbPbx7/rFJudsOYFxLM+CxR0gU73LY5pyvkximzAeGDnBk1/5W9d5Npfu6HyrCOk7KCKT
 5T4xg0lqvTH280P9NiFH/XXkShTMQH4zB+HH+1jqwqSxe4/jLBPJN44PuM3MYTBNvgB8aT
 kmZn6SY9KMarVUDDQYgWKtIaxaoibeo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-434-TODSoRqVP9CKDUWd4PH-6g-1; Tue, 31 Dec 2019 08:04:59 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CB4DE107ACC4
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:58 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4FFCE620A6
 for <qemu-devel@nongnu.org>; Tue, 31 Dec 2019 13:04:58 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 86/86] numa: remove deprecated implicit RAM distribution
 between nodes
Date: Tue, 31 Dec 2019 14:04:10 +0100
Message-Id: <1577797450-88458-87-git-send-email-imammedo@redhat.com>
In-Reply-To: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
References: <1577797450-88458-1-git-send-email-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-MC-Unique: TODSoRqVP9CKDUWd4PH-6g-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
index 9f69883..aadc9af 100644
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
index 21f6a5a..5470238 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -43,10 +43,6 @@ void parse_numa_opts(MachineState *ms);
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
index a938052..b1ce8c5 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -715,12 +715,6 @@ static void machine_class_init(ObjectClass *oc, void *=
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
index 96776ff..522e689 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -330,42 +330,6 @@ static void complete_init_numa_distance(MachineState *=
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
@@ -435,30 +399,15 @@ void numa_complete_configuration(MachineState *ms)
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
index b2805fe..3a1edba 100644
--- a/hw/i386/pc_piix.c
+++ b/hw/i386/pc_piix.c
@@ -533,7 +533,6 @@ static void pc_i440fx_2_9_machine_options(MachineClass =
*m)
     pc_i440fx_2_10_machine_options(m);
     compat_props_add(m->compat_props, hw_compat_2_9, hw_compat_2_9_len);
     compat_props_add(m->compat_props, pc_compat_2_9, pc_compat_2_9_len);
-    m->numa_auto_assign_ram =3D numa_legacy_auto_assign_ram;
 }
=20
 DEFINE_I440FX_MACHINE(v2_9, "pc-i440fx-2.9", NULL,
diff --git a/hw/i386/pc_q35.c b/hw/i386/pc_q35.c
index f15711b..ed6c7be 100644
--- a/hw/i386/pc_q35.c
+++ b/hw/i386/pc_q35.c
@@ -467,7 +467,6 @@ static void pc_q35_2_10_machine_options(MachineClass *m=
)
     pc_q35_2_11_machine_options(m);
     compat_props_add(m->compat_props, hw_compat_2_10, hw_compat_2_10_len);
     compat_props_add(m->compat_props, pc_compat_2_10, pc_compat_2_10_len);
-    m->numa_auto_assign_ram =3D numa_legacy_auto_assign_ram;
     m->auto_enable_numa_with_memhp =3D false;
 }
=20
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 6527962..1cc7407 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -4380,11 +4380,6 @@ static void spapr_machine_class_init(ObjectClass *oc=
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
@@ -4637,7 +4632,6 @@ static void spapr_machine_2_9_class_options(MachineCl=
ass *mc)
     spapr_machine_2_10_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_2_9, hw_compat_2_9_len);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-    mc->numa_auto_assign_ram =3D numa_legacy_auto_assign_ram;
     smc->pre_2_10_has_unused_icps =3D true;
     smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_DISABLED;
 }
@@ -4657,7 +4651,6 @@ static void spapr_machine_2_8_class_options(MachineCl=
ass *mc)
     spapr_machine_2_9_class_options(mc);
     compat_props_add(mc->compat_props, hw_compat_2_8, hw_compat_2_8_len);
     compat_props_add(mc->compat_props, compat, G_N_ELEMENTS(compat));
-    mc->numa_mem_align_shift =3D 23;
 }
=20
 DEFINE_SPAPR_MACHINE(2_8, "2.8", false);
diff --git a/qemu-deprecated.texi b/qemu-deprecated.texi
index d9b07ba..05e6082 100644
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
index 088dd32..4872f11 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -168,14 +168,14 @@ If any on the three values is given, the total number=
 of CPUs @var{n} can be omi
 ETEXI
=20
 DEF("numa", HAS_ARG, QEMU_OPTION_numa,
-    "-numa node[,mem=3Dsize][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode]\n=
"
-    "-numa node[,memdev=3Did][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode]\=
n"
+    "-numa node,mem=3Dsize[,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode]\n"
+    "-numa node,memdev=3Did[,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode]\n"
     "-numa dist,src=3Dsource,dst=3Ddestination,val=3Ddistance\n"
     "-numa cpu,node-id=3Dnode[,socket-id=3Dx][,core-id=3Dy][,thread-id=3Dz=
]\n",
     QEMU_ARCH_ALL)
 STEXI
-@item -numa node[,mem=3D@var{size}][,cpus=3D@var{firstcpu}[-@var{lastcpu}]=
][,nodeid=3D@var{node}]
-@itemx -numa node[,memdev=3D@var{id}][,cpus=3D@var{firstcpu}[-@var{lastcpu=
}]][,nodeid=3D@var{node}]
+@item -numa node,mem=3D@var{size}[,cpus=3D@var{firstcpu}[-@var{lastcpu}]][=
,nodeid=3D@var{node}]
+@itemx -numa node,memdev=3D@var{id}[,cpus=3D@var{firstcpu}[-@var{lastcpu}]=
][,nodeid=3D@var{node}]
 @itemx -numa dist,src=3D@var{source},dst=3D@var{destination},val=3D@var{di=
stance}
 @itemx -numa cpu,node-id=3D@var{node}[,socket-id=3D@var{x}][,core-id=3D@va=
r{y}][,thread-id=3D@var{z}]
 @findex -numa
@@ -193,7 +193,7 @@ split between them.
 For example, the following option assigns VCPUs 0, 1, 2 and 5 to
 a NUMA node:
 @example
--numa node,cpus=3D0-2,cpus=3D5
+-numa node,cpus=3D0-2,cpus=3D5,memdev=3Dram-backend-id
 @end example
=20
 @samp{cpu} option is a new alternative to @samp{cpus} option
@@ -210,14 +210,14 @@ For example:
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


