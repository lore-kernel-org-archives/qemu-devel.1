Received: from eggs.gnu.org ([2001:4830:134:3::10]:49022)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbFQ5-0004pT-0M
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:43:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cbFQ2-0005Qb-JA
	for qemu-devel@nongnu.org; Tue, 07 Feb 2017 18:43:33 -0500
References: <20170202123045.GA24714@chaz.gmail.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f8a93c01-682e-fbcb-7b81-012f6df97465@redhat.com>
Date: Wed, 8 Feb 2017 00:43:18 +0100
MIME-Version: 1.0
In-Reply-To: <20170202123045.GA24714@chaz.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GE0sXjsI3op9Lq46CsrXDGmIph4GfePWQ"
Subject: Re: [Qemu-devel] [qcow2] how to avoid qemu doing
 lseek(SEEK_DATA/SEEK_HOLE)?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephane Chazelas <stephane.chazelas@gmail.com>, qemu-devel@nongnu.org, Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GE0sXjsI3op9Lq46CsrXDGmIph4GfePWQ
From: Max Reitz <mreitz@redhat.com>
To: Stephane Chazelas <stephane.chazelas@gmail.com>, qemu-devel@nongnu.org,
 Qemu-block <qemu-block@nongnu.org>, Kevin Wolf <kwolf@redhat.com>
Message-ID: <f8a93c01-682e-fbcb-7b81-012f6df97465@redhat.com>
Subject: Re: [Qemu-devel] [qcow2] how to avoid qemu doing
 lseek(SEEK_DATA/SEEK_HOLE)?
References: <20170202123045.GA24714@chaz.gmail.com>
In-Reply-To: <20170202123045.GA24714@chaz.gmail.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

I've been thinking about the issue but I'm not sure I've come to a
resolution you'll like much.

I'm not really in favor of optimizing code for ZFS, especially if that
means worse code for every other case. I think it very much makes sense
to assume that lseek(SEEK_{DATA,HOLE}) is faster than writing data to
disk, and actually so much faster that it even pays off if you sometimes
to the lseek() only to find out that you actually have to write data stil=
l.

Therefore, the patch as it is makes sense. The fact that said lseek() is
slow on ZFS is (in my humble opinion) the ZFS driver's problem that
needs to be fixed there.

If ZFS has a good alternative for us to check whether a given area of a
file will return zeroes when read, I'm all ears and it might be a good
idea to use it. That is, if someone can write the code for it because
I'd rather not if that requires ZFS headers and a ZFS for testing.

(Determining whether a file has a hole in it and where it is has
actually plagued as for a while now. lseek() seemed to be the most
widespread way with the least amount of pitfalls to do it.)

OTOH, it may make sense to offer a way for the user to disable
lseek(SEEK_{DATA,HOLE}) in our "file" block driver. That way your issue
would be solved, too, I guess. I'll look into it.


Max



On 02.02.2017 13:30, Stephane Chazelas wrote:
> Hello,
>=20
> since qemu-2.7.0, doing synchronised I/O in a VM (tested with
> Ubuntu 16.04 amd64 VM)  while the disk is backed by a qcow2
> file sitting on a ZFS filesystem (zfs on Linux on Debian jessie
> (PVE)), the performances are dreadful:
>=20
> # time dd if=3D/dev/zero count=3D1000  of=3Db oflag=3Ddsync
> 1000+0 records in
> 1000+0 records out
> 512000 bytes (512 kB, 500 KiB) copied, 21.9908 s, 23.3 kB/s
> dd if=3D/dev/zero count=3D1000 of=3Db oflag=3Ddsync  0.00s user 0.04s s=
ystem 0% cpu 21.992 total
>=20
> (22 seconds to write that half megabyte). Same with O_SYNC or
> O_DIRECT, or doing fsync() or sync_file_range() after each
> write().
>=20
> I first noticed it for dpkg unpacking kernel headers where dpkg
> does a sync_file_range() after each file is extracted.
>=20
> Note that it doesn't happen when writing anything else than
> zeroes (like tr '\0' x < /dev/zero | dd count=3D1000  of=3Db
> oflag=3Ddsync). In the case of the kernel headers, I suppose the
> zeroes come from the non-filled parts of the ext4 blocks.
>=20
> Doing strace -fc on the qemu process, 98% of the time is spent
> in the lseek() system call.
>=20
> That's the lseek(SEEK_DATA) followed by lseek(SEEK_HOLE) done by
> find_allocation() called to find out whether sectors are within
> a hole in a sparse file.
>=20
> #0  lseek64 () at ../sysdeps/unix/syscall-template.S:81
> #1  0x0000561287cf4ca8 in find_allocation (bs=3D0x7fd898d70000, hole=3D=
<synthetic pointer>, data=3D<synthetic pointer>, start=3D<optimized out>)=

>     at block/raw-posix.c:1702
> #2  raw_co_get_block_status (bs=3D0x7fd898d70000, sector_num=3D<optimiz=
ed out>, nb_sectors=3D40, pnum=3D0x7fd80dd05aac, file=3D0x7fd80dd05ab0) a=
t block/raw-posix.c:1765
> #3  0x0000561287cfae92 in bdrv_co_get_block_status (bs=3D0x7fd898d70000=
, sector_num=3Dsector_num@entry=3D1303680, nb_sectors=3D40, pnum=3Dpnum@e=
ntry=3D0x7fd80dd05aac,
>     file=3Dfile@entry=3D0x7fd80dd05ab0) at block/io.c:1709
> #4  0x0000561287cfafaa in bdrv_co_get_block_status (bs=3Dbs@entry=3D0x7=
fd898d66000, sector_num=3Dsector_num@entry=3D33974144, nb_sectors=3D<opti=
mized out>,
>     nb_sectors@entry=3D40, pnum=3Dpnum@entry=3D0x7fd80dd05bbc, file=3Df=
ile@entry=3D0x7fd80dd05bc0) at block/io.c:1742
> #5  0x0000561287cfb0bb in bdrv_co_get_block_status_above (file=3D0x7fd8=
0dd05bc0, pnum=3D0x7fd80dd05bbc, nb_sectors=3D40, sector_num=3D33974144, =
base=3D0x0,
>     bs=3D<optimized out>) at block/io.c:1776
> #6  bdrv_get_block_status_above_co_entry (opaque=3Dopaque@entry=3D0x7fd=
80dd05b40) at block/io.c:1792
> #7  0x0000561287cfae08 in bdrv_get_block_status_above (bs=3D0x7fd898d66=
000, base=3Dbase@entry=3D0x0, sector_num=3D<optimized out>, nb_sectors=3D=
nb_sectors@entry=3D40,
>     pnum=3Dpnum@entry=3D0x7fd80dd05bbc, file=3Dfile@entry=3D0x7fd80dd05=
bc0) at block/io.c:1824
> #8  0x0000561287cd372d in is_zero_sectors (bs=3D<optimized out>, start=3D=
<optimized out>, count=3D40) at block/qcow2.c:2428
> #9  0x0000561287cd38ed in is_zero_sectors (count=3D<optimized out>, sta=
rt=3D<optimized out>, bs=3D<optimized out>) at block/qcow2.c:2471
> #10 qcow2_co_pwrite_zeroes (bs=3D0x7fd898d66000, offset=3D33974144, cou=
nt=3D24576, flags=3D2724114573) at block/qcow2.c:2452
> #11 0x0000561287cfcb7f in bdrv_co_do_pwrite_zeroes (bs=3Dbs@entry=3D0x7=
fd898d66000, offset=3Doffset@entry=3D17394782208, count=3Dcount@entry=3D4=
096,
>     flags=3Dflags@entry=3DBDRV_REQ_ZERO_WRITE) at block/io.c:1218
> #12 0x0000561287cfd0cb in bdrv_aligned_pwritev (bs=3D0x7fd898d66000, re=
q=3D<optimized out>, offset=3D17394782208, bytes=3D4096, align=3D1, qiov=3D=
0x0,
>     flags=3D<optimized out>) at block/io.c:1320
> #13 0x0000561287cfe450 in bdrv_co_do_zero_pwritev (req=3D<optimized out=
>, flags=3D<optimized out>, bytes=3D<optimized out>, offset=3D<optimized =
out>,
>     bs=3D<optimized out>) at block/io.c:1422
> #14 bdrv_co_pwritev (child=3D0x15, offset=3D17394782208, bytes=3D4096, =
qiov=3D0x7fd8a25eb08d <lseek64+45>, qiov@entry=3D0x0, flags=3D231758512) =
at block/io.c:1492
> #15 0x0000561287cefdc7 in blk_co_pwritev (blk=3D0x7fd898cad540, offset=3D=
17394782208, bytes=3D4096, qiov=3D0x0, flags=3D<optimized out>) at block/=
block-backend.c:788
> #16 0x0000561287cefeeb in blk_aio_write_entry (opaque=3D0x7fd812941440)=
 at block/block-backend.c:982
> #17 0x0000561287d67c7a in coroutine_trampoline (i0=3D<optimized out>, i=
1=3D<optimized out>) at util/coroutine-ucontext.c:78
>=20
> Now, performance is really bad on ZFS for those lseek().
> I believe that's https://github.com/zfsonlinux/zfs/issues/4306
>=20
> Until that's fixed in ZFS, I need to find a way to avoid those
> lseek()s in the first place.
>=20
> One way is to downgrade to 2.6.2 where those lseek()s are not
> called. The change that introduced them seems to be:
>=20
> https://github.com/qemu/qemu/commit/2928abce6d1d426d37c0a9bd5f85fb95cf3=
3f709
> (and there have been further changes to improve it later).
>=20
> If I understand correctly, that change was about preventing data
> from being allocated when the user is writing unaligned zeroes.
>=20
> I suppose the idea is that if something is trying to write
> zeroes in the middle of an _allocated_ qcow2 cluster, but the
> corresponding sectors in the file underneath are in a hole, we
> don't want to write those zeros as that would allocate the data
> at the file level.
>=20
> I can see it makes sense, but in my case, the little space
> efficiency it brings is largely overshadowed by the sharp
> decrease in performance.
>=20
> For now, I work around it by changing the "#ifdef SEEK_DATA"
> to "#if 0" in find_allocation().
>=20
> Note that passing detect-zeroes=3Doff or detect-zeroes=3Dunmap (with
> discard) doesn't help (even though FALLOC_FL_PUNCH_HOLE is
> supported on ZFS on Linux).
>=20
> Is there any other way I could use to prevent those lseek()s
> without having to rebuild qemu?
>=20
> Would you consider adding an option to disable that behaviour
> (skip checking allocation at file level for qcow2 image)?
>=20
> Thanks,
> Stephane
>=20
>=20
>=20



--GE0sXjsI3op9Lq46CsrXDGmIph4GfePWQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliaW5YSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AkeAH/0bCDLSTrCQBIjz1K7l7LNG5oVT+h3dm
9Gl0k51ZwbzzrDsVcbWhCmLCu034JUEY0zWw97vp9rNlClWpaBCjY8BChSYgxltI
TBlAI4Yy5ARLtMCAxdLWVcRrqH6MgaNwrqIGMX70AEQvDn23cGGCZUToN3bg75lD
ZttXeyXJYhLAxcSB7YYGAyZC+HcfbMjxaER6ojDgf5KRLtM1mazzjBv08C+qOwAj
sUcYUcuxMEXt9u+kcJGNFTzRYNFv0btoRI35ZZyHQu41xhS0vbjLge8BCTfe71M6
/p9AO33QDsSSfjlIcb3DBsDd1z3mMVmaHW037jRuRvdDKygeQGcOVDo=
=b5ax
-----END PGP SIGNATURE-----

--GE0sXjsI3op9Lq46CsrXDGmIph4GfePWQ--
