Received: from eggs.gnu.org ([2001:4830:134:3::10]:60302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gSk4q-0005OI-SC
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:47:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gSk4m-00041c-Mx
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 09:47:32 -0500
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Fri, 30 Nov 2018 14:47:23 +0000
Message-ID: <20181130144705.77454-7-anton.nefedov@virtuozzo.com>
References: <20181130144705.77454-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181130144705.77454-1-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v6 6/9] scsi: move unmap error checking to the
 complete callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-block@nongnu.org" <qemu-block@nongnu.org>, "kwolf@redhat.com" <kwolf@redhat.com>, "mreitz@redhat.com" <mreitz@redhat.com>, "armbru@redhat.com" <armbru@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "famz@redhat.com" <famz@redhat.com>, "eblake@redhat.com" <eblake@redhat.com>, Denis Lunev <den@virtuozzo.com>, "berto@igalia.com" <berto@igalia.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Anton Nefedov <anton.nefedov@virtuozzo.com>

This will help to account the operation in the following commit.

The difference is that we don't call scsi_disk_req_check_error() before
the 1st discard iteration anymore. That function also checks if
the request is cancelled, however it shouldn't get canceled until it
yields in blk_aio() functions anyway.
Same approach is already used for emulate_write_same.

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 hw/scsi/scsi-disk.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index b1133e6293..daf37d117c 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1606,9 +1606,6 @@ static void scsi_unmap_complete_noio(UnmapCBData *dat=
a, int ret)
     SCSIDiskState *s =3D DO_UPCAST(SCSIDiskState, qdev, r->req.dev);
=20
     assert(r->req.aiocb =3D=3D NULL);
-    if (scsi_disk_req_check_error(r, ret, false)) {
-        goto done;
-    }
=20
     if (data->count > 0) {
         r->sector =3D ldq_be_p(&data->inbuf[0]);
@@ -1644,7 +1641,12 @@ static void scsi_unmap_complete(void *opaque, int re=
t)
     r->req.aiocb =3D NULL;
=20
     aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
-    scsi_unmap_complete_noio(data, ret);
+    if (scsi_disk_req_check_error(r, ret, false)) {
+        scsi_req_unref(&r->req);
+        g_free(data);
+    } else {
+        scsi_unmap_complete_noio(data, ret);
+    }
     aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
 }
=20
--=20
2.17.1
