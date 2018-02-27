Received: from eggs.gnu.org ([2001:4830:134:3::10]:34873)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqfDY-0005h4-7N
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:23:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eqfDW-0008Vz-Jk
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 08:22:52 -0500
From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 27 Feb 2018 14:21:39 +0100
Message-Id: <20180227132150.13847-16-cohuck@redhat.com>
In-Reply-To: <20180227132150.13847-1-cohuck@redhat.com>
References: <20180227132150.13847-1-cohuck@redhat.com>
Subject: [Qemu-devel] [PULL 15/26] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, rth@twiddle.net, agraf@suse.de, david@redhat.com, thuth@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: Christian Borntraeger <borntraeger@de.ibm.com>

This patch is the s390 implementation of guest crash information,
similar to commit d187e08dc4 ("i386/cpu: add crash-information QOM
property") and the related commits. We will detect several crash
reasons, with the "disabled wait" being the most important one, since
this is used by all s390 guests as a "panic like" notification.

Demonstrate these ways with examples as follows.

  1. crash-information QOM property;

  Run qemu with -qmp unix:qmp-sock,server, then use utility "qmp-shell"
  to execute "qom-get" command, and might get the result like,

  (QEMU) (QEMU) qom-get path=/machine/unattached/device[0] \
      property=crash-information
  {"return": {"core": 0, "reason": "disabled-wait", "psw-mask": 562956395872256, \
      "type": "s390", "psw-addr": 1102832}}

  2. GUEST_PANICKED event reporting;

  Run qemu with a socket option, and telnet or nc to that,
  -chardev socket,id=qmp,port=4444,host=localhost,server \
  -mon chardev=qmp,mode=control,pretty=on \
  Negotiating the mode by { "execute": "qmp_capabilities" }, and the crash
  information will be reported on a guest crash event like,

  {
    "timestamp": {
        "seconds": 1518004739,
        "microseconds": 552563
    },
    "event": "GUEST_PANICKED",
    "data": {
        "action": "pause",
        "info": {
            "core": 0,
            "psw-addr": 1102832,
            "reason": "disabled-wait",
            "psw-mask": 562956395872256,
            "type": "s390"
        }
    }
  }

  3. log;

  Run qemu with the parameters: -D <logfile> -d guest_errors, to
  specify the logfile and log item. The results might be,

  Guest crashed on cpu 0: disabled-wait
  PSW: 0x0002000180000000 0x000000000010d3f0

Co-authored-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
Message-Id: <20180209122543.25755-1-borntraeger@de.ibm.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
[CH: tweaked qapi comment]
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 qapi/run-state.json   | 55 +++++++++++++++++++++++++++++++++++++++++++++++++--
 target/s390x/cpu.c    | 45 +++++++++++++++++++++++++++++++++++++++++
 target/s390x/cpu.h    |  2 ++
 target/s390x/helper.c |  5 ++++-
 target/s390x/kvm.c    | 15 +++++++-------
 vl.c                  | 11 +++++++++--
 6 files changed, 120 insertions(+), 13 deletions(-)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index bca46a8785..92d29fd571 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -320,22 +320,29 @@
 #
 # An enumeration of the guest panic information types
 #
+# @hyper-v: hyper-v guest panic information type
+#
+# @s390: s390 guest panic information type (Since: 2.12)
+#
 # Since: 2.9
 ##
 { 'enum': 'GuestPanicInformationType',
-  'data': [ 'hyper-v'] }
+  'data': [ 'hyper-v', 's390' ] }
 
 ##
 # @GuestPanicInformation:
 #
 # Information about a guest panic
 #
+# @type: Crash type that defines the hypervisor specific information
+#
 # Since: 2.9
 ##
 {'union': 'GuestPanicInformation',
  'base': {'type': 'GuestPanicInformationType'},
  'discriminator': 'type',
- 'data': { 'hyper-v': 'GuestPanicInformationHyperV' } }
+ 'data': { 'hyper-v': 'GuestPanicInformationHyperV',
+           's390': 'GuestPanicInformationS390' } }
 
 ##
 # @GuestPanicInformationHyperV:
@@ -350,3 +357,47 @@
            'arg3': 'uint64',
            'arg4': 'uint64',
            'arg5': 'uint64' } }
+
+##
+# @S390CrashReason:
+#
+# Reason why the CPU is in a crashed state.
+#
+# @unknown: no crash reason was set
+#
+# @disabled-wait: the CPU has entered a disabled wait state
+#
+# @extint-loop: clock comparator or cpu timer interrupt with new PSW enabled
+#              for external interrupts
+#
+# @pgmint-loop: program interrupt with BAD new PSW
+#
+# @opint-loop: operation exception interrupt with invalid code at the program
+#             interrupt new PSW
+#
+# Since: 2.12
+##
+{ 'enum': 'S390CrashReason',
+  'data': [ 'unknown',
+            'disabled-wait',
+            'extint-loop',
+            'pgmint-loop',
+            'opint-loop' ] }
+
+##
+# @GuestPanicInformationS390:
+#
+# S390 specific guest panic information (PSW)
+#
+# @core: core id of the CPU that crashed
+# @psw-mask: control fields of guest PSW
+# @psw-addr: guest instruction address
+# @reason: guest crash reason
+#
+# Since: 2.12
+##
+{'struct': 'GuestPanicInformationS390',
+ 'data': { 'core': 'uint32',
+           'psw-mask': 'uint64',
+           'psw-addr': 'uint64',
+           'reason': 'S390CrashReason' } }
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index a665b9e60e..3e1be56536 100644
--- a/target/s390x/cpu.c
+++ b/target/s390x/cpu.c
@@ -35,6 +35,8 @@
 #include "qemu/error-report.h"
 #include "trace.h"
 #include "qapi/visitor.h"
+#include "qapi-visit.h"
+#include "sysemu/hw_accel.h"
 #include "exec/exec-all.h"
 #include "hw/qdev-properties.h"
 #ifndef CONFIG_USER_ONLY
@@ -228,6 +230,46 @@ out:
     error_propagate(errp, err);
 }
 
+static GuestPanicInformation *s390_cpu_get_crash_info(CPUState *cs)
+{
+    GuestPanicInformation *panic_info;
+    S390CPU *cpu = S390_CPU(cs);
+
+    cpu_synchronize_state(cs);
+    panic_info = g_malloc0(sizeof(GuestPanicInformation));
+
+    panic_info->type = GUEST_PANIC_INFORMATION_TYPE_S390;
+#if !defined(CONFIG_USER_ONLY)
+    panic_info->u.s390.core = cpu->env.core_id;
+#else
+    panic_info->u.s390.core = 0; /* sane default for non system emulation */
+#endif
+    panic_info->u.s390.psw_mask = cpu->env.psw.mask;
+    panic_info->u.s390.psw_addr = cpu->env.psw.addr;
+    panic_info->u.s390.reason = cpu->env.crash_reason;
+
+    return panic_info;
+}
+
+static void s390_cpu_get_crash_info_qom(Object *obj, Visitor *v,
+                                        const char *name, void *opaque,
+                                        Error **errp)
+{
+    CPUState *cs = CPU(obj);
+    GuestPanicInformation *panic_info;
+
+    if (!cs->crash_occurred) {
+        error_setg(errp, "No crash occurred");
+        return;
+    }
+
+    panic_info = s390_cpu_get_crash_info(cs);
+
+    visit_type_GuestPanicInformation(v, "crash-information", &panic_info,
+                                     errp);
+    qapi_free_GuestPanicInformation(panic_info);
+}
+
 static void s390_cpu_initfn(Object *obj)
 {
     CPUState *cs = CPU(obj);
@@ -240,6 +282,8 @@ static void s390_cpu_initfn(Object *obj)
     cs->env_ptr = env;
     cs->halted = 1;
     cs->exception_index = EXCP_HLT;
+    object_property_add(obj, "crash-information", "GuestPanicInformation",
+                        s390_cpu_get_crash_info_qom, NULL, NULL, NULL, NULL);
     s390_cpu_model_register_props(obj);
 #if !defined(CONFIG_USER_ONLY)
     qemu_get_timedate(&tm, 0);
@@ -473,6 +517,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     cc->do_interrupt = s390_cpu_do_interrupt;
 #endif
     cc->dump_state = s390_cpu_dump_state;
+    cc->get_crash_info = s390_cpu_get_crash_info;
     cc->set_pc = s390_cpu_set_pc;
     cc->gdb_read_register = s390_cpu_gdb_read_register;
     cc->gdb_write_register = s390_cpu_gdb_write_register;
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 96df2fe5c9..09ec8a9b76 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -83,6 +83,8 @@ struct CPUS390XState {
 
     PSW psw;
 
+    S390CrashReason crash_reason;
+
     uint64_t cc_src;
     uint64_t cc_dst;
     uint64_t cc_vr;
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 84aaef3a53..615fa24ab9 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -83,12 +83,15 @@ static inline bool is_special_wait_psw(uint64_t psw_addr)
 
 void s390_handle_wait(S390CPU *cpu)
 {
+    CPUState *cs = CPU(cpu);
+
     if (s390_cpu_halt(cpu) == 0) {
 #ifndef CONFIG_USER_ONLY
         if (is_special_wait_psw(cpu->env.psw.addr)) {
             qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
         } else {
-            qemu_system_guest_panicked(NULL);
+            cpu->env.crash_reason = S390_CRASH_REASON_DISABLED_WAIT;
+            qemu_system_guest_panicked(cpu_get_crash_info(cs));
         }
 #endif
     }
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index e13c8907df..83e4eaf45d 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1541,15 +1541,14 @@ static int handle_instruction(S390CPU *cpu, struct kvm_run *run)
     return r;
 }
 
-static void unmanageable_intercept(S390CPU *cpu, const char *str, int pswoffset)
+static void unmanageable_intercept(S390CPU *cpu, S390CrashReason reason,
+                                   int pswoffset)
 {
     CPUState *cs = CPU(cpu);
 
-    error_report("Unmanageable %s! CPU%i new PSW: 0x%016lx:%016lx",
-                 str, cs->cpu_index, ldq_phys(cs->as, cpu->env.psa + pswoffset),
-                 ldq_phys(cs->as, cpu->env.psa + pswoffset + 8));
     s390_cpu_halt(cpu);
-    qemu_system_guest_panicked(NULL);
+    cpu->env.crash_reason = reason;
+    qemu_system_guest_panicked(cpu_get_crash_info(cs));
 }
 
 /* try to detect pgm check loops */
@@ -1579,7 +1578,7 @@ static int handle_oper_loop(S390CPU *cpu, struct kvm_run *run)
         !(oldpsw.mask & PSW_MASK_PSTATE) &&
         (newpsw.mask & PSW_MASK_ASC) == (oldpsw.mask & PSW_MASK_ASC) &&
         (newpsw.mask & PSW_MASK_DAT) == (oldpsw.mask & PSW_MASK_DAT)) {
-        unmanageable_intercept(cpu, "operation exception loop",
+        unmanageable_intercept(cpu, S390_CRASH_REASON_OPINT_LOOP,
                                offsetof(LowCore, program_new_psw));
         return EXCP_HALTED;
     }
@@ -1600,12 +1599,12 @@ static int handle_intercept(S390CPU *cpu)
             r = handle_instruction(cpu, run);
             break;
         case ICPT_PROGRAM:
-            unmanageable_intercept(cpu, "program interrupt",
+            unmanageable_intercept(cpu, S390_CRASH_REASON_PGMINT_LOOP,
                                    offsetof(LowCore, program_new_psw));
             r = EXCP_HALTED;
             break;
         case ICPT_EXT_INT:
-            unmanageable_intercept(cpu, "external interrupt",
+            unmanageable_intercept(cpu, S390_CRASH_REASON_EXTINT_LOOP,
                                    offsetof(LowCore, external_new_psw));
             r = EXCP_HALTED;
             break;
diff --git a/vl.c b/vl.c
index 9e7235df6d..3018433706 100644
--- a/vl.c
+++ b/vl.c
@@ -1736,7 +1736,7 @@ void qemu_system_reset(ShutdownCause reason)
 
 void qemu_system_guest_panicked(GuestPanicInformation *info)
 {
-    qemu_log_mask(LOG_GUEST_ERROR, "Guest crashed\n");
+    qemu_log_mask(LOG_GUEST_ERROR, "Guest crashed");
 
     if (current_cpu) {
         current_cpu->crash_occurred = true;
@@ -1752,13 +1752,20 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
 
     if (info) {
         if (info->type == GUEST_PANIC_INFORMATION_TYPE_HYPER_V) {
-            qemu_log_mask(LOG_GUEST_ERROR, "HV crash parameters: (%#"PRIx64
+            qemu_log_mask(LOG_GUEST_ERROR, "\nHV crash parameters: (%#"PRIx64
                           " %#"PRIx64" %#"PRIx64" %#"PRIx64" %#"PRIx64")\n",
                           info->u.hyper_v.arg1,
                           info->u.hyper_v.arg2,
                           info->u.hyper_v.arg3,
                           info->u.hyper_v.arg4,
                           info->u.hyper_v.arg5);
+        } else if (info->type == GUEST_PANIC_INFORMATION_TYPE_S390) {
+            qemu_log_mask(LOG_GUEST_ERROR, " on cpu %d: %s\n"
+                          "PSW: 0x%016" PRIx64 " 0x%016" PRIx64"\n",
+                          info->u.s390.core,
+                          S390CrashReason_str(info->u.s390.reason),
+                          info->u.s390.psw_mask,
+                          info->u.s390.psw_addr);
         }
         qapi_free_GuestPanicInformation(info);
     }
-- 
2.13.6
