Return-Path: <SRS0=XH1q=UL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DF38C31E46
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 08:49:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08779206E0
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2019 08:49:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08779206E0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57634 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haywO-0005b4-Hz
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 04:49:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57801)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <like.xu@linux.intel.com>) id 1hayrq-00039n-GX
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:44:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <like.xu@linux.intel.com>) id 1hayrk-0006G7-4n
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:44:26 -0400
Received: from mga11.intel.com ([192.55.52.93]:10698)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
 id 1hayrj-0005un-PA
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 04:44:20 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
 by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 12 Jun 2019 01:43:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,363,1557212400"; d="scan'208";a="184175093"
Received: from likexu-e5-2699-v4.sh.intel.com ([10.239.48.178])
 by fmsmga002.fm.intel.com with ESMTP; 12 Jun 2019 01:43:34 -0700
From: Like Xu <like.xu@linux.intel.com>
To: qemu-devel@nongnu.org,
	Eduardo Habkost <ehabkost@redhat.com>
Date: Wed, 12 Jun 2019 16:41:03 +0800
Message-Id: <20190612084104.34984-9-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190612084104.34984-1-like.xu@linux.intel.com>
References: <20190612084104.34984-1-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.93
Subject: [Qemu-devel] [PATCH v3 8/9] machine: Refactor smp_parse() in vl.c
 as MachineClass::smp_parse()
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, like.xu@linux.intel.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

To make smp_parse() more flexible and expansive, a smp_parse function
pointer is added to MachineClass that machine types could override.

The generic smp_parse() code in vl.c is moved to hw/core/machine.c, and
become the default implementation of MachineClass::smp_parse. A PC-specific
function called pc_smp_parse() has been added to hw/i386/pc.c, which in
this patch changes nothing against the default one .

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
---
 hw/core/machine.c    | 77 ++++++++++++++++++++++++++++++++++++++++++++
 hw/i386/pc.c         | 76 +++++++++++++++++++++++++++++++++++++++++++
 include/hw/boards.h  |  5 +++
 include/hw/i386/pc.h |  1 +
 vl.c                 | 75 ++----------------------------------------
 5 files changed, 161 insertions(+), 73 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 9eeba448ed..d58a684abf 100644
--- a/hw/core/machine.c
+++ b/hw/core/machine.c
@@ -11,6 +11,9 @@
  */
 
 #include "qemu/osdep.h"
+#include "qemu/option.h"
+#include "qapi/qmp/qerror.h"
+#include "sysemu/replay.h"
 #include "qemu/units.h"
 #include "hw/boards.h"
 #include "qapi/error.h"
@@ -722,6 +725,79 @@ void machine_set_cpu_numa_node(MachineState *machine,
     }
 }
 
+static void smp_parse(MachineState *ms, QemuOpts *opts)
+{
+    /* copy it from legacy smp_parse() in vl.c */
+    if (opts) {
+        unsigned cpus    = qemu_opt_get_number(opts, "cpus", 0);
+        unsigned sockets = qemu_opt_get_number(opts, "sockets", 0);
+        unsigned cores   = qemu_opt_get_number(opts, "cores", 0);
+        unsigned threads = qemu_opt_get_number(opts, "threads", 0);
+
+        /* compute missing values, prefer sockets over cores over threads */
+        if (cpus == 0 || sockets == 0) {
+            cores = cores > 0 ? cores : 1;
+            threads = threads > 0 ? threads : 1;
+            if (cpus == 0) {
+                sockets = sockets > 0 ? sockets : 1;
+                cpus = cores * threads * sockets;
+            } else {
+                ms->smp.max_cpus =
+                        qemu_opt_get_number(opts, "maxcpus", cpus);
+                sockets = ms->smp.max_cpus / (cores * threads);
+            }
+        } else if (cores == 0) {
+            threads = threads > 0 ? threads : 1;
+            cores = cpus / (sockets * threads);
+            cores = cores > 0 ? cores : 1;
+        } else if (threads == 0) {
+            threads = cpus / (cores * sockets);
+            threads = threads > 0 ? threads : 1;
+        } else if (sockets * cores * threads < cpus) {
+            error_report("cpu topology: "
+                         "sockets (%u) * cores (%u) * threads (%u) < "
+                         "smp_cpus (%u)",
+                         sockets, cores, threads, cpus);
+            exit(1);
+        }
+
+        ms->smp.max_cpus =
+                qemu_opt_get_number(opts, "maxcpus", cpus);
+
+        if (ms->smp.max_cpus < cpus) {
+            error_report("maxcpus must be equal to or greater than smp");
+            exit(1);
+        }
+
+        if (sockets * cores * threads > ms->smp.max_cpus) {
+            error_report("cpu topology: "
+                         "sockets (%u) * cores (%u) * threads (%u) > "
+                         "maxcpus (%u)",
+                         sockets, cores, threads,
+                         ms->smp.max_cpus);
+            exit(1);
+        }
+
+        if (sockets * cores * threads != ms->smp.max_cpus) {
+            warn_report("Invalid CPU topology deprecated: "
+                        "sockets (%u) * cores (%u) * threads (%u) "
+                        "!= maxcpus (%u)",
+                        sockets, cores, threads,
+                        ms->smp.max_cpus);
+        }
+
+        ms->smp.cpus = cpus;
+        ms->smp.cores = cores;
+        ms->smp.threads = threads;
+    }
+
+    if (ms->smp.cpus > 1) {
+        Error *blocker = NULL;
+        error_setg(&blocker, QERR_REPLAY_NOT_SUPPORTED, "smp");
+        replay_add_blocker(blocker);
+    }
+}
+
 static void machine_class_init(ObjectClass *oc, void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -729,6 +805,7 @@ static void machine_class_init(ObjectClass *oc, void *data)
     /* Default 128 MB as guest ram size */
     mc->default_ram_size = 128 * MiB;
     mc->rom_file_has_mr = true;
+    mc->smp_parse = smp_parse;
 
     /* numa node memory size aligned on 8MB by default.
      * On Linux, each node's border has to be 8MB aligned
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index b4dbd1064d..63b44bd2bd 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -78,6 +78,8 @@
 #include "hw/i386/intel_iommu.h"
 #include "hw/net/ne2000-isa.h"
 #include "standard-headers/asm-x86/bootparam.h"
+#include "sysemu/replay.h"
+#include "qapi/qmp/qerror.h"
 
 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ
@@ -1539,6 +1541,79 @@ static void pc_new_cpu(PCMachineState *pcms, int64_t apic_id, Error **errp)
     error_propagate(errp, local_err);
 }
 
+void pc_smp_parse(MachineState *ms, QemuOpts *opts)
+{
+    /* copy it from legacy smp_parse() in vl.c */
+    if (opts) {
+        unsigned cpus    = qemu_opt_get_number(opts, "cpus", 0);
+        unsigned sockets = qemu_opt_get_number(opts, "sockets", 0);
+        unsigned cores   = qemu_opt_get_number(opts, "cores", 0);
+        unsigned threads = qemu_opt_get_number(opts, "threads", 0);
+
+        /* compute missing values, prefer sockets over cores over threads */
+        if (cpus == 0 || sockets == 0) {
+            cores = cores > 0 ? cores : 1;
+            threads = threads > 0 ? threads : 1;
+            if (cpus == 0) {
+                sockets = sockets > 0 ? sockets : 1;
+                cpus = cores * threads * sockets;
+            } else {
+                ms->smp.max_cpus =
+                        qemu_opt_get_number(opts, "maxcpus", cpus);
+                sockets = ms->smp.max_cpus / (cores * threads);
+            }
+        } else if (cores == 0) {
+            threads = threads > 0 ? threads : 1;
+            cores = cpus / (sockets * threads);
+            cores = cores > 0 ? cores : 1;
+        } else if (threads == 0) {
+            threads = cpus / (cores * sockets);
+            threads = threads > 0 ? threads : 1;
+        } else if (sockets * cores * threads < cpus) {
+            error_report("cpu topology: "
+                         "sockets (%u) * cores (%u) * threads (%u) < "
+                         "smp_cpus (%u)",
+                         sockets, cores, threads, cpus);
+            exit(1);
+        }
+
+        ms->smp.max_cpus =
+                qemu_opt_get_number(opts, "maxcpus", cpus);
+
+        if (ms->smp.max_cpus < cpus) {
+            error_report("maxcpus must be equal to or greater than smp");
+            exit(1);
+        }
+
+        if (sockets * cores * threads > ms->smp.max_cpus) {
+            error_report("cpu topology: "
+                         "sockets (%u) * cores (%u) * threads (%u) > "
+                         "maxcpus (%u)",
+                         sockets, cores, threads,
+                         ms->smp.max_cpus);
+            exit(1);
+        }
+
+        if (sockets * cores * threads != ms->smp.max_cpus) {
+            warn_report("Invalid CPU topology deprecated: "
+                        "sockets (%u) * cores (%u) * threads (%u) "
+                        "!= maxcpus (%u)",
+                        sockets, cores, threads,
+                        ms->smp.max_cpus);
+        }
+
+        ms->smp.cpus = cpus;
+        ms->smp.cores = cores;
+        ms->smp.threads = threads;
+    }
+
+    if (ms->smp.cpus > 1) {
+        Error *blocker = NULL;
+        error_setg(&blocker, QERR_REPLAY_NOT_SUPPORTED, "smp");
+        replay_add_blocker(blocker);
+    }
+}
+
 void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp)
 {
     int64_t apic_id = x86_cpu_apic_id_from_index(ms, id);
@@ -2779,6 +2854,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->has_hotpluggable_cpus = true;
     mc->default_boot_order = "cad";
     mc->hot_add_cpu = pc_hot_add_cpu;
+    mc->smp_parse = pc_smp_parse;
     mc->block_default_type = IF_IDE;
     mc->max_cpus = 255;
     mc->reset = pc_machine_reset;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 1e000229e1..c025f33407 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -158,6 +158,10 @@ typedef struct {
  * @kvm_type:
  *    Return the type of KVM corresponding to the kvm-type string option or
  *    computed based on other criteria such as the host kernel capabilities.
+ * @smp_parse:
+ *    The function pointer to hook different machine specific functions for
+ *    parsing "smp-opts" from QemuOpts to MachineState::CpuTopology and more
+ *    machine specific topology fields, such as smp_dies for PCMachine.
  */
 struct MachineClass {
     /*< private >*/
@@ -174,6 +178,7 @@ struct MachineClass {
     void (*reset)(MachineState *state);
     void (*hot_add_cpu)(MachineState *state, const int64_t id, Error **errp);
     int (*kvm_type)(MachineState *machine, const char *arg);
+    void (*smp_parse)(MachineState *ms, QemuOpts *opts);
 
     BlockInterfaceType block_default_type;
     int units_per_default_bus;
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index fae9217e34..7ca24746cc 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -189,6 +189,7 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
 
 void pc_cpus_init(PCMachineState *pcms);
 void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp);
+void pc_smp_parse(MachineState *ms, QemuOpts *opts);
 
 void pc_guest_info_init(PCMachineState *pcms);
 
diff --git a/vl.c b/vl.c
index 0760b2724e..53ea9b6d6f 100644
--- a/vl.c
+++ b/vl.c
@@ -1245,78 +1245,6 @@ static QemuOptsList qemu_smp_opts = {
     },
 };
 
-static void smp_parse(QemuOpts *opts)
-{
-    if (opts) {
-        unsigned cpus    = qemu_opt_get_number(opts, "cpus", 0);
-        unsigned sockets = qemu_opt_get_number(opts, "sockets", 0);
-        unsigned cores   = qemu_opt_get_number(opts, "cores", 0);
-        unsigned threads = qemu_opt_get_number(opts, "threads", 0);
-
-        /* compute missing values, prefer sockets over cores over threads */
-        if (cpus == 0 || sockets == 0) {
-            cores = cores > 0 ? cores : 1;
-            threads = threads > 0 ? threads : 1;
-            if (cpus == 0) {
-                sockets = sockets > 0 ? sockets : 1;
-                cpus = cores * threads * sockets;
-            } else {
-                current_machine->smp.max_cpus =
-                        qemu_opt_get_number(opts, "maxcpus", cpus);
-                sockets = current_machine->smp.max_cpus / (cores * threads);
-            }
-        } else if (cores == 0) {
-            threads = threads > 0 ? threads : 1;
-            cores = cpus / (sockets * threads);
-            cores = cores > 0 ? cores : 1;
-        } else if (threads == 0) {
-            threads = cpus / (cores * sockets);
-            threads = threads > 0 ? threads : 1;
-        } else if (sockets * cores * threads < cpus) {
-            error_report("cpu topology: "
-                         "sockets (%u) * cores (%u) * threads (%u) < "
-                         "smp_cpus (%u)",
-                         sockets, cores, threads, cpus);
-            exit(1);
-        }
-
-        current_machine->smp.max_cpus =
-                qemu_opt_get_number(opts, "maxcpus", cpus);
-
-        if (current_machine->smp.max_cpus < cpus) {
-            error_report("maxcpus must be equal to or greater than smp");
-            exit(1);
-        }
-
-        if (sockets * cores * threads > current_machine->smp.max_cpus) {
-            error_report("cpu topology: "
-                         "sockets (%u) * cores (%u) * threads (%u) > "
-                         "maxcpus (%u)",
-                         sockets, cores, threads,
-                         current_machine->smp.max_cpus);
-            exit(1);
-        }
-
-        if (sockets * cores * threads != current_machine->smp.max_cpus) {
-            warn_report("Invalid CPU topology deprecated: "
-                        "sockets (%u) * cores (%u) * threads (%u) "
-                        "!= maxcpus (%u)",
-                        sockets, cores, threads,
-                        current_machine->smp.max_cpus);
-        }
-
-        current_machine->smp.cpus = cpus;
-        current_machine->smp.cores = cores;
-        current_machine->smp.threads = threads;
-    }
-
-    if (current_machine->smp.cpus > 1) {
-        Error *blocker = NULL;
-        error_setg(&blocker, QERR_REPLAY_NOT_SUPPORTED, "smp");
-        replay_add_blocker(blocker);
-    }
-}
-
 static void realtime_init(void)
 {
     if (enable_mlock) {
@@ -4043,7 +3971,8 @@ int main(int argc, char **argv, char **envp)
     current_machine->smp.cores = 1;
     current_machine->smp.threads = 1;
 
-    smp_parse(qemu_opts_find(qemu_find_opts("smp-opts"), NULL));
+    machine_class->smp_parse(current_machine,
+        qemu_opts_find(qemu_find_opts("smp-opts"), NULL));
 
     /* sanity-check smp_cpus and max_cpus against machine_class */
     if (current_machine->smp.cpus < machine_class->min_cpus) {
-- 
2.21.0


