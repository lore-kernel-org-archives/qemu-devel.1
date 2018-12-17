Received: from eggs.gnu.org ([2001:4830:134:3::10]:43181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ28p-0000Uk-93
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ28l-0003iP-3b
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44218)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZ28h-0003KG-Sj
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:33 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Dec 2018 00:16:35 +0100
Message-Id: <20181217231700.24482-11-pbonzini@redhat.com>
In-Reply-To: <20181217231700.24482-1-pbonzini@redhat.com>
References: <20181217231700.24482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 10/35] memory: update coalesced_range on
 transaction_commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>

The e1000 driver calls memory_region_add_coalescing but
kvm_coalesce_mmio_region is never called for those regions.  The bug
dates back to the introduction of the memory region API; to fix it,
delete and re-add coalesced MMIO ranges when building the FlatViews.

Because coalesced MMIO regions apply to all address spaces, the
has_coalesced_range flag has to be changed into an int.

Fixes: 093bc2cd885e ("Hierarchical memory region API")
Reported-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/memory.c b/memory.c
index 072769aa06..5759f74034 100644
--- a/memory.c
+++ b/memory.c
@@ -217,7 +217,7 @@ struct FlatRange {
     bool romd_mode;
     bool readonly;
     bool nonvolatile;
-    bool has_coalesced_range;
+    int has_coalesced_range;
 };
=20
 #define FOR_EACH_FLAT_RANGE(var, view)          \
@@ -651,7 +651,7 @@ static void render_memory_region(FlatView *view,
     fr.romd_mode =3D mr->romd_mode;
     fr.readonly =3D readonly;
     fr.nonvolatile =3D nonvolatile;
-    fr.has_coalesced_range =3D false;
+    fr.has_coalesced_range =3D 0;
=20
     /* Render the region itself into any gaps left by the current view. =
*/
     for (i =3D 0; i < view->nr && int128_nz(remain); ++i) {
@@ -858,6 +858,10 @@ static void flat_range_coalesced_io_del(FlatRange *f=
r, AddressSpace *as)
         return;
     }
=20
+    if (--fr->has_coalesced_range > 0) {
+        return;
+    }
+
     MEMORY_LISTENER_UPDATE_REGION(fr, as, Reverse, coalesced_io_del,
                                   int128_get64(fr->addr.start),
                                   int128_get64(fr->addr.size));
@@ -873,7 +877,10 @@ static void flat_range_coalesced_io_add(FlatRange *f=
r, AddressSpace *as)
         return;
     }
=20
-    fr->has_coalesced_range =3D true;
+    if (fr->has_coalesced_range++) {
+        return;
+    }
+
     QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
         tmp =3D addrrange_shift(cmr->addr,
                               int128_sub(fr->addr.start,
@@ -920,6 +927,7 @@ static void address_space_update_topology_pass(Addres=
sSpace *as,
             /* In old but not in new, or in both but attributes changed.=
 */
=20
             if (!adding) {
+                flat_range_coalesced_io_del(frold, as);
                 MEMORY_LISTENER_UPDATE_REGION(frold, as, Reverse, region=
_del);
             }
=20
@@ -927,7 +935,9 @@ static void address_space_update_topology_pass(Addres=
sSpace *as,
         } else if (frold && frnew && flatrange_equal(frold, frnew)) {
             /* In both and unchanged (except logging may have changed) *=
/
=20
-            if (adding) {
+            if (!adding) {
+                flat_range_coalesced_io_del(frold, as);
+            } else {
                 MEMORY_LISTENER_UPDATE_REGION(frnew, as, Forward, region=
_nop);
                 if (frnew->dirty_log_mask & ~frold->dirty_log_mask) {
                     MEMORY_LISTENER_UPDATE_REGION(frnew, as, Forward, lo=
g_start,
@@ -939,6 +949,7 @@ static void address_space_update_topology_pass(Addres=
sSpace *as,
                                                   frold->dirty_log_mask,
                                                   frnew->dirty_log_mask)=
;
                 }
+                flat_range_coalesced_io_add(frnew, as);
             }
=20
             ++iold;
@@ -948,6 +959,7 @@ static void address_space_update_topology_pass(Addres=
sSpace *as,
=20
             if (adding) {
                 MEMORY_LISTENER_UPDATE_REGION(frnew, as, Forward, region=
_add);
+                flat_range_coalesced_io_add(frnew, as);
             }
=20
             ++inew;
--=20
2.20.1
