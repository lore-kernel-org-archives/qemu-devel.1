Received: from eggs.gnu.org ([209.51.188.92]:50048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1EcL-0001Hi-3J
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1h1EcK-00022v-7N
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:41 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36374)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1h1EcJ-00022I-Ty
	for qemu-devel@nongnu.org; Tue, 05 Mar 2019 13:16:40 -0500
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Tue,  5 Mar 2019 18:15:56 +0000
Message-Id: <20190305181602.9051-16-dgilbert@redhat.com>
In-Reply-To: <20190305181602.9051-1-dgilbert@redhat.com>
References: <20190305181602.9051-1-dgilbert@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 15/21] migration: API to clear bits of guest
 free pages from the dirty bitmap
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

This patch adds an API to clear bits corresponding to guest free pages
from the dirty bitmap. Spilt the free page block if it crosses the QEMU
RAMBlock boundary.

Signed-off-by: Wei Wang <wei.w.wang@intel.com>
CC: Dr. David Alan Gilbert <dgilbert@redhat.com>
CC: Juan Quintela <quintela@redhat.com>
CC: Michael S. Tsirkin <mst@redhat.com>
CC: Peter Xu <peterx@redhat.com>
Reviewed-by: Peter Xu <peterx@redhat.com>
Message-Id: <1544516693-5395-5-git-send-email-wei.w.wang@intel.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/misc.h |  2 ++
 migration/ram.c          | 47 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+)

diff --git a/include/migration/misc.h b/include/migration/misc.h
index 0471e04d1f..a3809fc67e 100644
--- a/include/migration/misc.h
+++ b/include/migration/misc.h
@@ -14,12 +14,14 @@
 #ifndef MIGRATION_MISC_H
 #define MIGRATION_MISC_H
=20
+#include "exec/cpu-common.h"
 #include "qemu/notify.h"
 #include "qapi/qapi-types-net.h"
=20
 /* migration/ram.c */
=20
 void ram_mig_init(void);
+void qemu_guest_free_page_hint(void *addr, size_t len);
=20
 /* migration/block.c */
=20
diff --git a/migration/ram.c b/migration/ram.c
index 0747873ca9..32c0dbb98a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3181,6 +3181,53 @@ static void ram_state_resume_prepare(RAMState *rs,=
 QEMUFile *out)
     trace_ram_state_resume_prepare(pages);
 }
=20
+/*
+ * This function clears bits of the free pages reported by the caller fr=
om the
+ * migration dirty bitmap. @addr is the host address corresponding to th=
e
+ * start of the continuous guest free pages, and @len is the total bytes=
 of
+ * those pages.
+ */
+void qemu_guest_free_page_hint(void *addr, size_t len)
+{
+    RAMBlock *block;
+    ram_addr_t offset;
+    size_t used_len, start, npages;
+    MigrationState *s =3D migrate_get_current();
+
+    /* This function is currently expected to be used during live migrat=
ion */
+    if (!migration_is_setup_or_active(s->state)) {
+        return;
+    }
+
+    for (; len > 0; len -=3D used_len, addr +=3D used_len) {
+        block =3D qemu_ram_block_from_host(addr, false, &offset);
+        if (unlikely(!block || offset >=3D block->used_length)) {
+            /*
+             * The implementation might not support RAMBlock resize duri=
ng
+             * live migration, but it could happen in theory with future
+             * updates. So we add a check here to capture that case.
+             */
+            error_report_once("%s unexpected error", __func__);
+            return;
+        }
+
+        if (len <=3D block->used_length - offset) {
+            used_len =3D len;
+        } else {
+            used_len =3D block->used_length - offset;
+        }
+
+        start =3D offset >> TARGET_PAGE_BITS;
+        npages =3D used_len >> TARGET_PAGE_BITS;
+
+        qemu_mutex_lock(&ram_state->bitmap_mutex);
+        ram_state->migration_dirty_pages -=3D
+                      bitmap_count_one_with_offset(block->bmap, start, n=
pages);
+        bitmap_clear(block->bmap, start, npages);
+        qemu_mutex_unlock(&ram_state->bitmap_mutex);
+    }
+}
+
 /*
  * Each of ram_save_setup, ram_save_iterate and ram_save_complete has
  * long-running RCU critical section.  When rcu-reclaims in the code
--=20
2.20.1
