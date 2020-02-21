Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3442C11D28
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:51:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8CF892071E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 03:51:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8CF892071E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=emindsoft.com.cn
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4zLh-0007UT-Mj
	for qemu-devel@archiver.kernel.org; Thu, 20 Feb 2020 22:51:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:48231)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <chengang@emindsoft.com.cn>) id 1j4zGd-0001FN-4y
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:46:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <chengang@emindsoft.com.cn>) id 1j4zGb-0005G5-5x
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:46:18 -0500
Received: from lucky1.263xmail.com ([211.157.147.134]:32926)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <chengang@emindsoft.com.cn>)
 id 1j4zGa-000542-Cr
 for qemu-devel@nongnu.org; Thu, 20 Feb 2020 22:46:17 -0500
Received: from localhost (unknown [192.168.167.209])
 by lucky1.263xmail.com (Postfix) with ESMTP id 1BF0258200;
 Fri, 21 Feb 2020 11:46:05 +0800 (CST)
X-MAIL-GRAY: 0
X-MAIL-DELIVERY: 1
X-ADDR-CHECKED4: 1
X-ANTISPAM-LEVEL: 2
X-ABS-CHECKED: 0
Received: from localhost.localdomain (unknown [223.72.97.172])
 by smtp.263.net (postfix) whith ESMTP id
 P22442T140151049139968S1582256757456790_; 
 Fri, 21 Feb 2020 11:46:05 +0800 (CST)
X-UNIQUE-TAG: <9f80cb3f1d8e9caecd045f22d6f27df4>
X-RL-SENDER: chengang@emindsoft.com.cn
X-SENDER: chengang@emindsoft.com.cn
X-LOGIN-NAME: chengang@emindsoft.com.cn
X-FST-TO: pbonzini@redhat.com
X-SENDER-IP: 223.72.97.172
X-ATTACHMENT-NUM: 0
X-DNS-TYPE: 0
From: chengang@emindsoft.com.cn
To: pbonzini@redhat.com
Subject: [PATCH] target: i386: Check float overflow about register stack
Date: Fri, 21 Feb 2020 11:45:47 +0800
Message-Id: <20200221034547.5215-1-chengang@emindsoft.com.cn>
X-Mailer: git-send-email 2.24.0.308.g228f53135a
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 211.157.147.134
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-devel@nongnu.org, Chen Gang <gang.chen.5i5j@gmail.com>,
 chengang@emindsoft.com.cn, ehabkost@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Chen Gang <gang.chen.5i5j@gmail.com>

The fxam instruction also checks the register stack overflow, which can
be get by the following fstsw instruction. The related code is below, it
works well under real x86_64 hardware, but can not work under qemu-i386.

0006b63c <_CIsqrt>:
   6b63c:       55                      push   %ebp
   6b63d:       89 e5                   mov    %esp,%ebp
   6b63f:       83 ec 44                sub    $0x44,%esp
   6b642:       dd 1c 24                fstpl  (%esp)
   6b645:       9b                      fwait
   6b646:       e8 d5 04 00 00          call   6bb20 <wine_backtrace>
   6b64b:       b9 01 00 00 00          mov    $0x1,%ecx
   6b650:       d9 e5                   fxam
   6b652:       9b df e0                fstsw  %ax
   6b655:       66 25 00 45             and    $0x4500,%ax
   6b659:       66 3d 00 41             cmp    $0x4100,%ax
   6b65d:       74 07                   je     6b666 <_CIsqrt+0x2a>
   6b65f:       dd 1c cc                fstpl  (%esp,%ecx,8)
   6b662:       9b                      fwait
   6b663:       41                      inc    %ecx
   6b664:       eb ea                   jmp    6b650 <_CIsqrt+0x14>
   6b666:       89 4d fc                mov    %ecx,-0x4(%ebp)
   6b669:       e8 b2 0f 00 00          call   6c620 <MSVCRT_sqrt>
   6b66e:       8b 4d fc                mov    -0x4(%ebp),%ecx
   6b671:       dd 1c 24                fstpl  (%esp)
   6b674:       49                      dec    %ecx
   6b675:       dd 04 cc                fldl   (%esp,%ecx,8)
   6b678:       83 f9 00                cmp    $0x0,%ecx
   6b67b:       75 f7                   jne    6b674 <_CIsqrt+0x38>
   6b67d:       c9                      leave
   6b67e:       c3                      ret
   6b67f:       90                      nop

Signed-off-by: Chen Gang <chengang@emindsoft.com.cn>
---
 target/i386/cpu.h        |  1 +
 target/i386/fpu_helper.c | 70 ++++++++++++++++++++++++----------------
 2 files changed, 44 insertions(+), 27 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index 576f309bbf..3e2b719ab7 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -1394,6 +1394,7 @@ typedef struct CPUX86State {
     struct {} start_init_save;
=20
     /* FPU state */
+    bool foverflow;
     unsigned int fpstt; /* top of stack index */
     uint16_t fpus;
     uint16_t fpuc;
diff --git a/target/i386/fpu_helper.c b/target/i386/fpu_helper.c
index 99f28f267f..81f3cefe8b 100644
--- a/target/i386/fpu_helper.c
+++ b/target/i386/fpu_helper.c
@@ -91,17 +91,31 @@ void cpu_set_ignne(void)
 }
 #endif
=20
+static inline void set_fpstt(CPUX86State *env, unsigned int fpstt,
+                             bool pop, bool full)
+{
+    env->foverflow =3D (fpstt > 7) && full; /* clear the original flag *=
/
+    if (pop) {
+        if (full) {
+            env->fptags[env->fpstt] =3D 1; /* invalidate stack entry */
+        }
+        env->fpstt =3D fpstt & 7;
+    } else {
+        env->fpstt =3D fpstt & 7;
+        if (full) {
+            env->fptags[env->fpstt] =3D 0; /* validate stack entry */
+        }
+    }
+}
=20
 static inline void fpush(CPUX86State *env)
 {
-    env->fpstt =3D (env->fpstt - 1) & 7;
-    env->fptags[env->fpstt] =3D 0; /* validate stack entry */
+    set_fpstt(env, env->fpstt - 1, false, true);
 }
=20
 static inline void fpop(CPUX86State *env)
 {
-    env->fptags[env->fpstt] =3D 1; /* invalidate stack entry */
-    env->fpstt =3D (env->fpstt + 1) & 7;
+    set_fpstt(env, env->fpstt + 1, true, true);
 }
=20
 static inline floatx80 helper_fldt(CPUX86State *env, target_ulong ptr,
@@ -211,11 +225,10 @@ void helper_flds_ST0(CPUX86State *env, uint32_t val=
)
         uint32_t i;
     } u;
=20
-    new_fpstt =3D (env->fpstt - 1) & 7;
+    new_fpstt =3D env->fpstt - 1;
     u.i =3D val;
-    env->fpregs[new_fpstt].d =3D float32_to_floatx80(u.f, &env->fp_statu=
s);
-    env->fpstt =3D new_fpstt;
-    env->fptags[new_fpstt] =3D 0; /* validate stack entry */
+    env->fpregs[new_fpstt & 7].d =3D float32_to_floatx80(u.f, &env->fp_s=
tatus);
+    set_fpstt(env, new_fpstt, false, true);
 }
=20
 void helper_fldl_ST0(CPUX86State *env, uint64_t val)
@@ -226,31 +239,28 @@ void helper_fldl_ST0(CPUX86State *env, uint64_t val=
)
         uint64_t i;
     } u;
=20
-    new_fpstt =3D (env->fpstt - 1) & 7;
+    new_fpstt =3D env->fpstt - 1;
     u.i =3D val;
-    env->fpregs[new_fpstt].d =3D float64_to_floatx80(u.f, &env->fp_statu=
s);
-    env->fpstt =3D new_fpstt;
-    env->fptags[new_fpstt] =3D 0; /* validate stack entry */
+    env->fpregs[new_fpstt & 7].d =3D float64_to_floatx80(u.f, &env->fp_s=
tatus);
+    set_fpstt(env, new_fpstt, false, true);
 }
=20
 void helper_fildl_ST0(CPUX86State *env, int32_t val)
 {
     int new_fpstt;
=20
-    new_fpstt =3D (env->fpstt - 1) & 7;
-    env->fpregs[new_fpstt].d =3D int32_to_floatx80(val, &env->fp_status)=
;
-    env->fpstt =3D new_fpstt;
-    env->fptags[new_fpstt] =3D 0; /* validate stack entry */
+    new_fpstt =3D env->fpstt - 1;
+    env->fpregs[new_fpstt & 7].d =3D int32_to_floatx80(val, &env->fp_sta=
tus);
+    set_fpstt(env, new_fpstt, false, true);
 }
=20
 void helper_fildll_ST0(CPUX86State *env, int64_t val)
 {
     int new_fpstt;
=20
-    new_fpstt =3D (env->fpstt - 1) & 7;
-    env->fpregs[new_fpstt].d =3D int64_to_floatx80(val, &env->fp_status)=
;
-    env->fpstt =3D new_fpstt;
-    env->fptags[new_fpstt] =3D 0; /* validate stack entry */
+    new_fpstt =3D env->fpstt - 1;
+    env->fpregs[new_fpstt & 7].d =3D int64_to_floatx80(val, &env->fp_sta=
tus);
+    set_fpstt(env, new_fpstt, false, true);
 }
=20
 uint32_t helper_fsts_ST0(CPUX86State *env)
@@ -345,10 +355,9 @@ void helper_fldt_ST0(CPUX86State *env, target_ulong =
ptr)
 {
     int new_fpstt;
=20
-    new_fpstt =3D (env->fpstt - 1) & 7;
-    env->fpregs[new_fpstt].d =3D helper_fldt(env, ptr, GETPC());
-    env->fpstt =3D new_fpstt;
-    env->fptags[new_fpstt] =3D 0; /* validate stack entry */
+    new_fpstt =3D env->fpstt - 1;
+    env->fpregs[new_fpstt & 7].d =3D helper_fldt(env, ptr, GETPC());
+    set_fpstt(env, new_fpstt, false, true);
 }
=20
 void helper_fstt_ST0(CPUX86State *env, target_ulong ptr)
@@ -368,13 +377,13 @@ void helper_fpop(CPUX86State *env)
=20
 void helper_fdecstp(CPUX86State *env)
 {
-    env->fpstt =3D (env->fpstt - 1) & 7;
+    set_fpstt(env, env->fpstt - 1, false, false);
     env->fpus &=3D ~0x4700;
 }
=20
 void helper_fincstp(CPUX86State *env)
 {
-    env->fpstt =3D (env->fpstt + 1) & 7;
+    set_fpstt(env, env->fpstt + 1, true, false);
     env->fpus &=3D ~0x4700;
 }
=20
@@ -382,6 +391,7 @@ void helper_fincstp(CPUX86State *env)
=20
 void helper_ffree_STN(CPUX86State *env, int st_index)
 {
+    set_fpstt(env, env->fpstt + st_index, true, false);
     env->fptags[(env->fpstt + st_index) & 7] =3D 1;
 }
=20
@@ -644,6 +654,7 @@ void helper_fninit(CPUX86State *env)
 {
     env->fpus =3D 0;
     env->fpstt =3D 0;
+    env->foverflow =3D false;
     cpu_set_fpuc(env, 0x37f);
     env->fptags[0] =3D 1;
     env->fptags[1] =3D 1;
@@ -1008,6 +1019,11 @@ void helper_fxam_ST0(CPUX86State *env)
     } else {
         env->fpus |=3D 0x400;
     }
+
+    if (env->foverflow) {
+        env->fpus |=3D 0x4100;
+        env->fpus &=3D ~0x400;
+    }
 }
=20
 static void do_fstenv(CPUX86State *env, target_ulong ptr, int data32,
@@ -1636,7 +1652,7 @@ void helper_ldmxcsr(CPUX86State *env, uint32_t val)
=20
 void helper_enter_mmx(CPUX86State *env)
 {
-    env->fpstt =3D 0;
+    set_fpstt(env, 0, true, false);
     *(uint32_t *)(env->fptags) =3D 0;
     *(uint32_t *)(env->fptags + 4) =3D 0;
 }
--=20
2.24.0.308.g228f53135a




