Received: from eggs.gnu.org ([209.51.188.92]:55056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hGnoT-0001nT-KC
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 12:53:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1hGnoS-0001VK-8u
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 12:53:33 -0400
References: <20190417154850.29110-1-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5eeffb36-9db3-30e8-91d2-2e3796b0a40d@redhat.com>
Date: Wed, 17 Apr 2019 18:53:14 +0200
MIME-Version: 1.0
In-Reply-To: <20190417154850.29110-1-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2ULsnNL7NIdbnuf3KyLcU9cL2zepptIKG"
Subject: Re: [Qemu-devel] [PATCH] block: Fix AioContext switch for bs->drv
 == NULL
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2ULsnNL7NIdbnuf3KyLcU9cL2zepptIKG
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-devel@nongnu.org
Message-ID: <5eeffb36-9db3-30e8-91d2-2e3796b0a40d@redhat.com>
Subject: Re: [PATCH] block: Fix AioContext switch for bs->drv == NULL
References: <20190417154850.29110-1-kwolf@redhat.com>
In-Reply-To: <20190417154850.29110-1-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.04.19 17:48, Kevin Wolf wrote:
> Even for block nodes with bs->drv =3D=3D NULL, we can't just ignore a
> bdrv_set_aio_context() call. Leaving the node in its old context can
> mean that it's still in an iothread context in bdrv_close_all() during
> shutdown, resulting in an attempted unlock of the AioContext lock which=

> we don't hold.
>=20
> This is an example stack trace of a related crash:
>=20
>  #0  0x00007ffff59da57f in raise () at /lib64/libc.so.6
>  #1  0x00007ffff59c4895 in abort () at /lib64/libc.so.6
>  #2  0x0000555555b97b1e in error_exit (err=3D<optimized out>, msg=3Dmsg=
@entry=3D0x555555d386d0 <__func__.19059> "qemu_mutex_unlock_impl") at uti=
l/qemu-thread-posix.c:36
>  #3  0x0000555555b97f7f in qemu_mutex_unlock_impl (mutex=3Dmutex@entry=3D=
0x5555568002f0, file=3Dfile@entry=3D0x555555d378df "util/async.c", line=3D=
line@entry=3D507) at util/qemu-thread-posix.c:97
>  #4  0x0000555555b92f55 in aio_context_release (ctx=3Dctx@entry=3D0x555=
556800290) at util/async.c:507
>  #5  0x0000555555b05cf8 in bdrv_prwv_co (child=3Dchild@entry=3D0x7fffc8=
0012f0, offset=3Doffset@entry=3D131072, qiov=3Dqiov@entry=3D0x7fffffffd4f=
0, is_write=3Dis_write@entry=3Dtrue, flags=3Dflags@entry=3D0)
>          at block/io.c:833
>  #6  0x0000555555b060a9 in bdrv_pwritev (qiov=3D0x7fffffffd4f0, offset=3D=
131072, child=3D0x7fffc80012f0) at block/io.c:990
>  #7  0x0000555555b060a9 in bdrv_pwrite (child=3D0x7fffc80012f0, offset=3D=
131072, buf=3D<optimized out>, bytes=3D<optimized out>) at block/io.c:990=

>  #8  0x0000555555ae172b in qcow2_cache_entry_flush (bs=3Dbs@entry=3D0x5=
55556810680, c=3Dc@entry=3D0x5555568cc740, i=3Di@entry=3D0) at block/qcow=
2-cache.c:51
>  #9  0x0000555555ae18dd in qcow2_cache_write (bs=3Dbs@entry=3D0x5555568=
10680, c=3D0x5555568cc740) at block/qcow2-cache.c:248
>  #10 0x0000555555ae15de in qcow2_cache_flush (bs=3D0x555556810680, c=3D=
<optimized out>) at block/qcow2-cache.c:259
>  #11 0x0000555555ae16b1 in qcow2_cache_flush_dependency (c=3D0x5555568a=
1700, c=3D0x5555568a1700, bs=3D0x555556810680) at block/qcow2-cache.c:194=

>  #12 0x0000555555ae16b1 in qcow2_cache_entry_flush (bs=3Dbs@entry=3D0x5=
55556810680, c=3Dc@entry=3D0x5555568a1700, i=3Di@entry=3D0) at block/qcow=
2-cache.c:194
>  #13 0x0000555555ae18dd in qcow2_cache_write (bs=3Dbs@entry=3D0x5555568=
10680, c=3D0x5555568a1700) at block/qcow2-cache.c:248
>  #14 0x0000555555ae15de in qcow2_cache_flush (bs=3Dbs@entry=3D0x5555568=
10680, c=3D<optimized out>) at block/qcow2-cache.c:259
>  #15 0x0000555555ad242c in qcow2_inactivate (bs=3Dbs@entry=3D0x55555681=
0680) at block/qcow2.c:2124
>  #16 0x0000555555ad2590 in qcow2_close (bs=3D0x555556810680) at block/q=
cow2.c:2153
>  #17 0x0000555555ab0c62 in bdrv_close (bs=3D0x555556810680) at block.c:=
3358
>  #18 0x0000555555ab0c62 in bdrv_delete (bs=3D0x555556810680) at block.c=
:3542
>  #19 0x0000555555ab0c62 in bdrv_unref (bs=3D0x555556810680) at block.c:=
4598
>  #20 0x0000555555af4d72 in blk_remove_bs (blk=3Dblk@entry=3D0x555556810=
3d0) at block/block-backend.c:785
>  #21 0x0000555555af4dbb in blk_remove_all_bs () at block/block-backend.=
c:483
>  #22 0x0000555555aae02f in bdrv_close_all () at block.c:3412
>  #23 0x00005555557f9796 in main (argc=3D<optimized out>, argv=3D<optimi=
zed out>, envp=3D<optimized out>) at vl.c:4776
>=20
> The reproducer I used is a qcow2 image on gluster volume, where the
> virtual disk size (4 GB) is larger than the gluster volume size (64M),
> so we can easily trigger an ENOSPC. This backend is assigned to a
> virtio-blk device using an iothread, and then from the guest a
> 'dd if=3D/dev/zero of=3D/dev/vda bs=3D1G count=3D1' causes the VM to st=
op
> because of an I/O error. qemu_gluster_co_flush_to_disk() sets
> bs->drv =3D NULL on error, so when virtio-blk stops the dataplane, the
> block nodes stay in the iothread AioContext. A 'quit' monitor command
> issued from this paused state crashes the process.
>=20
> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=3D1631227
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--2ULsnNL7NIdbnuf3KyLcU9cL2zepptIKG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAly3WfoACgkQ9AfbAGHV
z0Cwvgf8CW8OEOu77hMjYsdBX+rYsbGYvkG0C2wkrdbV62WxXPOxsIV9QYw3F5Bb
K8L5f/YeEDDI4fHb4yDh45nb2xhq0rrkQKxnjAIiNUlpymSWa5xPorTvxMAjMPl3
cocAsE6dEM1mIZtQ9R0vM91d1XSe6n6PuMquKJYj1oLA91WRJV2NWk75Cr3+CbNd
lSXDpLKzdfmkMHLnuXo3cwxWtVdfG8kxjsLw/YQI9JiAkorky33grtl75QUD7/TY
AeDv2HYf7oAeSmA34+Evj18Nr6cfx1ID6Fc7qBVOghZ7j5uTfXiXh46X7neMa1DU
SD3wtajVh1ELfUOBDYIpaCD9I2ErZQ==
=KAt6
-----END PGP SIGNATURE-----

--2ULsnNL7NIdbnuf3KyLcU9cL2zepptIKG--
