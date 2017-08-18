Received: from eggs.gnu.org ([2001:4830:134:3::10]:49395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1difha-0002Gb-LX
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1difhW-0007II-PX
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51578)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1difhW-0007HY-Ha
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 07:44:30 -0400
From: David Hildenbrand <david@redhat.com>
Date: Fri, 18 Aug 2017 13:43:46 +0200
Message-Id: <20170818114353.13455-12-david@redhat.com>
In-Reply-To: <20170818114353.13455-1-david@redhat.com>
References: <20170818114353.13455-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 for-2.11 11/18] target/s390x: move
 psw_key_valid() to mem_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: rth@twiddle.net, Aurelien Jarno <aurelien@aurel32.net>, thuth@redhat.com, cohuck@redhat.com, david@redhat.com, borntraeger@de.ibm.com, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

Only used in that file.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
---
 target/s390x/cpu.h        | 11 -----------
 target/s390x/mem_helper.c | 11 +++++++++++
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index c71a4bf..8300cb2 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -366,17 +366,6 @@ void s390x_cpu_debug_excp_handler(CPUState *cs);
 #define MMU_SECONDARY_IDX       1
 #define MMU_HOME_IDX            2
=20
-static inline bool psw_key_valid(CPUS390XState *env, uint8_t psw_key)
-{
-    uint16_t pkm =3D env->cregs[3] >> 16;
-
-    if (env->psw.mask & PSW_MASK_PSTATE) {
-        /* PSW key has range 0..15, it is valid if the bit is 1 in the P=
KM */
-        return pkm & (0x80 >> psw_key);
-    }
-    return true;
-}
-
 static inline int cpu_mmu_index(CPUS390XState *env, bool ifetch)
 {
     switch (env->psw.mask & PSW_MASK_ASC) {
diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
index c71dce4..b91c740 100644
--- a/target/s390x/mem_helper.c
+++ b/target/s390x/mem_helper.c
@@ -56,6 +56,17 @@ void tlb_fill(CPUState *cs, target_ulong addr, MMUAcce=
ssType access_type,
 #define HELPER_LOG(x...)
 #endif
=20
+static inline bool psw_key_valid(CPUS390XState *env, uint8_t psw_key)
+{
+    uint16_t pkm =3D env->cregs[3] >> 16;
+
+    if (env->psw.mask & PSW_MASK_PSTATE) {
+        /* PSW key has range 0..15, it is valid if the bit is 1 in the P=
KM */
+        return pkm & (0x80 >> psw_key);
+    }
+    return true;
+}
+
 /* Reduce the length so that addr + len doesn't cross a page boundary.  =
*/
 static inline uint32_t adj_len_to_page(uint32_t len, uint64_t addr)
 {
--=20
2.9.4
