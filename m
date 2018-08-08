Received: from eggs.gnu.org ([2001:4830:134:3::10]:51497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fnQC1-0005sL-TB
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:16:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fnQBv-0002hR-SJ
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:16:09 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42908 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fnQBv-0002hH-LW
	for qemu-devel@nongnu.org; Wed, 08 Aug 2018 11:16:03 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 44A9A40216E7
	for <qemu-devel@nongnu.org>; Wed,  8 Aug 2018 15:16:03 +0000 (UTC)
From: Igor Mammedov <imammedo@redhat.com>
Date: Wed,  8 Aug 2018 17:15:49 +0200
Message-Id: <1533741349-199141-5-git-send-email-imammedo@redhat.com>
In-Reply-To: <1533741349-199141-1-git-send-email-imammedo@redhat.com>
References: <1533741349-199141-1-git-send-email-imammedo@redhat.com>
Subject: [Qemu-devel] [RFC PATCH 4/4] acpi: add support for CST update
 notification
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>

Reuse cpu hotplug inotification interface to notify guest about CST change.

Signed-off-by: Igor Mammedov <imammedo@redhat.com>
---
 include/hw/acpi/cpu.h           |  1 +
 docs/specs/acpi_cpu_hotplug.txt | 11 ++++++++---
 hw/acpi/cpu.c                   | 27 ++++++++++++++++++++++++++-
 3 files changed, 35 insertions(+), 4 deletions(-)

diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index eb79cbf..51d7fc6 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -28,6 +28,7 @@ typedef struct AcpiCpuStatus {
     uint64_t arch_id;
     bool is_inserting;
     bool is_removing;
+    bool is_cst_update;
     uint32_t ost_event;
     uint32_t ost_status;
     AcpiCState cst;
diff --git a/docs/specs/acpi_cpu_hotplug.txt b/docs/specs/acpi_cpu_hotplug.txt
index adfb026..41ba236 100644
--- a/docs/specs/acpi_cpu_hotplug.txt
+++ b/docs/specs/acpi_cpu_hotplug.txt
@@ -41,7 +41,10 @@ read access:
               It's valid only when bit 0 is set.
            2: Device remove event, used to distinguish device for which
               no device eject request to OSPM was issued.
-           3-7: reserved and should be ignored by OSPM
+           3: reserved and should be ignored by OSPM
+           4: Device CST event, used to distinguish device for which
+              device eject request to OSPM was issued
+           5-7: reserved and should be ignored by OSPM
     [0x5-0x7] reserved
     [0x8] Command data: (DWORD access)
           in case of error or unsupported command reads is 0xFFFFFFFF
@@ -70,14 +73,16 @@ write access:
                selected CPU device
             3: if set to 1 initiates device eject, set by OSPM when it
                triggers CPU device removal and calls _EJ0 method
+            4: if set to 1 clears CST update event, set by OSPM
+               after it has emitted CST update notification
             4-7: reserved, OSPM must clear them before writing to register
     [0x5] Command field: (1 byte access)
           value:
-            0: selects a CPU device with inserting/removing events and
+            0: selects a CPU device with inserting/removing/cst events and
                following reads from 'Command data' register return
                selected CPU (CPU selector value). If no CPU with events
                found, the current CPU selector doesn't change and
-               corresponding insert/remove event flags are not set.
+               corresponding insert/remove/cst event flags are not set.
             1: following writes to 'Command data' register set OST event
                register in QEMU
             2: following writes to 'Command data' register set OST status
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index 7ef04f9..c4a9fac 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -67,6 +67,7 @@ static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr, unsigned size)
         val |= cdev->cpu ? 1 : 0;
         val |= cdev->is_inserting ? 2 : 0;
         val |= cdev->is_removing  ? 4 : 0;
+        val |= cdev->is_cst_update ? 16 : 0;
         trace_cpuhp_acpi_read_flags(cpu_st->selector, val);
         break;
     case ACPI_CPU_CMD_DATA_OFFSET_RW:
@@ -162,6 +163,8 @@ static void cpu_hotplug_wr(void *opaque, hwaddr addr, uint64_t data,
             dev = DEVICE(cdev->cpu);
             hotplug_ctrl = qdev_get_hotplug_handler(dev);
             hotplug_handler_unplug(hotplug_ctrl, dev, NULL);
+        } else if (data & 16) { /* clear CST update event */
+            cdev->is_cst_update = false;
         }
         break;
     case ACPI_CPU_CMD_OFFSET_WR:
@@ -312,6 +315,7 @@ static const VMStateDescription vmstate_cstate_sts = {
         VMSTATE_UINT32(cst.current_cst_field, AcpiCpuStatus),
         VMSTATE_UINT32(cst.latency, AcpiCpuStatus),
         VMSTATE_UINT32(cst.power, AcpiCpuStatus),
+        VMSTATE_BOOL(is_cst_update, AcpiCpuStatus),
         VMSTATE_END_OF_LIST()
     }
 };
@@ -383,6 +387,7 @@ const VMStateDescription vmstate_cpu_hotplug = {
 #define CPU_INSERT_EVENT  "CINS"
 #define CPU_REMOVE_EVENT  "CRMV"
 #define CPU_EJECT_EVENT   "CEJ0"
+#define CPU_CST_EVENT     "CSTU"
 
 void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
                     hwaddr io_base,
@@ -435,7 +440,13 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
         aml_append(field, aml_named_field(CPU_REMOVE_EVENT, 1));
         /* initiates device eject, write only */
         aml_append(field, aml_named_field(CPU_EJECT_EVENT, 1));
-        aml_append(field, aml_reserved_field(4));
+        if (opts.cstate_enabled) {
+            /* (read) 1 if has a CST event. (write) 1 to clear event */
+            aml_append(field, aml_named_field(CPU_CST_EVENT, 1));
+            aml_append(field, aml_reserved_field(3));
+        } else {
+            aml_append(field, aml_reserved_field(4));
+        }
         aml_append(field, aml_named_field(CPU_COMMAND, 8));
         aml_append(cpu_ctrl_dev, field);
 
@@ -470,6 +481,7 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
         Aml *ins_evt = aml_name("%s.%s", cphp_res_path, CPU_INSERT_EVENT);
         Aml *rm_evt = aml_name("%s.%s", cphp_res_path, CPU_REMOVE_EVENT);
         Aml *ej_evt = aml_name("%s.%s", cphp_res_path, CPU_EJECT_EVENT);
+        Aml *cst_evt = aml_name("%s.%s", cphp_res_path, CPU_CST_EVENT);
 
         aml_append(cpus_dev, aml_name_decl("_HID", aml_string("ACPI0010")));
         aml_append(cpus_dev, aml_name_decl("_CID", aml_eisaid("PNP0A05")));
@@ -524,6 +536,7 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
             Aml *has_event = aml_local(0);
             Aml *dev_chk = aml_int(1);
             Aml *eject_req = aml_int(3);
+            Aml *cst_upd = aml_int(0x81);
             Aml *next_cpu_cmd = aml_int(CPHP_GET_NEXT_CPU_WITH_EVENT_CMD);
 
             aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
@@ -553,6 +566,18 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
                  }
                  aml_append(else_ctx, ifctx);
                  aml_append(while_ctx, else_ctx);
+                 if (opts.cstate_enabled == true) {
+                    else_ctx = aml_else();
+                    ifctx = aml_if(aml_equal(cst_evt, one));
+                    {
+                        aml_append(ifctx,
+                            aml_call2(CPU_NOTIFY_METHOD, cpu_data, cst_upd));
+                        aml_append(ifctx, aml_store(one, cst_evt));
+                        aml_append(ifctx, aml_store(one, has_event));
+                    }
+                    aml_append(else_ctx, ifctx);
+                    aml_append(while_ctx, else_ctx);
+                 }
             }
             aml_append(method, while_ctx);
             aml_append(method, aml_release(ctrl_lock));
-- 
2.7.4
