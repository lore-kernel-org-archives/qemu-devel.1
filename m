Received: from eggs.gnu.org ([2001:4830:134:3::10]:37543)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1famD8-00072x-4J
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 14:09:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1famD4-0003dL-Gn
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 14:09:01 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:54680 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1famD4-0003cQ-58
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 14:08:58 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Wed,  4 Jul 2018 20:08:27 +0200
Message-Id: <1530727708-5416-8-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1530727708-5416-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1530727708-5416-1-git-send-email-aleksandar.markovic@rt-rk.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 7/8] target/mips: Don't update BadVAddr
 register in Debug Mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, aleksandar.markovic@wavecomp.com, petar.jovanovic@wavecomp.com, pburton@wavecomp.com

From: Yongbok Kim <yongbok.kim@mips.com>

BadVAddr should not be updated if (env->hflags & MIPS_HFLAG_DM) is
set.

Signed-off-by: Yongbok Kim <yongbok.kim@mips.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@wavecomp.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philippe.mathieu.daude@gmail.co=
m>
---
 target/mips/helper.c    |  4 +++-
 target/mips/op_helper.c | 12 +++++++++---
 2 files changed, 12 insertions(+), 4 deletions(-)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index 8cf91ce..e215af9 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -502,7 +502,9 @@ static void raise_mmu_exception(CPUMIPSState *env, ta=
rget_ulong address,
         break;
     }
     /* Raise exception */
-    env->CP0_BadVAddr =3D address;
+    if (!(env->hflags & MIPS_HFLAG_DM)) {
+        env->CP0_BadVAddr =3D address;
+    }
     env->CP0_Context =3D (env->CP0_Context & ~0x007fffff) |
                        ((address >> 9) & 0x007ffff0);
     env->CP0_EntryHi =3D (env->CP0_EntryHi & env->CP0_EntryHi_ASID_mask)=
 |
diff --git a/target/mips/op_helper.c b/target/mips/op_helper.c
index 0b8ec7d..a6a57bd 100644
--- a/target/mips/op_helper.c
+++ b/target/mips/op_helper.c
@@ -271,7 +271,9 @@ static inline hwaddr do_translate_address(CPUMIPSStat=
e *env,
 target_ulong helper_##name(CPUMIPSState *env, target_ulong arg, int mem_=
idx)  \
 {                                                                       =
      \
     if (arg & almask) {                                                 =
      \
-        env->CP0_BadVAddr =3D arg;                                      =
        \
+        if (!(env->hflags & MIPS_HFLAG_DM)) {                           =
      \
+            env->CP0_BadVAddr =3D arg;                                  =
        \
+        }                                                               =
      \
         do_raise_exception(env, EXCP_AdEL, GETPC());                    =
      \
     }                                                                   =
      \
     env->lladdr =3D do_translate_address(env, arg, 0, GETPC());         =
        \
@@ -291,7 +293,9 @@ target_ulong helper_##name(CPUMIPSState *env, target_=
ulong arg1,              \
     target_long tmp;                                                    =
      \
                                                                         =
      \
     if (arg2 & almask) {                                                =
      \
-        env->CP0_BadVAddr =3D arg2;                                     =
        \
+        if (!(env->hflags & MIPS_HFLAG_DM)) {                           =
      \
+            env->CP0_BadVAddr =3D arg2;                                 =
        \
+        }                                                               =
      \
         do_raise_exception(env, EXCP_AdES, GETPC());                    =
      \
     }                                                                   =
      \
     if (do_translate_address(env, arg2, 1, GETPC()) =3D=3D env->lladdr) =
{         \
@@ -2456,7 +2460,9 @@ void mips_cpu_do_unaligned_access(CPUState *cs, vad=
dr addr,
     int error_code =3D 0;
     int excp;
=20
-    env->CP0_BadVAddr =3D addr;
+    if (!(env->hflags & MIPS_HFLAG_DM)) {
+        env->CP0_BadVAddr =3D addr;
+    }
=20
     if (access_type =3D=3D MMU_DATA_STORE) {
         excp =3D EXCP_AdES;
--=20
2.7.4
