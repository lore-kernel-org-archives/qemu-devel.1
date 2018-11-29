Received: from eggs.gnu.org ([2001:4830:134:3::10]:56365)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSIKP-0001sH-Hf
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:09:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSIKM-0007rw-GC
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:09:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59318)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gSIKI-0007pa-OS
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:09:40 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 29 Nov 2018 10:09:31 +0100
Message-Id: <20181129090933.30622-2-pbonzini@redhat.com>
In-Reply-To: <20181129090933.30622-1-pbonzini@redhat.com>
References: <20181129090933.30622-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/3] memory: extract
 flat_range_coalesced_io_{del, add}
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

Extract two new functions from memory_region_update_coalesced_range_as.
To avoid duplication in the creation of the MemoryRegionSection, use
MEMORY_LISTENER_UPDATE_REGION instead of MEMORY_LISTENER_CALL
to invoke the listener callback.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 53 +++++++++++++++++++++++++++++------------------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/memory.c b/memory.c
index d14c6dec1d..119b6e46d5 100644
--- a/memory.c
+++ b/memory.c
@@ -850,6 +850,33 @@ static void address_space_update_ioeventfds(AddressS=
pace *as)
     flatview_unref(view);
 }
=20
+static void flat_range_coalesced_io_del(FlatRange *fr, AddressSpace *as)
+{
+    MEMORY_LISTENER_UPDATE_REGION(fr, as, Reverse, coalesced_io_del,
+                                  int128_get64(fr->addr.start),
+                                  int128_get64(fr->addr.size));
+}
+
+static void flat_range_coalesced_io_add(FlatRange *fr, AddressSpace *as)
+{
+    MemoryRegion *mr =3D fr->mr;
+    CoalescedMemoryRange *cmr;
+    AddrRange tmp;
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
+        MEMORY_LISTENER_UPDATE_REGION(fr, as, Forward, coalesced_io_add,
+                                      int128_get64(tmp.start),
+                                      int128_get64(tmp.size));
+    }
+}
+
 static void address_space_update_topology_pass(AddressSpace *as,
                                                const FlatView *old_view,
                                                const FlatView *new_view,
@@ -2136,34 +2163,12 @@ static void memory_region_update_coalesced_range_=
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
--=20
2.19.1
