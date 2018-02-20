Received: from eggs.gnu.org ([2001:4830:134:3::10]:52284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoG0U-00069g-D7
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 17:03:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eoG0T-0002V9-CE
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 17:03:26 -0500
References: <20180220170135.5299-1-berto@igalia.com>
	<2d9713f2-87c1-12ba-3f46-a9a476279cda@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <6064e2b5-c7aa-7ec1-b917-5431f0dc57a8@redhat.com>
Date: Tue, 20 Feb 2018 16:03:00 -0600
MIME-Version: 1.0
In-Reply-To: <2d9713f2-87c1-12ba-3f46-a9a476279cda@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] specs/qcow2: Fix documentation of the
 compressed cluster descriptor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On 02/20/2018 01:40 PM, Eric Blake wrote:
> On 02/20/2018 11:01 AM, Alberto Garcia wrote:
>=20
> tl:dr; I think we need a v3 with even more clarification.
>=20

>=20
> I'm also making an additional observationn: Due to the pigeonhole=20
> principle and the fact that the compression stream adds metadata, we=20
> KNOW that there are some (rare) cases where attempting to compress data=
=20
> will actually result in an INCREASE in size ('man gzip' backs up this=20
> claim, calling out a worst case -0.015% compression ratio, or 15 bytes=20
> added for every 1000 bytes of input, on uncompressible data).=C2=A0 So=20
> presumably, we should state that a cluster can only be written in=20
> compressed form IF it occupies less space than the uncompressed cluster=
=20
> (we could also allow a compressed form that occupies the same length as=
=20
> the uncompressed cluster, but that's a waste of CPU cycles).
>=20
> Once we have that restriction stated, then it becomes obvious that a=20
> compressed cluster should never REQUIRE using more than one host cluste=
r=20
> (and this is backed up by qcow2_alloc_bytes() asserting that size <=3D=20
> s->cluster_size).=C2=A0 Where things get interesting, though, is whethe=
r we=20
> PERMIT a compressed cluster to overlap a host cluster boundary.=20
> Technically, it might be possible, but qemu does NOT do that (again,=20
> looking at qcow2_alloc_bytes() - we loop if free_in_cluster < size) - s=
o=20
> we may want to be explicit about this point to prevent OTHER=20
> implementations from creating a compressed cluster that crosses host=20
> cluster boundaries (right now, I can't see qcow2_decompress_cluster()=20
> validating it, though - YIKES).

That said, a simple patch to try this:

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index 8c4b26ceaf2..85b5dbd9c16 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -1598,6 +1598,15 @@ int qcow2_decompress_cluster(BlockDriverState=20
*bs, uint64_t cluster_offset)
          sector_offset =3D coffset & 511;
          csize =3D nb_csectors * 512 - sector_offset;

+        /* We never write a compressed cluster that crosses host
+         * cluster boundaries; reject images that do that.  */
+        if (csize + (coffset % s->cluster_size) > s->cluster_size) {
+            qcow2_signal_corruption(bs, true, coffset, csize,
+                                    "Compressed cluster at %#" PRIx64
+                                    " crosses host cluster boundary",=20
coffset);
+            return -EIO;
+        }
+
          /* Allocate buffers on first decompress operation, most images =
are
           * uncompressed and the memory overhead can be avoided.  The=20
buffers
           * are freed in .bdrv_close().

triggers failures in iotests 122:

--- /home/eblake/qemu/tests/qemu-iotests/122.out	2017-10-06=20
13:45:25.559279136 -0500
+++ /home/eblake/qemu/tests/qemu-iotests/122.out.bad	2018-02-20=20
15:54:29.890221575 -0600
@@ -117,8 +117,8 @@
  convert -c -S 0:
  read 3145728/3145728 bytes at offset 0
  3 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
-read 63963136/63963136 bytes at offset 3145728
-61 MiB, X ops; XX:XX:XX.X (XXX YYY/sec and XXX ops/sec)
+qcow2: Marking image as corrupt: Compressed cluster at 0x5ffd2 crosses=20
host cluster boundary; further corruption events will be suppressed
+read failed: Input/output error
  [{ "start": 0, "length": 67108864, "depth": 0, "zero": false, "data":=20
true}]

so it looks like I'm reading qcow2_alloc_bytes() wrong and that we CAN=20
have a compressed cluster that crosses host cluster boundaries?


> So if I may suggest:
>=20
>  =C2=A0=C2=A0 x+1 - 61:=C2=A0=C2=A0=C2=A0 Number of additional 512-byte=
 sectors used for the
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 compressed data, beyond the sector containing the
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 offset in the previous field.=C2=A0 These sectors must=
 fit
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 within the same host cluster.

This sentence needs tweaking to match reality, given that my simple=20
patch to flag cross-sector hosts triggered (or I need to figure out what=20
was wrong with my patch).

>=C2=A0 Note that the compressed
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 data does not necessarily occupy all of the bytes in
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 the final sector; rather, decompression stops when it
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 has produced a cluster of data.=C2=A0 Another compress=
ed
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 cluster may map to the tail of the final sector used
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 by this compressed cluster.
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
