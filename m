Received: from eggs.gnu.org ([2001:4830:134:3::10]:33229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1eUrCX-0003or-R5
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 04:43:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <slp@redhat.com>) id 1eUrCV-0000X9-0i
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 04:43:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36970)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <slp@redhat.com>) id 1eUrCU-0000Vn-Os
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 04:43:38 -0500
From: Sergio Lopez <slp@redhat.com>
Date: Fri, 29 Dec 2017 10:42:05 +0100
Message-Id: <20171229094206.14512-2-slp@redhat.com>
In-Reply-To: <20171229094206.14512-1-slp@redhat.com>
References: <20171229094206.14512-1-slp@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] vl: extend qemu_system_guest_panicked with
 abort_on_panic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: f4bug@amsat.org, mjt@tls.msk.ru, pbonzini@redhat.com, qemu-devel@nongnu.org
Cc: Sergio Lopez <slp@redhat.com>

The abort_on_panic argument for qemu_system_guest_panicked allows
callers to request an immediate abort() of the process.

Signed-off-by: Sergio Lopez <slp@redhat.com>
---
 accel/kvm/kvm-all.c     |  2 +-
 hw/misc/pvpanic.c       |  2 +-
 hw/ppc/spapr_rtas.c     |  2 +-
 include/sysemu/sysemu.h |  3 ++-
 target/s390x/helper.c   |  2 +-
 target/s390x/kvm.c      |  2 +-
 vl.c                    | 10 ++++++++--
 7 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/accel/kvm/kvm-all.c b/accel/kvm/kvm-all.c
index f290f487a5..fe90789a27 100644
--- a/accel/kvm/kvm-all.c
+++ b/accel/kvm/kvm-all.c
@@ -1971,7 +1971,7 @@ int kvm_cpu_exec(CPUState *cpu)
             case KVM_SYSTEM_EVENT_CRASH:
                 kvm_cpu_synchronize_state(cpu);
                 qemu_mutex_lock_iothread();
-                qemu_system_guest_panicked(cpu_get_crash_info(cpu));
+                qemu_system_guest_panicked(cpu_get_crash_info(cpu), false);
                 qemu_mutex_unlock_iothread();
                 ret = 0;
                 break;
diff --git a/hw/misc/pvpanic.c b/hw/misc/pvpanic.c
index b26250dec9..4fb074df06 100644
--- a/hw/misc/pvpanic.c
+++ b/hw/misc/pvpanic.c
@@ -38,7 +38,7 @@ static void handle_event(int event)
     }
 
     if (event & PVPANIC_PANICKED) {
-        qemu_system_guest_panicked(NULL);
+        qemu_system_guest_panicked(NULL, false);
         return;
     }
 }
diff --git a/hw/ppc/spapr_rtas.c b/hw/ppc/spapr_rtas.c
index 4bb939d3d1..775a7bd716 100644
--- a/hw/ppc/spapr_rtas.c
+++ b/hw/ppc/spapr_rtas.c
@@ -294,7 +294,7 @@ static void rtas_ibm_os_term(PowerPCCPU *cpu,
                             target_ulong args,
                             uint32_t nret, target_ulong rets)
 {
-    qemu_system_guest_panicked(NULL);
+    qemu_system_guest_panicked(NULL, false);
 
     rtas_st(rets, 0, RTAS_OUT_SUCCESS);
 }
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 31612caf10..2d8e7371af 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -83,7 +83,8 @@ ShutdownCause qemu_shutdown_requested_get(void);
 ShutdownCause qemu_reset_requested_get(void);
 void qemu_system_killed(int signal, pid_t pid);
 void qemu_system_reset(ShutdownCause reason);
-void qemu_system_guest_panicked(GuestPanicInformation *info);
+void qemu_system_guest_panicked(GuestPanicInformation *info,
+                                bool abort_on_panic);
 
 void qemu_add_exit_notifier(Notifier *notify);
 void qemu_remove_exit_notifier(Notifier *notify);
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 35d9741918..16d88f37f8 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -89,7 +89,7 @@ void s390_handle_wait(S390CPU *cpu)
         if (is_special_wait_psw(cpu->env.psw.addr)) {
             qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         } else {
-            qemu_system_guest_panicked(NULL);
+            qemu_system_guest_panicked(NULL, false);
         }
 #endif
     }
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 9b8b59f2a2..9948f8c0cb 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1567,7 +1567,7 @@ static void unmanageable_intercept(S390CPU *cpu, const char *str, int pswoffset)
                  str, cs->cpu_index, ldq_phys(cs->as, cpu->env.psa + pswoffset),
                  ldq_phys(cs->as, cpu->env.psa + pswoffset + 8));
     s390_cpu_halt(cpu);
-    qemu_system_guest_panicked(NULL);
+    qemu_system_guest_panicked(NULL, false);
 }
 
 /* try to detect pgm check loops */
diff --git a/vl.c b/vl.c
index d3a5c5d021..71c1456ea7 100644
--- a/vl.c
+++ b/vl.c
@@ -1751,9 +1751,15 @@ void qemu_system_reset(ShutdownCause reason)
     cpu_synchronize_all_post_reset();
 }
 
-void qemu_system_guest_panicked(GuestPanicInformation *info)
+void qemu_system_guest_panicked(GuestPanicInformation *info,
+                                bool abort_on_panic)
 {
-    qemu_log_mask(LOG_GUEST_ERROR, "Guest crashed\n");
+    if (abort_on_panic) {
+        qemu_log_mask(LOG_GUEST_ERROR, "Guest crashed, aborting\n");
+        abort();
+    } else {
+        qemu_log_mask(LOG_GUEST_ERROR, "Guest crashed\n");
+    }
 
     if (current_cpu) {
         current_cpu->crash_occurred = true;
-- 
2.14.3
