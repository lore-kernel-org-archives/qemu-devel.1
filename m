Received: from eggs.gnu.org ([2001:4830:134:3::10]:33234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cfsb7-0001Yf-Mh
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:22:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@openvz.org>) id 1cfsb2-00044n-VU
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:22:05 -0500
Received: from mailhub.sw.ru ([195.214.232.25]:9778 helo=relay.sw.ru)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <den@openvz.org>) id 1cfsb2-00043J-Ju
	for qemu-devel@nongnu.org; Mon, 20 Feb 2017 13:22:00 -0500
From: "Denis V. Lunev" <den@openvz.org>
Date: Mon, 20 Feb 2017 21:21:53 +0300
Message-Id: <1487614915-18710-2-git-send-email-den@openvz.org>
In-Reply-To: <1487614915-18710-1-git-send-email-den@openvz.org>
References: <1487614915-18710-1-git-send-email-den@openvz.org>
Subject: [Qemu-devel] [PATCH 1/3] i386/cpu: release GuestPanicInformation
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: den@openvz.org, Anton Nefedov <anton.nefedov@virtuozzo.com>, Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>

From: Anton Nefedov <anton.nefedov@virtuozzo.com>

Do not make some foreign function do it.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Signed-off-by: Denis V. Lunev <den@openvz.org>
CC: Paolo Bonzini <pbonzini@redhat.com>
CC: Eric Blake <eblake@redhat.com>
---
 kvm-all.c |  5 ++++-
 vl.c      | 22 +++++++++-------------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/kvm-all.c b/kvm-all.c
index 0c94637..ac07902 100644
--- a/kvm-all.c
+++ b/kvm-all.c
@@ -1909,6 +1909,7 @@ int kvm_cpu_exec(CPUState *cpu)
 
     do {
         MemTxAttrs attrs;
+        GuestPanicInformation *crash_info;
 
         if (cpu->kvm_vcpu_dirty) {
             kvm_arch_put_registers(cpu, KVM_PUT_RUNTIME_STATE);
@@ -2001,9 +2002,11 @@ int kvm_cpu_exec(CPUState *cpu)
                 break;
             case KVM_SYSTEM_EVENT_CRASH:
                 kvm_cpu_synchronize_state(cpu);
+                crash_info = cpu_get_crash_info(cpu);
                 qemu_mutex_lock_iothread();
-                qemu_system_guest_panicked(cpu_get_crash_info(cpu));
+                qemu_system_guest_panicked(crash_info);
                 qemu_mutex_unlock_iothread();
+                qapi_free_GuestPanicInformation(crash_info);
                 ret = 0;
                 break;
             default:
diff --git a/vl.c b/vl.c
index 27d9829..81382b6 100644
--- a/vl.c
+++ b/vl.c
@@ -1682,6 +1682,15 @@ void qemu_system_reset(bool report)
 void qemu_system_guest_panicked(GuestPanicInformation *info)
 {
     qemu_log_mask(LOG_GUEST_ERROR, "Guest crashed\n");
+    if (info && info->type == GUEST_PANIC_INFORMATION_KIND_HYPER_V) {
+        qemu_log_mask(LOG_GUEST_ERROR, "HV crash parameters: (%#"PRIx64
+                      " %#"PRIx64" %#"PRIx64" %#"PRIx64" %#"PRIx64")\n",
+                      info->u.hyper_v.data->arg1,
+                      info->u.hyper_v.data->arg2,
+                      info->u.hyper_v.data->arg3,
+                      info->u.hyper_v.data->arg4,
+                      info->u.hyper_v.data->arg5);
+    }
 
     if (current_cpu) {
         current_cpu->crash_occurred = true;
@@ -1694,19 +1703,6 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
                                        !!info, info, &error_abort);
         qemu_system_shutdown_request();
     }
-
-    if (info) {
-        if (info->type == GUEST_PANIC_INFORMATION_KIND_HYPER_V) {
-            qemu_log_mask(LOG_GUEST_ERROR, "HV crash parameters: (%#"PRIx64
-                          " %#"PRIx64" %#"PRIx64" %#"PRIx64" %#"PRIx64")\n",
-                          info->u.hyper_v.data->arg1,
-                          info->u.hyper_v.data->arg2,
-                          info->u.hyper_v.data->arg3,
-                          info->u.hyper_v.data->arg4,
-                          info->u.hyper_v.data->arg5);
-        }
-        qapi_free_GuestPanicInformation(info);
-    }
 }
 
 void qemu_system_reset_request(void)
-- 
2.7.4
