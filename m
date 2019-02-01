Received: from eggs.gnu.org ([209.51.188.92]:47450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeXR-0007EY-7e
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:31:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gpeXN-0003CP-Dj
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 14:31:43 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Fri,  1 Feb 2019 20:29:30 +0100
Message-Id: <20190201192935.18394-27-mreitz@redhat.com>
In-Reply-To: <20190201192935.18394-1-mreitz@redhat.com>
References: <20190201192935.18394-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v13 26/31] block/nvme: Fix
 bdrv_refresh_filename()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

Currently, nvme's bdrv_refresh_filename() is an exact copy of null's
implementation.  However, for null, "null-co://" and "null-aio://" are
indeed valid filenames -- for nvme, they are not, as a device address is
still required.

The correct implementation should generate a filename of the form
"nvme://[PCI address]/[namespace]" (as the comment above
nvme_parse_filename() describes).

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block/nvme.c | 23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff --git a/block/nvme.c b/block/nvme.c
index 88c24399ab..7f0a2abd22 100644
--- a/block/nvme.c
+++ b/block/nvme.c
@@ -111,6 +111,9 @@ typedef struct {
=20
     /* Total size of mapped qiov, accessed under dma_map_lock */
     int dma_map_count;
+
+    /* PCI address (required for nvme_refresh_filename()) */
+    char *device;
 } BDRVNVMeState;
=20
 #define NVME_BLOCK_OPT_DEVICE "device"
@@ -557,6 +560,7 @@ static int nvme_init(BlockDriverState *bs, const char=
 *device, int namespace,
=20
     qemu_co_mutex_init(&s->dma_map_lock);
     qemu_co_queue_init(&s->dma_flush_queue);
+    s->device =3D g_strdup(device);
     s->nsid =3D namespace;
     s->aio_context =3D bdrv_get_aio_context(bs);
     ret =3D event_notifier_init(&s->irq_notifier, 0);
@@ -729,6 +733,8 @@ static void nvme_close(BlockDriverState *bs)
     event_notifier_cleanup(&s->irq_notifier);
     qemu_vfio_pci_unmap_bar(s->vfio, 0, (void *)s->regs, 0, NVME_BAR_SIZ=
E);
     qemu_vfio_close(s->vfio);
+
+    g_free(s->device);
 }
=20
 static int nvme_file_open(BlockDriverState *bs, QDict *options, int flag=
s,
@@ -1055,21 +1061,10 @@ static int nvme_reopen_prepare(BDRVReopenState *r=
eopen_state,
=20
 static void nvme_refresh_filename(BlockDriverState *bs)
 {
-    const QDictEntry *e;
-
-    for (e =3D qdict_first(bs->full_open_options); e;
-         e =3D qdict_next(bs->full_open_options, e))
-    {
-        /* These options can be ignored */
-        if (strcmp(qdict_entry_key(e), "filename") &&
-            strcmp(qdict_entry_key(e), "driver"))
-        {
-            return;
-        }
-    }
+    BDRVNVMeState *s =3D bs->opaque;
=20
-    snprintf(bs->exact_filename, sizeof(bs->exact_filename), "%s://",
-             bs->drv->format_name);
+    snprintf(bs->exact_filename, sizeof(bs->exact_filename), "nvme://%s/=
%i",
+             s->device, s->nsid);
 }
=20
 static void nvme_refresh_limits(BlockDriverState *bs, Error **errp)
--=20
2.20.1
