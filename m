Received: from eggs.gnu.org ([2001:4830:134:3::10]:47680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1fD3od-0003RB-6E
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 04:05:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1fD3oZ-0002jj-V4
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 04:05:43 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:37698
	helo=mx07-00178001.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christophe.lyon@st.com>)
	id 1fD3oZ-0002jL-Jd
	for qemu-devel@nongnu.org; Mon, 30 Apr 2018 04:05:39 -0400
From: Christophe Lyon <christophe.lyon@st.com>
Date: Mon, 30 Apr 2018 10:03:44 +0200
Message-ID: <20180430080404.7323-5-christophe.lyon@st.com>
In-Reply-To: <20180430080404.7323-1-christophe.lyon@st.com>
References: <20180430080404.7323-1-christophe.lyon@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [ARM/FDPIC v4 4/4] linux-user: ARM-FDPIC: Add support
 for signals for FDPIC targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, christophe.lyon@linaro.org, peter.maydell@linaro.org, riku.voipio@iki.fi, laurent@vivier.eu

The FDPIC restorer needs to deal with a function descriptor, hence we
have to extend 'retcode' such that it can hold the instructions needed
to perform this.

The restorer sequence uses the same thumbness as the exception
handler (mainly to support Thumb-only architectures).

Co-Authored-By: Micka=C3=ABl Gu=C3=AAn=C3=A9 <mickael.guene@st.com>
Signed-off-by: Christophe Lyon <christophe.lyon@st.com>

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 8d9e6e8..6dbc699 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -2045,13 +2045,13 @@ struct sigframe_v1
 {
     struct target_sigcontext sc;
     abi_ulong extramask[TARGET_NSIG_WORDS-1];
-    abi_ulong retcode;
+    abi_ulong retcode[4];
 };
=20
 struct sigframe_v2
 {
     struct target_ucontext_v2 uc;
-    abi_ulong retcode;
+    abi_ulong retcode[4];
 };
=20
 struct rt_sigframe_v1
@@ -2060,14 +2060,14 @@ struct rt_sigframe_v1
     abi_ulong puc;
     struct target_siginfo info;
     struct target_ucontext_v1 uc;
-    abi_ulong retcode;
+    abi_ulong retcode[4];
 };
=20
 struct rt_sigframe_v2
 {
     struct target_siginfo info;
     struct target_ucontext_v2 uc;
-    abi_ulong retcode;
+    abi_ulong retcode[4];
 };
=20
 #define TARGET_CONFIG_CPU_32 1
@@ -2090,6 +2090,21 @@ static const abi_ulong retcodes[4] =3D {
 	SWI_SYS_RT_SIGRETURN,	SWI_THUMB_RT_SIGRETURN
 };
=20
+/*
+ * Stub needed to make sure the FD register (r9) contains the right
+ * value.
+ */
+static const unsigned long sigreturn_fdpic_codes[3] =3D {
+    0xe59fc004, /* ldr r12, [pc, #4] to read function descriptor */
+    0xe59c9004, /* ldr r9, [r12, #4] to setup GOT */
+    0xe59cf000  /* ldr pc, [r12] to jump into restorer */
+};
+
+static const unsigned long sigreturn_fdpic_thumb_codes[3] =3D {
+    0xc008f8df, /* ldr r12, [pc, #8] to read function descriptor */
+    0x9004f8dc, /* ldr r9, [r12, #4] to setup GOT */
+    0xf000f8dc  /* ldr pc, [r12] to jump into restorer */
+};
=20
 static inline int valid_user_regs(CPUARMState *regs)
 {
@@ -2143,13 +2158,33 @@ get_sigframe(struct target_sigaction *ka, CPUARMS=
tate *regs, int framesize)
     return (sp - framesize) & ~7;
 }
=20
-static void
+static int
 setup_return(CPUARMState *env, struct target_sigaction *ka,
              abi_ulong *rc, abi_ulong frame_addr, int usig, abi_ulong rc=
_addr)
 {
-    abi_ulong handler =3D ka->_sa_handler;
+    abi_ulong handler =3D 0;
+    abi_ulong handler_fdpic_GOT =3D 0;
     abi_ulong retcode;
-    int thumb =3D handler & 1;
+
+    int thumb;
+    int is_fdpic =3D info_is_fdpic(((TaskState *)thread_cpu->opaque)->in=
fo);
+
+    if (is_fdpic) {
+        /* In FDPIC mode, ka->_sa_handler points to a function
+         * descriptor (FD). The first word contains the address of the
+         * handler. The second word contains the value of the PIC
+         * register (r9).  */
+        abi_ulong funcdesc_ptr =3D ka->_sa_handler;
+        if (get_user_ual(handler, funcdesc_ptr)
+            || get_user_ual(handler_fdpic_GOT, funcdesc_ptr + 4)) {
+            return 1;
+        }
+    } else {
+        handler =3D ka->_sa_handler;
+    }
+
+    thumb =3D handler & 1;
+
     uint32_t cpsr =3D cpsr_read(env);
=20
     cpsr &=3D ~CPSR_IT;
@@ -2160,7 +2195,28 @@ setup_return(CPUARMState *env, struct target_sigac=
tion *ka,
     }
=20
     if (ka->sa_flags & TARGET_SA_RESTORER) {
-        retcode =3D ka->sa_restorer;
+        if (is_fdpic) {
+            /* For FDPIC we ensure that the restorer is called with a
+             * correct r9 value.  For that we need to write code on
+             * the stack that sets r9 and jumps back to restorer
+             * value.
+             */
+            if (thumb) {
+                __put_user(sigreturn_fdpic_thumb_codes[0], rc);
+                __put_user(sigreturn_fdpic_thumb_codes[1], rc + 1);
+                __put_user(sigreturn_fdpic_thumb_codes[2], rc + 2);
+                __put_user((abi_ulong)ka->sa_restorer, rc + 3);
+            } else {
+                __put_user(sigreturn_fdpic_codes[0], rc);
+                __put_user(sigreturn_fdpic_codes[1], rc + 1);
+                __put_user(sigreturn_fdpic_codes[2], rc + 2);
+                __put_user((abi_ulong)ka->sa_restorer, rc + 3);
+            }
+
+            retcode =3D rc_addr + thumb;
+        } else {
+            retcode =3D ka->sa_restorer;
+        }
     } else {
         unsigned int idx =3D thumb;
=20
@@ -2174,10 +2230,15 @@ setup_return(CPUARMState *env, struct target_siga=
ction *ka,
     }
=20
     env->regs[0] =3D usig;
+    if (is_fdpic) {
+        env->regs[9] =3D handler_fdpic_GOT;
+    }
     env->regs[13] =3D frame_addr;
     env->regs[14] =3D retcode;
     env->regs[15] =3D handler & (thumb ? ~1 : ~3);
     cpsr_write(env, cpsr, CPSR_IT | CPSR_T, CPSRWriteByInstr);
+
+    return 0;
 }
=20
 static abi_ulong *setup_sigframe_v2_vfp(abi_ulong *regspace, CPUARMState=
 *env)
@@ -2270,12 +2331,15 @@ static void setup_frame_v1(int usig, struct targe=
t_sigaction *ka,
         __put_user(set->sig[i], &frame->extramask[i - 1]);
     }
=20
-    setup_return(regs, ka, &frame->retcode, frame_addr, usig,
-                 frame_addr + offsetof(struct sigframe_v1, retcode));
+    if (setup_return(regs, ka, frame->retcode, frame_addr, usig,
+                     frame_addr + offsetof(struct sigframe_v1, retcode))=
) {
+        goto sigsegv;
+    }
=20
     unlock_user_struct(frame, frame_addr, 1);
     return;
 sigsegv:
+    unlock_user_struct(frame, frame_addr, 1);
     force_sigsegv(usig);
 }
=20
@@ -2292,12 +2356,15 @@ static void setup_frame_v2(int usig, struct targe=
t_sigaction *ka,
=20
     setup_sigframe_v2(&frame->uc, set, regs);
=20
-    setup_return(regs, ka, &frame->retcode, frame_addr, usig,
-                 frame_addr + offsetof(struct sigframe_v2, retcode));
+    if (setup_return(regs, ka, frame->retcode, frame_addr, usig,
+                     frame_addr + offsetof(struct sigframe_v2, retcode))=
) {
+        goto sigsegv;
+    }
=20
     unlock_user_struct(frame, frame_addr, 1);
     return;
 sigsegv:
+    unlock_user_struct(frame, frame_addr, 1);
     force_sigsegv(usig);
 }
=20
@@ -2347,8 +2414,10 @@ static void setup_rt_frame_v1(int usig, struct tar=
get_sigaction *ka,
         __put_user(set->sig[i], &frame->uc.tuc_sigmask.sig[i]);
     }
=20
-    setup_return(env, ka, &frame->retcode, frame_addr, usig,
-                 frame_addr + offsetof(struct rt_sigframe_v1, retcode));
+    if (setup_return(env, ka, frame->retcode, frame_addr, usig,
+                     frame_addr + offsetof(struct rt_sigframe_v1, retcod=
e))) {
+        goto sigsegv;
+    }
=20
     env->regs[1] =3D info_addr;
     env->regs[2] =3D uc_addr;
@@ -2356,6 +2425,7 @@ static void setup_rt_frame_v1(int usig, struct targ=
et_sigaction *ka,
     unlock_user_struct(frame, frame_addr, 1);
     return;
 sigsegv:
+    unlock_user_struct(frame, frame_addr, 1);
     force_sigsegv(usig);
 }
=20
@@ -2378,8 +2448,10 @@ static void setup_rt_frame_v2(int usig, struct tar=
get_sigaction *ka,
=20
     setup_sigframe_v2(&frame->uc, set, env);
=20
-    setup_return(env, ka, &frame->retcode, frame_addr, usig,
-                 frame_addr + offsetof(struct rt_sigframe_v2, retcode));
+    if (setup_return(env, ka, frame->retcode, frame_addr, usig,
+                     frame_addr + offsetof(struct rt_sigframe_v2, retcod=
e))) {
+        goto sigsegv;
+    }
=20
     env->regs[1] =3D info_addr;
     env->regs[2] =3D uc_addr;
@@ -2387,6 +2459,7 @@ static void setup_rt_frame_v2(int usig, struct targ=
et_sigaction *ka,
     unlock_user_struct(frame, frame_addr, 1);
     return;
 sigsegv:
+    unlock_user_struct(frame, frame_addr, 1);
     force_sigsegv(usig);
 }
=20
--=20
2.6.3
