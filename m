Received: from eggs.gnu.org ([2001:4830:134:3::10]:48988)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cg7uQ-0007r2-Vz
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:43:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1cg7uQ-0002uQ-1G
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:43:03 -0500
Received: from mail-wm0-x242.google.com ([2a00:1450:400c:c09::242]:35952)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1cg7uP-0002uH-RQ
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 05:43:01 -0500
Received: by mail-wm0-x242.google.com with SMTP id r18so18944817wmd.3
	for <qemu-devel@nongnu.org>; Tue, 21 Feb 2017 02:43:01 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 21 Feb 2017 11:42:56 +0100
Message-Id: <20170221104256.5153-4-pbonzini@redhat.com>
In-Reply-To: <20170221104256.5153-1-pbonzini@redhat.com>
References: <20170221104256.5153-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH 3/3] vl: pass CPUState to
 qemu_system_guest_panicked
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, anton.nefedov@virtuozzo.com, den@openvz.org

qemu_system_guest_panicked was already using current_cpu implicitly,
so it makes sense for it to receive a CPUState.  This lets the
function call cpu_get_crash_info and free the result.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/sysemu/sysemu.h |  2 +-
 kvm-all.c               |  2 +-
 vl.c                    | 13 ++++++++++---
 3 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 576c7ce..a02f53a 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -66,7 +66,7 @@ int qemu_shutdown_requested_get(void);
 int qemu_reset_requested_get(void);
 void qemu_system_killed(int signal, pid_t pid);
 void qemu_system_reset(bool report);
-void qemu_system_guest_panicked(GuestPanicInformation *info);
+void qemu_system_guest_panicked(CPUState *cpu);
 size_t qemu_target_page_bits(void);
 
 void qemu_add_exit_notifier(Notifier *notify);
diff --git a/kvm-all.c b/kvm-all.c
index 7ad20b7..edecef0 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -2071,7 +2071,7 @@ int kvm_cpu_exec(CPUState *cpu)
             case KVM_SYSTEM_EVENT_CRASH:
                 kvm_cpu_synchronize_state(cpu);
                 qemu_mutex_lock_iothread();
-                qemu_system_guest_panicked(cpu_get_crash_info(cpu));
+                qemu_system_guest_panicked(cpu);
                 qemu_mutex_unlock_iothread();
                 ret = 0;
                 break;
diff --git a/vl.c b/vl.c
index d8b9dec..2de75ce 100644
--- a/vl.c
+++ b/vl.c
@@ -1679,13 +1679,20 @@ void qemu_system_reset(bool report)
     cpu_synchronize_all_post_reset();
 }
 
-void qemu_system_guest_panicked(GuestPanicInformation *info)
+void qemu_system_guest_panicked(CPUState *cpu)
 {
+    GuestPanicInformation *info = NULL;
+
     qemu_log_mask(LOG_GUEST_ERROR, "Guest crashed\n");
 
-    if (current_cpu) {
-        current_cpu->crash_occurred = true;
+    if (!cpu) {
+        cpu = current_cpu;
+    }
+    if (cpu) {
+        cpu->crash_occurred = true;
+        info = cpu_get_crash_info(cpu);
     }
+
     qapi_event_send_guest_panicked(GUEST_PANIC_ACTION_PAUSE,
                                    !!info, info, &error_abort);
     vm_stop(RUN_STATE_GUEST_PANICKED);
-- 
2.9.3
