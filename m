Received: from eggs.gnu.org ([209.51.188.92]:43705)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1UxG-0006Ur-BJ
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:43:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1UxF-0005Ij-HG
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:43:22 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1UxF-0005IG-9Z
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:43:21 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  6 Mar 2019 11:42:20 +0000
Message-Id: <20190306114227.9125-16-dgilbert@redhat.com>
In-Reply-To: <20190306114227.9125-1-dgilbert@redhat.com>
References: <20190306114227.9125-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/22] migration: use bitmap_mutex in
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
Cc: eblake@redhat.com, armbru@redhat.com

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
