Received: from eggs.gnu.org ([2001:4830:134:3::10]:52015)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds5d8-00033I-Fm
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:14:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds5d5-0003EG-5z
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:14:54 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:42168)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1ds5d4-0003A1-M1
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 07:14:51 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed, 13 Sep 2017 14:14:32 +0300
Message-Id: <150530127274.10902.16324091925081075909.stgit@frigg.lan>
In-Reply-To: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
References: <150529642278.10902.18234057937634437857.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 20/22] instrument: Add event
 'guest_user_syscall'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 bsd-user/syscall.c              |    6 ++++++
 instrument/control.c            |   18 ++++++++++++++++++
 instrument/events.h             |    7 +++++++
 instrument/events.inc.h         |   16 ++++++++++++++++
 instrument/load.c               |    1 +
 instrument/qemu-instr/control.h |   15 +++++++++++++++
 linux-user/syscall.c            |    2 ++
 stubs/instrument.c              |    3 +++
 8 files changed, 68 insertions(+)

diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
index 3230f722f3..0d92eaf8c4 100644
--- a/bsd-user/syscall.c
+++ b/bsd-user/syscall.c
@@ -324,6 +324,8 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, a=
bi_long arg1,
 #ifdef DEBUG
     gemu_log("freebsd syscall %d\n", num);
 #endif
+    instr_guest_user_syscall(cpu, num,
+                             arg1, arg2, arg3, arg4, arg5, arg6, arg7, a=
rg8);
     trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg=
6, arg7, arg8);
     if(do_strace)
         print_freebsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
@@ -423,6 +425,8 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, ab=
i_long arg1,
 #ifdef DEBUG
     gemu_log("netbsd syscall %d\n", num);
 #endif
+    instr_guest_user_syscall(cpu, num,
+                             arg1, arg2, arg3, arg4, arg5, arg6, 0, 0);
     trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg=
6, 0, 0);
     if(do_strace)
         print_netbsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
@@ -499,6 +503,8 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, a=
bi_long arg1,
 #ifdef DEBUG
     gemu_log("openbsd syscall %d\n", num);
 #endif
+    instr_guest_user_syscall(cpu, num,
+                             arg1, arg2, arg3, arg4, arg5, arg6, 0, 0);
     trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg=
6, 0, 0);
     if(do_strace)
         print_openbsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
diff --git a/instrument/control.c b/instrument/control.c
index 3fcacb2853..45efeef7ac 100644
--- a/instrument/control.c
+++ b/instrument/control.c
@@ -193,3 +193,21 @@ SYM_PUBLIC void qi_event_set_guest_mem_before_exec(
     ERROR_IF(!tcg_enabled(), "called without TCG");
     instr_set_event(guest_mem_before_exec, fn);
 }
+
+
+void (*instr_event__guest_user_syscall)(
+    QICPU vcpu, uint64_t num, uint64_t arg1, uint64_t arg2, uint64_t arg=
3,
+    uint64_t arg4, uint64_t arg5, uint64_t arg6, uint64_t arg7, uint64_t=
 arg8);
+
+SYM_PUBLIC void qi_event_set_guest_user_syscall(
+    void (*fn)(QICPU vcpu, uint64_t num, uint64_t arg1, uint64_t arg2,
+               uint64_t arg3, uint64_t arg4, uint64_t arg5, uint64_t arg=
6,
+               uint64_t arg7, uint64_t arg8))
+{
+    ERROR_IF(!instr_get_state(), "called outside instrumentation");
+    ERROR_IF(!tcg_enabled(), "called without TCG");
+#if !defined(CONFIG_USER_ONLY)
+    ERROR_IF(true, "called in full-system mode");
+#endif
+    instr_set_event(guest_user_syscall, fn);
+}
diff --git a/instrument/events.h b/instrument/events.h
index 6507b26867..8c944e1f91 100644
--- a/instrument/events.h
+++ b/instrument/events.h
@@ -68,6 +68,13 @@ extern void (*instr_event__guest_mem_before_exec)(
 static inline void instr_guest_mem_before_exec(
     CPUState *vcpu, uint64_t vaddr, TraceMemInfo info);
=20
+extern void (*instr_event__guest_user_syscall)(
+    QICPU vcpu, uint64_t num, uint64_t arg1, uint64_t arg2, uint64_t arg=
3,
+    uint64_t arg4, uint64_t arg5, uint64_t arg6, uint64_t arg7, uint64_t=
 arg8);
+static inline void instr_guest_user_syscall(
+    CPUState *vcpu, uint64_t num, uint64_t arg1, uint64_t arg2, uint64_t=
 arg3,
+    uint64_t arg4, uint64_t arg5, uint64_t arg6, uint64_t arg7, uint64_t=
 arg8);
+
=20
 #include "instrument/events.inc.h"
=20
diff --git a/instrument/events.inc.h b/instrument/events.inc.h
index ebc8020715..e2f4315fb0 100644
--- a/instrument/events.inc.h
+++ b/instrument/events.inc.h
@@ -78,3 +78,19 @@ static inline void instr_guest_mem_before_exec(
         instr_set_state(INSTR_STATE_DISABLE);
     }
 }
+
+static inline void instr_guest_user_syscall(
+    CPUState *vcpu, uint64_t num, uint64_t arg1, uint64_t arg2, uint64_t=
 arg3,
+    uint64_t arg4, uint64_t arg5, uint64_t arg6, uint64_t arg7, uint64_t=
 arg8)
+{
+    void (*cb)(QICPU vcpu, uint64_t num, uint64_t arg1, uint64_t arg2,
+               uint64_t arg3, uint64_t arg4, uint64_t arg5, uint64_t arg=
6,
+               uint64_t arg7, uint64_t arg8)
+        =3D instr_get_event(guest_user_syscall);
+    if (cb) {
+        instr_set_state(INSTR_STATE_ENABLE);
+        QICPU vcpu_ =3D instr_cpu_to_qicpu(vcpu);
+        (*cb)(vcpu_, num, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8=
);
+        instr_set_state(INSTR_STATE_DISABLE);
+    }
+}
diff --git a/instrument/load.c b/instrument/load.c
index f1d769b92d..a76f76e1d1 100644
--- a/instrument/load.c
+++ b/instrument/load.c
@@ -164,6 +164,7 @@ InstrUnloadError instr_unload(const char *id)
     instr_set_event(guest_cpu_reset, NULL);
     instr_set_event(guest_mem_before_trans, NULL);
     instr_set_event(guest_mem_before_exec, NULL);
+    instr_set_event(guest_user_syscall, NULL);
=20
     instr_cpu_stop_all_end(&info);
     cpu_list_unlock();
diff --git a/instrument/qemu-instr/control.h b/instrument/qemu-instr/cont=
rol.h
index acd4b10f03..136058af4f 100644
--- a/instrument/qemu-instr/control.h
+++ b/instrument/qemu-instr/control.h
@@ -142,6 +142,21 @@ void qi_event_gen_guest_mem_before_exec(
 void qi_event_set_guest_mem_before_exec(
     void (*fn)(QICPU vcpu, uint64_t vaddr, QIMemInfo info));
=20
+/*
+ * Start executing a guest system call in syscall emulation mode.
+ *
+ * @num: System call number.
+ * @arg*: System call argument value.
+ *
+ * Mode: user
+ * Targets: TCG(all)
+ * Time: exec
+ */
+void qi_event_set_guest_user_syscall(
+    void (*fn)(QICPU vcpu, uint64_t num, uint64_t arg1, uint64_t arg2,
+               uint64_t arg3, uint64_t arg4, uint64_t arg5, uint64_t arg=
6,
+               uint64_t arg7, uint64_t arg8));
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e73a07fa6f..c9f0b9fa56 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7723,6 +7723,8 @@ abi_long do_syscall(void *cpu_env, int num, abi_lon=
g arg1,
 #ifdef DEBUG
     gemu_log("syscall %d", num);
 #endif
+    instr_guest_user_syscall(cpu, num,
+                             arg1, arg2, arg3, arg4, arg5, arg6, arg7, a=
rg8);
     trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg=
6, arg7, arg8);
     if(do_strace)
         print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
diff --git a/stubs/instrument.c b/stubs/instrument.c
index 640c91f470..bb585c69ce 100644
--- a/stubs/instrument.c
+++ b/stubs/instrument.c
@@ -66,3 +66,6 @@ void helper_instr_guest_mem_before_exec(
 void (*instr_event__guest_mem_before_exec)(
     QICPU vcpu_trans, QITCGv_cpu vcpu_exec,
     QITCGv vaddr, QIMemInfo info);
+void (*instr_event__guest_user_syscall)(
+    QICPU vcpu, uint64_t num, uint64_t arg1, uint64_t arg2, uint64_t arg=
3,
+    uint64_t arg4, uint64_t arg5, uint64_t arg6, uint64_t arg7, uint64_t=
 arg8);
