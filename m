Received: from eggs.gnu.org ([209.51.188.92]:43830)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1UxU-0006h0-B7
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:43:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1UxT-0005WF-BY
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:43:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35858)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1UxT-0005VI-1I
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 06:43:35 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Wed,  6 Mar 2019 11:42:23 +0000
Message-Id: <20190306114227.9125-19-dgilbert@redhat.com>
In-Reply-To: <20190306114227.9125-1-dgilbert@redhat.com>
References: <20190306114227.9125-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 18/22] migration/ram.c: add the free page
 optimization enable flag
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

This patch adds the free page optimization enable flag, and a function
to set this flag. When the free page optimization is enabled, not all
the pages are needed to be sent in the bulk stage.

Why using a new flag, instead of directly disabling ram_bulk_stage when
the optimization is running?
Thanks for Peter Xu's reminder that disabling ram_bulk_stage will affect
the use of compression. Please see save_page_use_compression. When
xbzrle and compression are used, if free page optimizaion causes the
ram_bulk_stage to be disabled, save_page_use_compression will return
false, which disables the use of compression. That is, if free page
optimization avoids the sending of half of the guest pages, the other
half of pages loses the benefits of compression in the meantime. Using a
new flag to let migration_bitmap_find_dirty skip the free pages in the
bulk stage will avoid the above issue.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Peter Xu <peterx@redhat.com>
Message-Id: <1544516693-5395-7-git-send-email-wei.w.wang@intel.com>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/misc.h |  1 +
 migration/ram.c          | 18 +++++++++++++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index dc46d3354f..5cdbabd094 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -38,6 +38,7 @@ void precopy_infrastructure_init(void);
 void precopy_add_notifier(NotifierWithReturn *n);
 void precopy_remove_notifier(NotifierWithReturn *n);
 int precopy_notify(PrecopyNotifyReason reason, Error **errp);
+void precopy_enable_free_page_optimization(void);
=20
 void ram_mig_init(void);
 void qemu_guest_free_page_hint(void *addr, size_t len);
diff --git a/migration/ram.c b/migration/ram.c
index bee4fb3fd4..35bd6213e9 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -316,6 +316,8 @@ struct RAMState {
     uint32_t last_version;
     /* We are in the first round */
     bool ram_bulk_stage;
+    /* The free page optimization is enabled */
+    bool fpo_enabled;
     /* How many times we have dirty too many pages */
     int dirty_rate_high_cnt;
     /* these variables are used for bitmap sync */
@@ -380,6 +382,15 @@ int precopy_notify(PrecopyNotifyReason reason, Error=
 **errp)
     return notifier_with_return_list_notify(&precopy_notifier_list, &pnd=
);
 }
=20
+void precopy_enable_free_page_optimization(void)
+{
+    if (!ram_state) {
+        return;
+    }
+
+    ram_state->fpo_enabled =3D true;
+}
+
 uint64_t ram_bytes_remaining(void)
 {
     return ram_state ? (ram_state->migration_dirty_pages * TARGET_PAGE_S=
IZE) :
@@ -1601,7 +1612,11 @@ unsigned long migration_bitmap_find_dirty(RAMState=
 *rs, RAMBlock *rb,
         return size;
     }
=20
-    if (rs->ram_bulk_stage && start > 0) {
+    /*
+     * When the free page optimization is enabled, we need to check the =
bitmap
+     * to send the non-free pages rather than all the pages in the bulk =
stage.
+     */
+    if (!rs->fpo_enabled && rs->ram_bulk_stage && start > 0) {
         next =3D start + 1;
     } else {
         next =3D find_next_bit(bitmap, size, start);
@@ -2651,6 +2666,7 @@ static void ram_state_reset(RAMState *rs)
     rs->last_page =3D 0;
     rs->last_version =3D ram_list.version;
     rs->ram_bulk_stage =3D true;
+    rs->fpo_enabled =3D false;
 }
=20
 #define MAX_WAIT 50 /* ms, half buffered_file limit */
--=20
2.20.1
