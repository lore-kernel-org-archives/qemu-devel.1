Received: from eggs.gnu.org ([2001:4830:134:3::10]:45405)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f5slW-00078s-AF
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:52:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f5slV-0002fX-5D
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 08:52:50 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Tue, 10 Apr 2018 22:52:29 +1000
Message-Id: <20180410125233.31618-4-david@gibson.dropbear.id.au>
In-Reply-To: <20180410125233.31618-1-david@gibson.dropbear.id.au>
References: <20180410125233.31618-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/7] target/ppc: Fix backwards migration of
 msr_mask
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: groug@kaod.org, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

21b786f "PowerPC: Add TS bits into msr_mask" added the transaction states
to msr_mask for recent POWER CPUs to allow correct migration of machines
that are in certain interim transactional memory states.

This was correct, but unfortunately breaks backwards of pseries-2.7 and
earlier machine types which (stupidly) transferred the msr_mask in the
migration stream and failed if it wasn't equal on each end.

This works around the problem by masking out the new MSR bits in the
compatibility code to send the msr_mask on old machine types.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Greg Kurz <groug@kaod.org>
Tested-by: Greg Kurz <groug@kaod.org>
Tested-by: Luk=C3=A1=C5=A1 Doktor <ldoktor@redhat.com>
---
 target/ppc/machine.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/target/ppc/machine.c b/target/ppc/machine.c
index e475206c6a..0634cdb295 100644
--- a/target/ppc/machine.c
+++ b/target/ppc/machine.c
@@ -190,7 +190,15 @@ static int cpu_pre_save(void *opaque)
=20
     /* Hacks for migration compatibility between 2.6, 2.7 & 2.8 */
     if (cpu->pre_2_8_migration) {
-        cpu->mig_msr_mask =3D env->msr_mask;
+        /* Mask out bits that got added to msr_mask since the versions
+         * which stupidly included it in the migration stream. */
+        target_ulong metamask =3D 0
+#if defined(TARGET_PPC64)
+            | (1ULL << MSR_TS0)
+            | (1ULL << MSR_TS1)
+#endif
+            ;
+        cpu->mig_msr_mask =3D env->msr_mask & ~metamask;
         cpu->mig_insns_flags =3D env->insns_flags & insns_compat_mask;
         cpu->mig_insns_flags2 =3D env->insns_flags2 & insns_compat_mask2=
;
         cpu->mig_nb_BATs =3D env->nb_BATs;
--=20
2.14.3
