Return-Path: <SRS0=wUMn=VC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E29C5B57D
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 22:34:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3820F2133F
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jul 2019 22:34:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3820F2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hjWmH-0007MF-6W
	for qemu-devel@archiver.kernel.org; Fri, 05 Jul 2019 18:34:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55176)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <ehabkost@redhat.com>) id 1hjWV6-00081T-Sr
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:16:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <ehabkost@redhat.com>) id 1hjWV5-0003hw-0X
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:16:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38692)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1hjWV4-0003hi-Oy
 for qemu-devel@nongnu.org; Fri, 05 Jul 2019 18:16:14 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 41004C057E9F;
 Fri,  5 Jul 2019 22:16:13 +0000 (UTC)
Received: from localhost (ovpn-116-30.gru2.redhat.com [10.97.116.30])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 92E2818A49;
 Fri,  5 Jul 2019 22:16:12 +0000 (UTC)
From: Eduardo Habkost <ehabkost@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Date: Fri,  5 Jul 2019 19:14:49 -0300
Message-Id: <20190705221504.25166-28-ehabkost@redhat.com>
In-Reply-To: <20190705221504.25166-1-ehabkost@redhat.com>
References: <20190705221504.25166-1-ehabkost@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 05 Jul 2019 22:16:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL v6 27/42] machine: Refactor smp_parse() in vl.c
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
Cc: Like Xu <like.xu@linux.intel.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Like Xu <like.xu@linux.intel.com>

To make smp_parse() more flexible and expansive, a smp_parse function
pointer is added to MachineClass that machine types could override.

The generic smp_parse() code in vl.c is moved to hw/core/machine.c, and
become the default implementation of MachineClass::smp_parse. A PC-specific
function called pc_smp_parse() has been added to hw/i386/pc.c, which in
this patch changes nothing against the default one .

Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Like Xu <like.xu@linux.intel.com>
Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
Message-Id: <20190620054525.37188-3-like.xu@linux.intel.com>
Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
---
 include/hw/boards.h  |  5 +++
 include/hw/i386/pc.h |  1 +
 hw/core/machine.c    | 76 ++++++++++++++++++++++++++++++++++++++++++
 hw/i386/pc.c         | 79 ++++++++++++++++++++++++++++++++++++++++++++
 vl.c                 | 75 ++---------------------------------------
 5 files changed, 163 insertions(+), 73 deletions(-)

diff --git a/include/hw/boards.h b/include/hw/boards.h
index ae7a542511..a71d1a53a5 100644
--- a/include/hw/boards.h
+++ b/include/hw/boards.h
@@ -162,6 +162,10 @@ typedef struct {
  *    computed based on other criteria such as the host kernel capabilities.
  * @numa_mem_supported:
  *    true if '--numa node.mem' option is supported and false otherwise
+ * @smp_parse:
+ *    The function pointer to hook different machine specific functions for
+ *    parsing "smp-opts" from QemuOpts to MachineState::CpuTopology and more
+ *    machine specific topology fields, such as smp_dies for PCMachine.
  */
 struct MachineClass {
     /*< private >*/
@@ -178,6 +182,7 @@ struct MachineClass {
     void (*reset)(MachineState *state);
     void (*hot_add_cpu)(MachineState *state, const int64_t id, Error **errp);
     int (*kvm_type)(MachineState *machine, const char *arg);
+    void (*smp_parse)(MachineState *ms, QemuOpts *opts);
 
     BlockInterfaceType block_default_type;
     int units_per_default_bus;
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index e56c1a39cb..0fa3e3beeb 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -192,6 +192,7 @@ void pc_acpi_smi_interrupt(void *opaque, int irq, int level);
 
 void pc_cpus_init(PCMachineState *pcms);
 void pc_hot_add_cpu(MachineState *ms, const int64_t id, Error **errp);
+void pc_smp_parse(MachineState *ms, QemuOpts *opts);
 
 void pc_guest_info_init(PCMachineState *pcms);
 
diff --git a/hw/core/machine.c b/hw/core/machine.c
index b35dea05bd..2be19ec0cd 100644
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
@@ -726,6 +729,78 @@ void machine_set_cpu_numa_node(MachineState *machine,
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
@@ -733,6 +808,7 @@ static void machine_class_init(ObjectClass *oc, void *data)
     /* Default 128 MB as guest ram size */
     mc->default_ram_size = 128 * MiB;
     mc->rom_file_has_mr = true;
+    mc->smp_parse = smp_parse;
 
     /* numa node memory size aligned on 8MB by default.
      * On Linux, each node's border has to be 8MB aligned
diff --git a/hw/i386/pc.c b/hw/i386/pc.c
index 14f7b4532e..894084c4e1 100644
--- a/hw/i386/pc.c
+++ b/hw/i386/pc.c
@@ -81,6 +81,8 @@
 #include "standard-headers/asm-x86/bootparam.h"
 #include "hw/virtio/virtio-pmem-pci.h"
 #include "hw/mem/memory-device.h"
+#include "sysemu/replay.h"
+#include "qapi/qmp/qerror.h"
 
 /* debug PC/ISA interrupts */
 //#define DEBUG_IRQ
@@ -1532,6 +1534,82 @@ static void pc_new_cpu(PCMachineState *pcms, int64_t apic_id, Error **errp)
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
     PCMachineState *pcms = PC_MACHINE(ms);
@@ -2846,6 +2924,7 @@ static void pc_machine_class_init(ObjectClass *oc, void *data)
     mc->has_hotpluggable_cpus = true;
     mc->default_boot_order = "cad";
     mc->hot_add_cpu = pc_hot_add_cpu;
+    mc->smp_parse = pc_smp_parse;
     mc->block_default_type = IF_IDE;
     mc->max_cpus = 255;
     mc->reset = pc_machine_reset;
diff --git a/vl.c b/vl.c
index 56aa221385..96d2456f70 100644
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
@@ -4014,7 +3942,8 @@ int main(int argc, char **argv, char **envp)
     current_machine->smp.cores = 1;
     current_machine->smp.threads = 1;
 
-    smp_parse(qemu_opts_find(qemu_find_opts("smp-opts"), NULL));
+    machine_class->smp_parse(current_machine,
+        qemu_opts_find(qemu_find_opts("smp-opts"), NULL));
 
     /* sanity-check smp_cpus and max_cpus against machine_class */
     if (current_machine->smp.cpus < machine_class->min_cpus) {
-- 
2.18.0.rc1.1.g3f1ff2140


