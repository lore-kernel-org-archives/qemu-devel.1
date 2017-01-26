Received: from eggs.gnu.org ([2001:4830:134:3::10]:33658)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cWqvd-0002R3-Sk
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 15:46:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cWqvZ-0003xO-V6
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 15:45:57 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Thu, 26 Jan 2017 21:45:47 +0100
Message-Id: <20170126204547.9418-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH] spapr: clock should count only if vm is running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, qemu-ppc@nongnu.org, Alexey Kardashevskiy <aik@ozlabs.ru>, Laurent Vivier <lvivier@redhat.com>

This is a port to ppc of the i386 commit:
    00f4d64 kvmclock: clock should count only if vm is running

We remove timebase_/pre_save/post_load/ functions,
and use the VM state change handler to save and restore
the guest_timebase (on stop and continue).

Time base offset has originally been introduced by commit
    98a8b52 spapr: Add support for time base offset migration

So while VM is paused, the time is stopped. This allows to have
the same result with date (based on Time Base Register) and
hwclock (based on "get-time-of-day" RTAS call).

Moreover in TCG mode, the Time Base is always paused, so this
patch also adjust the behavior between TCG and KVM.

VM state field "time_of_the_day_ns" is now useless but we keep
it to be able to migrate to older version of the machine.

As vmstate_ppc_timebase structure (with timebase_pre_save() and
timebase_post_load() functions) was only used by vmstate_spapr,
we register the VM state change handler only in ppc_spapr_init().

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 hw/ppc/ppc.c         | 76 ++++++++++++++++++----------------------------------
 hw/ppc/spapr.c       |  6 +++++
 hw/ppc/trace-events  |  3 ---
 target/ppc/cpu-qom.h |  3 +++
 4 files changed, 35 insertions(+), 53 deletions(-)

diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
index 8945869..a839e25 100644
--- a/hw/ppc/ppc.c
+++ b/hw/ppc/ppc.c
@@ -847,10 +847,11 @@ static void cpu_ppc_set_tb_clk (void *opaque, uint32_t freq)
     cpu_ppc_store_purr(cpu, 0x0000000000000000ULL);
 }
 
-static void timebase_pre_save(void *opaque)
+#if defined(TARGET_PPC64) && defined(CONFIG_KVM)
+void cpu_ppc_clock_vm_state_change(void *opaque, int running,
+                                   RunState state)
 {
     PPCTimebase *tb = opaque;
-    uint64_t ticks = cpu_get_host_ticks();
     PowerPCCPU *first_ppc_cpu = POWERPC_CPU(first_cpu);
 
     if (!first_ppc_cpu->env.tb_env) {
@@ -858,64 +859,39 @@ static void timebase_pre_save(void *opaque)
         return;
     }
 
-    tb->time_of_the_day_ns = qemu_clock_get_ns(QEMU_CLOCK_HOST);
-    /*
-     * tb_offset is only expected to be changed by migration so
-     * there is no need to update it from KVM here
-     */
-    tb->guest_timebase = ticks + first_ppc_cpu->env.tb_env->tb_offset;
-}
+    if (running) {
+        uint64_t ticks = cpu_get_host_ticks();
+        CPUState *cpu;
+        int64_t tb_offset;
 
-static int timebase_post_load(void *opaque, int version_id)
-{
-    PPCTimebase *tb_remote = opaque;
-    CPUState *cpu;
-    PowerPCCPU *first_ppc_cpu = POWERPC_CPU(first_cpu);
-    int64_t tb_off_adj, tb_off, ns_diff;
-    int64_t migration_duration_ns, migration_duration_tb, guest_tb, host_ns;
-    unsigned long freq;
+        tb_offset = tb->guest_timebase - ticks;
 
-    if (!first_ppc_cpu->env.tb_env) {
-        error_report("No timebase object");
-        return -1;
-    }
-
-    freq = first_ppc_cpu->env.tb_env->tb_freq;
-    /*
-     * Calculate timebase on the destination side of migration.
-     * The destination timebase must be not less than the source timebase.
-     * We try to adjust timebase by downtime if host clocks are not
-     * too much out of sync (1 second for now).
-     */
-    host_ns = qemu_clock_get_ns(QEMU_CLOCK_HOST);
-    ns_diff = MAX(0, host_ns - tb_remote->time_of_the_day_ns);
-    migration_duration_ns = MIN(NANOSECONDS_PER_SECOND, ns_diff);
-    migration_duration_tb = muldiv64(freq, migration_duration_ns,
-                                     NANOSECONDS_PER_SECOND);
-    guest_tb = tb_remote->guest_timebase + MIN(0, migration_duration_tb);
-
-    tb_off_adj = guest_tb - cpu_get_host_ticks();
-
-    tb_off = first_ppc_cpu->env.tb_env->tb_offset;
-    trace_ppc_tb_adjust(tb_off, tb_off_adj, tb_off_adj - tb_off,
-                        (tb_off_adj - tb_off) / freq);
-
-    /* Set new offset to all CPUs */
-    CPU_FOREACH(cpu) {
-        PowerPCCPU *pcpu = POWERPC_CPU(cpu);
-        pcpu->env.tb_env->tb_offset = tb_off_adj;
+        /* Set new offset to all CPUs */
+        CPU_FOREACH(cpu) {
+            PowerPCCPU *pcpu = POWERPC_CPU(cpu);
+            pcpu->env.tb_env->tb_offset = tb_offset;
+            kvm_set_one_reg(cpu, KVM_REG_PPC_TB_OFFSET,
+                            &pcpu->env.tb_env->tb_offset);
+        }
+    } else {
+        uint64_t ticks = cpu_get_host_ticks();
+
+        /* not used anymore, we keep it for compatibility */
+        tb->time_of_the_day_ns = qemu_clock_get_ns(QEMU_CLOCK_HOST);
+        /*
+         * tb_offset is only expected to be changed by QEMU so
+         * there is no need to update it from KVM here
+         */
+        tb->guest_timebase = ticks + first_ppc_cpu->env.tb_env->tb_offset;
     }
-
-    return 0;
 }
+#endif
 
 const VMStateDescription vmstate_ppc_timebase = {
     .name = "timebase",
     .version_id = 1,
     .minimum_version_id = 1,
     .minimum_version_id_old = 1,
-    .pre_save = timebase_pre_save,
-    .post_load = timebase_post_load,
     .fields      = (VMStateField []) {
         VMSTATE_UINT64(guest_timebase, PPCTimebase),
         VMSTATE_INT64(time_of_the_day_ns, PPCTimebase),
diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index a642e66..ee78096 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -2116,6 +2116,12 @@ static void ppc_spapr_init(MachineState *machine)
     qemu_register_reset(spapr_ccs_reset_hook, spapr);
 
     qemu_register_boot_set(spapr_boot_set, spapr);
+
+    /* to stop and start vmclock */
+    if (kvm_enabled()) {
+        qemu_add_vm_change_state_handler(cpu_ppc_clock_vm_state_change,
+                                         &spapr->tb);
+    }
 }
 
 static int spapr_kvm_type(const char *vm_type)
diff --git a/hw/ppc/trace-events b/hw/ppc/trace-events
index 2297ead..4360c23 100644
--- a/hw/ppc/trace-events
+++ b/hw/ppc/trace-events
@@ -68,9 +68,6 @@ spapr_rtas_ibm_configure_connector_missing_fdt(uint32_t index) "DRC index: 0x%"P
 spapr_vio_h_reg_crq(uint64_t reg, uint64_t queue_addr, uint64_t queue_len) "CRQ for dev 0x%" PRIx64 " registered at 0x%" PRIx64 "/0x%" PRIx64
 spapr_vio_free_crq(uint32_t reg) "CRQ for dev 0x%" PRIx32 " freed"
 
-# hw/ppc/ppc.c
-ppc_tb_adjust(uint64_t offs1, uint64_t offs2, int64_t diff, int64_t seconds) "adjusted from 0x%"PRIx64" to 0x%"PRIx64", diff %"PRId64" (%"PRId64"s)"
-
 # hw/ppc/prep.c
 prep_io_800_writeb(uint32_t addr, uint32_t val) "0x%08" PRIx32 " => 0x%02" PRIx32
 prep_io_800_readb(uint32_t addr, uint32_t retval) "0x%08" PRIx32 " <= 0x%02" PRIx32
diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
index d46c31a..b7977ba 100644
--- a/target/ppc/cpu-qom.h
+++ b/target/ppc/cpu-qom.h
@@ -214,6 +214,9 @@ extern const struct VMStateDescription vmstate_ppc_timebase;
     .flags      = VMS_STRUCT,                                         \
     .offset     = vmstate_offset_value(_state, _field, PPCTimebase),  \
 }
+
+void cpu_ppc_clock_vm_state_change(void *opaque, int running,
+                                   RunState state);
 #endif
 
 #endif
-- 
2.9.3
