Received: from eggs.gnu.org ([2001:4830:134:3::10]:47233)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gS3Cx-00083O-99
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:01:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gS3Cs-0006cv-0S
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 12:01:03 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42983)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gS2jy-00080y-Rt
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 11:31:07 -0500
References: <20181128.181700.1038782556965887223.atsushi.nemoto@sord.co.jp>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7329ea70-1ae9-4084-0f65-b5ad252348bb@redhat.com>
Date: Wed, 28 Nov 2018 17:30:59 +0100
MIME-Version: 1.0
In-Reply-To: <20181128.181700.1038782556965887223.atsushi.nemoto@sord.co.jp>
Content-Type: multipart/mixed; boundary="------------45188A601B16F00B79E75142"
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] memory: update coalesced_range on
 transaction_commit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>, qemu-devel@nongnu.org

This is a multi-part message in MIME format.
--------------45188A601B16F00B79E75142
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 28/11/18 10:17, Atsushi Nemoto wrote:
> The e1000 driver calls memory_region_add_coalescing but
> kvm_coalesce_mmio_region never been called for those regions.
>=20
> Update coalesced_range on memory_region_transaction_commit to fix this.
>=20
> It seems very old bug since memory region API
> was merged on commit 093bc2cd885e ("Hierarchical memory region API").
>=20
> Signed-off-by: Atsushi Nemoto <atsushi.nemoto@sord.co.jp>

I attach the patch I came up with.  What do you think?

Thanks,

Paolo

>  memory.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/memory.c b/memory.c
> index d14c6dec1d..f773b0be50 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1021,6 +1021,8 @@ void memory_region_transaction_begin(void)
>      ++memory_region_transaction_depth;
>  }
> =20
> +static void memory_region_update_coalesced_range_as(MemoryRegion *mr, =
AddressSpace *as);
> +
>  void memory_region_transaction_commit(void)
>  {
>      AddressSpace *as;
> @@ -1038,6 +1040,7 @@ void memory_region_transaction_commit(void)
>              QTAILQ_FOREACH(as, &address_spaces, address_spaces_link) {
>                  address_space_set_flatview(as);
>                  address_space_update_ioeventfds(as);
> +                memory_region_update_coalesced_range_as(NULL, as);
>              }
>              memory_region_update_pending =3D false;
>              ioeventfd_update_pending =3D false;
> @@ -2142,7 +2145,7 @@ static void memory_region_update_coalesced_range_=
as(MemoryRegion *mr, AddressSpa
> =20
>      view =3D address_space_get_flatview(as);
>      FOR_EACH_FLAT_RANGE(fr, view) {
> -        if (fr->mr =3D=3D mr) {
> +        if (fr->mr =3D=3D mr || (!mr && !QTAILQ_EMPTY(&fr->mr->coalesc=
ed))) {
>              section =3D (MemoryRegionSection) {
>                  .fv =3D view,
>                  .offset_within_address_space =3D int128_get64(fr->addr=
.start),
> @@ -2152,7 +2155,7 @@ static void memory_region_update_coalesced_range_=
as(MemoryRegion *mr, AddressSpa
>              MEMORY_LISTENER_CALL(as, coalesced_io_del, Reverse, &secti=
on,
>                                   int128_get64(fr->addr.start),
>                                   int128_get64(fr->addr.size));
> -            QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
> +            QTAILQ_FOREACH(cmr, &fr->mr->coalesced, link) {
>                  tmp =3D addrrange_shift(cmr->addr,
>                                        int128_sub(fr->addr.start,
>                                                   int128_make64(fr->off=
set_in_region)));
>=20


--------------45188A601B16F00B79E75142
Content-Type: text/x-patch;
 name="coalesce.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="coalesce.patch"

diff --git a/memory.c b/memory.c
index d14c6dec1d..5759f74034 100644
--- a/memory.c
+++ b/memory.c
@@ -217,6 +217,7 @@ struct FlatRange {
     bool romd_mode;
     bool readonly;
     bool nonvolatile;
+    int has_coalesced_range;
 };
=20
 #define FOR_EACH_FLAT_RANGE(var, view)          \
@@ -650,6 +651,7 @@ static void render_memory_region(FlatView *view,
     fr.romd_mode =3D mr->romd_mode;
     fr.readonly =3D readonly;
     fr.nonvolatile =3D nonvolatile;
+    fr.has_coalesced_range =3D 0;
=20
     /* Render the region itself into any gaps left by the current view. =
*/
     for (i =3D 0; i < view->nr && int128_nz(remain); ++i) {
@@ -850,6 +852,49 @@ static void address_space_update_ioeventfds(AddressS=
pace *as)
     flatview_unref(view);
 }
=20
+static void flat_range_coalesced_io_del(FlatRange *fr, AddressSpace *as)=

+{
+    if (!fr->has_coalesced_range) {
+        return;
+    }
+
+    if (--fr->has_coalesced_range > 0) {
+        return;
+    }
+
+    MEMORY_LISTENER_UPDATE_REGION(fr, as, Reverse, coalesced_io_del,
+                                  int128_get64(fr->addr.start),
+                                  int128_get64(fr->addr.size));
+}
+
+static void flat_range_coalesced_io_add(FlatRange *fr, AddressSpace *as)=

+{
+    MemoryRegion *mr =3D fr->mr;
+    CoalescedMemoryRange *cmr;
+    AddrRange tmp;
+
+    if (QTAILQ_EMPTY(&mr->coalesced)) {
+        return;
+    }
+
+    if (fr->has_coalesced_range++) {
+        return;
+    }
+
+    QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
+        tmp =3D addrrange_shift(cmr->addr,
+                              int128_sub(fr->addr.start,
+                                         int128_make64(fr->offset_in_reg=
ion)));
+        if (!addrrange_intersects(tmp, fr->addr)) {
+            continue;
+        }
+        tmp =3D addrrange_intersection(tmp, fr->addr);
+        MEMORY_LISTENER_UPDATE_REGION(fr, as, Forward, coalesced_io_add,=

+                                      int128_get64(tmp.start),
+                                      int128_get64(tmp.size));
+    }
+}
+
 static void address_space_update_topology_pass(AddressSpace *as,
                                                const FlatView *old_view,=

                                                const FlatView *new_view,=

@@ -882,6 +927,7 @@ static void address_space_update_topology_pass(Addres=
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
@@ -889,7 +935,9 @@ static void address_space_update_topology_pass(Addres=
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
@@ -901,6 +949,7 @@ static void address_space_update_topology_pass(Addres=
sSpace *as,
                                                   frold->dirty_log_mask,=

                                                   frnew->dirty_log_mask)=
;
                 }
+                flat_range_coalesced_io_add(frnew, as);
             }
=20
             ++iold;
@@ -910,6 +959,7 @@ static void address_space_update_topology_pass(Addres=
sSpace *as,
=20
             if (adding) {
                 MEMORY_LISTENER_UPDATE_REGION(frnew, as, Forward, region=
_add);
+                flat_range_coalesced_io_add(frnew, as);
             }
=20
             ++inew;
@@ -2136,34 +2186,12 @@ static void memory_region_update_coalesced_range_=
as(MemoryRegion *mr, AddressSpa
 {
     FlatView *view;
     FlatRange *fr;
-    CoalescedMemoryRange *cmr;
-    AddrRange tmp;
-    MemoryRegionSection section;
=20
     view =3D address_space_get_flatview(as);
     FOR_EACH_FLAT_RANGE(fr, view) {
         if (fr->mr =3D=3D mr) {
-            section =3D (MemoryRegionSection) {
-                .fv =3D view,
-                .offset_within_address_space =3D int128_get64(fr->addr.s=
tart),
-                .size =3D fr->addr.size,
-            };
-
-            MEMORY_LISTENER_CALL(as, coalesced_io_del, Reverse, &section=
,
-                                 int128_get64(fr->addr.start),
-                                 int128_get64(fr->addr.size));
-            QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
-                tmp =3D addrrange_shift(cmr->addr,
-                                      int128_sub(fr->addr.start,
-                                                 int128_make64(fr->offse=
t_in_region)));
-                if (!addrrange_intersects(tmp, fr->addr)) {
-                    continue;
-                }
-                tmp =3D addrrange_intersection(tmp, fr->addr);
-                MEMORY_LISTENER_CALL(as, coalesced_io_add, Forward, &sec=
tion,
-                                     int128_get64(tmp.start),
-                                     int128_get64(tmp.size));
-            }
+            flat_range_coalesced_io_del(fr, as);
+            flat_range_coalesced_io_add(fr, as);
         }
     }
     flatview_unref(view);


--------------45188A601B16F00B79E75142--
