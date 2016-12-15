Received: from eggs.gnu.org ([2001:4830:134:3::10]:42523)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBs-0002tr-Om
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cHKBp-0001Hz-Hh
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:32 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59252
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1cHKBp-0001Hf-Bp
	for qemu-devel@nongnu.org; Wed, 14 Dec 2016 19:46:29 -0500
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
	uBF0jfEw079907
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:28 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0b-001b2d01.pphosted.com with ESMTP id 27bdm790b4-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Wed, 14 Dec 2016 19:46:28 -0500
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Wed, 14 Dec 2016 19:46:28 -0500
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Wed, 14 Dec 2016 18:43:56 -0600
In-Reply-To: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1481762701-4587-1-git-send-email-mdroth@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Message-Id: <1481762701-4587-3-git-send-email-mdroth@linux.vnet.ibm.com>
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 02/67] hw/ppc/spapr: Move code related to "ibm,
 pa-features" to a separate function
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

The function spapr_populate_cpu_dt() has become quite big
already, and since we likely have to extend the pa-features
property for every new processor generation, it is nicer
if we put the related code into a separate function.

Signed-off-by: Thomas Huth <thuth@redhat.com>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
(cherry picked from commit 230bf719d3a3b144a4ffa441e5d6170ef0ad8999)
---
 hw/ppc/spapr.c | 66 ++++++++++++++++++++++++++++++++--------------------=
------
 1 file changed, 36 insertions(+), 30 deletions(-)

diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
index 30d6800..36d9077 100644
--- a/hw/ppc/spapr.c
+++ b/hw/ppc/spapr.c
@@ -594,6 +594,41 @@ static int spapr_populate_memory(sPAPRMachineState *=
spapr, void *fdt)
     return 0;
 }
=20
+/* Populate the "ibm,pa-features" property */
+static void spapr_populate_pa_features(CPUPPCState *env, void *fdt, int =
offset)
+{
+    uint8_t pa_features_206[] =3D { 6, 0,
+        0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
+    uint8_t pa_features_207[] =3D { 24, 0,
+        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0,
+        0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
+        0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
+        0x80, 0x00, 0x80, 0x00, 0x80, 0x00 };
+    uint8_t *pa_features;
+    size_t pa_size;
+
+    if (env->mmu_model =3D=3D POWERPC_MMU_2_06) {
+        pa_features =3D pa_features_206;
+        pa_size =3D sizeof(pa_features_206);
+    } else { /* env->mmu_model =3D=3D POWERPC_MMU_2_07 */
+        pa_features =3D pa_features_207;
+        pa_size =3D sizeof(pa_features_207);
+    }
+
+    if (env->ci_large_pages) {
+        /*
+         * Note: we keep CI large pages off by default because a 64K cap=
able
+         * guest provisioned with large pages might otherwise try to map=
 a qemu
+         * framebuffer (or other kind of memory mapped PCI BAR) using 64=
K pages
+         * even if that qemu runs on a 4k host.
+         * We dd this bit back here if we are confident this is not an i=
ssue
+         */
+        pa_features[3] |=3D 0x20;
+    }
+
+    _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_si=
ze)));
+}
+
 static void spapr_populate_cpu_dt(CPUState *cs, void *fdt, int offset,
                                   sPAPRMachineState *spapr)
 {
@@ -621,24 +656,6 @@ static void spapr_populate_cpu_dt(CPUState *cs, void=
 *fdt, int offset,
         _FDT((fdt_setprop_cell(fdt, offset, "ibm,my-drc-index", drc_inde=
x)));
     }
=20
-    /* Note: we keep CI large pages off for now because a 64K capable gu=
est
-     * provisioned with large pages might otherwise try to map a qemu
-     * framebuffer (or other kind of memory mapped PCI BAR) using 64K pa=
ges
-     * even if that qemu runs on a 4k host.
-     *
-     * We can later add this bit back when we are confident this is not
-     * an issue (!HV KVM or 64K host)
-     */
-    uint8_t pa_features_206[] =3D { 6, 0,
-        0xf6, 0x1f, 0xc7, 0x00, 0x80, 0xc0 };
-    uint8_t pa_features_207[] =3D { 24, 0,
-        0xf6, 0x1f, 0xc7, 0xc0, 0x80, 0xf0,
-        0x80, 0x00, 0x00, 0x00, 0x00, 0x00,
-        0x00, 0x00, 0x00, 0x00, 0x80, 0x00,
-        0x80, 0x00, 0x80, 0x00, 0x80, 0x00 };
-    uint8_t *pa_features;
-    size_t pa_size;
-
     _FDT((fdt_setprop_cell(fdt, offset, "reg", index)));
     _FDT((fdt_setprop_string(fdt, offset, "device_type", "cpu")));
=20
@@ -705,18 +722,7 @@ static void spapr_populate_cpu_dt(CPUState *cs, void=
 *fdt, int offset,
                           page_sizes_prop, page_sizes_prop_size)));
     }
=20
-    /* Do the ibm,pa-features property, adjust it for ci-large-pages */
-    if (env->mmu_model =3D=3D POWERPC_MMU_2_06) {
-        pa_features =3D pa_features_206;
-        pa_size =3D sizeof(pa_features_206);
-    } else /* env->mmu_model =3D=3D POWERPC_MMU_2_07 */ {
-        pa_features =3D pa_features_207;
-        pa_size =3D sizeof(pa_features_207);
-    }
-    if (env->ci_large_pages) {
-        pa_features[3] |=3D 0x20;
-    }
-    _FDT((fdt_setprop(fdt, offset, "ibm,pa-features", pa_features, pa_si=
ze)));
+    spapr_populate_pa_features(env, fdt, offset);
=20
     _FDT((fdt_setprop_cell(fdt, offset, "ibm,chip-id",
                            cs->cpu_index / vcpus_per_socket)));
--=20
1.9.1
