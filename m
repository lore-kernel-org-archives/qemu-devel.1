Received: from eggs.gnu.org ([209.51.188.92]:50020)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1EcJ-0001Fi-76
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1EcI-00021O-BR
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33162)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1EcI-00020j-4C
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:38 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  5 Mar 2019 18:15:55 +0000
Message-Id: <20190305181602.9051-15-dgilbert@redhat.com>
In-Reply-To: <20190305181602.9051-1-dgilbert@redhat.com>
References: <20190305181602.9051-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 14/21] migration: use bitmap_mutex in
 migration_bitmap_clear_dirty
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, marcel.apfelbaum@gmail.com, wei.w.wang@intel.com, yury-kotov@yandex-team.ru, chen.zhang@intel.com

From: Wei Wang <wei.w.wang@intel.com>

The bitmap mutex is used to synchronize threads to update the dirty
bitmap and the migration_dirty_pages counter. For example, the free
page optimization clears bits of free pages from the bitmap in an
iothread context. This patch makes migration_bitmap_clear_dirty update
the bitmap and counter under the mutex.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Peter Xu <peterx@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <1544516693-5395-4-git-send-email-wei.w.wang@intel.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 migration/ram.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 01315edd66..0747873ca9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -342,7 +342,7 @@ struct RAMState {
     uint64_t target_page_count;
     /* number of dirty bits in the bitmap */
     uint64_t migration_dirty_pages;
-    /* protects modification of the bitmap */
+    /* Protects modification of the bitmap and migration dirty pages */
     QemuMutex bitmap_mutex;
     /* The RAMBlock used in the last src_page_requests */
     RAMBlock *last_req_rb;
@@ -1590,11 +1590,14 @@ static inline bool migration_bitmap_clear_dirty(R=
AMState *rs,
 {
     bool ret;
=20
+    qemu_mutex_lock(&rs->bitmap_mutex);
     ret =3D test_and_clear_bit(page, rb->bmap);
=20
     if (ret) {
         rs->migration_dirty_pages--;
     }
+    qemu_mutex_unlock(&rs->bitmap_mutex);
+
     return ret;
 }
=20
--=20
2.20.1
