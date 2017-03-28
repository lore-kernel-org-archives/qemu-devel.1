Received: from eggs.gnu.org ([2001:4830:134:3::10]:56990)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1csywh-0008Fw-NH
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 17:46:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <den@virtuozzo.com>) id 1csywg-0007iQ-IN
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 17:46:31 -0400
References: <1490625488-7980-1-git-send-email-den@openvz.org>
	<20170328162620.GD11725@noname.redhat.com>
From: "Denis V. Lunev" <den@openvz.org>
Message-ID: <94ecee49-3d48-946f-aedb-c4ecba3f29e2@openvz.org>
Date: Tue, 28 Mar 2017 20:12:49 +0300
MIME-Version: 1.0
In-Reply-To: <20170328162620.GD11725@noname.redhat.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/1] parallels: wrong call to bdrv_truncate
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org

On 03/28/2017 07:26 PM, Kevin Wolf wrote:
> [ Cc: qemu-block ]
>
> Am 27.03.2017 um 16:38 hat Denis V. Lunev geschrieben:
>> Parallels driver should not call bdrv_truncate if the image was opened=

>> in the read-only mode. Without the patch
>>     qemu-img check harddisk.hds
>> asserts with
>>     bdrv_truncate: Assertion `child->perm & BLK_PERM_RESIZE' failed.
>>
>> Parameters used on the write path are not needed if the image is opene=
d
>> in the read-only mode.
>>
>> Signed-off-by: Denis V. Lunev <den@openvz.org>
>> Reported-by: Edgar Kaziahmedov <edos@virtuozzo.mipt.ru>
>> CC: Stefan Hajnoczi <stefanha@redhat.com>
>> ---
>>  block/parallels.c | 3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/block/parallels.c b/block/parallels.c
>> index 6bf9375..4173b3f 100644
>> --- a/block/parallels.c
>> +++ b/block/parallels.c
>> @@ -687,7 +687,8 @@ static int parallels_open(BlockDriverState *bs, QD=
ict *options, int flags,
>>      if (local_err !=3D NULL) {
>>          goto fail_options;
>>      }
>> -    if (!bdrv_has_zero_init(bs->file->bs) ||
>> +
>> +    if (!(flags & BDRV_O_RESIZE) || !bdrv_has_zero_init(bs->file->bs)=
 ||
>>              bdrv_truncate(bs->file, bdrv_getlength(bs->file->bs)) !=3D=
 0) {
>>          s->prealloc_mode =3D PRL_PREALLOC_MODE_FALLOCATE;
>>      }
> Relying on BDRV_O_RESIZE in block drivers is wrong. It is set in some
> paths (specifically the users of blk_new_open), but not in others. We
> should probably have filtered out the flag before passing it to the
> drivers.
>
> As a concrete example, if you're using -blockdev, the bdrv_truncate()
> call won't be executed after applying this patch.
>
> I think the correct way would be to check bdrv_is_read_only() instead.
>
> Kevin
hmmm. But why do we have

int bdrv_truncate(BdrvChild *child, int64_t offset)
{
    BlockDriverState *bs =3D child->bs;
    BlockDriver *drv =3D bs->drv;
    int ret;

    assert(child->perm & BLK_PERM_RESIZE);

    if (!drv)
        return -ENOMEDIUM;
    if (!drv->bdrv_truncate)
        return -ENOTSUP;
    if (bs->read_only)
        return -EACCES;

    ret =3D drv->bdrv_truncate(bs, offset);

instead of

int bdrv_truncate(BdrvChild *child, int64_t offset)
{
    BlockDriverState *bs =3D child->bs;
    BlockDriver *drv =3D bs->drv;
    int ret;

    if (!drv)
        return -ENOMEDIUM;
    if (!drv->bdrv_truncate)
        return -ENOTSUP;
    if (bs->read_only)
        return -EACCES;

    assert(child->perm & BLK_PERM_RESIZE);
    ret =3D drv->bdrv_truncate(bs, offset);

technically this will work properly for my case and calling of
bdrv_truncate could be valid.

Another thing, should we add assert like added into bdrv_co_pwritev,
namely
    assert(!(bs->open_flags & BDRV_O_INACTIVE));
in the same place below access check.

Technically, the requested change is not a problem it looks a bit
strange and not consistent to me.

Den
