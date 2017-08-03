Received: from eggs.gnu.org ([2001:4830:134:3::10]:35394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ddHNS-00016i-Np
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:45:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ddHNO-0002UP-Kb
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:45:30 -0400
Received: from mailapp01.imgtec.com ([195.59.15.196]:52125)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Yongbok.Kim@imgtec.com>) id 1ddHNO-0002U2-Bo
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 10:45:26 -0400
From: Yongbok Kim <yongbok.kim@imgtec.com>
Date: Thu, 3 Aug 2017 15:45:10 +0100
Message-ID: <1501771515-22847-4-git-send-email-yongbok.kim@imgtec.com>
In-Reply-To: <1501771515-22847-1-git-send-email-yongbok.kim@imgtec.com>
References: <1501771515-22847-1-git-send-email-yongbok.kim@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/8] mips: Improve segment defs for KVM T&E
 guests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, James Hogan <james.hogan@imgtec.com>, Aurelien Jarno <aurelien@aurel32.net>, Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org

From: James Hogan <james.hogan@imgtec.com>

Improve the segment definitions used by get_physical_address() to yield
target_ulong types, e.g. 0xffffffff80000000 instead of 0x80000000. This
is in preparation for enabling emulation of MIPS KVM T&E segments in TCG
MIPS targets, which unlike KVM could potentially have 64-bit
target_ulong. In such a case the offset guest KSEG0 address ends up at
e.g. 0x000000008xxxxxxx instead of 0xffffffff8xxxxxxx.

This also allows the casts to int32_t that force sign extension to be
removed, which removes any confusion due to relational comparison of
unsigned (target_ulong) and signed (int32_t) types.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Yongbok Kim <yongbok.kim@imgtec.com>
Cc: Aurelien Jarno <aurelien@aurel32.net>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Signed-off-by: Yongbok Kim <yongbok.kim@imgtec.com>
---
 target/mips/helper.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/target/mips/helper.c b/target/mips/helper.c
index a2b79e8..05883b9 100644
--- a/target/mips/helper.c
+++ b/target/mips/helper.c
@@ -216,14 +216,14 @@ static int get_physical_address (CPUMIPSState *env,=
 hwaddr *physical,
     /* effective address (modified for KVM T&E kernel segments) */
     target_ulong address =3D real_address;
=20
-#define USEG_LIMIT      0x7FFFFFFFUL
-#define KSEG0_BASE      0x80000000UL
-#define KSEG1_BASE      0xA0000000UL
-#define KSEG2_BASE      0xC0000000UL
-#define KSEG3_BASE      0xE0000000UL
+#define USEG_LIMIT      ((target_ulong)(int32_t)0x7FFFFFFFUL)
+#define KSEG0_BASE      ((target_ulong)(int32_t)0x80000000UL)
+#define KSEG1_BASE      ((target_ulong)(int32_t)0xA0000000UL)
+#define KSEG2_BASE      ((target_ulong)(int32_t)0xC0000000UL)
+#define KSEG3_BASE      ((target_ulong)(int32_t)0xE0000000UL)
=20
-#define KVM_KSEG0_BASE  0x40000000UL
-#define KVM_KSEG2_BASE  0x60000000UL
+#define KVM_KSEG0_BASE  ((target_ulong)(int32_t)0x40000000UL)
+#define KVM_KSEG2_BASE  ((target_ulong)(int32_t)0x60000000UL)
=20
     if (kvm_enabled()) {
         /* KVM T&E adds guest kernel segments in useg */
@@ -307,17 +307,17 @@ static int get_physical_address (CPUMIPSState *env,=
 hwaddr *physical,
             ret =3D TLBRET_BADADDR;
         }
 #endif
-    } else if (address < (int32_t)KSEG1_BASE) {
+    } else if (address < KSEG1_BASE) {
         /* kseg0 */
         ret =3D get_segctl_physical_address(env, physical, prot, real_ad=
dress, rw,
                                           access_type, mmu_idx,
                                           env->CP0_SegCtl1 >> 16, 0x1FFF=
FFFF);
-    } else if (address < (int32_t)KSEG2_BASE) {
+    } else if (address < KSEG2_BASE) {
         /* kseg1 */
         ret =3D get_segctl_physical_address(env, physical, prot, real_ad=
dress, rw,
                                           access_type, mmu_idx,
                                           env->CP0_SegCtl1, 0x1FFFFFFF);
-    } else if (address < (int32_t)KSEG3_BASE) {
+    } else if (address < KSEG3_BASE) {
         /* sseg (kseg2) */
         ret =3D get_segctl_physical_address(env, physical, prot, real_ad=
dress, rw,
                                           access_type, mmu_idx,
@@ -974,8 +974,7 @@ void mips_cpu_do_interrupt(CPUState *cs)
         } else if (cause =3D=3D 30 && !(env->CP0_Config3 & (1 << CP0C3_S=
C) &&
                                     env->CP0_Config5 & (1 << CP0C5_CV)))=
 {
             /* Force KSeg1 for cache errors */
-            env->active_tc.PC =3D (int32_t)KSEG1_BASE |
-                                (env->CP0_EBase & 0x1FFFF000);
+            env->active_tc.PC =3D KSEG1_BASE | (env->CP0_EBase & 0x1FFFF=
000);
         } else {
             env->active_tc.PC =3D env->CP0_EBase & ~0xfff;
         }
--=20
2.7.4
