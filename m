Received: from eggs.gnu.org ([2001:4830:134:3::10]:37970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5Da-00085n-18
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DV-0007Fl-A7
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5DU-0007FA-Vh
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:37 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 19C6F804E2
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 15:23:36 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:22:58 +0100
Message-Id: <20161222152300.32395-24-pbonzini@redhat.com>
In-Reply-To: <20161222152300.32395-1-pbonzini@redhat.com>
References: <20161222152300.32395-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 23/25] kvmclock: reduce kvmclock difference on
 migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>

From: Marcelo Tosatti <mtosatti@redhat.com>

Check for KVM_CAP_ADJUST_CLOCK capability KVM_CLOCK_TSC_STABLE, which
indicates that KVM_GET_CLOCK returns a value as seen by the guest at
that moment.

For new machine types, use this value rather than reading
from guest memory.

This reduces kvmclock difference on migration from 5s to 0.1s
(when max_downtime == 5s).

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Message-Id: <20161121105052.598267440@redhat.com>
[Add comment explaining what is going on. - Paolo]
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/kvm/clock.c    | 142 +++++++++++++++++++++++++++++++++++++++++++------
 include/hw/i386/pc.h   |   5 ++
 target/i386/kvm.c      |   7 +++
 target/i386/kvm_i386.h |   1 +
 4 files changed, 140 insertions(+), 15 deletions(-)

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index 0f75dd3..ef9d560 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -36,6 +36,13 @@ typedef struct KVMClockState {
 
     uint64_t clock;
     bool clock_valid;
+
+    /* whether machine type supports reliable KVM_GET_CLOCK */
+    bool mach_use_reliable_get_clock;
+
+    /* whether the 'clock' value was obtained in a host with
+     * reliable KVM_GET_CLOCK */
+    bool clock_is_reliable;
 } KVMClockState;
 
 struct pvclock_vcpu_time_info {
@@ -81,6 +88,60 @@ static uint64_t kvmclock_current_nsec(KVMClockState *s)
     return nsec + time.system_time;
 }
 
+static void kvm_update_clock(KVMClockState *s)
+{
+    struct kvm_clock_data data;
+    int ret;
+
+    ret = kvm_vm_ioctl(kvm_state, KVM_GET_CLOCK, &data);
+    if (ret < 0) {
+        fprintf(stderr, "KVM_GET_CLOCK failed: %s\n", strerror(ret));
+                abort();
+    }
+    s->clock = data.clock;
+
+    /* If kvm_has_adjust_clock_stable() is false, KVM_GET_CLOCK returns
+     * essentially CLOCK_MONOTONIC plus a guest-specific adjustment.  This
+     * can drift from the TSC-based value that is computed by the guest,
+     * so we need to go through kvmclock_current_nsec().  If
+     * kvm_has_adjust_clock_stable() is true, and the flags contain
+     * KVM_CLOCK_TSC_STABLE, then KVM_GET_CLOCK returns a TSC-based value
+     * and kvmclock_current_nsec() is not necessary.
+     *
+     * Here, however, we need not check KVM_CLOCK_TSC_STABLE.  This is because:
+     *
+     * - if the host has disabled the kvmclock master clock, the guest already
+     *   has protection against time going backwards.  This "safety net" is only
+     *   absent when kvmclock is stable;
+     *
+     * - therefore, we can replace a check like
+     *
+     *       if last KVM_GET_CLOCK was not reliable then
+     *               read from memory
+     *
+     *   with
+     *
+     *       if last KVM_GET_CLOCK was not reliable && masterclock is enabled
+     *               read from memory
+     *
+     * However:
+     *
+     * - if kvm_has_adjust_clock_stable() returns false, the left side is
+     *   always true (KVM_GET_CLOCK is never reliable), and the right side is
+     *   unknown (because we don't have data.flags).  We must assume it's true
+     *   and read from memory.
+     *
+     * - if kvm_has_adjust_clock_stable() returns true, the result of the &&
+     *   is always false (masterclock is enabled iff KVM_GET_CLOCK is reliable)
+     *
+     * So we can just use this instead:
+     *
+     *       if !kvm_has_adjust_clock_stable() then
+     *               read from memory
+     */
+    s->clock_is_reliable = kvm_has_adjust_clock_stable();
+}
+
 static void kvmclock_vm_state_change(void *opaque, int running,
                                      RunState state)
 {
@@ -91,15 +152,21 @@ static void kvmclock_vm_state_change(void *opaque, int running,
 
     if (running) {
         struct kvm_clock_data data = {};
-        uint64_t time_at_migration = kvmclock_current_nsec(s);
-
-        s->clock_valid = false;
 
-        /* We can't rely on the migrated clock value, just discard it */
-        if (time_at_migration) {
-            s->clock = time_at_migration;
+        /*
+         * If the host where s->clock was read did not support reliable
+         * KVM_GET_CLOCK, read kvmclock value from memory.
+         */
+        if (!s->clock_is_reliable) {
+            uint64_t pvclock_via_mem = kvmclock_current_nsec(s);
+            /* We can't rely on the saved clock value, just discard it */
+            if (pvclock_via_mem) {
+                s->clock = pvclock_via_mem;
+            }
         }
 
+        s->clock_valid = false;
+
         data.clock = s->clock;
         ret = kvm_vm_ioctl(kvm_state, KVM_SET_CLOCK, &data);
         if (ret < 0) {
@@ -120,8 +187,6 @@ static void kvmclock_vm_state_change(void *opaque, int running,
             }
         }
     } else {
-        struct kvm_clock_data data;
-        int ret;
 
         if (s->clock_valid) {
             return;
@@ -129,13 +194,7 @@ static void kvmclock_vm_state_change(void *opaque, int running,
 
         kvm_synchronize_all_tsc();
 
-        ret = kvm_vm_ioctl(kvm_state, KVM_GET_CLOCK, &data);
-        if (ret < 0) {
-            fprintf(stderr, "KVM_GET_CLOCK failed: %s\n", strerror(ret));
-            abort();
-        }
-        s->clock = data.clock;
-
+        kvm_update_clock(s);
         /*
          * If the VM is stopped, declare the clock state valid to
          * avoid re-reading it on next vmsave (which would return
@@ -149,25 +208,78 @@ static void kvmclock_realize(DeviceState *dev, Error **errp)
 {
     KVMClockState *s = KVM_CLOCK(dev);
 
+    kvm_update_clock(s);
+
     qemu_add_vm_change_state_handler(kvmclock_vm_state_change, s);
 }
 
+static bool kvmclock_clock_is_reliable_needed(void *opaque)
+{
+    KVMClockState *s = opaque;
+
+    return s->mach_use_reliable_get_clock;
+}
+
+static const VMStateDescription kvmclock_reliable_get_clock = {
+    .name = "kvmclock/clock_is_reliable",
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .needed = kvmclock_clock_is_reliable_needed,
+    .fields = (VMStateField[]) {
+        VMSTATE_BOOL(clock_is_reliable, KVMClockState),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
+/*
+ * When migrating, read the clock just before migration,
+ * so that the guest clock counts during the events
+ * between:
+ *
+ *  * vm_stop()
+ *  *
+ *  * pre_save()
+ *
+ *  This reduces kvmclock difference on migration from 5s
+ *  to 0.1s (when max_downtime == 5s), because sending the
+ *  final pages of memory (which happens between vm_stop()
+ *  and pre_save()) takes max_downtime.
+ */
+static void kvmclock_pre_save(void *opaque)
+{
+    KVMClockState *s = opaque;
+
+    kvm_update_clock(s);
+}
+
 static const VMStateDescription kvmclock_vmsd = {
     .name = "kvmclock",
     .version_id = 1,
     .minimum_version_id = 1,
+    .pre_save = kvmclock_pre_save,
     .fields = (VMStateField[]) {
         VMSTATE_UINT64(clock, KVMClockState),
         VMSTATE_END_OF_LIST()
+    },
+    .subsections = (const VMStateDescription * []) {
+        &kvmclock_reliable_get_clock,
+        NULL
     }
 };
 
+static Property kvmclock_properties[] = {
+    DEFINE_PROP_BOOL("x-mach-use-reliable-get-clock", KVMClockState,
+                      mach_use_reliable_get_clock, true),
+    DEFINE_PROP_END_OF_LIST(),
+};
+
 static void kvmclock_class_init(ObjectClass *klass, void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
 
     dc->realize = kvmclock_realize;
     dc->vmsd = &kvmclock_vmsd;
+    dc->props = kvmclock_properties;
 }
 
 static const TypeInfo kvmclock_info = {
diff --git a/include/hw/i386/pc.h b/include/hw/i386/pc.h
index b37bc5b..b22e699 100644
--- a/include/hw/i386/pc.h
+++ b/include/hw/i386/pc.h
@@ -379,6 +379,11 @@ bool e820_get_entry(int, uint32_t, uint64_t *, uint64_t *);
 #define PC_COMPAT_2_7 \
     HW_COMPAT_2_7 \
     {\
+        .driver   = "kvmclock",\
+        .property = "x-mach-use-reliable-get-clock",\
+        .value    = "off",\
+    },\
+    {\
         .driver   = TYPE_X86_CPU,\
         .property = "l3-cache",\
         .value    = "off",\
diff --git a/target/i386/kvm.c b/target/i386/kvm.c
index f62264a..10a9cd8 100644
--- a/target/i386/kvm.c
+++ b/target/i386/kvm.c
@@ -117,6 +117,13 @@ bool kvm_has_smm(void)
     return kvm_check_extension(kvm_state, KVM_CAP_X86_SMM);
 }
 
+bool kvm_has_adjust_clock_stable(void)
+{
+    int ret = kvm_check_extension(kvm_state, KVM_CAP_ADJUST_CLOCK);
+
+    return (ret == KVM_CLOCK_TSC_STABLE);
+}
+
 bool kvm_allows_irq0_override(void)
 {
     return !kvm_irqchip_in_kernel() || kvm_has_gsi_routing();
diff --git a/target/i386/kvm_i386.h b/target/i386/kvm_i386.h
index 7607929..bfce427 100644
--- a/target/i386/kvm_i386.h
+++ b/target/i386/kvm_i386.h
@@ -17,6 +17,7 @@
 
 bool kvm_allows_irq0_override(void);
 bool kvm_has_smm(void);
+bool kvm_has_adjust_clock_stable(void);
 void kvm_synchronize_all_tsc(void);
 void kvm_arch_reset_vcpu(X86CPU *cs);
 void kvm_arch_do_init_vcpu(X86CPU *cs);
-- 
2.9.3
