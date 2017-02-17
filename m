Received: from eggs.gnu.org ([2001:4830:134:3::10]:59414)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ceiDi-0002e0-5S
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:05:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1ceiDh-0002Ec-14
	for qemu-devel@nongnu.org; Fri, 17 Feb 2017 08:05:06 -0500
Date: Fri, 17 Feb 2017 14:04:55 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170217130455.GG5338@noname.redhat.com>
References: <1487153430-17260-1-git-send-email-vsementsov@virtuozzo.com>
	<1487153430-17260-10-git-send-email-vsementsov@virtuozzo.com>
	<20170216114533.GC4869@noname.redhat.com>
	<20170216124753.GE4869@noname.redhat.com>
	<f257ad53-748b-64b6-1b70-ddbbfb79c965@virtuozzo.com>
	<20170217122154.GD5338@noname.redhat.com>
	<4109eae4-2871-00c5-4e1e-ffbaeff659c4@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <4109eae4-2871-00c5-4e1e-ffbaeff659c4@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v15 09/25] qcow2: add
 .bdrv_load_autoloading_dirty_bitmaps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Cc: famz@redhat.com, qemu-block@nongnu.org, armbru@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, pbonzini@redhat.com, den@openvz.org, mreitz@redhat.com

Am 17.02.2017 um 13:55 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 17.02.2017 15:21, Kevin Wolf wrote:
>=20
>     Am 17.02.2017 um 13:07 hat Vladimir Sementsov-Ogievskiy geschrieben=
:
>=20
>         16.02.2017 15:47, Kevin Wolf wrote:
>=20
>             Sorry, this was sent too early. Next attempt...
>=20
>             Am 16.02.2017 um 12:45 hat Kevin Wolf geschrieben:
>=20
>                 Am 15.02.2017 um 11:10 hat Vladimir Sementsov-Ogievskiy=
 geschrieben:
>=20
>                     Auto loading bitmaps are bitmaps in Qcow2, with the=
 AUTO flag set. They
>                     are loaded when the image is opened and become Bdrv=
DirtyBitmaps for the
>                     corresponding drive.
>=20
>                     Extra data in bitmaps is not supported for now.
>=20
>         [...]
>=20
>=20
>                     hdx.o vhdx-endian.o vhdx-log.o
>                     diff --git a/block/qcow2-bitmap.c b/block/qcow2-bit=
map.c
>                     new file mode 100644
>                     index 0000000..e08e46e
>                     --- /dev/null
>                     +++ b/block/qcow2-bitmap.c
>=20
>         [...]
>=20
>=20
>                     +
>                     +static int update_header_sync(BlockDriverState *bs=
)
>                     +{
>                     +    int ret;
>                     +
>                     +    ret =3D qcow2_update_header(bs);
>                     +    if (ret < 0) {
>                     +        return ret;
>                     +    }
>                     +
>                     +    /* We don't return bdrv_flush error code. Even=
 if it fails, write was
>                     +     * successful and it is more logical to consid=
er that header is in the new
>                     +     * state than in the old.
>                     +     */
>                     +    ret =3D bdrv_flush(bs);
>                     +    if (ret < 0) {
>                     +        fprintf(stderr, "Failed to flush qcow2 hea=
der");
>                     +    }
>=20
>             I don't think I can agree with this one. If you don't care =
whether the
>             new header is actually on disk, don't call bdrv_flush(). Bu=
t if you do
>             care, then bdrv_flush() failure means that most likely the =
new header
>             has not made it to the disk, but is just sitting in some vo=
latile cache.
>=20
>         And what should be done on bdrv_flush fail? Current solution wa=
s
>         proposed by Max.
>=20
>     Pass an error up and let the calling operation fail, because we can=
't
>     promise that it actually executed correctly.
>=20
>=20
> It was my first option. The problem is that resulting state is absolute=
ly
> inconsistent - it is not guaranteed=A0 to be the old one or new.. Howev=
er with
> current approach it may be inconsistent too, but without an error..
>=20
> So, error message should contain information that all dirty bitmaps may=
 be
> inconsistent even if in the image all flags says that bitmaps are OK.

After a failing flush, we're always in a state that is hard to predict
and where we can make little guarantees about what the image actually
contains on disk and what not. The only thing we can really do is to
make sure the user sees an error and can respond to it, rather than
being silent about a potential corruption.

>                     +    return 0;
>                     +}
>                     +
>=20
>         [...]
>=20
>=20
>                     +
>                     +/* This function returns the number of disk sector=
s covered by a single cluster
>                     + * of bitmap data. */
>                     +static uint64_t disk_sectors_in_bitmap_cluster(con=
st BDRVQcow2State *s,
>                     +                                               con=
st BdrvDirtyBitmap *bitmap)
>                     +{
>                     +    uint32_t sector_granularity =3D
>                     +            bdrv_dirty_bitmap_granularity(bitmap) =
>> BDRV_SECTOR_BITS;
>                     +
>                     +    return (uint64_t)sector_granularity * (s->clus=
ter_size << 3);
>                     +}
>=20
>             This has nothing to do with disk sectors, neither of the gu=
est disk nor
>             of the host disk. It's just using a funny 512 bytes unit. I=
s there a
>             good reason for introducing this funny unit in new code?
>=20
>             I'm also not sure what this function calculates, but it's n=
ot what the
>             comment says. The unit of the result is something like sect=
ors * bytes,
>             and even when normalising it to a single base unit, I've ne=
ver seen a
>             use for square bytes so far.
>=20
>         sector granularity is number of disk sectors, corresponding to =
one
>         bit of the dirty bitmap, (disk-sectors/bitmap-bit)
>=20
>     Please don't use the word "disk sectors", it's misleading because i=
t's
>     not a sector size of any specific disk. It's best to say just "sect=
ors",
>     which is a fixed qemu block layer unit of 512 bytes.
>=20
>=20
>         cluster_size << 3 is a number of bits in one cluster, (bitmap-b=
it)
>=20
>         so, we have
>         sector_granularity (disk-sector/bitmap-bit) * <cluster size in =
bits>
>         (bitmapbit)  =3D some disk sectors, corresponding to one cluste=
r of
>         bitmap data.
>=20
>     Aha! I completely misunderstood what a bitmap cluster is supposed t=
o
>     be. I expected it to be a chunk of bitmap data whose size correspon=
ds to
>     the bitmap granularity, whereas it's really about qcow2 clusters.
>=20
>     I wonder if we can rephrase the comment to make this more obvious. =
Maybe
>     "...covered by a single qcow2 cluster containing bitmap data"? And =
the
>     function could be called sectors_covered_by_bitmap_cluster() or
>     something.
>=20
>=20
> No problem with that, I'm always for better wording)
>=20
> s/containing/of/ looks better for me, as it should be covered by bitmap=
 data,
> not by cluster.

That works for me, too.

Kevin
