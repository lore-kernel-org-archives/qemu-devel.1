Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBFBBC34021
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:37:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A92F920725
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 17:37:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VaMJpW55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A92F920725
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49380 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3kKy-0006Az-QQ
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 12:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37997)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <imammedo@redhat.com>) id 1j3kIa-0000u1-1N
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <imammedo@redhat.com>) id 1j3kIY-0001cZ-KZ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:11 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:44180
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1j3kIY-0001c8-G9
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 12:35:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1581960910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RM7uhLD53k+hNkv1a4EgcMlQV+rv0h03YJkOpdhwAT4=;
 b=VaMJpW55ZpujB+UOUYMJSCauzBOyaNFF0YQMBtYUOKnPtXLQHwpDHlylK/5bHRErp0C/Sw
 3SecauwNTWWhD3founM42cB2PXJ/QU0zB2L4i7bHEamYAvqkJUjGssLB/hD7HN451bRcV8
 TVjPDvP4C+BoOaT/91+H5kUwKK5bdKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-111-1HeA4JhsPViUDiCpBkrVfQ-1; Mon, 17 Feb 2020 12:35:08 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id EFD8918FE862;
 Mon, 17 Feb 2020 17:35:06 +0000 (UTC)
Received: from dell-r430-03.lab.eng.brq.redhat.com
 (dell-r430-03.lab.eng.brq.redhat.com [10.37.153.18])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EBC7B90526;
 Mon, 17 Feb 2020 17:35:05 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 05/79] initialize MachineState::ram in NUMA case
Date: Mon, 17 Feb 2020 12:33:38 -0500
Message-Id: <20200217173452.15243-6-imammedo@redhat.com>
In-Reply-To: <20200217173452.15243-1-imammedo@redhat.com>
References: <20200217173452.15243-1-imammedo@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: 1HeA4JhsPViUDiCpBkrVfQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: pasic@linux.ibm.com, Paolo Bonzini <pbonzini@redhat.com>,
 ehabkost@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

In case of NUMA there are 2 cases to consider:
 1. '-numa node,memdev', the only one that will be available
    for 5.0 and newer machine types.

    In this case reuse current behavior, with only difference
    memdevs are put into MachineState::ram container +
    a temporary glue to keep memory_region_allocate_system_memory()
    working until all boards converted.

 2. fake NUMA ("-numa node mem" and default RAM splitting)
    the later has been deprecated and will be removed but the former
    is going to stay available for compat reasons for 5.0 and
    older machine types

    it takes allocate_system_memory_nonnuma() path, like non-NUMA
    case and falls under conversion to memdev.  So extend non-NUMA
    MachineState::ram initialization introduced in previous patch
    to take care of fake NUMA case.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
CC: ehabkost@redhat.com
CC: pbonzini@redhat.com
CC: pasic@linux.ibm.com
---
 include/sysemu/numa.h |  1 +
 hw/core/numa.c        | 43 ++++++++++++++++++++++++++++++-------------
 vl.c                  |  2 +-
 3 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index ba693cc80b..ad58ee88f7 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -112,5 +112,6 @@ void numa_default_auto_assign_ram(MachineClass *mc, Nod=
eInfo *nodes,
                                   int nb_nodes, ram_addr_t size);
 void numa_cpu_pre_plug(const struct CPUArchId *slot, DeviceState *dev,
                        Error **errp);
+bool numa_uses_legacy_mem(void);
=20
 #endif
diff --git a/hw/core/numa.c b/hw/core/numa.c
index 8264336209..e6baf2c33e 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -52,6 +52,11 @@ QemuOptsList qemu_numa_opts =3D {
 };
=20
 static int have_memdevs;
+bool numa_uses_legacy_mem(void)
+{
+    return !have_memdevs;
+}
+
 static int have_mem;
 static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
                              * For all nodes, nodeid < max_numa_nodeid
@@ -652,6 +657,23 @@ void numa_default_auto_assign_ram(MachineClass *mc, No=
deInfo *nodes,
     nodes[i].node_mem =3D size - usedmem;
 }
=20
+static void numa_init_memdev_container(MachineState *ms, MemoryRegion *ram=
)
+{
+    int i;
+    uint64_t addr =3D 0;
+
+    for (i =3D 0; i < ms->numa_state->num_nodes; i++) {
+        uint64_t size =3D ms->numa_state->nodes[i].node_mem;
+        HostMemoryBackend *backend =3D ms->numa_state->nodes[i].node_memde=
v;
+        if (!backend) {
+            continue;
+        }
+        MemoryRegion *seg =3D machine_consume_memdev(ms, backend);
+        memory_region_add_subregion(ram, addr, seg);
+        addr +=3D size;
+    }
+}
+
 void numa_complete_configuration(MachineState *ms)
 {
     int i;
@@ -734,6 +756,12 @@ void numa_complete_configuration(MachineState *ms)
             exit(1);
         }
=20
+        if (!numa_uses_legacy_mem() && mc->default_ram_id) {
+            ms->ram =3D g_new(MemoryRegion, 1);
+            memory_region_init(ms->ram, OBJECT(ms), mc->default_ram_id,
+                               ram_size);
+            numa_init_memdev_container(ms, ms->ram);
+        }
         /* QEMU needs at least all unique node pair distances to build
          * the whole NUMA distance table. QEMU treats the distance table
          * as symmetric by default, i.e. distance A->B =3D=3D distance B->=
A.
@@ -800,27 +828,16 @@ void memory_region_allocate_system_memory(MemoryRegio=
n *mr, Object *owner,
                                           const char *name,
                                           uint64_t ram_size)
 {
-    uint64_t addr =3D 0;
-    int i;
     MachineState *ms =3D MACHINE(qdev_get_machine());
=20
     if (ms->numa_state =3D=3D NULL ||
-        ms->numa_state->num_nodes =3D=3D 0 || !have_memdevs) {
+        ms->numa_state->num_nodes =3D=3D 0 || numa_uses_legacy_mem()) {
         allocate_system_memory_nonnuma(mr, owner, name, ram_size);
         return;
     }
=20
     memory_region_init(mr, owner, name, ram_size);
-    for (i =3D 0; i < ms->numa_state->num_nodes; i++) {
-        uint64_t size =3D ms->numa_state->nodes[i].node_mem;
-        HostMemoryBackend *backend =3D ms->numa_state->nodes[i].node_memde=
v;
-        if (!backend) {
-            continue;
-        }
-        MemoryRegion *seg =3D machine_consume_memdev(ms, backend);
-        memory_region_add_subregion(mr, addr, seg);
-        addr +=3D size;
-    }
+    numa_init_memdev_container(ms, mr);
 }
=20
 static void numa_stat_memory_devices(NumaNodeMem node_mem[])
diff --git a/vl.c b/vl.c
index 4dc4803611..2103804c52 100644
--- a/vl.c
+++ b/vl.c
@@ -4290,7 +4290,7 @@ int main(int argc, char **argv, char **envp)
     parse_numa_opts(current_machine);
=20
     if (machine_class->default_ram_id && current_machine->ram_size &&
-        !current_machine->ram_memdev_id) {
+        numa_uses_legacy_mem() && !current_machine->ram_memdev_id) {
         create_default_memdev(current_machine, mem_path, mem_prealloc);
     }
     /* do monitor/qmp handling at preconfig state if requested */
--=20
2.18.1


