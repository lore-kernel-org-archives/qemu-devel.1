Received: from eggs.gnu.org ([2001:4830:134:3::10]:43119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ28h-0000Nh-6d
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gZ28a-0003Il-Rf
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:39198)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gZ28a-0003IM-Ji
	for qemu-devel@nongnu.org; Mon, 17 Dec 2018 18:17:24 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E2BF942BC3
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:17:23 +0000 (UTC)
Received: from donizetti.redhat.com (unknown [10.36.112.10])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 10A925D9C8
	for <qemu-devel@nongnu.org>; Mon, 17 Dec 2018 23:17:22 +0000 (UTC)
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Tue, 18 Dec 2018 00:16:34 +0100
Message-Id: <20181217231700.24482-10-pbonzini@redhat.com>
In-Reply-To: <20181217231700.24482-1-pbonzini@redhat.com>
References: <20181217231700.24482-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 09/35] memory: avoid unnecessary
 coalesced_io_del operations
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

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
2.20.1
