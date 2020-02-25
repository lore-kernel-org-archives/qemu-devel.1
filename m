Return-Path: <SRS0=OzdF=4N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B5FEC35DE1
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:58:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6862176D
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2020 11:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pejccUuq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6862176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Yqh-00046R-5R
	for qemu-devel@archiver.kernel.org; Tue, 25 Feb 2020 06:58:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49040)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6YkB-0000Ce-14
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1j6Yk7-0005TA-AS
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:18 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430]:37502)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1j6Yk4-0005L0-Gq
 for qemu-devel@nongnu.org; Tue, 25 Feb 2020 06:51:13 -0500
Received: by mail-wr1-x430.google.com with SMTP id l5so10125413wrx.4
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2020 03:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=as7CGWOWGXE57oU8YwvSX5tl4J+OWfioOgpjkUNxRR4=;
 b=pejccUuqch7mz3Bb7nAbh43mUgTX+f/KVn8mNPaHi35DrmZxxNU26Eq4/rqsfVFPVt
 BH6ww9Al2LTWyGLV3MFGmMB7j7rS9XIaiGxzlL04OC0kdTfNOUulyrHMz5TL+lE8hQwQ
 sKtEdArbJccXbOTC1U58tZtTBWHajj3TSBDRZnrCzVZOQ8WnYaC3W0p0QqMpR80VOrhy
 3c5EgJRfyEuAr3mkeZfF4I3gl0M2MPKsY0q9gkesSMRb8i8KD9xkjHP8csb/22aey3wM
 NCCstCK/4DyQyKZ7Zk3Wxv+ezQo2MQLww8dKFCudC04BvQ47V87oChiwGFjJrKhziLp/
 h2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=as7CGWOWGXE57oU8YwvSX5tl4J+OWfioOgpjkUNxRR4=;
 b=njJQqdq46M6WW4UI2MKpm3WsQ94IVi5/kuNlJu+n8K93K6dFS9WCl5fjZokCyYsKCl
 vALAR5chrtvTzZGiceqMYUSgFOuF4ulb/qfQqB4q6vo1nKEI+8EPK27iW0kfKt7jm6jY
 AlSQutHosOCQ0W5LO85uD/Cz/C67euZTQIp5OjJ33+0SZ2uC8LsFnsaP/uEbVX2TJ+rw
 pouF2wamM14kdBAPVKtD3x957pFiejjQqjSYvrmA7Q34KyBc3AR9PcvN00UpnwV6+JUF
 z1CdKpnJgaNw7nUcAhrw+OwITtA/C4tU55lI0WtxDjev06Yg7iyp6rLXvnjoWK4oSLB1
 QHRg==
X-Gm-Message-State: APjAAAVzCfvBrGW+cRDE7cFDrqcPinrsuvq80fRkRNEdKa8Z761RLIb4
 3kePuihL9j7n9OGdm/eMfM4ubwwS
X-Google-Smtp-Source: APXvYqzW/mqv3y5cBqX72KjIFKL77vw9o+UOqKwP2MwBNvvz0F/pi8RJeecRRk2SJlDrobBuJUy4aA==
X-Received: by 2002:adf:f586:: with SMTP id f6mr69861127wro.46.1582631471210; 
 Tue, 25 Feb 2020 03:51:11 -0800 (PST)
Received: from 640k.localdomain ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id b67sm3922326wmc.38.2020.02.25.03.51.10
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 25 Feb 2020 03:51:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 005/136] initialize MachineState::ram in NUMA case
Date: Tue, 25 Feb 2020 12:48:55 +0100
Message-Id: <1582631466-13880-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
References: <1582631466-13880-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::430
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
Message-Id: <20200219160953.13771-6-imammedo@redhat.com>
---
 hw/core/numa.c        | 43 ++++++++++++++++++++++++++++++-------------
 include/sysemu/numa.h |  1 +
 vl.c                  |  2 +-
 3 files changed, 32 insertions(+), 14 deletions(-)

diff --git a/hw/core/numa.c b/hw/core/numa.c
index 8264336..e6baf2c 100644
--- a/hw/core/numa.c
+++ b/hw/core/numa.c
@@ -52,6 +52,11 @@ QemuOptsList qemu_numa_opts = {
 };
 
 static int have_memdevs;
+bool numa_uses_legacy_mem(void)
+{
+    return !have_memdevs;
+}
+
 static int have_mem;
 static int max_numa_nodeid; /* Highest specified NUMA node ID, plus one.
                              * For all nodes, nodeid < max_numa_nodeid
@@ -652,6 +657,23 @@ void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
     nodes[i].node_mem = size - usedmem;
 }
 
+static void numa_init_memdev_container(MachineState *ms, MemoryRegion *ram)
+{
+    int i;
+    uint64_t addr = 0;
+
+    for (i = 0; i < ms->numa_state->num_nodes; i++) {
+        uint64_t size = ms->numa_state->nodes[i].node_mem;
+        HostMemoryBackend *backend = ms->numa_state->nodes[i].node_memdev;
+        if (!backend) {
+            continue;
+        }
+        MemoryRegion *seg = machine_consume_memdev(ms, backend);
+        memory_region_add_subregion(ram, addr, seg);
+        addr += size;
+    }
+}
+
 void numa_complete_configuration(MachineState *ms)
 {
     int i;
@@ -734,6 +756,12 @@ void numa_complete_configuration(MachineState *ms)
             exit(1);
         }
 
+        if (!numa_uses_legacy_mem() && mc->default_ram_id) {
+            ms->ram = g_new(MemoryRegion, 1);
+            memory_region_init(ms->ram, OBJECT(ms), mc->default_ram_id,
+                               ram_size);
+            numa_init_memdev_container(ms, ms->ram);
+        }
         /* QEMU needs at least all unique node pair distances to build
          * the whole NUMA distance table. QEMU treats the distance table
          * as symmetric by default, i.e. distance A->B == distance B->A.
@@ -800,27 +828,16 @@ void memory_region_allocate_system_memory(MemoryRegion *mr, Object *owner,
                                           const char *name,
                                           uint64_t ram_size)
 {
-    uint64_t addr = 0;
-    int i;
     MachineState *ms = MACHINE(qdev_get_machine());
 
     if (ms->numa_state == NULL ||
-        ms->numa_state->num_nodes == 0 || !have_memdevs) {
+        ms->numa_state->num_nodes == 0 || numa_uses_legacy_mem()) {
         allocate_system_memory_nonnuma(mr, owner, name, ram_size);
         return;
     }
 
     memory_region_init(mr, owner, name, ram_size);
-    for (i = 0; i < ms->numa_state->num_nodes; i++) {
-        uint64_t size = ms->numa_state->nodes[i].node_mem;
-        HostMemoryBackend *backend = ms->numa_state->nodes[i].node_memdev;
-        if (!backend) {
-            continue;
-        }
-        MemoryRegion *seg = machine_consume_memdev(ms, backend);
-        memory_region_add_subregion(mr, addr, seg);
-        addr += size;
-    }
+    numa_init_memdev_container(ms, mr);
 }
 
 static void numa_stat_memory_devices(NumaNodeMem node_mem[])
diff --git a/include/sysemu/numa.h b/include/sysemu/numa.h
index ba693cc..ad58ee8 100644
--- a/include/sysemu/numa.h
+++ b/include/sysemu/numa.h
@@ -112,5 +112,6 @@ void numa_default_auto_assign_ram(MachineClass *mc, NodeInfo *nodes,
                                   int nb_nodes, ram_addr_t size);
 void numa_cpu_pre_plug(const struct CPUArchId *slot, DeviceState *dev,
                        Error **errp);
+bool numa_uses_legacy_mem(void);
 
 #endif
diff --git a/vl.c b/vl.c
index 4dc4803..2103804 100644
--- a/vl.c
+++ b/vl.c
@@ -4290,7 +4290,7 @@ int main(int argc, char **argv, char **envp)
     parse_numa_opts(current_machine);
 
     if (machine_class->default_ram_id && current_machine->ram_size &&
-        !current_machine->ram_memdev_id) {
+        numa_uses_legacy_mem() && !current_machine->ram_memdev_id) {
         create_default_memdev(current_machine, mem_path, mem_prealloc);
     }
     /* do monitor/qmp handling at preconfig state if requested */
-- 
1.8.3.1



