Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1557DC33C99
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:28:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3CE82073D
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 08:28:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gzsmgJVg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3CE82073D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44606 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iokDf-0002kf-So
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 03:28:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51811)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mst@redhat.com>) id 1iojPT-0005PZ-GQ
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:36:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mst@redhat.com>) id 1iojPP-0007kl-6z
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:36:15 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24475
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mst@redhat.com>) id 1iojPP-0007kN-03
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 02:36:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1578382570;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pXEsl8xj2B6C4J6CzOpzs7IZM8KuBGBRcno+vmHdxQg=;
 b=gzsmgJVgmNseW0R89bDurxMJW7NTEgOFXXgg5bYkdlcqmfBAvtIOZ6ZwRjNHaYHCdf2YPR
 Tfp1clr9WqpUyzBQ+N5T4XyNVCUo8vbhr+YRBahWN7aV6RsZ2G+eB8SEhi8OsyUBi0gS4V
 RJT83+BDaiR2Hrj+O0h3S1YrVbjWFPs=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-438-5lcbFu6XNpGYljEfVnFSKw-1; Tue, 07 Jan 2020 02:36:09 -0500
Received: by mail-qk1-f198.google.com with SMTP id l7so16546541qke.8
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 23:36:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MPPKzQOazirg5jBND3h1wpeXbc817RV9EQNRRNDvGLg=;
 b=GbKg9I86IbqfDcmjqSnWo1xax29qAuEUr31zOwUmNXghzBZTdXPkwydBcqK8oQc/Em
 AHZ0ppBqdVuHQN+aanFBI1bxVA8m9ZobWEFk6XBXqzx2LynGXhOOSKGBp8+Rl+8HNJRu
 /02nEOqs5Gw36jAFoahgvCdSLQ2uVwgrwiFHxmQllmBFUYtJCoNDDrTXOjcaAbEM73JU
 kv40mFLQlZy5KQWj7F134k4JiOZKah35PhWux6uYBQWvdweQ2tGmq6fKEhCFQsUmnJjg
 cDX3gtW0LAqOpBjZCN+AnU1/1hSdPgnavLpnWh80R/nObZOJEXUdgYJY7HxiErTI0+83
 0FLg==
X-Gm-Message-State: APjAAAW8JZ5ZmBtepyls1rCVob6p5NwIogMNiXvAq2HcwNmfobf/3Dr3
 C2gyxkmPeRJ3vLvr7qTp/c+3CVOJsVr7r8ZgYvy/eaGfBQaTvIAphbG3fo4b1jSU8RA/dBiX4kp
 4XXL8dYht4OIZqfM=
X-Received: by 2002:ae9:e40d:: with SMTP id q13mr88401233qkc.2.1578382568247; 
 Mon, 06 Jan 2020 23:36:08 -0800 (PST)
X-Google-Smtp-Source: APXvYqz7VizsjOq+UEdvWGxb2t2vuRxCPl4fW2Jjnpdgqw9WpzvGcYwY2mvglzlT3mFq8gQX3nQqiA==
X-Received: by 2002:ae9:e40d:: with SMTP id q13mr88401203qkc.2.1578382567800; 
 Mon, 06 Jan 2020 23:36:07 -0800 (PST)
Received: from redhat.com (bzq-79-183-34-164.red.bezeqint.net. [79.183.34.164])
 by smtp.gmail.com with ESMTPSA id l17sm22090382qkk.22.2020.01.06.23.36.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Jan 2020 23:36:07 -0800 (PST)
Date: Tue, 7 Jan 2020 02:36:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL v2 11/32] numa: Extend CLI to provide initiator information
 for numa nodes
Message-ID: <20200107073451.298261-12-mst@redhat.com>
References: <20200107073451.298261-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200107073451.298261-1-mst@redhat.com>
X-Mailer: git-send-email 2.24.1.751.gd10ce2899c
X-Mutt-Fcc: =sent
X-MC-Unique: 5lcbFu6XNpGYljEfVnFSKw-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Jingqi Liu <jingqi.liu@intel.com>,
 Tao Xu <tao3.xu@intel.com>, Markus Armbruster <armbru@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Dan Williams <dan.j.williams@intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Tao Xu <tao3.xu@intel.com>

In ACPI 6.3 chapter 5.2.27 Heterogeneous Memory Attribute Table (HMAT),
The initiator represents processor which access to memory. And in 5.2.27.3
Memory Proximity Domain Attributes Structure, the attached initiator is
defined as where the memory controller responsible for a memory proximity
domain. With attached initiator information, the topology of heterogeneous
memory can be described. Add new machine property 'hmat' to enable all
HMAT specific options.

Extend CLI of "-numa node" option to indicate the initiator numa node-id.
In the linux kernel, the codes in drivers/acpi/hmat/hmat.c parse and report
the platform's HMAT tables. Before using initiator option, enable HMAT with
-machine hmat=3Don.

Acked-by: Markus Armbruster <armbru@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Reviewed-by: Jingqi Liu <jingqi.liu@intel.com>
Suggested-by: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Tao Xu <tao3.xu@intel.com>
Message-Id: <20191213011929.2520-2-tao3.xu@intel.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 qapi/machine.json     | 10 ++++++-
 include/sysemu/numa.h |  5 ++++
 hw/core/machine.c     | 64 +++++++++++++++++++++++++++++++++++++++++++
 hw/core/numa.c        | 23 ++++++++++++++++
 qemu-options.hx       | 35 +++++++++++++++++++----
 5 files changed, 131 insertions(+), 6 deletions(-)

diff --git a/qapi/machine.json b/qapi/machine.json
index ca26779f1a..27d0e37534 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -463,6 +463,13 @@
 # @memdev: memory backend object.  If specified for one node,
 #          it must be specified for all nodes.
 #
+# @initiator: defined in ACPI 6.3 Chapter 5.2.27.3 Table 5-145,
+#             points to the nodeid which has the memory controller
+#             responsible for this NUMA node. This field provides
+#             additional information as to the initiator node that
+#             is closest (as in directly attached) to this node, and
+#             therefore has the best performance (since 5.0)
+#
 # Since: 2.1
 ##
 { 'struct': 'NumaNodeOptions',
@@ -470,7 +477,8 @@
    '*nodeid': 'uint16',
    '*cpus':   ['uint16'],
    '*mem':    'size',
-   '*memdev': 'str' }}
+   '*memdev': 'str',
+   '*initiator': 'uint16' }}
=20
 ##
 # @NumaDistOptions:
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index ae9c41d02b..788cbec7a2 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -18,6 +18,8 @@ struct NodeInfo {
     uint64_t node_mem;
     struct HostMemoryBackend *node_memdev;
     bool present;
+    bool has_cpu;
+    uint16_t initiator;
     uint8_t distance[MAX_NODES];
 };
=20
@@ -33,6 +35,9 @@ struct NumaState {
     /* Allow setting NUMA distance for different NUMA nodes */
     bool have_numa_distance;
=20
+    /* Detect if HMAT support is enabled. */
+    bool hmat_enabled;
+
     /* NUMA nodes information */
     NodeInfo nodes[MAX_NODES];
 };
diff --git a/hw/core/machine.c b/hw/core/machine.c
index 0854dcebdd..f5e2b32b3b 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -430,6 +430,20 @@ static void machine_set_nvdimm(Object *obj, bool value=
, Error **errp)
     ms->nvdimms_state->is_enabled =3D value;
 }
=20
+static bool machine_get_hmat(Object *obj, Error **errp)
+{
+    MachineState *ms =3D MACHINE(obj);
+
+    return ms->numa_state->hmat_enabled;
+}
+
+static void machine_set_hmat(Object *obj, bool value, Error **errp)
+{
+    MachineState *ms =3D MACHINE(obj);
+
+    ms->numa_state->hmat_enabled =3D value;
+}
+
 static char *machine_get_nvdimm_persistence(Object *obj, Error **errp)
 {
     MachineState *ms =3D MACHINE(obj);
@@ -557,6 +571,7 @@ void machine_set_cpu_numa_node(MachineState *machine,
                                const CpuInstanceProperties *props, Error *=
*errp)
 {
     MachineClass *mc =3D MACHINE_GET_CLASS(machine);
+    NodeInfo *numa_info =3D machine->numa_state->nodes;
     bool match =3D false;
     int i;
=20
@@ -626,6 +641,17 @@ void machine_set_cpu_numa_node(MachineState *machine,
         match =3D true;
         slot->props.node_id =3D props->node_id;
         slot->props.has_node_id =3D props->has_node_id;
+
+        if (machine->numa_state->hmat_enabled) {
+            if ((numa_info[props->node_id].initiator < MAX_NODES) &&
+                (props->node_id !=3D numa_info[props->node_id].initiator))=
 {
+                error_setg(errp, "The initiator of CPU NUMA node %" PRId64
+                        " should be itself", props->node_id);
+                return;
+            }
+            numa_info[props->node_id].has_cpu =3D true;
+            numa_info[props->node_id].initiator =3D props->node_id;
+        }
     }
=20
     if (!match) {
@@ -846,6 +872,13 @@ static void machine_initfn(Object *obj)
=20
     if (mc->numa_mem_supported) {
         ms->numa_state =3D g_new0(NumaState, 1);
+        object_property_add_bool(obj, "hmat",
+                                 machine_get_hmat, machine_set_hmat,
+                                 &error_abort);
+        object_property_set_description(obj, "hmat",
+                                        "Set on/off to enable/disable "
+                                        "ACPI Heterogeneous Memory Attribu=
te "
+                                        "Table (HMAT)", NULL);
     }
=20
     /* Register notifier when init is done for sysbus sanity checks */
@@ -913,6 +946,32 @@ static char *cpu_slot_to_string(const CPUArchId *cpu)
     return g_string_free(s, false);
 }
=20
+static void numa_validate_initiator(NumaState *numa_state)
+{
+    int i;
+    NodeInfo *numa_info =3D numa_state->nodes;
+
+    for (i =3D 0; i < numa_state->num_nodes; i++) {
+        if (numa_info[i].initiator =3D=3D MAX_NODES) {
+            error_report("The initiator of NUMA node %d is missing, use "
+                         "'-numa node,initiator' option to declare it", i)=
;
+            exit(1);
+        }
+
+        if (!numa_info[numa_info[i].initiator].present) {
+            error_report("NUMA node %" PRIu16 " is missing, use "
+                         "'-numa node' option to declare it first",
+                         numa_info[i].initiator);
+            exit(1);
+        }
+
+        if (!numa_info[numa_info[i].initiator].has_cpu) {
+            error_report("The initiator of NUMA node %d is invalid", i);
+            exit(1);
+        }
+    }
+}
+
 static void machine_numa_finish_cpu_init(MachineState *machine)
 {
     int i;
@@ -953,6 +1012,11 @@ static void machine_numa_finish_cpu_init(MachineState=
 *machine)
             machine_set_cpu_numa_node(machine, &props, &error_fatal);
         }
     }
+
+    if (machine->numa_state->hmat_enabled) {
+        numa_validate_initiator(machine->numa_state);
+    }
+
     if (s->len && !qtest_enabled()) {
         warn_report("CPU(s) not present in any NUMA nodes: %s",
                     s->str);
diff --git a/hw/core/numa.c b/hw/core/numa.c
index e3332a984f..e60da99293 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -133,6 +133,29 @@ static void parse_numa_node(MachineState *ms, NumaNode=
Options *node,
         numa_info[nodenr].node_mem =3D object_property_get_uint(o, "size",=
 NULL);
         numa_info[nodenr].node_memdev =3D MEMORY_BACKEND(o);
     }
+
+    /*
+     * If not set the initiator, set it to MAX_NODES. And if
+     * HMAT is enabled and this node has no cpus, QEMU will raise error.
+     */
+    numa_info[nodenr].initiator =3D MAX_NODES;
+    if (node->has_initiator) {
+        if (!ms->numa_state->hmat_enabled) {
+            error_setg(errp, "ACPI Heterogeneous Memory Attribute Table "
+                       "(HMAT) is disabled, enable it with -machine hmat=
=3Don "
+                       "before using any of hmat specific options");
+            return;
+        }
+
+        if (node->initiator >=3D MAX_NODES) {
+            error_report("The initiator id %" PRIu16 " expects an integer =
"
+                         "between 0 and %d", node->initiator,
+                         MAX_NODES - 1);
+            return;
+        }
+
+        numa_info[nodenr].initiator =3D node->initiator;
+    }
     numa_info[nodenr].present =3D true;
     max_numa_nodeid =3D MAX(max_numa_nodeid, nodenr + 1);
     ms->numa_state->num_nodes++;
diff --git a/qemu-options.hx b/qemu-options.hx
index e9d6231438..b78bc52634 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -40,7 +40,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
     "                suppress-vmdesc=3Don|off disables self-describing mig=
ration (default=3Doff)\n"
     "                nvdimm=3Don|off controls NVDIMM support (default=3Dof=
f)\n"
     "                enforce-config-section=3Don|off enforce configuration=
 section migration (default=3Doff)\n"
-    "                memory-encryption=3D@var{} memory encryption object t=
o use (default=3Dnone)\n",
+    "                memory-encryption=3D@var{} memory encryption object t=
o use (default=3Dnone)\n"
+    "                hmat=3Don|off controls ACPI HMAT support (default=3Do=
ff)\n",
     QEMU_ARCH_ALL)
 STEXI
 @item -machine [type=3D]@var{name}[,prop=3D@var{value}[,...]]
@@ -94,6 +95,9 @@ NOTE: this parameter is deprecated. Please use @option{-g=
lobal}
 @option{migration.send-configuration}=3D@var{on|off} instead.
 @item memory-encryption=3D@var{}
 Memory encryption object to use. The default is none.
+@item hmat=3Don|off
+Enables or disables ACPI Heterogeneous Memory Attribute Table (HMAT) suppo=
rt.
+The default is off.
 @end table
 ETEXI
=20
@@ -168,14 +172,14 @@ If any on the three values is given, the total number=
 of CPUs @var{n} can be omi
 ETEXI
=20
 DEF("numa", HAS_ARG, QEMU_OPTION_numa,
-    "-numa node[,mem=3Dsize][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode]\n=
"
-    "-numa node[,memdev=3Did][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode]\=
n"
+    "-numa node[,mem=3Dsize][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode][,=
initiator=3Dnode]\n"
+    "-numa node[,memdev=3Did][,cpus=3Dfirstcpu[-lastcpu]][,nodeid=3Dnode][=
,initiator=3Dnode]\n"
     "-numa dist,src=3Dsource,dst=3Ddestination,val=3Ddistance\n"
     "-numa cpu,node-id=3Dnode[,socket-id=3Dx][,core-id=3Dy][,thread-id=3Dz=
]\n",
     QEMU_ARCH_ALL)
 STEXI
-@item -numa node[,mem=3D@var{size}][,cpus=3D@var{firstcpu}[-@var{lastcpu}]=
][,nodeid=3D@var{node}]
-@itemx -numa node[,memdev=3D@var{id}][,cpus=3D@var{firstcpu}[-@var{lastcpu=
}]][,nodeid=3D@var{node}]
+@item -numa node[,mem=3D@var{size}][,cpus=3D@var{firstcpu}[-@var{lastcpu}]=
][,nodeid=3D@var{node}][,initiator=3D@var{initiator}]
+@itemx -numa node[,memdev=3D@var{id}][,cpus=3D@var{firstcpu}[-@var{lastcpu=
}]][,nodeid=3D@var{node}][,initiator=3D@var{initiator}]
 @itemx -numa dist,src=3D@var{source},dst=3D@var{destination},val=3D@var{di=
stance}
 @itemx -numa cpu,node-id=3D@var{node}[,socket-id=3D@var{x}][,core-id=3D@va=
r{y}][,thread-id=3D@var{z}]
 @findex -numa
@@ -222,6 +226,27 @@ split equally between them.
 @samp{mem} and @samp{memdev} are mutually exclusive. Furthermore,
 if one node uses @samp{memdev}, all of them have to use it.
=20
+@samp{initiator} is an additional option that points to an @var{initiator}
+NUMA node that has best performance (the lowest latency or largest bandwid=
th)
+to this NUMA @var{node}. Note that this option can be set only when
+the machine property 'hmat' is set to 'on'.
+
+Following example creates a machine with 2 NUMA nodes, node 0 has CPU.
+node 1 has only memory, and its initiator is node 0. Note that because
+node 0 has CPU, by default the initiator of node 0 is itself and must be
+itself.
+@example
+-machine hmat=3Don \
+-m 2G,slots=3D2,maxmem=3D4G \
+-object memory-backend-ram,size=3D1G,id=3Dm0 \
+-object memory-backend-ram,size=3D1G,id=3Dm1 \
+-numa node,nodeid=3D0,memdev=3Dm0 \
+-numa node,nodeid=3D1,memdev=3Dm1,initiator=3D0 \
+-smp 2,sockets=3D2,maxcpus=3D2  \
+-numa cpu,node-id=3D0,socket-id=3D0 \
+-numa cpu,node-id=3D0,socket-id=3D1
+@end example
+
 @var{source} and @var{destination} are NUMA node IDs.
 @var{distance} is the NUMA distance from @var{source} to @var{destination}=
.
 The distance from a node to itself is always 10. If any pair of nodes is
--=20
MST


