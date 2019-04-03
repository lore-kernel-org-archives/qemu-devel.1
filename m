Received: from eggs.gnu.org ([209.51.188.92]:41833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hBWDk-0000eE-Ko
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:05:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1hBWDi-0005Vu-Gy
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 23:05:48 -0400
From: Eric Blake <eblake@redhat.com>
Date: Tue,  2 Apr 2019 22:05:26 -0500
Message-Id: <20190403030526.12258-8-eblake@redhat.com>
In-Reply-To: <20190403030526.12258-1-eblake@redhat.com>
References: <20190403030526.12258-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH for-4.1 7/7] nbd/server: Avoid unaligned
 dirty-bitmap status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com, vsementsov@virtuozzo.com, qemu-block@nongnu.org

The NBD spec requires that responses to NBD_CMD_BLOCK_STATUS be
aligned to the server's advertised min_block alignment, if the client
agreed to abide by alignments. In general, since dirty bitmap
granularity cannot go below 512, and it is hard to provoke qcow2 to go
above an alignment of 512, this is not an issue. And until the block
layer can see through filters, the moment you use blkdebug, you can no
longer export dirty bitmaps over NBD.  But once we fix the traversal
through filters, then blkdebug can create a scenario where the server
is provoked into supplying a non-compliant reply.

Thus, it is time to fix the dirty bitmap code to round requests to
aligned boundaries.

This hack patch lets blkdebug be used; although note that Max has
proposed a more complete solution
https://lists.gnu.org/archive/html/qemu-devel/2019-02/msg03534.html

| diff --git a/nbd/server.c b/nbd/server.c
| index 576deb931c8..1d370b5b2c7 100644
| --- a/nbd/server.c
| +++ b/nbd/server.c
| @@ -1507,6 +1507,9 @@ NBDExport *nbd_export_new(BlockDriverState *bs, u=
int64_t dev_offset,
|          BdrvDirtyBitmap *bm =3D NULL;
|
|          while (true) {
| +            while (bs->drv && bs->drv->is_filter && bs->file) {
| +                bs =3D bs->file->bs;
| +            }
|              bm =3D bdrv_find_dirty_bitmap(bs, bitmap);
|              if (bm !=3D NULL || bs->backing =3D=3D NULL) {
|                  break;

Then the following sequence creates a dirty bitmap with granularity
512, exposed through a blkdebug interface with minimum block size 4k;
correct behavior is to see a map showing the first 4k as "data":false
(corresponding to the dirty bit in the 2nd of 8 sectors, rounded
up). Without this patch, the code instead showed the entire image as
"data":true (due to the client working around the server
non-compliance by coalescing regions, but assuming that data:true
takes precedence, which is the opposite of the behavior we want during
x-dirty-bitmap).

$ printf %01000d 0 > img
$ qemu-img create -f qcow2 -F raw -b img img.wrap 64k
$ qemu-system-x86_64 -nodefaults -nographic -qmp stdio
{'execute':'qmp_capabilities'}
{'execute':'blockdev-add','arguments':{'node-name':'n','driver':'qcow2','=
file':{'driver':'file','filename':'img.wrap'}}}
{'execute':'nbd-server-start','arguments':{'addr':{'type':'inet','data':{=
'host':'localhost','port':'10809'}}}}
{'execute':'block-dirty-bitmap-add','arguments':{'node':'n','name':'b','p=
ersistent':true,'granularity':512}}
{'execute':'nbd-server-add','arguments':{'device':'n','bitmap':'b','writa=
ble':true}}
^z
$ bg
$ qemu-io -f raw -c 'w 513 1' nbd://localhost:10809
$ fg
{'execute':'nbd-server-remove','arguments':{'name':'n'}}
{'execute':'block-dirty-bitmap-disable','arguments':{'node':'n','name':'b=
'}}
{'execute':'blockdev-add','arguments':{'driver':'blkdebug','align':4096,'=
image':'n','node-name':'wrap'}}
{'execute':'nbd-server-add','arguments':{'device':'wrap','bitmap':'b'}}
^z
$ bg
$ qemu-img map --output=3Djson --image-opts driver=3Dnbd,x-dirty-bitmap=3D=
qemu:dirty-bitmap:b,server.type=3Dinet,server.host=3Dlocalhost,server.por=
t=3D10809,export=3Dwrap
$ fg
{'execute':'quit'}

Signed-off-by: Eric Blake <eblake@redhat.com>

---
Not for 4.0; once Max's patches land to see through filters, then this
commit message will need to be rewritten, and the steps outlined above
instead turned into an addition for iotest 241.
---
 nbd/server.c | 40 ++++++++++++++++++++++++++++++++++------
 1 file changed, 34 insertions(+), 6 deletions(-)

diff --git a/nbd/server.c b/nbd/server.c
index 576deb931c8..82da0bae9ba 100644
--- a/nbd/server.c
+++ b/nbd/server.c
@@ -1982,7 +1982,8 @@ static int nbd_co_send_block_status(NBDClient *clie=
nt, uint64_t handle,
  * byte length encoded (which may be smaller or larger than the
  * original), and return the number of extents used.
  */
-static unsigned int bitmap_to_extents(BdrvDirtyBitmap *bitmap, uint64_t =
offset,
+static unsigned int bitmap_to_extents(uint32_t align,
+                                      BdrvDirtyBitmap *bitmap, uint64_t =
offset,
                                       uint64_t *length, NBDExtent *exten=
ts,
                                       unsigned int nb_extents,
                                       bool dont_fragment)
@@ -2008,13 +2009,30 @@ static unsigned int bitmap_to_extents(BdrvDirtyBi=
tmap *bitmap, uint64_t offset,
             bdrv_set_dirty_iter(it, begin);
             end =3D bdrv_dirty_iter_next(it);
         }
-        if (end =3D=3D -1 || end - begin > UINT32_MAX) {
+        if (end =3D=3D -1 || end - begin > UINT32_MAX - align) {
             /* Cap to an aligned value < 4G beyond begin. */
             end =3D MIN(bdrv_dirty_bitmap_size(bitmap),
                       begin + UINT32_MAX + 1 -
-                      bdrv_dirty_bitmap_granularity(bitmap));
+                      MAX(align, bdrv_dirty_bitmap_granularity(bitmap)))=
;
             next_dirty =3D dirty;
         }
+        /*
+         * Round unaligned bits: any transition mid-alignment makes
+         * that entire aligned region appear dirty
+         */
+        if (!QEMU_IS_ALIGNED(end, align)) {
+            if (dirty) {
+                end =3D QEMU_ALIGN_UP(end, align);
+            } else if (end - begin < align) {
+                end =3D begin + align;
+                dirty =3D true;
+            } else {
+                end =3D QEMU_ALIGN_DOWN(end, align);
+            }
+            if (end < bdrv_dirty_bitmap_size(bitmap)) {
+                next_dirty =3D bdrv_get_dirty_locked(NULL, bitmap, end);
+            }
+        }
         if (dont_fragment && end > overall_end) {
             end =3D overall_end;
         }
@@ -2042,11 +2060,21 @@ static int nbd_co_send_bitmap(NBDClient *client, =
uint64_t handle,
 {
     int ret;
     unsigned int nb_extents =3D dont_fragment ? 1 : NBD_MAX_BITMAP_EXTEN=
TS;
-    NBDExtent *extents =3D g_new(NBDExtent, nb_extents);
+    NBDExtent *extents;
     uint64_t final_length =3D length;

-    nb_extents =3D bitmap_to_extents(bitmap, offset, &final_length, exte=
nts,
-                                   nb_extents, dont_fragment);
+    /* Easiest to just refuse to answer an unaligned query */
+    if (client->check_align &&
+        !QEMU_IS_ALIGNED(offset | length, client->check_align)) {
+        return nbd_co_send_structured_error(client, handle, -EINVAL,
+                                            "unaligned dirty bitmap requ=
est",
+                                            errp);
+    }
+
+    extents =3D g_new(NBDExtent, nb_extents);
+    nb_extents =3D bitmap_to_extents(client->check_align ?: 1, bitmap, o=
ffset,
+                                   &final_length, extents, nb_extents,
+                                   dont_fragment);

     ret =3D nbd_co_send_extents(client, handle, extents, nb_extents,
                               final_length, last, context_id, errp);
--=20
2.20.1
