Received: from eggs.gnu.org ([2001:4830:134:3::10]:42801)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKC3-0003We-NJ
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKC0-0001Pg-LR
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:43 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44822
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKC0-0001P9-EI
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:40 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0hfvq136263
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:39 -0500
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdm3s0xu-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:39 -0500
Received: from localhost
	by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 17:46:39 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:43:57 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1481762701-4587-4-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 03/67] hw/ppc/spapr: Fix the selection of the
 processor features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, Thomas Huth <thuth@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

From: Thomas Huth <thuth@redhat.com>

The current code uses pa_features_206 for POWERPC_MMU_2_06, and
for everything else, it uses pa_features_207. This is bad in some
cases because there is also a "degraded" MMU version of ISA 2.06,
called POWERPC_MMU_2_06a, which should of course use the flags for
2.06 instead. And there is also the possibility that the user runs
the pseries machine with a POWER5+ or even 970 processor. In that
case we certainly do not want to set the flags for 2.07, and rather
simply skip the setting of the pa-features property instead.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit 4cbec30d769a73853b60dc7f275e6e7da9ab5162)
---
 hw/ppc/spapr.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 36d9077..9f0d99b 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -607,12 +607,19 @@ static void spapr_populate_pa_features(CPUPPCState =
*env, void *fdt, int offset)
     uint8_t *pa_features;
     size_t pa_size;
=20
-    if (env->mmu_model =3D=3D POWERPC_MMU_2_06) {
+    switch (env->mmu_model) {
+    case POWERPC_MMU_2_06:
+    case POWERPC_MMU_2_06a:
         pa_features =3D pa_features_206;
         pa_size =3D sizeof(pa_features_206);
-    } else { /* env->mmu_model =3D=3D POWERPC_MMU_2_07 */
+        break;
+    case POWERPC_MMU_2_07:
+    case POWERPC_MMU_2_07a:
         pa_features =3D pa_features_207;
         pa_size =3D sizeof(pa_features_207);
+        break;
+    default:
+        return;
     }
=20
     if (env->ci_large_pages) {
--=20
1.9.1
