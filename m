Received: from eggs.gnu.org ([209.51.188.92]:51254)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gqeC5-0000pe-Dd
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:21:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gqe1K-00051y-Gq
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:10:44 -0500
Received: from forwardcorp1j.cmail.yandex.net ([5.255.227.105]:54187)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1gqe1G-00047s-L7
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 08:10:41 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
Date: Mon,  4 Feb 2019 16:09:55 +0300
Message-Id: <20190204130958.18904-2-yury-kotov@yandex-team.ru>
In-Reply-To: <20190204130958.18904-1-yury-kotov@yandex-team.ru>
References: <20190204130958.18904-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 1/4] exec: Change RAMBlockIterFunc definition
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

Currently, qemu_ram_foreach_* calls RAMBlockIterFunc with many
block-specific arguments. But often iter func needs RAMBlock*.
It's more effective to call RAMBlockIterFunc with RAMBlock* argument.
So, fix RAMBlockIterFunc definition and add some functions to read RAMBlo=
ck*
fields witch were passed.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 exec.c                    | 21 +++++++++++++++++----
 include/exec/cpu-common.h |  6 ++++--
 migration/postcopy-ram.c  | 36 +++++++++++++++++++++---------------
 migration/rdma.c          |  7 +++++--
 util/vfio-helpers.c       |  6 +++---
 5 files changed, 50 insertions(+), 26 deletions(-)

diff --git a/exec.c b/exec.c
index da3e635f91..a61d501568 100644
--- a/exec.c
+++ b/exec.c
@@ -1970,6 +1970,21 @@ const char *qemu_ram_get_idstr(RAMBlock *rb)
     return rb->idstr;
 }
=20
+void *qemu_ram_get_host_addr(RAMBlock *rb)
+{
+    return rb->host;
+}
+
+ram_addr_t qemu_ram_get_offset(RAMBlock *rb)
+{
+    return rb->offset;
+}
+
+ram_addr_t qemu_ram_get_used_length(RAMBlock *rb)
+{
+    return rb->used_length;
+}
+
 bool qemu_ram_is_shared(RAMBlock *rb)
 {
     return rb->flags & RAM_SHARED;
@@ -3960,8 +3975,7 @@ int qemu_ram_foreach_block(RAMBlockIterFunc func, v=
oid *opaque)
=20
     rcu_read_lock();
     RAMBLOCK_FOREACH(block) {
-        ret =3D func(block->idstr, block->host, block->offset,
-                   block->used_length, opaque);
+        ret =3D func(block, opaque);
         if (ret) {
             break;
         }
@@ -3980,8 +3994,7 @@ int qemu_ram_foreach_migratable_block(RAMBlockIterF=
unc func, void *opaque)
         if (!qemu_ram_is_migratable(block)) {
             continue;
         }
-        ret =3D func(block->idstr, block->host, block->offset,
-                   block->used_length, opaque);
+        ret =3D func(block, opaque);
         if (ret) {
             break;
         }
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index 2ad2d6d86b..bdae5446d7 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -72,6 +72,9 @@ ram_addr_t qemu_ram_block_host_offset(RAMBlock *rb, voi=
d *host);
 void qemu_ram_set_idstr(RAMBlock *block, const char *name, DeviceState *=
dev);
 void qemu_ram_unset_idstr(RAMBlock *block);
 const char *qemu_ram_get_idstr(RAMBlock *rb);
+void *qemu_ram_get_host_addr(RAMBlock *rb);
+ram_addr_t qemu_ram_get_offset(RAMBlock *rb);
+ram_addr_t qemu_ram_get_used_length(RAMBlock *rb);
 bool qemu_ram_is_shared(RAMBlock *rb);
 bool qemu_ram_is_uf_zeroable(RAMBlock *rb);
 void qemu_ram_set_uf_zeroable(RAMBlock *rb);
@@ -116,8 +119,7 @@ void cpu_flush_icache_range(hwaddr start, int len);
 extern struct MemoryRegion io_mem_rom;
 extern struct MemoryRegion io_mem_notdirty;
=20
-typedef int (RAMBlockIterFunc)(const char *block_name, void *host_addr,
-    ram_addr_t offset, ram_addr_t length, void *opaque);
+typedef int (RAMBlockIterFunc)(RAMBlock *rb, void *opaque);
=20
 int qemu_ram_foreach_block(RAMBlockIterFunc func, void *opaque);
 int qemu_ram_foreach_migratable_block(RAMBlockIterFunc func, void *opaqu=
e);
diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
index fa09dba534..b098816221 100644
--- a/migration/postcopy-ram.c
+++ b/migration/postcopy-ram.c
@@ -319,10 +319,10 @@ static bool ufd_check_and_apply(int ufd, MigrationI=
ncomingState *mis)
=20
 /* Callback from postcopy_ram_supported_by_host block iterator.
  */
-static int test_ramblock_postcopiable(const char *block_name, void *host=
_addr,
-                             ram_addr_t offset, ram_addr_t length, void =
*opaque)
+static int test_ramblock_postcopiable(RAMBlock *rb, void *opaque)
 {
-    RAMBlock *rb =3D qemu_ram_block_by_name(block_name);
+    const char *block_name =3D qemu_ram_get_idstr(rb);
+    ram_addr_t length =3D qemu_ram_get_used_length(rb);
     size_t pagesize =3D qemu_ram_pagesize(rb);
=20
     if (length % pagesize) {
@@ -443,9 +443,12 @@ out:
  * must be done right at the start prior to pre-copy.
  * opaque should be the MIS.
  */
-static int init_range(const char *block_name, void *host_addr,
-                      ram_addr_t offset, ram_addr_t length, void *opaque=
)
+static int init_range(RAMBlock *rb, void *opaque)
 {
+    const char *block_name =3D qemu_ram_get_idstr(rb);
+    void *host_addr =3D qemu_ram_get_host_addr(rb);
+    ram_addr_t offset =3D qemu_ram_get_offset(rb);
+    ram_addr_t length =3D qemu_ram_get_used_length(rb);
     trace_postcopy_init_range(block_name, host_addr, offset, length);
=20
     /*
@@ -465,9 +468,12 @@ static int init_range(const char *block_name, void *=
host_addr,
  * At the end of migration, undo the effects of init_range
  * opaque should be the MIS.
  */
-static int cleanup_range(const char *block_name, void *host_addr,
-                        ram_addr_t offset, ram_addr_t length, void *opaq=
ue)
+static int cleanup_range(RAMBlock *rb, void *opaque)
 {
+    const char *block_name =3D qemu_ram_get_idstr(rb);
+    void *host_addr =3D qemu_ram_get_host_addr(rb);
+    ram_addr_t offset =3D qemu_ram_get_offset(rb);
+    ram_addr_t length =3D qemu_ram_get_used_length(rb);
     MigrationIncomingState *mis =3D opaque;
     struct uffdio_range range_struct;
     trace_postcopy_cleanup_range(block_name, host_addr, offset, length);
@@ -586,9 +592,12 @@ int postcopy_ram_incoming_cleanup(MigrationIncomingS=
tate *mis)
 /*
  * Disable huge pages on an area
  */
-static int nhp_range(const char *block_name, void *host_addr,
-                    ram_addr_t offset, ram_addr_t length, void *opaque)
+static int nhp_range(RAMBlock *rb, void *opaque)
 {
+    const char *block_name =3D qemu_ram_get_idstr(rb);
+    void *host_addr =3D qemu_ram_get_host_addr(rb);
+    ram_addr_t offset =3D qemu_ram_get_offset(rb);
+    ram_addr_t length =3D qemu_ram_get_used_length(rb);
     trace_postcopy_nhp_range(block_name, host_addr, offset, length);
=20
     /*
@@ -626,15 +635,13 @@ int postcopy_ram_prepare_discard(MigrationIncomingS=
tate *mis)
  *   opaque: MigrationIncomingState pointer
  * Returns 0 on success
  */
-static int ram_block_enable_notify(const char *block_name, void *host_ad=
dr,
-                                   ram_addr_t offset, ram_addr_t length,
-                                   void *opaque)
+static int ram_block_enable_notify(RAMBlock *rb, void *opaque)
 {
     MigrationIncomingState *mis =3D opaque;
     struct uffdio_register reg_struct;
=20
-    reg_struct.range.start =3D (uintptr_t)host_addr;
-    reg_struct.range.len =3D length;
+    reg_struct.range.start =3D (uintptr_t)qemu_ram_get_host_addr(rb);
+    reg_struct.range.len =3D qemu_ram_get_used_length(rb);
     reg_struct.mode =3D UFFDIO_REGISTER_MODE_MISSING;
=20
     /* Now tell our userfault_fd that it's responsible for this area */
@@ -647,7 +654,6 @@ static int ram_block_enable_notify(const char *block_=
name, void *host_addr,
         return -1;
     }
     if (reg_struct.ioctls & ((__u64)1 << _UFFDIO_ZEROPAGE)) {
-        RAMBlock *rb =3D qemu_ram_block_by_name(block_name);
         qemu_ram_set_uf_zeroable(rb);
     }
=20
diff --git a/migration/rdma.c b/migration/rdma.c
index 54a3c11540..7eb38ee764 100644
--- a/migration/rdma.c
+++ b/migration/rdma.c
@@ -624,9 +624,12 @@ static int rdma_add_block(RDMAContext *rdma, const c=
har *block_name,
  * in advanced before the migration starts. This tells us where the RAM =
blocks
  * are so that we can register them individually.
  */
-static int qemu_rdma_init_one_block(const char *block_name, void *host_a=
ddr,
-    ram_addr_t block_offset, ram_addr_t length, void *opaque)
+static int qemu_rdma_init_one_block(RAMBlock *rb, void *opaque)
 {
+    const char *block_name =3D qemu_ram_get_idstr(rb);
+    void *host_addr =3D qemu_ram_get_host_addr(rb);
+    ram_addr_t block_offset =3D qemu_ram_get_offset(rb);
+    ram_addr_t length =3D qemu_ram_get_used_length(rb);
     return rdma_add_block(opaque, block_name, host_addr, block_offset, l=
ength);
 }
=20
diff --git a/util/vfio-helpers.c b/util/vfio-helpers.c
index 342d4a2285..2367fe8f7f 100644
--- a/util/vfio-helpers.c
+++ b/util/vfio-helpers.c
@@ -391,10 +391,10 @@ static void qemu_vfio_ram_block_removed(RAMBlockNot=
ifier *n,
     }
 }
=20
-static int qemu_vfio_init_ramblock(const char *block_name, void *host_ad=
dr,
-                                   ram_addr_t offset, ram_addr_t length,
-                                   void *opaque)
+static int qemu_vfio_init_ramblock(RAMBlock *rb, void *opaque)
 {
+    void *host_addr =3D qemu_ram_get_host_addr(rb);
+    ram_addr_t length =3D qemu_ram_get_used_length(rb);
     int ret;
     QEMUVFIOState *s =3D opaque;
=20
--=20
2.20.1
