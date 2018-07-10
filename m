Received: from eggs.gnu.org ([2001:4830:134:3::10]:52604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fchmm-0005v2-2m
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 21:49:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fchmk-0006W8-AA
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 21:49:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54166 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1fchmk-0006Vx-4C
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 21:49:46 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A66DC818F049
	for <qemu-devel@nongnu.org>; Tue, 10 Jul 2018 01:49:45 +0000 (UTC)
Date: Tue, 10 Jul 2018 04:49:45 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180710014756.548217-1-mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180710000024.542612-1-mst@redhat.com>
Subject: [Qemu-devel] [PATCH hack dontapply v2 8/7 untested] acpi: support
 cst change notifications
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>, ehabkost@redhat.com, pbonzini@redhat.com

(Ab)use cpu hotplug event infrastructure to report per-CPU _CST change
events.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---

Untested infrastructure to notify about _CST changes.

 include/hw/acpi/cpu.h |  4 ++++
 hw/acpi/cpu.c         | 39 +++++++++++++++++++++++++++++++++++----
 hw/acpi/trace-events  |  3 ++-
 3 files changed, 41 insertions(+), 5 deletions(-)

diff --git a/include/hw/acpi/cpu.h b/include/hw/acpi/cpu.h
index 89ce172941..31e20c590b 100644
--- a/include/hw/acpi/cpu.h
+++ b/include/hw/acpi/cpu.h
@@ -22,6 +22,7 @@ typedef struct AcpiCpuStatus {
     uint64_t arch_id;
     bool is_inserting;
     bool is_removing;
+    bool is_cst_changing;
     uint32_t ost_event;
     uint32_t ost_status;
 } AcpiCpuStatus;
@@ -37,6 +38,9 @@ typedef struct CPUHotplugState {
 void acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
                       CPUHotplugState *cpu_st, DeviceState *dev, Error **errp);
 
+void acpi_cpu_change_cst(HotplugHandler *hotplug_dev,
+                         CPUHotplugState *cpu_st, DeviceState *dev, Error **errp);
+
 void acpi_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
                                 CPUHotplugState *cpu_st,
                                 DeviceState *dev, Error **errp);
diff --git a/hw/acpi/cpu.c b/hw/acpi/cpu.c
index e9e207b033..6dc0cfb901 100644
--- a/hw/acpi/cpu.c
+++ b/hw/acpi/cpu.c
@@ -66,6 +66,7 @@ static uint64_t cpu_hotplug_rd(void *opaque, hwaddr addr, unsigned size)
         val |= cdev->cpu ? 1 : 0;
         val |= cdev->is_inserting ? 2 : 0;
         val |= cdev->is_removing  ? 4 : 0;
+        val |= cdev->is_cst_changing  ? 0x10 : 0;
         trace_cpuhp_acpi_read_flags(cpu_st->selector, val);
         break;
     case ACPI_CPU_CMD_DATA_OFFSET_RW:
@@ -126,6 +127,9 @@ static void cpu_hotplug_wr(void *opaque, hwaddr addr, uint64_t data,
             dev = DEVICE(cdev->cpu);
             hotplug_ctrl = qdev_get_hotplug_handler(dev);
             hotplug_handler_unplug(hotplug_ctrl, dev, NULL);
+        } else if (data & 0x10) {
+            cdev->is_cst_changing = false;
+            trace_cpuhp_acpi_clear_cst_evt(cpu_st->selector);
         }
         break;
     case ACPI_CPU_CMD_OFFSET_WR:
@@ -137,10 +141,12 @@ static void cpu_hotplug_wr(void *opaque, hwaddr addr, uint64_t data,
 
                 do {
                     cdev = &cpu_st->devs[iter];
-                    if (cdev->is_inserting || cdev->is_removing) {
+                    if (cdev->is_inserting || cdev->is_removing ||
+                        cdev->is_cst_changing) {
                         cpu_st->selector = iter;
                         trace_cpuhp_acpi_cpu_has_events(cpu_st->selector,
-                            cdev->is_inserting, cdev->is_removing);
+                            cdev->is_inserting, cdev->is_removing,
+                            cdev->is_cst_changing);
                         break;
                     }
                     iter = iter + 1 < cpu_st->dev_count ? iter + 1 : 0;
@@ -237,6 +243,18 @@ void acpi_cpu_plug_cb(HotplugHandler *hotplug_dev,
     }
 }
 
+void acpi_cpu_change_cst(HotplugHandler *hotplug_dev,
+                         CPUHotplugState *cpu_st, DeviceState *dev, Error **errp)
+{
+    AcpiCpuStatus *cdev = get_cpu_status(cpu_st, dev);
+    if (!cdev) {
+        return;
+    }
+
+    cdev->is_cst_changing = true;
+    acpi_send_event(DEVICE(hotplug_dev), ACPI_CPU_HOTPLUG_STATUS);
+}
+
 void acpi_cpu_unplug_request_cb(HotplugHandler *hotplug_dev,
                                 CPUHotplugState *cpu_st,
                                 DeviceState *dev, Error **errp)
@@ -273,6 +291,7 @@ static const VMStateDescription vmstate_cpuhp_sts = {
     .fields      = (VMStateField[]) {
         VMSTATE_BOOL(is_inserting, AcpiCpuStatus),
         VMSTATE_BOOL(is_removing, AcpiCpuStatus),
+        VMSTATE_BOOL(is_cst_changing, AcpiCpuStatus),
         VMSTATE_UINT32(ost_event, AcpiCpuStatus),
         VMSTATE_UINT32(ost_status, AcpiCpuStatus),
         VMSTATE_END_OF_LIST()
@@ -309,6 +328,7 @@ const VMStateDescription vmstate_cpu_hotplug = {
 #define CPU_INSERT_EVENT  "CINS"
 #define CPU_REMOVE_EVENT  "CRMV"
 #define CPU_EJECT_EVENT   "CEJ0"
+#define CPU_CSTATE_EVENT  "CSTE"
 
 void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
                     hwaddr io_base,
@@ -361,7 +381,8 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
         aml_append(field, aml_named_field(CPU_REMOVE_EVENT, 1));
         /* initiates device eject, write only */
         aml_append(field, aml_named_field(CPU_EJECT_EVENT, 1));
-        aml_append(field, aml_reserved_field(4));
+        aml_append(field, aml_named_field(CPU_CSTATE_EVENT, 1));
+        aml_append(field, aml_reserved_field(3));
         aml_append(field, aml_named_field(CPU_COMMAND, 8));
         aml_append(cpu_ctrl_dev, field);
 
@@ -396,6 +417,7 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
         Aml *ins_evt = aml_name("%s.%s", cphp_res_path, CPU_INSERT_EVENT);
         Aml *rm_evt = aml_name("%s.%s", cphp_res_path, CPU_REMOVE_EVENT);
         Aml *ej_evt = aml_name("%s.%s", cphp_res_path, CPU_EJECT_EVENT);
+        Aml *cst_evt = aml_name("%s.%s", cphp_res_path, CPU_CSTATE_EVENT);
 
         aml_append(cpus_dev, aml_name_decl("_HID", aml_string("ACPI0010")));
         aml_append(cpus_dev, aml_name_decl("_CID", aml_eisaid("PNP0A05")));
@@ -450,17 +472,26 @@ void build_cpus_aml(Aml *table, MachineState *machine, CPUHotplugFeatures opts,
             Aml *has_event = aml_local(0);
             Aml *dev_chk = aml_int(1);
             Aml *eject_req = aml_int(3);
+            Aml *cst_changed = aml_int(0x81); /* Re-evaluate _CST: ACPI 2.0: 8.3.2 _CST (C States) */
             Aml *next_cpu_cmd = aml_int(CPHP_GET_NEXT_CPU_WITH_EVENT_CMD);
 
             aml_append(method, aml_acquire(ctrl_lock, 0xFFFF));
             aml_append(method, aml_store(one, has_event));
             while_ctx = aml_while(aml_equal(has_event, one));
             {
-                 /* clear loop exit condition, ins_evt/rm_evt checks
+                 /* clear loop exit condition, ins_evt/rm_evt/cst_evt checks
                   * will set it to 1 while next_cpu_cmd returns a CPU
                   * with events */
                  aml_append(while_ctx, aml_store(zero, has_event));
                  aml_append(while_ctx, aml_store(next_cpu_cmd, cpu_cmd));
+                 ifctx = aml_if(aml_equal(cst_evt, one));
+                 {
+                     aml_append(ifctx,
+                         aml_call2(CPU_NOTIFY_METHOD, cpu_data, cst_changed));
+                     aml_append(ifctx, aml_store(one, cst_evt));
+                     aml_append(ifctx, aml_store(one, has_event));
+                 }
+                 aml_append(while_ctx, ifctx);
                  ifctx = aml_if(aml_equal(ins_evt, one));
                  {
                      aml_append(ifctx,
diff --git a/hw/acpi/trace-events b/hw/acpi/trace-events
index df0024f8b2..d9ea0dc0e3 100644
--- a/hw/acpi/trace-events
+++ b/hw/acpi/trace-events
@@ -23,9 +23,10 @@ cpuhp_acpi_read_flags(uint32_t idx, uint8_t flags) "idx[0x%"PRIx32"] flags: 0x%"
 cpuhp_acpi_write_idx(uint32_t idx) "set active cpu idx: 0x%"PRIx32
 cpuhp_acpi_write_cmd(uint32_t idx, uint8_t cmd) "idx[0x%"PRIx32"] cmd: 0x%"PRIx8
 cpuhp_acpi_read_cmd_data(uint32_t idx, uint32_t data) "idx[0x%"PRIx32"] data: 0x%"PRIx32
-cpuhp_acpi_cpu_has_events(uint32_t idx, bool ins, bool rm) "idx[0x%"PRIx32"] inserting: %d, removing: %d"
+cpuhp_acpi_cpu_has_events(uint32_t idx, bool ins, bool rm, bool cst) "idx[0x%"PRIx32"] inserting: %d, removing: %d, cst: %d"
 cpuhp_acpi_clear_inserting_evt(uint32_t idx) "idx[0x%"PRIx32"]"
 cpuhp_acpi_clear_remove_evt(uint32_t idx) "idx[0x%"PRIx32"]"
+cpuhp_acpi_clear_cst_evt(uint32_t idx) "idx[0x%"PRIx32"]"
 cpuhp_acpi_ejecting_invalid_cpu(uint32_t idx) "0x%"PRIx32
 cpuhp_acpi_ejecting_cpu(uint32_t idx) "0x%"PRIx32
 cpuhp_acpi_write_ost_ev(uint32_t slot, uint32_t ev) "idx[0x%"PRIx32"] OST EVENT: 0x%"PRIx32
-- 
MST
