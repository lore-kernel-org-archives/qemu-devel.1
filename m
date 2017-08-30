Received: from eggs.gnu.org ([2001:4830:134:3::10]:57613)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6H3-0003fz-Ey
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:55:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dn6H2-0005qg-BH
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:55:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46570)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dn6H2-0005qP-3z
	for qemu-devel@nongnu.org; Wed, 30 Aug 2017 12:55:28 -0400
From: Cornelia Huck <cohuck@redhat.com>
Date: Wed, 30 Aug 2017 18:52:40 +0200
Message-Id: <20170830165252.13421-33-cohuck@redhat.com>
In-Reply-To: <20170830165252.13421-1-cohuck@redhat.com>
References: <20170830165252.13421-1-cohuck@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 32/44] target/s390x: move cpu_mmu_idx_to_asc()
 to excp_helper.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org, rth@twiddle.net, agraf@suse.de, thuth@redhat.com, borntraeger@de.ibm.com, david@redhat.com, Cornelia Huck <cohuck@redhat.com>

From: David Hildenbrand <david@redhat.com>

Only used in that file.

Reviewed-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: David Hildenbrand <david@redhat.com>
Message-Id: <20170818114353.13455-11-david@redhat.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 target/s390x/cpu.h         | 14 --------------
 target/s390x/excp_helper.c | 14 ++++++++++++++
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/target/s390x/cpu.h b/target/s390x/cpu.h
index 10208ecbbb..c71a4bf0c4 100644
--- a/target/s390x/cpu.h
+++ b/target/s390x/cpu.h
@@ -393,20 +393,6 @@ static inline int cpu_mmu_index(CPUS390XState *env, =
bool ifetch)
     }
 }
=20
-static inline uint64_t cpu_mmu_idx_to_asc(int mmu_idx)
-{
-    switch (mmu_idx) {
-    case MMU_PRIMARY_IDX:
-        return PSW_ASC_PRIMARY;
-    case MMU_SECONDARY_IDX:
-        return PSW_ASC_SECONDARY;
-    case MMU_HOME_IDX:
-        return PSW_ASC_HOME;
-    default:
-        abort();
-    }
-}
-
 static inline void cpu_get_tb_cpu_state(CPUS390XState* env, target_ulong=
 *pc,
                                         target_ulong *cs_base, uint32_t =
*flags)
 {
diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
index d1833772d5..db86259188 100644
--- a/target/s390x/excp_helper.c
+++ b/target/s390x/excp_helper.c
@@ -68,6 +68,20 @@ int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr addr=
ess,
=20
 #else /* !CONFIG_USER_ONLY */
=20
+static inline uint64_t cpu_mmu_idx_to_asc(int mmu_idx)
+{
+    switch (mmu_idx) {
+    case MMU_PRIMARY_IDX:
+        return PSW_ASC_PRIMARY;
+    case MMU_SECONDARY_IDX:
+        return PSW_ASC_SECONDARY;
+    case MMU_HOME_IDX:
+        return PSW_ASC_HOME;
+    default:
+        abort();
+    }
+}
+
 int s390_cpu_handle_mmu_fault(CPUState *cs, vaddr orig_vaddr,
                               int rw, int mmu_idx)
 {
--=20
2.13.5
