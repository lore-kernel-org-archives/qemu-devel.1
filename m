Received: from eggs.gnu.org ([2001:4830:134:3::10]:55692)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpfAy-0001Br-Jc
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpfAt-0004dx-Ah
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:35:48 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:33047)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpfAs-0004dY-UW
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:35:43 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed,  6 Sep 2017 21:35:23 +0300
Message-Id: <150472292357.24907.8416317535071720615.stgit@frigg.lan>
In-Reply-To: <150471856141.24907.274176769201097378.stgit@frigg.lan>
References: <150471856141.24907.274176769201097378.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 18/20] instrument: Add event
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
Cc: Eric Blake <eblake@redhat.com>, "Emilio G. Cota" <cota@braap.org>, Stefan Hajnoczi <stefanha@redhat.com>, =?UTF-8?q?Llu=C3=ADs=20Vilanova?= <vilanova@ac.upc.edu>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Llu=C3=ADs Vilanova <vilanova@ac.upc.edu>
---
 bsd-user/syscall.c              |    3 +++
 instrument/control.c            |   14 ++++++++++++++
 instrument/events.h             |    7 +++++++
 instrument/events.inc.h         |   16 ++++++++++++++++
 instrument/load.c               |    1 +
 instrument/qemu-instr/control.h |   15 +++++++++++++++
 linux-user/syscall.c            |    1 +
 stubs/instrument.c              |    3 +++
 8 files changed, 60 insertions(+)

diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
index 3230f722f3..43f8887529 100644
--- a/bsd-user/syscall.c
+++ b/bsd-user/syscall.c
@@ -324,6 +324,7 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, a=
bi_long arg1,
 #ifdef DEBUG
     gemu_log("freebsd syscall %d\n", num);
 #endif
+    instr_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg=
6, arg7, arg8);
     trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg=
6, arg7, arg8);
     if(do_strace)
         print_freebsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
@@ -423,6 +424,7 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, ab=
i_long arg1,
 #ifdef DEBUG
     gemu_log("netbsd syscall %d\n", num);
 #endif
+    instr_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg=
6, 0, 0);
     trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg=
6, 0, 0);
     if(do_strace)
         print_netbsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
@@ -499,6 +501,7 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, a=
bi_long arg1,
 #ifdef DEBUG
     gemu_log("openbsd syscall %d\n", num);
 #endif
+    instr_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg=
6, 0, 0);
     trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg=
6, 0, 0);
     if(do_strace)
         print_openbsd_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
diff --git a/instrument/control.c b/instrument/control.c
index f39e81d7c7..7e84dadf24 100644
--- a/instrument/control.c
+++ b/instrument/control.c
@@ -121,3 +121,17 @@ QI_VPUBLIC void qi_event_set_guest_mem_before_exec(
     ERROR_IF(!instr_get_state(), "called outside instrumentation");
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
+QI_VPUBLIC void qi_event_set_guest_user_syscall(
+    void (*fn)(QICPU vcpu, uint64_t num, uint64_t arg1, uint64_t arg2,
+               uint64_t arg3, uint64_t arg4, uint64_t arg5, uint64_t arg=
6,
+               uint64_t arg7, uint64_t arg8))
+{
+    ERROR_IF(!instr_get_state(), "called outside instrumentation");
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
index d7a3065ac1..9c64497533 100644
--- a/instrument/events.inc.h
+++ b/instrument/events.inc.h
@@ -77,3 +77,19 @@ static inline void instr_guest_mem_before_exec(
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
+        QICPU vcpu_ =3D instr_cpu_set(vcpu);
+        (*cb)(vcpu_, num, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8=
);
+        instr_set_state(INSTR_STATE_DISABLE);
+    }
+}
diff --git a/instrument/load.c b/instrument/load.c
index 1df660d5d1..d977049082 100644
--- a/instrument/load.c
+++ b/instrument/load.c
@@ -153,6 +153,7 @@ InstrUnloadError instr_unload(int64_t handle_id)
     instr_set_event(guest_cpu_reset, NULL);
     instr_set_event(guest_mem_before_trans, NULL);
     instr_set_event(guest_mem_before_exec, NULL);
+    instr_set_event(guest_user_syscall, NULL);
=20
     /* this should never fail */
     if (dlclose(handle->dlhandle) < 0) {
diff --git a/instrument/qemu-instr/control.h b/instrument/qemu-instr/cont=
rol.h
index 4fa99a968d..cba8ade54e 100644
--- a/instrument/qemu-instr/control.h
+++ b/instrument/qemu-instr/control.h
@@ -134,6 +134,21 @@ void qi_event_gen_guest_mem_before_exec(
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
index e73a07fa6f..c0c33d4a75 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -7723,6 +7723,7 @@ abi_long do_syscall(void *cpu_env, int num, abi_lon=
g arg1,
 #ifdef DEBUG
     gemu_log("syscall %d", num);
 #endif
+    instr_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg=
6, arg7, arg8);
     trace_guest_user_syscall(cpu, num, arg1, arg2, arg3, arg4, arg5, arg=
6, arg7, arg8);
     if(do_strace)
         print_syscall(num, arg1, arg2, arg3, arg4, arg5, arg6);
diff --git a/stubs/instrument.c b/stubs/instrument.c
index c6c279c85e..dbd8b1438d 100644
--- a/stubs/instrument.c
+++ b/stubs/instrument.c
@@ -18,3 +18,6 @@ void (*instr_event__guest_mem_before_trans)(
     QICPU vcpu_trans, QITCGv_cpu vcpu_exec, QITCGv vaddr, QIMemInfo info=
);
 void (*instr_event__guest_mem_before_exec)(
     QICPU vcpu_trans, QITCGv_cpu vcpu_exec, QITCGv vaddr, QIMemInfo info=
);
+void (*instr_event__guest_user_syscall)(
+    QICPU vcpu, uint64_t num, uint64_t arg1, uint64_t arg2, uint64_t arg=
3,
+    uint64_t arg4, uint64_t arg5, uint64_t arg6, uint64_t arg7, uint64_t=
 arg8);
