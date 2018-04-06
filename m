Received: from eggs.gnu.org ([2001:4830:134:3::10]:32776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1f4T8q-0004On-G2
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:19:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <christophe.lyon@st.com>) id 1f4T8n-0004hO-8a
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:19:04 -0400
Received: from mx08-00178001.pphosted.com ([91.207.212.93]:23918
	helo=mx07-00178001.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <christophe.lyon@st.com>)
	id 1f4T8m-0004h4-UI
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 11:19:01 -0400
From: Christophe Lyon <christophe.lyon@st.com>
Date: Fri, 6 Apr 2018 17:17:31 +0200
Message-ID: <20180406151752.10854-4-christophe.lyon@st.com>
In-Reply-To: <20180406151752.10854-1-christophe.lyon@st.com>
References: <20180406151752.10854-1-christophe.lyon@st.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [ARM/FDPIC 3/4] linux-user: ARM-FDPIC: Add support for
 signals for FDPIC targets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, christophe.lyon@linaro.org, peter.maydell@linaro.org

The FDPIC restorer needs to deal with a function descriptor, hence we
have to extend 'retcode' such that it can hold the instructions needed
to perform this.

The restorer sequence uses the same thumbness as the exception
handler (mainly to support Thumb-only architectures).

Co-Authored-By: Micka=C3=ABl Gu=C3=AAn=C3=A9 <mickael.guene@st.com>
Signed-off-by: Christophe Lyon <christophe.lyon@st.com>

diff --git a/linux-user/signal.c b/linux-user/signal.c
index 2ea3e03..75643d7 100644
--- a/linux-user/signal.c
+++ b/linux-user/signal.c
@@ -2039,13 +2039,13 @@ struct sigframe_v1
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
@@ -2054,14 +2054,14 @@ struct rt_sigframe_v1
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
@@ -2084,6 +2084,23 @@ static const abi_ulong retcodes[4] =3D {
 	SWI_SYS_RT_SIGRETURN,	SWI_THUMB_RT_SIGRETURN
 };
=20
+#if defined(CONFIG_USE_FDPIC)
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
+#endif
=20
 static inline int valid_user_regs(CPUARMState *regs)
 {
@@ -2143,7 +2160,19 @@ setup_return(CPUARMState *env, struct target_sigac=
tion *ka,
 {
     abi_ulong handler =3D ka->_sa_handler;
     abi_ulong retcode;
+
+#ifdef CONFIG_USE_FDPIC
+    int thumb;
+
+    if (env->is_fdpic) {
+        thumb =3D (((abi_ulong *)g2h(ka->_sa_handler))[0]) & 1;
+    } else {
+        thumb =3D handler & 1;
+    }
+#else
     int thumb =3D handler & 1;
+#endif
+
     uint32_t cpsr =3D cpsr_read(env);
=20
     cpsr &=3D ~CPSR_IT;
@@ -2154,8 +2183,37 @@ setup_return(CPUARMState *env, struct target_sigac=
tion *ka,
     }
=20
     if (ka->sa_flags & TARGET_SA_RESTORER) {
+#ifdef CONFIG_USE_FDPIC
+        if (env->is_fdpic) {
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
+        } else
+#endif
         retcode =3D ka->sa_restorer;
     } else {
+#ifdef CONFIG_USE_FDPIC
+        if (env->is_fdpic) {
+            qemu_log_mask(LOG_UNIMP,
+                          "arm: FDPIC signal return not implemented");
+            abort();
+        } else {
+#endif
         unsigned int idx =3D thumb;
=20
         if (ka->sa_flags & TARGET_SA_SIGINFO) {
@@ -2165,12 +2223,29 @@ setup_return(CPUARMState *env, struct target_siga=
ction *ka,
         __put_user(retcodes[idx], rc);
=20
         retcode =3D rc_addr + thumb;
+#ifdef CONFIG_USE_FDPIC
+        }
+#endif
     }
=20
     env->regs[0] =3D usig;
+#ifdef CONFIG_USE_FDPIC
+    if (env->is_fdpic) {
+        env->regs[9] =3D ((abi_ulong *)g2h(ka->_sa_handler))[1];
+    }
+#endif
     env->regs[13] =3D frame_addr;
     env->regs[14] =3D retcode;
+#ifdef CONFIG_USE_FDPIC
+    if (env->is_fdpic) {
+        env->regs[15] =3D ((abi_ulong *)g2h(ka->_sa_handler))[0]
+            & (thumb ? ~1 : ~3);
+    } else {
+        env->regs[15] =3D handler & (thumb ? ~1 : ~3);
+    }
+#else
     env->regs[15] =3D handler & (thumb ? ~1 : ~3);
+#endif
     cpsr_write(env, cpsr, CPSR_IT | CPSR_T, CPSRWriteByInstr);
 }
=20
@@ -2264,7 +2339,7 @@ static void setup_frame_v1(int usig, struct target_=
sigaction *ka,
         __put_user(set->sig[i], &frame->extramask[i - 1]);
     }
=20
-    setup_return(regs, ka, &frame->retcode, frame_addr, usig,
+    setup_return(regs, ka, frame->retcode, frame_addr, usig,
                  frame_addr + offsetof(struct sigframe_v1, retcode));
=20
     unlock_user_struct(frame, frame_addr, 1);
@@ -2286,7 +2361,7 @@ static void setup_frame_v2(int usig, struct target_=
sigaction *ka,
=20
     setup_sigframe_v2(&frame->uc, set, regs);
=20
-    setup_return(regs, ka, &frame->retcode, frame_addr, usig,
+    setup_return(regs, ka, frame->retcode, frame_addr, usig,
                  frame_addr + offsetof(struct sigframe_v2, retcode));
=20
     unlock_user_struct(frame, frame_addr, 1);
@@ -2341,7 +2416,7 @@ static void setup_rt_frame_v1(int usig, struct targ=
et_sigaction *ka,
         __put_user(set->sig[i], &frame->uc.tuc_sigmask.sig[i]);
     }
=20
-    setup_return(env, ka, &frame->retcode, frame_addr, usig,
+    setup_return(env, ka, frame->retcode, frame_addr, usig,
                  frame_addr + offsetof(struct rt_sigframe_v1, retcode));
=20
     env->regs[1] =3D info_addr;
@@ -2372,7 +2447,7 @@ static void setup_rt_frame_v2(int usig, struct targ=
et_sigaction *ka,
=20
     setup_sigframe_v2(&frame->uc, set, env);
=20
-    setup_return(env, ka, &frame->retcode, frame_addr, usig,
+    setup_return(env, ka, frame->retcode, frame_addr, usig,
                  frame_addr + offsetof(struct rt_sigframe_v2, retcode));
=20
     env->regs[1] =3D info_addr;
--=20
2.6.3
