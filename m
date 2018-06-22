Received: from eggs.gnu.org ([2001:4830:134:3::10]:39844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWDd3-0007lk-79
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:24:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fWDd1-0003cl-8V
	for qemu-devel@nongnu.org; Fri, 22 Jun 2018 00:24:57 -0400
From: David Gibson <david@gibson.dropbear.id.au>
Date: Fri, 22 Jun 2018 14:24:35 +1000
Message-Id: <20180622042437.14259-21-david@gibson.dropbear.id.au>
In-Reply-To: <20180622042437.14259-1-david@gibson.dropbear.id.au>
References: <20180622042437.14259-1-david@gibson.dropbear.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 21/23] target/ppc: Add
 ppc_hash64_filter_pagesizes()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: agraf@suse.de, aik@ozlabs.ru, groug@kaod.org, clg@kaod.org, lvivier@redhat.com, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

The paravirtualized PAPR platform sometimes needs to restrict the guest t=
o
using only some of the page sizes actually supported by the host's MMU.
At the moment this is handled in KVM specific code, but for consistency w=
e
want to apply the same limitations to all accelerators.

This makes a start on this by providing a helper function in the cpu code
to allow platform code to remove some of the cpu's page size definitions
via a caller supplied callback.

Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Greg Kurz <groug@kaod.org>
---
 target/ppc/mmu-hash64.c | 59 +++++++++++++++++++++++++++++++++++++++++
 target/ppc/mmu-hash64.h |  3 +++
 2 files changed, 62 insertions(+)

diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
index aa200cba4c..276d9015e7 100644
--- a/target/ppc/mmu-hash64.c
+++ b/target/ppc/mmu-hash64.c
@@ -1166,3 +1166,62 @@ const PPCHash64Options ppc_hash64_opts_POWER7 =3D =
{
         },
     }
 };
+
+void ppc_hash64_filter_pagesizes(PowerPCCPU *cpu,
+                                 bool (*cb)(void *, uint32_t, uint32_t),
+                                 void *opaque)
+{
+    PPCHash64Options *opts =3D cpu->hash64_opts;
+    int i;
+    int n =3D 0;
+    bool ci_largepage =3D false;
+
+    assert(opts);
+
+    n =3D 0;
+    for (i =3D 0; i < ARRAY_SIZE(opts->sps); i++) {
+        PPCHash64SegmentPageSizes *sps =3D &opts->sps[i];
+        int j;
+        int m =3D 0;
+
+        assert(n <=3D i);
+
+        if (!sps->page_shift) {
+            break;
+        }
+
+        for (j =3D 0; j < ARRAY_SIZE(sps->enc); j++) {
+            PPCHash64PageSize *ps =3D &sps->enc[j];
+
+            assert(m <=3D j);
+            if (!ps->page_shift) {
+                break;
+            }
+
+            if (cb(opaque, sps->page_shift, ps->page_shift)) {
+                if (ps->page_shift >=3D 16) {
+                    ci_largepage =3D true;
+                }
+                sps->enc[m++] =3D *ps;
+            }
+        }
+
+        /* Clear rest of the row */
+        for (j =3D m; j < ARRAY_SIZE(sps->enc); j++) {
+            memset(&sps->enc[j], 0, sizeof(sps->enc[j]));
+        }
+
+        if (m) {
+            n++;
+        }
+    }
+
+    /* Clear the rest of the table */
+    for (i =3D n; i < ARRAY_SIZE(opts->sps); i++) {
+        memset(&opts->sps[i], 0, sizeof(opts->sps[i]));
+    }
+
+    if (!ci_largepage) {
+        opts->flags &=3D ~PPC_HASH64_CI_LARGEPAGE;
+    }
+}
diff --git a/target/ppc/mmu-hash64.h b/target/ppc/mmu-hash64.h
index 53dcec5b93..f11efc9cbc 100644
--- a/target/ppc/mmu-hash64.h
+++ b/target/ppc/mmu-hash64.h
@@ -20,6 +20,9 @@ unsigned ppc_hash64_hpte_page_shift_noslb(PowerPCCPU *c=
pu,
 void ppc_store_lpcr(PowerPCCPU *cpu, target_ulong val);
 void ppc_hash64_init(PowerPCCPU *cpu);
 void ppc_hash64_finalize(PowerPCCPU *cpu);
+void ppc_hash64_filter_pagesizes(PowerPCCPU *cpu,
+                                 bool (*cb)(void *, uint32_t, uint32_t),
+                                 void *opaque);
 #endif
=20
 /*
--=20
2.17.1
