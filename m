Received: from eggs.gnu.org ([209.51.188.92]:59746)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1giNaT-0003cV-HN
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 13:00:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1giNYM-0001sB-Nj
	for qemu-devel@nongnu.org; Sat, 12 Jan 2019 12:58:40 -0500
From: Eric Blake <eblake@redhat.com>
Date: Sat, 12 Jan 2019 11:57:58 -0600
Message-Id: <20190112175812.27068-6-eblake@redhat.com>
In-Reply-To: <20190112175812.27068-1-eblake@redhat.com>
References: <20190112175812.27068-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 05/19] nbd/server: Favor [u]int64_t over
 off_t
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: nsoffer@redhat.com, rjones@redhat.com, jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>

Although our compile-time environment is set up so that we always
support long files with 64-bit off_t, we have no guarantee whether
off_t is the same type as int64_t.  This requires casts when
printing values, and prevents us from directly using qemu_strtoi64().
Let's just flip to [u]int64_t (signed for length, because we have to
detect failure of blk_getlength() and because off_t was signed;
unsigned for offset because it lets us simplify some math without
having to worry about signed overflow).

Suggested-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Signed-off-by: Eric Blake <eblake@redhat.com>

---
v3: new patch
---
 include/block/nbd.h |  4 ++--
 nbd/server.c        | 14 +++++++-------
 qemu-nbd.c          | 26 ++++++++++----------------
 3 files changed, 19 insertions(+), 25 deletions(-)

diff --git a/include/block/nbd.h b/include/block/nbd.h
index 1971b557896..0f252829376 100644
--- a/include/block/nbd.h
+++ b/include/block/nbd.h
@@ -294,8 +294,8 @@ int nbd_errno_to_system_errno(int err);
 typedef struct NBDExport NBDExport;
 typedef struct NBDClient NBDClient;

-NBDExport *nbd_export_new(BlockDriverState *bs, off_t dev_offset, off_t =
size,
-                          const char *name, const char *description,
+NBDExport *nbd_export_new(BlockDriverState *bs, uint64_t dev_offset,
+                          int64_t size, const char *name, const char *de=
sc,
                           const char *bitmap, uint16_t nbdflags,
                           void (*close)(NBDExport *), bool writethrough,
                           BlockBackend *on_eject_blk, Error **errp);
diff --git a/nbd/server.c b/nbd/server.c
index c9937ccdc2a..15357d40fd7 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -77,8 +77,8 @@ struct NBDExport {
     BlockBackend *blk;
     char *name;
     char *description;
-    off_t dev_offset;
-    off_t size;
+    uint64_t dev_offset;
+    int64_t size;
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
+                          int64_t size, const char *name, const char *de=
sc,
                           const char *bitmap, uint16_t nbdflags,
                           void (*close)(NBDExport *), bool writethrough,
                           BlockBackend *on_eject_blk, Error **errp)
@@ -1497,7 +1497,7 @@ NBDExport *nbd_export_new(BlockDriverState *bs, off=
_t dev_offset, off_t size,
     exp->blk =3D blk;
     exp->dev_offset =3D dev_offset;
     exp->name =3D g_strdup(name);
-    exp->description =3D g_strdup(description);
+    exp->description =3D g_strdup(desc);
     exp->nbdflags =3D nbdflags;
     assert(dev_offset <=3D size);
     exp->size =3D QEMU_ALIGN_DOWN(size, BDRV_SECTOR_SIZE);
@@ -2131,8 +2131,8 @@ static int nbd_co_receive_request(NBDRequestData *r=
eq, NBDRequest *request,
     if (request->from > client->exp->size ||
         request->from + request->len > client->exp->size) {
         error_setg(errp, "operation past EOF; From: %" PRIu64 ", Len: %"=
 PRIu32
-                   ", Size: %" PRIu64, request->from, request->len,
-                   (uint64_t)client->exp->size);
+                   ", Size: %" PRId64, request->from, request->len,
+                   client->exp->size);
         return (request->type =3D=3D NBD_CMD_WRITE ||
                 request->type =3D=3D NBD_CMD_WRITE_ZEROES) ? -ENOSPC : -=
EINVAL;
     }
diff --git a/qemu-nbd.c b/qemu-nbd.c
index ff4adb9b3eb..96c0829970c 100644
--- a/qemu-nbd.c
+++ b/qemu-nbd.c
@@ -176,7 +176,7 @@ static void read_partition(uint8_t *p, struct partiti=
on_record *r)
 }

 static int find_partition(BlockBackend *blk, int partition,
-                          off_t *offset, off_t *size)
+                          uint64_t *offset, int64_t *size)
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
+                     "size (%" PRIu64 ")", dev_offset, fd_size);
         exit(EXIT_FAILURE);
     }
     fd_size -=3D dev_offset;

     if (partition !=3D -1) {
-        off_t limit;
+        int64_t limit;

         if (dev_offset) {
             error_report("Cannot request partition and offset together")=
;
@@ -1026,12 +1021,11 @@ int main(int argc, char **argv)
             exit(EXIT_FAILURE);
         }
         /* partition limits are (32-bit << 9); can't overflow 64 bits */
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
+                         " size %" PRId64 ", but size exceeds file lengt=
h %"
+                         PRId64, partition, dev_offset, limit, fd_size);
             exit(EXIT_FAILURE);
         }
         fd_size =3D limit;
--=20
2.20.1
