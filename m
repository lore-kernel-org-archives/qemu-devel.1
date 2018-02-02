Received: from eggs.gnu.org ([2001:4830:134:3::10]:37499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ehf7q-0001x9-35
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 12:28:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1ehf6l-0001Ne-Qd
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 12:27:45 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52102)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1ehf6k-0001KR-V5
	for qemu-devel@nongnu.org; Fri, 02 Feb 2018 12:26:39 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w12EWkZd111955
	for <qemu-devel@nongnu.org>; Fri, 2 Feb 2018 09:37:55 -0500
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2fvqtxx5me-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 02 Feb 2018 09:37:54 -0500
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 2 Feb 2018 14:37:51 -0000
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri,  2 Feb 2018 14:37:46 +0000
In-Reply-To: <20180202143746.204851-1-borntraeger@de.ibm.com>
References: <20180202143746.204851-1-borntraeger@de.ibm.com>
Message-Id: <20180202143746.204851-2-borntraeger@de.ibm.com>
Subject: [Qemu-devel] [PATCH v3 1/1] s390x/cpu: expose the guest crash
 information
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-s390x <qemu-s390x@nongnu.org>
Cc: qemu-devel <qemu-devel@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>, Halil Pasic <pasic@linux.vnet.ibm.com>, Eric Blake <eblake@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

This patch is the s390 implementation of guest crash information,
similar to commit d187e08dc4 ("i386/cpu: add crash-information QOM
property") and the related commits. We will detect several crash
reasons, with the "disabled wait" being the most important one, since
this is used by all s390 guests as a "panic like" notification.

Demonstrate these ways with examples as follows.

  1. crash-information QOM property;

  Run qemu with -qmp unix:qmp-sock,server, then use utility "qmp-shell"
  to execute "qom-get" command, and might get the result like,

  (QEMU) qom-get path=/machine/cpu[0]/ property=crash-information
  {"return": {"psw-addr": 1105350, "psw-mask": 562956395872256, "reason":
   "disabled wait", "type": "s390"}}

  2. GUEST_PANICKED event reporting;

  Run qemu with a socket option, and telnet or nc to that,
  -chardev socket,id=qmp,port=4444,host=localhost,server \
  -mon chardev=qmp,mode=control,pretty=on \
  Negotiating the mode by { "execute": "qmp_capabilities" }, and the crash
  information will be reported on a guest crash event like,

  {
      "timestamp": {
          "seconds": 1499931739,
          "microseconds": 961296
      },
      "event": "GUEST_PANICKED",
      "data": {
          "action": "pause",
          "info": {
              "psw-addr": 1105350,
              "reason": "disabled wait",
              "psw-mask": 562956395872256,
              "type": "s390"
          }
      }
  }

  3. log;

  Run qemu with the parameters: -D <logfile> -d guest_errors, to
  specify the logfile and log item. The results might be,

  Guest crashed
  S390 crash parameters: (0x0000100000000000 0x0000000000000006)
  S390 crash reason: operation exception loop

Co-authored-by: Jing Liu <liujbjl@linux.vnet.ibm.com>
Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
---
 qapi/run-state.json   | 29 ++++++++++++++++++++++++--
 target/s390x/cpu.c    | 57 +++++++++++++++++++++++++++++++++++++++++++++++++++
 target/s390x/cpu.h    | 10 +++++++++
 target/s390x/helper.c |  5 ++++-
 target/s390x/kvm.c    | 27 +++++++++++++++++++-----
 vl.c                  |  6 ++++++
 6 files changed, 126 insertions(+), 8 deletions(-)

diff --git a/qapi/run-state.json b/qapi/run-state.json
index bca46a8785..a93f6fea5c 100644
--- a/qapi/run-state.json
+++ b/qapi/run-state.json
@@ -320,22 +320,31 @@
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
+# @hyper-v: hyper-v guest panic information
+#
+# @s390: s390 guest panic information (Since: 2.12)
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
@@ -350,3 +359,19 @@
            'arg3': 'uint64',
            'arg4': 'uint64',
            'arg5': 'uint64' } }
+
+##
+# @GuestPanicInformationS390:
+#
+# S390 specific guest panic information (PSW)
+#
+# @psw-mask: control fields of guest PSW
+# @psw-addr: guest instruction address
+# @reason: guest crash reason for human reading
+#
+# Since: 2.12
+##
+{'struct': 'GuestPanicInformationS390',
+ 'data': { 'psw-mask': 'uint64',
+           'psw-addr': 'uint64',
+           'reason': 'str' } }
diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
index d2e6b9f5c7..ac8e963307 100644
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
@@ -237,6 +239,58 @@ out:
     error_propagate(errp, err);
 }
 
+static GuestPanicInformation *s390x_cpu_get_crash_info(CPUState *cs)
+{
+    GuestPanicInformation *panic_info;
+    S390CPU *cpu = S390_CPU(cs);
+
+    cpu_synchronize_state(cs);
+    panic_info = g_malloc0(sizeof(GuestPanicInformation));
+
+    panic_info->type = GUEST_PANIC_INFORMATION_TYPE_S390;
+    panic_info->u.s390.psw_mask = cpu->env.psw.mask;
+    panic_info->u.s390.psw_addr = cpu->env.psw.addr;
+
+    switch (cpu->env.crash_reason) {
+    case CRASH_REASON_PGM:
+        panic_info->u.s390.reason = g_strdup("program interrupt loop");
+        break;
+    case CRASH_REASON_EXT:
+        panic_info->u.s390.reason = g_strdup("external interrupt loop");
+        break;
+    case CRASH_REASON_WAITPSW:
+        panic_info->u.s390.reason = g_strdup("disabled wait");
+        break;
+    case CRASH_REASON_OPEREXC:
+        panic_info->u.s390.reason = g_strdup("operation exception loop");
+        break;
+    default:
+        panic_info->u.s390.reason = g_strdup("unknown crash reason");
+        break;
+    }
+
+    return panic_info;
+}
+
+static void s390x_cpu_get_crash_info_qom(Object *obj, Visitor *v,
+                                         const char *name, void *opaque,
+                                         Error **errp)
+{
+    CPUState *cs = CPU(obj);
+    GuestPanicInformation *panic_info;
+
+    if (!cs->crash_occurred) {
+        error_setg(errp, "No crash occured");
+        return;
+    }
+
+    panic_info = s390x_cpu_get_crash_info(cs);
+
+    visit_type_GuestPanicInformation(v, "crash-information", &panic_info,
+                                     errp);
+    qapi_free_GuestPanicInformation(panic_info);
+}
+
 static void s390_cpu_initfn(Object *obj)
 {
     CPUState *cs = CPU(obj);
@@ -249,6 +303,8 @@ static void s390_cpu_initfn(Object *obj)
     cs->env_ptr = env;
     cs->halted = 1;
     cs->exception_index = EXCP_HLT;
+    object_property_add(obj, "crash-information", "GuestPanicInformation",
+                        s390x_cpu_get_crash_info_qom, NULL, NULL, NULL, NULL);
     s390_cpu_model_register_props(obj);
 #if !defined(CONFIG_USER_ONLY)
     qemu_get_timedate(&tm, 0);
@@ -482,6 +538,7 @@ static void s390_cpu_class_init(ObjectClass *oc, void *data)
     cc->do_interrupt = s390_cpu_do_interrupt;
 #endif
     cc->dump_state = s390_cpu_dump_state;
+    cc->get_crash_info = s390x_cpu_get_crash_info;
     cc->set_pc = s390_cpu_set_pc;
     cc->gdb_read_register = s390_cpu_gdb_read_register;
     cc->gdb_write_register = s390_cpu_gdb_write_register;
diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index a1123ad621..71414cc324 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -77,6 +77,14 @@ typedef struct MchkQueue {
     uint16_t type;
 } MchkQueue;
 
+/* Crash cases. */
+enum crash_reasons {
+    CRASH_REASON_PGM,
+    CRASH_REASON_EXT,
+    CRASH_REASON_WAITPSW,
+    CRASH_REASON_OPEREXC,
+};
+
 struct CPUS390XState {
     uint64_t regs[16];     /* GP registers */
     /*
@@ -102,6 +110,8 @@ struct CPUS390XState {
 
     PSW psw;
 
+    enum crash_reasons crash_reason;
+
     uint64_t cc_src;
     uint64_t cc_dst;
     uint64_t cc_vr;
diff --git a/target/s390x/helper.c b/target/s390x/helper.c
index 35d9741918..56c3f13686 100644
--- a/target/s390x/helper.c
+++ b/target/s390x/helper.c
@@ -84,12 +84,15 @@ static inline bool is_special_wait_psw(uint64_t psw_addr)
 
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
+            cpu->env.crash_reason = CRASH_REASON_WAITPSW;
+            qemu_system_guest_panicked(cpu_get_crash_info(cs));
         }
 #endif
     }
diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
index 8736001156..c6a23262a8 100644
--- a/target/s390x/kvm.c
+++ b/target/s390x/kvm.c
@@ -1568,15 +1568,32 @@ static int handle_instruction(S390CPU *cpu, struct kvm_run *run)
     return r;
 }
 
-static void unmanageable_intercept(S390CPU *cpu, const char *str, int pswoffset)
+static void unmanageable_intercept(S390CPU *cpu, enum crash_reasons reason,
+                                   int pswoffset)
 {
     CPUState *cs = CPU(cpu);
+    const char *str;
 
+    switch (reason) {
+    case CRASH_REASON_PGM:
+        str = "program interrupt loop";
+        break;
+    case CRASH_REASON_EXT:
+        str = "external interrupt loop";
+        break;
+    case CRASH_REASON_OPEREXC:
+        str = "operation exception loop";
+        break;
+    default:
+        str = "unknown crash reason";
+        break;
+    }
     error_report("Unmanageable %s! CPU%i new PSW: 0x%016lx:%016lx",
                  str, cs->cpu_index, ldq_phys(cs->as, cpu->env.psa + pswoffset),
                  ldq_phys(cs->as, cpu->env.psa + pswoffset + 8));
     s390_cpu_halt(cpu);
-    qemu_system_guest_panicked(NULL);
+    cpu->env.crash_reason = reason;
+    qemu_system_guest_panicked(cpu_get_crash_info(cs));
 }
 
 /* try to detect pgm check loops */
@@ -1606,7 +1623,7 @@ static int handle_oper_loop(S390CPU *cpu, struct kvm_run *run)
         !(oldpsw.mask & PSW_MASK_PSTATE) &&
         (newpsw.mask & PSW_MASK_ASC) == (oldpsw.mask & PSW_MASK_ASC) &&
         (newpsw.mask & PSW_MASK_DAT) == (oldpsw.mask & PSW_MASK_DAT)) {
-        unmanageable_intercept(cpu, "operation exception loop",
+        unmanageable_intercept(cpu, CRASH_REASON_OPEREXC,
                                offsetof(LowCore, program_new_psw));
         return EXCP_HALTED;
     }
@@ -1627,12 +1644,12 @@ static int handle_intercept(S390CPU *cpu)
             r = handle_instruction(cpu, run);
             break;
         case ICPT_PROGRAM:
-            unmanageable_intercept(cpu, "program interrupt",
+            unmanageable_intercept(cpu, CRASH_REASON_PGM,
                                    offsetof(LowCore, program_new_psw));
             r = EXCP_HALTED;
             break;
         case ICPT_EXT_INT:
-            unmanageable_intercept(cpu, "external interrupt",
+            unmanageable_intercept(cpu, CRASH_REASON_EXT,
                                    offsetof(LowCore, external_new_psw));
             r = EXCP_HALTED;
             break;
diff --git a/vl.c b/vl.c
index e517a8d995..74ea60f248 100644
--- a/vl.c
+++ b/vl.c
@@ -1761,6 +1761,12 @@ void qemu_system_guest_panicked(GuestPanicInformation *info)
                           info->u.hyper_v.arg3,
                           info->u.hyper_v.arg4,
                           info->u.hyper_v.arg5);
+        } else if (info->type == GUEST_PANIC_INFORMATION_TYPE_S390) {
+            qemu_log_mask(LOG_GUEST_ERROR, "S390 crash parameters: (0x%016"
+                          PRIx64" 0x%016" PRIx64")\nS390 crash reason: %s\n",
+                          info->u.s390.psw_mask,
+                          info->u.s390.psw_addr,
+                          info->u.s390.reason);
         }
         qapi_free_GuestPanicInformation(info);
     }
-- 
2.14.3
