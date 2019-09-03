Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4956C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:40:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 96B462087E
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:40:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 96B462087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51918 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5GWz-0005Bz-Nf
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:40:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <ehabkost@redhat.com>) id 1i5FwU-0004HV-4q
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1i5FwQ-0001Fb-6h
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:20 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59072)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1i5FwP-0001CU-Gu
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 17:02:17 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E6F2A18C4269;
 Tue,  3 Sep 2019 21:02:13 +0000 (UTC)
Received: from localhost (ovpn-116-55.gru2.redhat.com [10.97.116.55])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4D3665C219;
 Tue,  3 Sep 2019 21:02:13 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <rth@twiddle.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 18:01:53 -0300
Message-Id: <20190903210201.14627-6-ehabkost@redhat.com>
In-Reply-To: <20190903210201.14627-1-ehabkost@redhat.com>
References: <20190903210201.14627-1-ehabkost@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.62]); Tue, 03 Sep 2019 21:02:14 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v2 05/13] numa: move numa global variable
 numa_info into MachineState
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
Cc: Tao Xu <tao3.xu@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tao Xu <tao3.xu@intel.com>

Move existing numa global numa_info (renamed as "nodes") into NumaState.

Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Igor Mammedov <imammedo@redhat.com>
Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
Message-Id: <20190809065731.9097-5-tao3.xu@intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/sysemu/numa.h    |  5 +++--
 exec.c                   |  2 +-
 hw/acpi/aml-build.c      |  6 ++++--
 hw/arm/boot.c            |  2 +-
 hw/arm/sbsa-ref.c        |  3 ++-
 hw/arm/virt-acpi-build.c |  7 ++++---
 hw/arm/virt.c            |  3 ++-
 hw/core/numa.c           | 15 +++++++++------
 hw/i386/pc.c             |  4 ++--
 hw/ppc/spapr.c           | 10 +++++-----
 hw/ppc/spapr_pci.c       |  4 +++-
 11 files changed, 36 insertions(+), 25 deletions(-)

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index bfe04b514c..ae9c41d02b 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -26,14 +26,15 @@ struct NumaNodeMem {
     uint64_t node_plugged_mem;
 };
=20
-extern NodeInfo numa_info[MAX_NODES];
-
 struct NumaState {
     /* Number of NUMA nodes */
     int num_nodes;
=20
     /* Allow setting NUMA distance for different NUMA nodes */
     bool have_numa_distance;
+
+    /* NUMA nodes information */
+    NodeInfo nodes[MAX_NODES];
 };
 typedef struct NumaState NumaState;
=20
diff --git a/exec.c b/exec.c
index e813058b05..0d47788f5f 100644
--- a/exec.c
+++ b/exec.c
@@ -1780,7 +1780,7 @@ long qemu_minrampagesize(void)
     if (hpsize > mainrampagesize &&
         (ms->numa_state =3D=3D NULL ||
          ms->numa_state->num_nodes =3D=3D 0 ||
-         numa_info[0].node_memdev =3D=3D NULL)) {
+         ms->numa_state->nodes[0].node_memdev =3D=3D NULL)) {
         static bool warned;
         if (!warned) {
             error_report("Huge page support disabled (n/a for main memor=
y).");
diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
index 043b47694c..78aee1a2f9 100644
--- a/hw/acpi/aml-build.c
+++ b/hw/acpi/aml-build.c
@@ -1738,8 +1738,10 @@ void build_slit(GArray *table_data, BIOSLinker *li=
nker, MachineState *ms)
     build_append_int_noprefix(table_data, nb_numa_nodes, 8);
     for (i =3D 0; i < nb_numa_nodes; i++) {
         for (j =3D 0; j < nb_numa_nodes; j++) {
-            assert(numa_info[i].distance[j]);
-            build_append_int_noprefix(table_data, numa_info[i].distance[=
j], 1);
+            assert(ms->numa_state->nodes[i].distance[j]);
+            build_append_int_noprefix(table_data,
+                                      ms->numa_state->nodes[i].distance[=
j],
+                                      1);
         }
     }
=20
diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index d3e88626c4..bf97ef3e33 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -601,7 +601,7 @@ int arm_load_dtb(hwaddr addr, const struct arm_boot_i=
nfo *binfo,
     if (ms->numa_state !=3D NULL && ms->numa_state->num_nodes > 0) {
         mem_base =3D binfo->loader_start;
         for (i =3D 0; i < ms->numa_state->num_nodes; i++) {
-            mem_len =3D numa_info[i].node_mem;
+            mem_len =3D ms->numa_state->nodes[i].node_mem;
             rc =3D fdt_add_memory_node(fdt, acells, mem_base,
                                      scells, mem_len, i);
             if (rc < 0) {
diff --git a/hw/arm/sbsa-ref.c b/hw/arm/sbsa-ref.c
index 7d7bb9fd96..27046cc284 100644
--- a/hw/arm/sbsa-ref.c
+++ b/hw/arm/sbsa-ref.c
@@ -170,7 +170,8 @@ static void create_fdt(SBSAMachineState *sms)
                 idx =3D (i * nb_numa_nodes + j) * 3;
                 matrix[idx + 0] =3D cpu_to_be32(i);
                 matrix[idx + 1] =3D cpu_to_be32(j);
-                matrix[idx + 2] =3D cpu_to_be32(numa_info[i].distance[j]=
);
+                matrix[idx + 2] =3D
+                    cpu_to_be32(ms->numa_state->nodes[i].distance[j]);
             }
         }
=20
diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
index b1deb76a53..6cdf156cf5 100644
--- a/hw/arm/virt-acpi-build.c
+++ b/hw/arm/virt-acpi-build.c
@@ -535,11 +535,12 @@ build_srat(GArray *table_data, BIOSLinker *linker, =
VirtMachineState *vms)
=20
     mem_base =3D vms->memmap[VIRT_MEM].base;
     for (i =3D 0; i < ms->numa_state->num_nodes; ++i) {
-        if (numa_info[i].node_mem > 0) {
+        if (ms->numa_state->nodes[i].node_mem > 0) {
             numamem =3D acpi_data_push(table_data, sizeof(*numamem));
-            build_srat_memory(numamem, mem_base, numa_info[i].node_mem, =
i,
+            build_srat_memory(numamem, mem_base,
+                              ms->numa_state->nodes[i].node_mem, i,
                               MEM_AFFINITY_ENABLED);
-            mem_base +=3D numa_info[i].node_mem;
+            mem_base +=3D ms->numa_state->nodes[i].node_mem;
         }
     }
=20
diff --git a/hw/arm/virt.c b/hw/arm/virt.c
index 414f7ecd02..d74538b021 100644
--- a/hw/arm/virt.c
+++ b/hw/arm/virt.c
@@ -246,7 +246,8 @@ static void create_fdt(VirtMachineState *vms)
                 idx =3D (i * nb_numa_nodes + j) * 3;
                 matrix[idx + 0] =3D cpu_to_be32(i);
                 matrix[idx + 1] =3D cpu_to_be32(j);
-                matrix[idx + 2] =3D cpu_to_be32(numa_info[i].distance[j]=
);
+                matrix[idx + 2] =3D
+                    cpu_to_be32(ms->numa_state->nodes[i].distance[j]);
             }
         }
=20
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 4a7adc9b98..4dfec5c95b 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -55,8 +55,6 @@ static int have_mem;
 static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
                              * For all nodes, nodeid < max_numa_nodeid
                              */
-NodeInfo numa_info[MAX_NODES];
-
=20
 static void parse_numa_node(MachineState *ms, NumaNodeOptions *node,
                             Error **errp)
@@ -66,6 +64,7 @@ static void parse_numa_node(MachineState *ms, NumaNodeO=
ptions *node,
     uint16List *cpus =3D NULL;
     MachineClass *mc =3D MACHINE_GET_CLASS(ms);
     unsigned int max_cpus =3D ms->smp.max_cpus;
+    NodeInfo *numa_info =3D ms->numa_state->nodes;
=20
     if (node->has_nodeid) {
         nodenr =3D node->nodeid;
@@ -145,6 +144,7 @@ void parse_numa_distance(MachineState *ms, NumaDistOp=
tions *dist, Error **errp)
     uint16_t src =3D dist->src;
     uint16_t dst =3D dist->dst;
     uint8_t val =3D dist->val;
+    NodeInfo *numa_info =3D ms->numa_state->nodes;
=20
     if (src >=3D MAX_NODES || dst >=3D MAX_NODES) {
         error_setg(errp, "Parameter '%s' expects an integer between 0 an=
d %d",
@@ -203,7 +203,7 @@ void set_numa_options(MachineState *ms, NumaOptions *=
object, Error **errp)
             error_setg(&err, "Missing mandatory node-id property");
             goto end;
         }
-        if (!numa_info[object->u.cpu.node_id].present) {
+        if (!ms->numa_state->nodes[object->u.cpu.node_id].present) {
             error_setg(&err, "Invalid node-id=3D%" PRId64 ", NUMA node m=
ust be "
                 "defined with -numa node,nodeid=3DID before it's used wi=
th "
                 "-numa cpu,node-id=3DID", object->u.cpu.node_id);
@@ -263,6 +263,7 @@ static void validate_numa_distance(MachineState *ms)
     int src, dst;
     bool is_asymmetrical =3D false;
     int nb_numa_nodes =3D ms->numa_state->num_nodes;
+    NodeInfo *numa_info =3D ms->numa_state->nodes;
=20
     for (src =3D 0; src < nb_numa_nodes; src++) {
         for (dst =3D src; dst < nb_numa_nodes; dst++) {
@@ -303,6 +304,7 @@ static void validate_numa_distance(MachineState *ms)
 static void complete_init_numa_distance(MachineState *ms)
 {
     int src, dst;
+    NodeInfo *numa_info =3D ms->numa_state->nodes;
=20
     /* Fixup NUMA distance by symmetric policy because if it is an
      * asymmetric distance table, it should be a complete table and
@@ -362,6 +364,7 @@ void numa_complete_configuration(MachineState *ms)
 {
     int i;
     MachineClass *mc =3D MACHINE_GET_CLASS(ms);
+    NodeInfo *numa_info =3D ms->numa_state->nodes;
=20
     /*
      * If memory hotplug is enabled (slots > 0) but without '-numa'
@@ -527,8 +530,8 @@ void memory_region_allocate_system_memory(MemoryRegio=
n *mr, Object *owner,
=20
     memory_region_init(mr, owner, name, ram_size);
     for (i =3D 0; i < ms->numa_state->num_nodes; i++) {
-        uint64_t size =3D numa_info[i].node_mem;
-        HostMemoryBackend *backend =3D numa_info[i].node_memdev;
+        uint64_t size =3D ms->numa_state->nodes[i].node_mem;
+        HostMemoryBackend *backend =3D ms->numa_state->nodes[i].node_mem=
dev;
         if (!backend) {
             continue;
         }
@@ -594,7 +597,7 @@ void query_numa_node_mem(NumaNodeMem node_mem[], Mach=
ineState *ms)
=20
     numa_stat_memory_devices(node_mem);
     for (i =3D 0; i < ms->numa_state->num_nodes; i++) {
-        node_mem[i].node_mem +=3D numa_info[i].node_mem;
+        node_mem[i].node_mem +=3D ms->numa_state->nodes[i].node_mem;
     }
 }
=20
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 5fba29c10b..985e9261b0 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -1046,7 +1046,7 @@ static FWCfgState *bochs_bios_init(AddressSpace *as=
, PCMachineState *pcms)
     }
     for (i =3D 0; i < nb_numa_nodes; i++) {
         numa_fw_cfg[pcms->apic_id_limit + 1 + i] =3D
-            cpu_to_le64(numa_info[i].node_mem);
+            cpu_to_le64(ms->numa_state->nodes[i].node_mem);
     }
     fw_cfg_add_bytes(fw_cfg, FW_CFG_NUMA, numa_fw_cfg,
                      (1 + pcms->apic_id_limit + nb_numa_nodes) *
@@ -1783,7 +1783,7 @@ void pc_guest_info_init(PCMachineState *pcms)
     pcms->node_mem =3D g_malloc0(pcms->numa_nodes *
                                     sizeof *pcms->node_mem);
     for (i =3D 0; i < ms->numa_state->num_nodes; i++) {
-        pcms->node_mem[i] =3D numa_info[i].node_mem;
+        pcms->node_mem[i] =3D ms->numa_state->nodes[i].node_mem;
     }
=20
     pcms->machine_done.notify =3D pc_machine_done;
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a7eb87feb6..a9cd350f0d 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -359,8 +359,8 @@ static hwaddr spapr_node0_size(MachineState *machine)
     if (machine->numa_state->num_nodes) {
         int i;
         for (i =3D 0; i < machine->numa_state->num_nodes; ++i) {
-            if (numa_info[i].node_mem) {
-                return MIN(pow2floor(numa_info[i].node_mem),
+            if (machine->numa_state->nodes[i].node_mem) {
+                return MIN(pow2floor(machine->numa_state->nodes[i].node_=
mem),
                            machine->ram_size);
             }
         }
@@ -404,7 +404,7 @@ static int spapr_populate_memory(SpaprMachineState *s=
papr, void *fdt)
     MachineState *machine =3D MACHINE(spapr);
     hwaddr mem_start, node_size;
     int i, nb_nodes =3D machine->numa_state->num_nodes;
-    NodeInfo *nodes =3D numa_info;
+    NodeInfo *nodes =3D machine->numa_state->nodes;
     NodeInfo ramnode;
=20
     /* No NUMA nodes, assume there is just one node with whole RAM */
@@ -2541,11 +2541,11 @@ static void spapr_validate_node_memory(MachineSta=
te *machine, Error **errp)
     }
=20
     for (i =3D 0; i < machine->numa_state->num_nodes; i++) {
-        if (numa_info[i].node_mem % SPAPR_MEMORY_BLOCK_SIZE) {
+        if (machine->numa_state->nodes[i].node_mem % SPAPR_MEMORY_BLOCK_=
SIZE) {
             error_setg(errp,
                        "Node %d memory size 0x%" PRIx64
                        " is not aligned to %" PRIu64 " MiB",
-                       i, numa_info[i].node_mem,
+                       i, machine->numa_state->nodes[i].node_mem,
                        SPAPR_MEMORY_BLOCK_SIZE / MiB);
             return;
         }
diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
index deb0b0c80c..210abc67c3 100644
--- a/hw/ppc/spapr_pci.c
+++ b/hw/ppc/spapr_pci.c
@@ -1825,6 +1825,7 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
     SysBusDevice *s =3D SYS_BUS_DEVICE(dev);
     SpaprPhbState *sphb =3D SPAPR_PCI_HOST_BRIDGE(s);
     PCIHostState *phb =3D PCI_HOST_BRIDGE(s);
+    MachineState *ms =3D MACHINE(spapr);
     char *namebuf;
     int i;
     PCIBus *bus;
@@ -1877,7 +1878,8 @@ static void spapr_phb_realize(DeviceState *dev, Err=
or **errp)
     }
=20
     if (sphb->numa_node !=3D -1 &&
-        (sphb->numa_node >=3D MAX_NODES || !numa_info[sphb->numa_node].p=
resent)) {
+        (sphb->numa_node >=3D MAX_NODES ||
+         !ms->numa_state->nodes[sphb->numa_node].present)) {
         error_setg(errp, "Invalid NUMA node ID for PCI host bridge");
         return;
     }
--=20
2.21.0


