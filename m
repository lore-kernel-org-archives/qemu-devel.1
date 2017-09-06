Received: from eggs.gnu.org ([2001:4830:134:3::10]:57111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpfEu-0002Dv-Im
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:39:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpfEp-0008CP-PR
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:39:52 -0400
Received: from roura.ac.upc.es ([147.83.33.10]:52334)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vilanova@ac.upc.edu>) id 1dpfEp-0008Be-Dh
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 14:39:47 -0400
From: =?utf-8?b?TGx1w61z?= Vilanova <vilanova@ac.upc.edu>
Date: Wed,  6 Sep 2017 21:39:25 +0300
Message-Id: <150472316564.24907.15448502877571730252.stgit@frigg.lan>
In-Reply-To: <150471856141.24907.274176769201097378.stgit@frigg.lan>
References: <150471856141.24907.274176769201097378.stgit@frigg.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v4 19/20] instrument: Add event
 'guest_user_syscall_ret'
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
 instrument/control.c            |   11 +++++++++++
 instrument/events.h             |    5 +++++
 instrument/events.inc.h         |   13 +++++++++++++
 instrument/load.c               |    1 +
 instrument/qemu-instr/control.h |   13 +++++++++++++
 linux-user/syscall.c            |    1 +
 stubs/instrument.c              |    2 ++
 8 files changed, 49 insertions(+)

diff --git a/bsd-user/syscall.c b/bsd-user/syscall.c
index 43f8887529..dcfb31f436 100644
--- a/bsd-user/syscall.c
+++ b/bsd-user/syscall.c
@@ -406,6 +406,7 @@ abi_long do_freebsd_syscall(void *cpu_env, int num, a=
bi_long arg1,
 #endif
     if (do_strace)
         print_freebsd_syscall_ret(num, ret);
+    instr_guest_user_syscall_ret(cpu, num, ret);
     trace_guest_user_syscall_ret(cpu, num, ret);
     return ret;
  efault:
@@ -483,6 +484,7 @@ abi_long do_netbsd_syscall(void *cpu_env, int num, ab=
i_long arg1,
 #endif
     if (do_strace)
         print_netbsd_syscall_ret(num, ret);
+    instr_guest_user_syscall_ret(cpu, num, ret);
     trace_guest_user_syscall_ret(cpu, num, ret);
     return ret;
  efault:
@@ -560,6 +562,7 @@ abi_long do_openbsd_syscall(void *cpu_env, int num, a=
bi_long arg1,
 #endif
     if (do_strace)
         print_openbsd_syscall_ret(num, ret);
+    instr_guest_user_syscall_ret(cpu, num, ret);
     trace_guest_user_syscall_ret(cpu, num, ret);
     return ret;
  efault:
diff --git a/instrument/control.c b/instrument/control.c
index 7e84dadf24..f8f368efb0 100644
--- a/instrument/control.c
+++ b/instrument/control.c
@@ -135,3 +135,14 @@ QI_VPUBLIC void qi_event_set_guest_user_syscall(
     ERROR_IF(!instr_get_state(), "called outside instrumentation");
     instr_set_event(guest_user_syscall, fn);
 }
+
+
+void (*instr_event__guest_user_syscall_ret)(
+    QICPU vcpu, uint64_t num, uint64_t ret);
+
+QI_VPUBLIC void qi_event_set_guest_user_syscall_ret(
+    void (*fn)(QICPU vcpu, uint64_t num, uint64_t ret))
+{
+    ERROR_IF(!instr_get_state(), "called outside instrumentation");
+    instr_set_event(guest_user_syscall_ret, fn);
+}
diff --git a/instrument/events.h b/instrument/events.h
index 8c944e1f91..6197ece466 100644
--- a/instrument/events.h
+++ b/instrument/events.h
@@ -75,6 +75,11 @@ static inline void instr_guest_user_syscall(
     CPUState *vcpu, uint64_t num, uint64_t arg1, uint64_t arg2, uint64_t=
 arg3,
     uint64_t arg4, uint64_t arg5, uint64_t arg6, uint64_t arg7, uint64_t=
 arg8);
=20
+extern void (*instr_event__guest_user_syscall_ret)(
+    QICPU vcpu, uint64_t num, uint64_t ret);
+static inline void instr_guest_user_syscall_ret(
+    CPUState *vcpu, uint64_t num, uint64_t ret);
+
=20
 #include "instrument/events.inc.h"
=20
diff --git a/instrument/events.inc.h b/instrument/events.inc.h
index 9c64497533..ca1d789cea 100644
--- a/instrument/events.inc.h
+++ b/instrument/events.inc.h
@@ -93,3 +93,16 @@ static inline void instr_guest_user_syscall(
         instr_set_state(INSTR_STATE_DISABLE);
     }
 }
+
+static inline void instr_guest_user_syscall_ret(
+    CPUState *vcpu, uint64_t num, uint64_t ret)
+{
+    void (*cb)(QICPU vcpu, uint64_t num, uint64_t ret)
+        =3D instr_get_event(guest_user_syscall_ret);
+    if (cb) {
+        instr_set_state(INSTR_STATE_ENABLE);
+        QICPU vcpu_ =3D instr_cpu_set(vcpu);
+        (*cb)(vcpu_, num, ret);
+        instr_set_state(INSTR_STATE_DISABLE);
+    }
+}
diff --git a/instrument/load.c b/instrument/load.c
index d977049082..decd357105 100644
--- a/instrument/load.c
+++ b/instrument/load.c
@@ -154,6 +154,7 @@ InstrUnloadError instr_unload(int64_t handle_id)
     instr_set_event(guest_mem_before_trans, NULL);
     instr_set_event(guest_mem_before_exec, NULL);
     instr_set_event(guest_user_syscall, NULL);
+    instr_set_event(guest_user_syscall_ret, NULL);
=20
     /* this should never fail */
     if (dlclose(handle->dlhandle) < 0) {
diff --git a/instrument/qemu-instr/control.h b/instrument/qemu-instr/cont=
rol.h
index cba8ade54e..fd83c86c2b 100644
--- a/instrument/qemu-instr/control.h
+++ b/instrument/qemu-instr/control.h
@@ -149,6 +149,19 @@ void qi_event_set_guest_user_syscall(
                uint64_t arg3, uint64_t arg4, uint64_t arg5, uint64_t arg=
6,
                uint64_t arg7, uint64_t arg8));
=20
+/*
+ * Finish executing a guest system call in syscall emulation mode.
+ *
+ * @num: System call number.
+ * @ret: System call result value.
+ *
+ * Mode: user
+ * Targets: TCG(all)
+ * Time: exec
+ */
+void qi_event_set_guest_user_syscall_ret(
+    void (*fn)(QICPU vcpu, uint64_t num, uint64_t ret));
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index c0c33d4a75..0f86b6935d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12397,6 +12397,7 @@ fail:
 #endif
     if(do_strace)
         print_syscall_ret(num, ret);
+    instr_guest_user_syscall_ret(cpu, num, ret);
     trace_guest_user_syscall_ret(cpu, num, ret);
     return ret;
 efault:
diff --git a/stubs/instrument.c b/stubs/instrument.c
index dbd8b1438d..7c171dcee0 100644
--- a/stubs/instrument.c
+++ b/stubs/instrument.c
@@ -21,3 +21,5 @@ void (*instr_event__guest_mem_before_exec)(
 void (*instr_event__guest_user_syscall)(
     QICPU vcpu, uint64_t num, uint64_t arg1, uint64_t arg2, uint64_t arg=
3,
     uint64_t arg4, uint64_t arg5, uint64_t arg6, uint64_t arg7, uint64_t=
 arg8);
+void (*instr_event__guest_user_syscall_ret)(
+    QICPU vcpu, uint64_t num, uint64_t ret);
