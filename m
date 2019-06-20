Return-Path: <SRS0=JMAk=UT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7C8C43613
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 05:52:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F8B1208CB
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2019 05:52:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F8B1208CB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43838 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdpzO-0007rC-GN
	for qemu-devel@archiver.kernel.org; Thu, 20 Jun 2019 01:52:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56191)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <like.xu@linux.intel.com>) id 1hdpvf-0005yP-1I
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 01:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <like.xu@linux.intel.com>) id 1hdpvc-0001q4-VF
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 01:48:10 -0400
Received: from mga05.intel.com ([192.55.52.43]:20329)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <like.xu@linux.intel.com>)
 id 1hdpvc-0001jz-K7
 for qemu-devel@nongnu.org; Thu, 20 Jun 2019 01:48:08 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
 by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384;
 19 Jun 2019 22:48:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,395,1557212400"; d="scan'208";a="162243107"
Received: from unknown (HELO likexu-E5-2699-v4.sh.intel.com) ([10.239.48.178])
 by fmsmga007.fm.intel.com with ESMTP; 19 Jun 2019 22:47:59 -0700
From: Like Xu <like.xu@linux.intel.com>
To: qemu-devel@nongnu.org,
	Eduardo Habkost <ehabkost@redhat.com>
Date: Thu, 20 Jun 2019 13:45:24 +0800
Message-Id: <20190620054525.37188-3-like.xu@linux.intel.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190620054525.37188-1-like.xu@linux.intel.com>
References: <20190620054525.37188-1-like.xu@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 192.55.52.43
Subject: [Qemu-devel] [PATCH v4 2/3] machine: Refactor smp_parse() in vl.c
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
Cc: like.xu@intel.com, Marcelo Tosatti <mtosatti@redhat.com>
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
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
---
 hw/core/machine.c    | 76 ++++++++++++++++++++++++++++++++++++++++++
 hw/i386/pc.c         | 79 ++++++++++++++++++++++++++++++++++++++++++++
 include/hw/boards.h  |  5 +++
 include/hw/i386/pc.h |  1 +
 vl.c                 | 75 ++---------------------------------------
 5 files changed, 163 insertions(+), 73 deletions(-)

diff --git a/hw/core/machine.c b/hw/core/machine.c
index 8b8d263afe..36a838f1cb 100644
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
@@ -728,6 +731,78 @@ void machine_set_cpu_numa_node(MachineState *machine,
     }
 }
 
+static void smp_parse(MachineState *ms, QemuOpts *opts)
+{
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
@@ -735,6 +810,7 @@ static void machine_class_init(ObjectClass *oc, void *data)
     /* Default 128 MB as guest ram size */
     mc->default_ram_size = 128 * MiB;
     mc->rom_file_has_mr = true;
+    mc->smp_parse = smp_parse;
 
     /* numa node memory size aligned on 8MB by default.
      * On Linux, each node's border has to be 8MB aligned
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 7b8c9caed6..092bd10d4d 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -79,6 +79,8 @@
 #include "hw/i386/intel_iommu.h"
 #include "hw/net/ne2000-isa.h"
 #include "standard-headers/asm-x86/bootparam.h"
+#include "sysemu/replay.h"
+#include "qapi/qmp/qerror.h"
 
 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ
@@ -1540,6 +1542,82 @@ static void pc_new_cpu(PCMachineState *pcms, int64_t apic_id, Error **errp)
     error_propagate(errp, local_err);
 }
 
+/*
+ * This function is very similar to smp_parse()
+ * in hw/core/machine.c but includes CPU die support.
+ */
+void pc_smp_parse(MachineState *ms, QemuOpts *opts)
+{
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
@@ -2780,6 +2858,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->has_hotpluggable_cpus = true;
     mc->default_boot_order = "cad";
     mc->hot_add_cpu = pc_hot_add_cpu;
+    mc->smp_parse = pc_smp_parse;
     mc->block_default_type = IF_IDE;
     mc->max_cpus = 255;
     mc->reset = pc_machine_reset;
diff --git a/include/hw/boards.h b/include/hw/boards.h
index 04f52c1335..6dd0761562 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -159,6 +159,10 @@ typedef struct {
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
@@ -175,6 +179,7 @@ struct MachineClass {
     void (*reset)(MachineState *state);
     void (*hot_add_cpu)(MachineState *state, const int64_t id, Error **errp);
     int (*kvm_type)(MachineState *machine, const char *arg);
+    void (*smp_parse)(MachineState *ms, QemuOpts *opts);
 
     BlockInterfaceType block_default_type;
     int units_per_default_bus;
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index 2ae86e202d..e96e449cef 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -189,6 +189,7 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
 
 void pc_cpus_init(PCMachineState *pcms);
 void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp);
+void pc_smp_parse(MachineState *ms, QemuOpts *opts);
 
 void pc_guest_info_init(PCMachineState *pcms);
 
diff --git a/vl.c b/vl.c
index 96f4dd828b..9218a718f3 100644
--- a/vl.c
+++ b/vl.c
@@ -1247,78 +1247,6 @@ static QemuOptsList qemu_smp_opts = {
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
@@ -4059,7 +3987,8 @@ int main(int argc, char **argv, char **envp)
     current_machine->smp.cores = 1;
     current_machine->smp.threads = 1;
 
-    smp_parse(qemu_opts_find(qemu_find_opts("smp-opts"), NULL));
+    machine_class->smp_parse(current_machine,
+        qemu_opts_find(qemu_find_opts("smp-opts"), NULL));
 
     /* sanity-check smp_cpus and max_cpus against machine_class */
     if (current_machine->smp.cpus < machine_class->min_cpus) {
-- 
2.21.0


