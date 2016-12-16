Received: from eggs.gnu.org ([2001:4830:134:3::10]:54436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cHpMd-0008Nh-NW
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 05:03:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cHpMZ-0008Kv-QC
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 05:03:43 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:33286)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cHpMZ-0008IJ-I1
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 05:03:39 -0500
Received: by mail-wm0-x242.google.com with SMTP id u144so4320527wmu.0
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 02:03:38 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <20161210172148.361793326@redhat.com>
	<20161210172324.482367805@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ccb8c6bf-f136-9a6c-fbdc-7e7d4924321e@redhat.com>
Date: Fri, 16 Dec 2016 11:03:33 +0100
MIME-Version: 1.0
In-Reply-To: <20161210172324.482367805@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [qemu patch V4 2/2] kvmclock: reduce kvmclock
 difference on migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org
Cc: qemu-devel@nongnu.org, Dr David Alan Gilbert <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>

I'd like to make a few cleanups and add more documentation:

diff --git a/hw/i386/kvm/clock.c b/hw/i386/kvm/clock.c
index eacc9dc..f767ea9 100644
--- a/hw/i386/kvm/clock.c
+++ b/hw/i386/kvm/clock.c
@@ -37,7 +37,7 @@ typedef struct KVMClockState {
     uint64_t clock;
     bool clock_valid;
 
-    /* whether machine type supports reliable get clock */
+    /* whether machine type supports reliable KVM_GET_CLOCK */
     bool mach_use_reliable_get_clock;
 
     /* whether the 'clock' value was obtained in a host with
@@ -88,7 +88,7 @@ static uint64_t kvmclock_current_nsec(KVMClockState *s)
     return nsec + time.system_time;
 }
 
-static uint64_t kvm_get_clock(void)
+static void kvm_update_clock(void)
 {
     struct kvm_clock_data data;
     int ret;
@@ -98,7 +98,48 @@ static uint64_t kvm_get_clock(void)
         fprintf(stderr, "KVM_GET_CLOCK failed: %s\n", strerror(ret));
                 abort();
     }
-    return data.clock;
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
+     *       if last KVM_GET_CLOCK was not reliable
+     *           read from memory
+     *
+     *   with
+     *
+     *       if last KVM_GET_CLOCK was not reliable && masterclock is enabled
+     *           read from memory
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
+     *           read from memory
+     */
+    s->clock_is_reliable = kvm_has_adjust_clock_stable();
 }
 
 static void kvmclock_vm_state_change(void *opaque, int running,
@@ -111,19 +153,17 @@ static void kvmclock_vm_state_change(void *opaque, int running,
 
     if (running) {
         struct kvm_clock_data data = {};
-        uint64_t pvclock_via_mem = 0;
 
         /*
          * If the host where s->clock was read did not support reliable
          * KVM_GET_CLOCK, read kvmclock value from memory.
          */
         if (!s->clock_is_reliable) {
-            pvclock_via_mem = kvmclock_current_nsec(s);
-        }
-
-        /* We can't rely on the saved clock value, just discard it */
-        if (pvclock_via_mem) {
-            s->clock = pvclock_via_mem;
+            uint64_t pvclock_via_mem = kvmclock_current_nsec(s);
+            /* We can't rely on the saved clock value, just discard it */
+            if (pvclock_via_mem) {
+                s->clock = pvclock_via_mem;
+            }
         }
 
         s->clock_valid = false;
@@ -155,11 +195,7 @@ static void kvmclock_vm_state_change(void *opaque, int running,
 
         kvm_synchronize_all_tsc();
 
-        s->clock = kvm_get_clock();
-        /* any code that sets s->clock needs to ensure clock_is_reliable
-         * is correctly set.
-         */
-        s->clock_is_reliable = kvm_has_adjust_clock_stable();
+        kvm_update_clock();
         /*
          * If the VM is stopped, declare the clock state valid to
          * avoid re-reading it on next vmsave (which would return
@@ -173,9 +209,7 @@ static void kvmclock_realize(DeviceState *dev, Error **errp)
 {
     KVMClockState *s = KVM_CLOCK(dev);
 
-    if (kvm_has_adjust_clock_stable()) {
-        s->clock_is_reliable = true;
-    }
+    kvm_update_clock();
 
     qemu_add_vm_change_state_handler(kvmclock_vm_state_change, s);
 }
@@ -216,7 +250,7 @@ static void kvmclock_pre_save(void *opaque)
 {
     KVMClockState *s = opaque;
 
-    s->clock = kvm_get_clock();
+    kvm_update_clock();
 }
 
 static const VMStateDescription kvmclock_vmsd = {
