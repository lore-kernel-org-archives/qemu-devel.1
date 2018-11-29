Received: from eggs.gnu.org ([2001:4830:134:3::10]:56375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSIKQ-0001t3-Fi
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:09:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gSIKO-0007sq-EC
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:09:46 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42544)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gSIKL-0007qF-NG
	for qemu-devel@nongnu.org; Thu, 29 Nov 2018 04:09:42 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 29 Nov 2018 10:09:32 +0100
Message-Id: <20181129090933.30622-3-pbonzini@redhat.com>
In-Reply-To: <20181129090933.30622-1-pbonzini@redhat.com>
References: <20181129090933.30622-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/3] memory: avoid unnecessary coalesced_io_del
 operations
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

Store whether the FlatRange has had any coalesced I/O ranges applied,
and if not avoid calling coalesced_io_del.  This is useful in preparation
for the next patch, which will call coalesced_io_del when rendering
memory regions.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 memory.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/memory.c b/memory.c
index 119b6e46d5..072769aa06 100644
--- a/memory.c
+++ b/memory.c
@@ -217,6 +217,7 @@ struct FlatRange {
     bool romd_mode;
     bool readonly;
     bool nonvolatile;
+    bool has_coalesced_range;
 };
=20
 #define FOR_EACH_FLAT_RANGE(var, view)          \
@@ -650,6 +651,7 @@ static void render_memory_region(FlatView *view,
     fr.romd_mode =3D mr->romd_mode;
     fr.readonly =3D readonly;
     fr.nonvolatile =3D nonvolatile;
+    fr.has_coalesced_range =3D false;
=20
     /* Render the region itself into any gaps left by the current view. =
*/
     for (i =3D 0; i < view->nr && int128_nz(remain); ++i) {
@@ -852,6 +854,10 @@ static void address_space_update_ioeventfds(AddressS=
pace *as)
=20
 static void flat_range_coalesced_io_del(FlatRange *fr, AddressSpace *as)
 {
+    if (!fr->has_coalesced_range) {
+        return;
+    }
+
     MEMORY_LISTENER_UPDATE_REGION(fr, as, Reverse, coalesced_io_del,
                                   int128_get64(fr->addr.start),
                                   int128_get64(fr->addr.size));
@@ -863,6 +869,11 @@ static void flat_range_coalesced_io_add(FlatRange *f=
r, AddressSpace *as)
     CoalescedMemoryRange *cmr;
     AddrRange tmp;
=20
+    if (QTAILQ_EMPTY(&mr->coalesced)) {
+        return;
+    }
+
+    fr->has_coalesced_range =3D true;
     QTAILQ_FOREACH(cmr, &mr->coalesced, link) {
         tmp =3D addrrange_shift(cmr->addr,
                               int128_sub(fr->addr.start,
--=20
2.19.1
