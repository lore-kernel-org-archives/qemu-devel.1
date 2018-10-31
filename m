Received: from eggs.gnu.org ([2001:4830:134:3::10]:35200)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gHomz-00042E-4W
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:35:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <anton.nefedov@virtuozzo.com>) id 1gHomx-00033T-1y
	for qemu-devel@nongnu.org; Wed, 31 Oct 2018 07:35:56 -0400
From: Anton Nefedov <anton.nefedov@virtuozzo.com>
Date: Wed, 31 Oct 2018 11:34:59 +0000
Message-ID: <20181031113418.29796-8-anton.nefedov@virtuozzo.com>
References: <20181031113418.29796-1-anton.nefedov@virtuozzo.com>
In-Reply-To: <20181031113418.29796-1-anton.nefedov@virtuozzo.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: [Qemu-devel] [PATCH v5 7/9] scsi: account unmap operations
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

Signed-off-by: Anton Nefedov <anton.nefedov@virtuozzo.com>
---
 hw/scsi/scsi-disk.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
index e132504913..dee71f9dde 100644
--- a/hw/scsi/scsi-disk.c
+++ b/hw/scsi/scsi-disk.c
@@ -1663,10 +1663,16 @@ static void scsi_unmap_complete_noio(UnmapCBData *d=
ata, int ret)
         r->sector =3D ldq_be_p(&data->inbuf[0]);
         r->sector_count =3D ldl_be_p(&data->inbuf[8]) & 0xffffffffULL;
         if (!check_lba_range(s, r->sector, r->sector_count)) {
+            block_acct_invalid(blk_get_stats(s->qdev.conf.blk),
+                               BLOCK_ACCT_UNMAP);
             scsi_check_condition(r, SENSE_CODE(LBA_OUT_OF_RANGE));
             goto done;
         }
=20
+        block_acct_start(blk_get_stats(s->qdev.conf.blk), &r->acct,
+                         r->sector_count * s->qdev.blocksize,
+                         BLOCK_ACCT_UNMAP);
+
         r->req.aiocb =3D blk_aio_pdiscard(s->qdev.conf.blk,
                                         r->sector * s->qdev.blocksize,
                                         r->sector_count * s->qdev.blocksiz=
e,
@@ -1693,10 +1699,11 @@ static void scsi_unmap_complete(void *opaque, int r=
et)
     r->req.aiocb =3D NULL;
=20
     aio_context_acquire(blk_get_aio_context(s->qdev.conf.blk));
-    if (scsi_disk_req_check_error(r, ret, false)) {
+    if (scsi_disk_req_check_error(r, ret, true)) {
         scsi_req_unref(&r->req);
         g_free(data);
     } else {
+        block_acct_done(blk_get_stats(s->qdev.conf.blk), &r->acct);
         scsi_unmap_complete_noio(data, ret);
     }
     aio_context_release(blk_get_aio_context(s->qdev.conf.blk));
@@ -1728,6 +1735,7 @@ static void scsi_disk_emulate_unmap(SCSIDiskReq *r, u=
int8_t *inbuf)
     }
=20
     if (blk_is_read_only(s->qdev.conf.blk)) {
+        block_acct_invalid(blk_get_stats(s->qdev.conf.blk), BLOCK_ACCT_UNM=
AP);
         scsi_check_condition(r, SENSE_CODE(WRITE_PROTECTED));
         return;
     }
@@ -1743,10 +1751,12 @@ static void scsi_disk_emulate_unmap(SCSIDiskReq *r,=
 uint8_t *inbuf)
     return;
=20
 invalid_param_len:
+    block_acct_invalid(blk_get_stats(s->qdev.conf.blk), BLOCK_ACCT_UNMAP);
     scsi_check_condition(r, SENSE_CODE(INVALID_PARAM_LEN));
     return;
=20
 invalid_field:
+    block_acct_invalid(blk_get_stats(s->qdev.conf.blk), BLOCK_ACCT_UNMAP);
     scsi_check_condition(r, SENSE_CODE(INVALID_FIELD));
 }
=20
--=20
2.17.1
