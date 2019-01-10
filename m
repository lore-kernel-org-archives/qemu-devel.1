Received: from eggs.gnu.org ([209.51.188.92]:49451)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1ghZ1p-0001Fa-I1
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:01:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1ghZ1k-00005T-Uy
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:01:41 -0500
Received: from forwardcorp1o.cmail.yandex.net ([37.9.109.47]:48490)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1ghZ1k-0008Sj-AB
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 07:01:36 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
Date: Thu, 10 Jan 2019 15:01:19 +0300
Message-Id: <20190110120120.9943-4-yury-kotov@yandex-team.ru>
In-Reply-To: <20190110120120.9943-1-yury-kotov@yandex-team.ru>
References: <20190110120120.9943-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 3/4] migration: introduce ignore-external
 capability
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: wrfsh@yandex-team.ru

We want to use local migration to update QEMU for running guests.
In this case we don't need to migrate external RAM.
So, add a capability to ignore such blocks during live migration.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 exec.c                    |  5 +++++
 include/exec/cpu-common.h |  1 +
 migration/migration.c     |  9 +++++++++
 migration/migration.h     |  1 +
 migration/ram.c           | 37 ++++++++++++++++++++++++++++++++++---
 qapi/migration.json       |  6 +++++-
 6 files changed, 55 insertions(+), 4 deletions(-)

diff --git a/exec.c b/exec.c
index ef2f29d7cb..3c3e42993f 100644
--- a/exec.c
+++ b/exec.c
@@ -2000,6 +2000,11 @@ void qemu_ram_unset_migratable(RAMBlock *rb)
     rb->flags &=3D ~RAM_MIGRATABLE;
 }
=20
+bool qemu_ram_is_external(RAMBlock *rb)
+{
+    return rb->flags & RAM_EXTERNAL;
+}
+
 /* Called with iothread lock held.  */
 void qemu_ram_set_idstr(RAMBlock *new_block, const char *name, DeviceSta=
te *dev)
 {
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 2ad2d6d86b..57e84e5aa4 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -78,6 +78,7 @@ void qemu_ram_set_uf_zeroable(RAMBlock *rb);
 bool qemu_ram_is_migratable(RAMBlock *rb);
 void qemu_ram_set_migratable(RAMBlock *rb);
 void qemu_ram_unset_migratable(RAMBlock *rb);
+bool qemu_ram_is_external(RAMBlock *rb);
=20
 size_t qemu_ram_pagesize(RAMBlock *block);
 size_t qemu_ram_pagesize_largest(void);
diff --git a/migration/migration.c b/migration/migration.c
index ffc4d9e556..9b789d3535 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -1979,6 +1979,15 @@ bool migrate_dirty_bitmaps(void)
     return s->enabled_capabilities[MIGRATION_CAPABILITY_DIRTY_BITMAPS];
 }
=20
+bool migrate_ignore_external(void)
+{
+    MigrationState *s;
+
+    s =3D migrate_get_current();
+
+    return s->enabled_capabilities[MIGRATION_CAPABILITY_X_IGNORE_EXTERNA=
L];
+}
+
 bool migrate_use_events(void)
 {
     MigrationState *s;
diff --git a/migration/migration.h b/migration/migration.h
index e413d4d8b6..06691242f3 100644
--- a/migration/migration.h
+++ b/migration/migration.h
@@ -255,6 +255,7 @@ bool migrate_release_ram(void);
 bool migrate_postcopy_ram(void);
 bool migrate_zero_blocks(void);
 bool migrate_dirty_bitmaps(void);
+bool migrate_ignore_external(void);
=20
 bool migrate_auto_converge(void);
 bool migrate_use_multifd(void);
diff --git a/migration/ram.c b/migration/ram.c
index 39629254e1..0091a8ae3a 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -166,6 +166,11 @@ out:
=20
 #undef RAMBLOCK_FOREACH
=20
+static bool is_ignored_block(RAMBlock *block)
+{
+    return migrate_ignore_external() && qemu_ram_is_external(block);
+}
+
 static void ramblock_recv_map_init(void)
 {
     RAMBlock *rb;
@@ -1537,7 +1542,7 @@ unsigned long migration_bitmap_find_dirty(RAMState =
*rs, RAMBlock *rb,
     unsigned long *bitmap =3D rb->bmap;
     unsigned long next;
=20
-    if (!qemu_ram_is_migratable(rb)) {
+    if (!qemu_ram_is_migratable(rb) || is_ignored_block(rb)) {
         return size;
     }
=20
@@ -1651,6 +1656,9 @@ static void migration_bitmap_sync(RAMState *rs)
     qemu_mutex_lock(&rs->bitmap_mutex);
     rcu_read_lock();
     RAMBLOCK_FOREACH_MIGRATABLE(block) {
+        if (is_ignored_block(block)) {
+            continue;
+        }
         migration_bitmap_sync_range(rs, block, 0, block->used_length);
     }
     ram_counters.remaining =3D ram_bytes_remaining();
@@ -2472,19 +2480,27 @@ void acct_update_position(QEMUFile *f, size_t siz=
e, bool zero)
     }
 }
=20
-uint64_t ram_bytes_total(void)
+static uint64_t ram_bytes_total_common(bool skip_ignored)
 {
     RAMBlock *block;
     uint64_t total =3D 0;
=20
     rcu_read_lock();
     RAMBLOCK_FOREACH_MIGRATABLE(block) {
+        if (skip_ignored && is_ignored_block(block)) {
+            continue;
+        }
         total +=3D block->used_length;
     }
     rcu_read_unlock();
     return total;
 }
=20
+uint64_t ram_bytes_total(void)
+{
+    return ram_bytes_total_common(true);
+}
+
 static void xbzrle_load_setup(void)
 {
     XBZRLE.decoded_buf =3D g_malloc(TARGET_PAGE_SIZE);
@@ -3162,7 +3178,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque=
)
=20
     rcu_read_lock();
=20
-    qemu_put_be64(f, ram_bytes_total() | RAM_SAVE_FLAG_MEM_SIZE);
+    qemu_put_be64(f, ram_bytes_total_common(false) | RAM_SAVE_FLAG_MEM_S=
IZE);
=20
     RAMBLOCK_FOREACH_MIGRATABLE(block) {
         qemu_put_byte(f, strlen(block->idstr));
@@ -3172,6 +3188,7 @@ static int ram_save_setup(QEMUFile *f, void *opaque=
)
             qemu_put_be64(f, block->page_size);
         }
         qemu_put_be64(f, block->offset);
+        qemu_put_byte(f, is_ignored_block(block) ? 1 : 0);
     }
=20
     rcu_read_unlock();
@@ -4135,13 +4152,27 @@ static int ram_load(QEMUFile *f, void *opaque, in=
t version_id)
                     }
                     if (version_id >=3D 5) {
                         ram_addr_t offset;
+                        bool ignored;
                         offset =3D qemu_get_be64(f);
+                        ignored =3D qemu_get_byte(f);
                         if (block->offset !=3D offset) {
                             error_report("Mismatched RAM block offset %s=
 "
                                          "%" PRId64 "!=3D %" PRId64,
                                          id, offset, (uint64_t)block->of=
fset);
                             ret =3D -EINVAL;
                         }
+                        if (ignored) {
+                            if (!migrate_ignore_external()) {
+                                error_report("Unexpected ignored RAM blo=
ck %s: "
+                                             "ignore-external capability=
 is "
+                                             "disabled", id);
+                                ret =3D -EINVAL;
+                            } else if (!qemu_ram_is_external(block)) {
+                                error_report("Only external RAM block %s=
 "
+                                             "can be ignored", id);
+                                ret =3D -EINVAL;
+                            }
+                        }
                     }
                     ram_control_load_hook(f, RAM_CONTROL_BLOCK_REG,
                                           block->idstr);
diff --git a/qapi/migration.json b/qapi/migration.json
index 31b589ec26..10bbac87f8 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -406,13 +406,17 @@
 #           devices (and thus take locks) immediately at the end of migr=
ation.
 #           (since 3.0)
 #
+# @x-ignore-external: If enabled, QEMU will not migrate shared memory
+#                     (since 4.0)
+#
 # Since: 1.2
 ##
 { 'enum': 'MigrationCapability',
   'data': ['xbzrle', 'rdma-pin-all', 'auto-converge', 'zero-blocks',
            'compress', 'events', 'postcopy-ram', 'x-colo', 'release-ram'=
,
            'block', 'return-path', 'pause-before-switchover', 'x-multifd=
',
-           'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate' =
] }
+           'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
+           'x-ignore-external' ] }
=20
 ##
 # @MigrationCapabilityStatus:
--=20
2.20.1
