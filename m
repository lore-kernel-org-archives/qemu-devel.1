Received: from eggs.gnu.org ([209.51.188.92]:40340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gliO8-0001Rv-E8
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gliO6-0005J1-Qk
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 17:49:52 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 21 Jan 2019 16:48:52 -0600
Message-Id: <20190121224907.26634-7-eblake@redhat.com>
In-Reply-To: <20190121224907.26634-1-eblake@redhat.com>
References: <20190121224907.26634-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 06/21] nbd/server: Favor [u]int64_t over off_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

Although our compile-time environment is set up so that we always
support long files with 64-bit off_t, we have no guarantee whether
off_t is the same type as int64_t.  This requires casts when
printing values, and prevents us from directly using qemu_strtoi64()
(which will be done in the next patch). Let's just flip to uint64_t
where possible, and stick to int64_t for detecting failure of
blk_getlength(); we also keep the assertions added in the previous
patch that the resulting values fit in 63 bits.  The overflow check
in nbd_co_receive_request() was already sane (request->from is
validated to fit in 63 bits, and request->len is 32 bits, so the
addition can't overflow 64 bits), but rewrite it in a form easier
to recognize as a typical overflow check.

Rename the variable 'description' to keep line lengths reasonable.

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
Message-Id: <20190117193658.16413-7-eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
---
 include/block/nbd.h |  4 ++--
 nbd/server.c        | 18 +++++++++---------
 qemu-nbd.c          | 29 +++++++++++------------------
 3 files changed, 22 insertions(+), 29 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 1971b557896..24be9570bb4 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -294,8 +294,8 @@ int nbd_errno_to_system_errno(int err);
 typedef struct NBDExport NBDExport;
 typedef struct NBDClient NBDClient;

-NBDExport *nbd_export_new(BlockDriverState *bs, off_t dev_offset, off_t =
size,
-                          const char *name, const char *description,
+NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
+                          uint64_t size, const char *name, const char *d=
esc,
                           const char *bitmap, uint16_t nbdflags,
                           void (*close)(NBDExport *), bool writethrough,
                           BlockBackend *on_eject_blk, Error **errp);
diff --git a/nbd/server.c b/nbd/server.c
index 51ee8094e02..cb0d5634fa1 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -77,8 +77,8 @@ struct NBDExport {
     BlockBackend *blk;
     char *name;
     char *description;
-    off_t dev_offset;
-    off_t size;
+    uint64_t dev_offset;
+    uint64_t size;
     uint16_t nbdflags;
     QTAILQ_HEAD(, NBDClient) clients;
     QTAILQ_ENTRY(NBDExport) next;
@@ -1455,8 +1455,8 @@ static void nbd_eject_notifier(Notifier *n, void *d=
ata)
     nbd_export_close(exp);
 }

-NBDExport *nbd_export_new(BlockDriverState *bs, off_t dev_offset, off_t =
size,
-                          const char *name, const char *description,
+NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
+                          uint64_t size, const char *name, const char *d=
esc,
                           const char *bitmap, uint16_t nbdflags,
                           void (*close)(NBDExport *), bool writethrough,
                           BlockBackend *on_eject_blk, Error **errp)
@@ -1495,12 +1495,12 @@ NBDExport *nbd_export_new(BlockDriverState *bs, o=
ff_t dev_offset, off_t size,
     exp->refcount =3D 1;
     QTAILQ_INIT(&exp->clients);
     exp->blk =3D blk;
-    assert(dev_offset >=3D 0 && dev_offset <=3D INT64_MAX);
+    assert(dev_offset <=3D INT64_MAX);
     exp->dev_offset =3D dev_offset;
     exp->name =3D g_strdup(name);
-    exp->description =3D g_strdup(description);
+    exp->description =3D g_strdup(desc);
     exp->nbdflags =3D nbdflags;
-    assert(size >=3D 0 && size <=3D INT64_MAX - dev_offset);
+    assert(size <=3D INT64_MAX - dev_offset);
     exp->size =3D QEMU_ALIGN_DOWN(size, BDRV_SECTOR_SIZE);

     if (bitmap) {
@@ -2130,10 +2130,10 @@ static int nbd_co_receive_request(NBDRequestData =
*req, NBDRequest *request,
         return -EROFS;
     }
     if (request->from > client->exp->size ||
-        request->from + request->len > client->exp->size) {
+        request->len > client->exp->size - request->from) {
         error_setg(errp, "operation past EOF; From: %" PRIu64 ", Len: %"=
 PRIu32
                    ", Size: %" PRIu64, request->from, request->len,
-                   (uint64_t)client->exp->size);
+                   client->exp->size);
         return (request->type =3D=3D NBD_CMD_WRITE ||
                 request->type =3D=3D NBD_CMD_WRITE_ZEROES) ? -ENOSPC : -=
EINVAL;
     }
diff --git a/qemu-nbd.c b/qemu-nbd.c
index 5c90c5e55f7..598caa656b2 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -176,7 +176,7 @@ static void read_partition(uint8_t *p, struct partiti=
on_record *r)
 }

 static int find_partition(BlockBackend *blk, int partition,
-                          off_t *offset, off_t *size)
+                          uint64_t *offset, uint64_t *size)
 {
     struct partition_record mbr[4];
     uint8_t data[MBR_SIZE];
@@ -500,14 +500,14 @@ int main(int argc, char **argv)
 {
     BlockBackend *blk;
     BlockDriverState *bs;
-    off_t dev_offset =3D 0;
+    uint64_t dev_offset =3D 0;
     uint16_t nbdflags =3D 0;
     bool disconnect =3D false;
     const char *bindto =3D NULL;
     const char *port =3D NULL;
     char *sockpath =3D NULL;
     char *device =3D NULL;
-    off_t fd_size;
+    int64_t fd_size;
     QemuOpts *sn_opts =3D NULL;
     const char *sn_id_or_name =3D NULL;
     const char *sopt =3D "hVb:o:p:rsnP:c:dvk:e:f:tl:x:T:D:B:";
@@ -665,10 +665,6 @@ int main(int argc, char **argv)
                 error_report("Invalid offset `%s'", optarg);
                 exit(EXIT_FAILURE);
             }
-            if (dev_offset < 0) {
-                error_report("Offset must be positive `%s'", optarg);
-                exit(EXIT_FAILURE);
-            }
             break;
         case 'l':
             if (strstart(optarg, SNAPSHOT_OPT_BASE, NULL)) {
@@ -1005,15 +1001,14 @@ int main(int argc, char **argv)
     }

     if (dev_offset >=3D fd_size) {
-        error_report("Offset (%lld) has to be smaller than the image siz=
e "
-                     "(%lld)",
-                     (long long int)dev_offset, (long long int)fd_size);
+        error_report("Offset (%" PRIu64 ") has to be smaller than the im=
age "
+                     "size (%" PRId64 ")", dev_offset, fd_size);
         exit(EXIT_FAILURE);
     }
     fd_size -=3D dev_offset;

     if (partition !=3D -1) {
-        off_t limit;
+        uint64_t limit;

         if (dev_offset) {
             error_report("Cannot request partition and offset together")=
;
@@ -1027,15 +1022,13 @@ int main(int argc, char **argv)
         }
         /*
          * MBR partition limits are (32-bit << 9); this assert lets
-         * the compiler know that we have two positive values that
-         * can't overflow 64 bits.
+         * the compiler know that we can't overflow 64 bits.
          */
-        assert(dev_offset >=3D 0 && dev_offset + limit >=3D dev_offset);
+        assert(dev_offset + limit >=3D dev_offset);
         if (dev_offset + limit > fd_size) {
-            error_report("Discovered partition %d at offset %lld size %l=
ld, "
-                         "but size exceeds file length %lld", partition,
-                         (long long int) dev_offset, (long long int) lim=
it,
-                         (long long int) fd_size);
+            error_report("Discovered partition %d at offset %" PRIu64
+                         " size %" PRIu64 ", but size exceeds file lengt=
h %"
+                         PRId64, partition, dev_offset, limit, fd_size);
             exit(EXIT_FAILURE);
         }
         fd_size =3D limit;
--=20
2.20.1
