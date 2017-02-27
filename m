Received: from eggs.gnu.org ([2001:4830:134:3::10]:41544)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ciPEn-0001do-Go
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 12:37:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ciPEm-0000gC-NC
	for qemu-devel@nongnu.org; Mon, 27 Feb 2017 12:37:29 -0500
Date: Mon, 27 Feb 2017 17:37:20 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170227173720.GJ10201@stefanha-x1.localdomain>
References: <1484884080-28836-1-git-send-email-zhang.zhanghailiang@huawei.com>
	<1484884080-28836-6-git-send-email-zhang.zhanghailiang@huawei.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="I/5syFLg1Ed7r+1G"
Content-Disposition: inline
In-Reply-To: <1484884080-28836-6-git-send-email-zhang.zhanghailiang@huawei.com>
Subject: Re: [Qemu-devel] [PATCH v3 5/6] replication: Implement block
 replication for shared disk case
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: zhanghailiang <zhang.zhanghailiang@huawei.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, kwolf@redhat.com, mreitz@redhat.com, xiecl.fnst@cn.fujitsu.com, zhangchen.fnst@cn.fujitsu.com, xuquan8@huawei.com, Wen Congyang <wency@cn.fujitsu.com>


--I/5syFLg1Ed7r+1G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 20, 2017 at 11:47:59AM +0800, zhanghailiang wrote:
> Just as the scenario of non-shared disk block replication,
> we are going to implement block replication from many basic
> blocks that are already in QEMU.
> The architecture is:
>=20
>          virtio-blk                     ||                               =
=2E----------
>              /                          ||                               =
| Secondary
>             /                           ||                               =
'----------
>            /                            ||                               =
  virtio-blk
>           /                             ||                               =
       |
>           |                             ||                               =
replication(5)
>           |                    NBD  -------->   NBD   (2)                =
       |
>           |                  client     ||    server ---> hidden disk <--=
 active disk(4)
>           |                     ^       ||                      |
>           |              replication(1) ||                      |
>           |                     |       ||                      |
>           |   +-----------------'       ||                      |
>          (3)  |drive-backup sync=3Dnone   ||                      |
> --------. |   +-----------------+       ||                      |
> Primary | |                     |       ||           backing    |
> --------' |                     |       ||                      |
>           V                     |                               |
>        +-------------------------------------------+            |
>        |               shared disk                 | <----------+
>        +-------------------------------------------+
>=20
>     1) Primary writes will read original data and forward it to Secondary
>        QEMU.
>     2) The hidden-disk is created automatically. It buffers the original =
content
>        that is modified by the primary VM. It should also be an empty dis=
k, and
>        the driver supports bdrv_make_empty() and backing file.
>     3) Primary write requests will be written to Shared disk.
>     4) Secondary write requests will be buffered in the active disk and it
>        will overwrite the existing sector content in the buffer.
>=20
> Signed-off-by: zhanghailiang <zhang.zhanghailiang@huawei.com>
> Signed-off-by: Wen Congyang <wency@cn.fujitsu.com>
> Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

Are there any restrictions on the shared disk?  For example the -drive
cache=3D mode must be 'none'.  If the cache mode isn't 'none' the
secondary host might have old data in the host page cache.  The
Secondary QEMU would have an inconsistent view of the shared disk.

Are image file formats like qcow2 supported for the shared disk?  Extra
steps are required to achieve consistency, see bdrv_invalidate_cache().

Stefan

--I/5syFLg1Ed7r+1G
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYtGPQAAoJEJykq7OBq3PIElUH/jq83ZFJjK+tBfAm7Asrqz8h
CZUeewqqWYQ5RUfFqODcL+k7S1bBIV7rvSZUyKvVQ2Zi5e8hXogG9Ugjj3iLSv4y
eYpHrPObIxjBhyrd1K2pA7qFmzlaYWneLhNYpBTvNq8zNs9MGQPNWjOBoe7viXpQ
t8yltNdDvOeREmRjD+cKXgYqPE3wgetSIEJEIj/zVEcWrTYa5tNdLHIIK8vN0slw
RIX523ZRbBfDxr+OdVKDSAPz8oWeYYlynFh9rwpb9vWh50eCmVbPvMQTmiC7d5yc
EoXN3ZLADdqhSE7Uo+HCnOd0yR/jCjF3uxYvdswqrFkxOrM0hjP2iCJtSDvMRUs=
=ao8W
-----END PGP SIGNATURE-----

--I/5syFLg1Ed7r+1G--
