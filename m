Received: from eggs.gnu.org ([209.51.188.92]:43943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1go7ta-0000TN-01
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:28:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <antonkuchin@yandex-team.ru>) id 1go7tZ-0006JF-7u
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 09:28:17 -0500
From: Anton Kuchin <antonkuchin@yandex-team.ru>
Date: Mon, 28 Jan 2019 17:27:48 +0300
Message-Id: <20190128142748.29140-3-antonkuchin@yandex-team.ru>
In-Reply-To: <20190128142748.29140-1-antonkuchin@yandex-team.ru>
References: <20190128142748.29140-1-antonkuchin@yandex-team.ru>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 2/2] block: migrate callers from blk_by_name to
 blk_lookup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Evgeny Yakovlev <wrfsh@yandex-team.ru>, Anton Kuchin <antonkuchin@yandex-team.ru>

Signed-off-by: Anton Kuchin <antonkuchin@yandex-team.ru>
---
 blockdev-nbd.c | 2 +-
 blockdev.c     | 6 +++---
 hmp.c          | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/blockdev-nbd.c b/blockdev-nbd.c
index d73ac1b026..f2ea7318cf 100644
--- a/blockdev-nbd.c
+++ b/blockdev-nbd.c
@@ -162,7 +162,7 @@ void qmp_nbd_server_add(const char *device, bool has_=
name, const char *name,
         return;
     }
=20
-    on_eject_blk =3D blk_by_name(device);
+    on_eject_blk =3D blk_lookup(device);
=20
     bs =3D bdrv_lookup_bs(device, device, errp);
     if (!bs) {
diff --git a/blockdev.c b/blockdev.c
index a8fa8748a9..bb01c41038 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1082,7 +1082,7 @@ void hmp_commit(Monitor *mon, const QDict *qdict)
         BlockDriverState *bs;
         AioContext *aio_context;
=20
-        blk =3D blk_by_name(device);
+        blk =3D blk_lookup(device);
         if (!blk) {
             monitor_printf(mon, "Device '%s' not found\n", device);
             return;
@@ -3066,7 +3066,7 @@ void hmp_drive_del(Monitor *mon, const QDict *qdict=
)
         return;
     }
=20
-    blk =3D blk_by_name(id);
+    blk =3D blk_lookup(id);
     if (!blk) {
         error_report("Device '%s' not found", id);
         return;
@@ -4431,7 +4431,7 @@ void qmp_x_block_latency_histogram_set(
     bool has_boundaries_flush, uint64List *boundaries_flush,
     Error **errp)
 {
-    BlockBackend *blk =3D blk_by_name(device);
+    BlockBackend *blk =3D blk_lookup(device);
     BlockAcctStats *stats;
     int ret;
=20
diff --git a/hmp.c b/hmp.c
index b2a2b1f84e..7b03d5c1d7 100644
--- a/hmp.c
+++ b/hmp.c
@@ -2460,7 +2460,7 @@ void hmp_qemu_io(Monitor *mon, const QDict *qdict)
     Error *err =3D NULL;
     int ret;
=20
-    blk =3D blk_by_name(device);
+    blk =3D blk_lookup(device);
     if (!blk) {
         BlockDriverState *bs =3D bdrv_lookup_bs(NULL, device, &err);
         if (bs) {
--=20
2.19.1
