Received: from eggs.gnu.org ([209.51.188.92]:44086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1guhYz-000648-I4
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:46:14 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1guhYy-0002HI-6V
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:46:13 -0500
Received: from forwardcorp1g.cmail.yandex.net ([2a02:6b8:0:1465::fd]:60944)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1guhYx-0002F3-RQ
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 12:46:12 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
Date: Fri, 15 Feb 2019 20:45:44 +0300
Message-Id: <20190215174548.2630-2-yury-kotov@yandex-team.ru>
In-Reply-To: <20190215174548.2630-1-yury-kotov@yandex-team.ru>
References: <20190215174548.2630-1-yury-kotov@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 1/5] exec: Change RAMBlockIterFunc definition
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Juan Quintela <quintela@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: wrfsh@yandex-team.ru, jiangshanlai@gmail.com, qemu-devel@lists.ewheeler.net, peter.maydell@linaro.org

Currently, qemu_ram_foreach_* calls RAMBlockIterFunc with many
block-specific arguments. But often iter func needs RAMBlock*.
This refactoring is needed for fast access to RAMBlock flags from
qemu_ram_foreach_block's callback. The only way to achieve this now
is to call qemu_ram_block_from_host (which also enumerates blocks).

So, this patch reduces complexity of
qemu_ram_foreach_block() -> cb() -> qemu_ram_block_from_host()
from O(n^2) to O(n).

Fix RAMBlockIterFunc definition and add some functions to read
RAMBlock* fields witch were passed.

Signed-off-by: Yury Kotov <yury-kotov@yandex-team.ru>
---
 exec.c                    | 21 +++++++++++++++++----
 include/exec/cpu-common.h |  6 ++++--
 migration/postcopy-ram.c  | 36 +++++++++++++++++++++---------------
 migration/rdma.c          |  7 +++++--
 stubs/ram-block.c         | 15 +++++++++++++++
 util/vfio-helpers.c       |  6 +++---
 6 files changed, 65 insertions(+), 26 deletions(-)

diff --git a/exec.c b/exec.c
index 518064530b..bf71462929 100644
--- a/exec.c
+++ b/exec.c
@@ -1972,6 +1972,21 @@ const char *qemu_ram_get_idstr(RAMBlock *rb)
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
@@ -3961,8 +3976,7 @@ int qemu_ram_foreach_block(RAMBlockIterFunc func, v=
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
@@ -3981,8 +3995,7 @@ int qemu_ram_foreach_migratable_block(RAMBlockIterF=
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
index 63ec1f9b37..9cd1f94bc5 100644
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
@@ -116,8 +119,7 @@ void cpu_flush_icache_range(hwaddr start, hwaddr len)=
;
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
diff --git a/stubs/ram-block.c b/stubs/ram-block.c
index cfa5d8678f..73c0a3ee08 100644
--- a/stubs/ram-block.c
+++ b/stubs/ram-block.c
@@ -2,6 +2,21 @@
 #include "exec/ramlist.h"
 #include "exec/cpu-common.h"
=20
+void *qemu_ram_get_host_addr(RAMBlock *rb)
+{
+    return 0;
+}
+
+ram_addr_t qemu_ram_get_offset(RAMBlock *rb)
+{
+    return 0;
+}
+
+ram_addr_t qemu_ram_get_used_length(RAMBlock *rb)
+{
+    return 0;
+}
+
 void ram_block_notifier_add(RAMBlockNotifier *n)
 {
 }
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
