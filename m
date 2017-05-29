Received: from eggs.gnu.org ([2001:4830:134:3::10]:58441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFPVu-00056P-25
	for qemu-devel@nongnu.org; Mon, 29 May 2017 14:35:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFPVt-0001AZ-3T
	for qemu-devel@nongnu.org; Mon, 29 May 2017 14:35:34 -0400
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
	<20170503122539.282182-10-vsementsov@virtuozzo.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <33ce370d-939f-d02e-0177-1184ae9f4fa7@redhat.com>
Date: Mon, 29 May 2017 20:35:16 +0200
MIME-Version: 1.0
In-Reply-To: <20170503122539.282182-10-vsementsov@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VJfnXeqQKjsXDHKhrhf4kjXtCmFo9TDaN"
Subject: Re: [Qemu-devel] [PATCH 09/25] block/dirty-bitmap: add readonly
 field to BdrvDirtyBitmap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com, famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VJfnXeqQKjsXDHKhrhf4kjXtCmFo9TDaN
From: Max Reitz <mreitz@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, eblake@redhat.com, jsnow@redhat.com,
 famz@redhat.com, den@openvz.org, stefanha@redhat.com, pbonzini@redhat.com
Message-ID: <33ce370d-939f-d02e-0177-1184ae9f4fa7@redhat.com>
Subject: Re: [PATCH 09/25] block/dirty-bitmap: add readonly field to
 BdrvDirtyBitmap
References: <20170503122539.282182-1-vsementsov@virtuozzo.com>
 <20170503122539.282182-10-vsementsov@virtuozzo.com>
In-Reply-To: <20170503122539.282182-10-vsementsov@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-03 14:25, Vladimir Sementsov-Ogievskiy wrote:
> It will be needed in following commits for persistent bitmaps.
> If bitmap is loaded from read-only storage (and we can't mark it
> "in use" in this storage) corresponding BdrvDirtyBitmap should be
> read-only.
>=20
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> ---
>  block/dirty-bitmap.c         | 16 ++++++++++++++++
>  include/block/dirty-bitmap.h |  3 +++
>  2 files changed, 19 insertions(+)

Revisiting this again after the whole series: So you never really make
sure that the read-only bitmaps are not written to (except for these
assertions). The idea is that you only set it for read-only BDS and
read-only BDS are never written to. But that assumption is not true,
generally, and can be broken e.g. using a commit job:

$ ./qemu-img create -f qcow2 backing.qcow2 64M
Formatting 'backing.qcow2', fmt=3Dqcow2 size=3D67108864 encryption=3Doff
    cluster_size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
$ ./qemu-img create -f qcow2 -b backing.qcow2 top.qcow2
Formatting 'top.qcow2', fmt=3Dqcow2 size=3D67108864
    backing_file=3Dbacking.qcow2 encryption=3Doff cluster_size=3D65536
    lazy_refcounts=3Doff refcount_bits=3D16
$ x86_64-softmmu/qemu-system-x86_64 -qmp stdio
{"QMP": {"version": {"qemu": {"micro": 50, "minor": 9, "major": 2},
"package": " (v2.9.0-632-g4a52d43-dirty)"}, "capabilities": []}}
{'execute': 'qmp_capabilities'}
{"return": {}}
{'execute': 'blockdev-add',
 'arguments': {'node-name': 'backing-node', 'driver': 'qcow2',
               'file': {'driver': 'file', 'filename': 'backing.qcow2'}}}
{"return": {}}
{'execute': 'block-dirty-bitmap-add',
 'arguments': {'node': 'backing-node', 'name': 'foo',
               'persistent': true, 'autoload': true}}
{"return": {}}
{'execute': 'blockdev-del', 'arguments': {'node-name': 'backing-node'}}
{"return": {}}
{'execute': 'blockdev-add',
 'arguments': {'node-name': 'top-node', 'driver': 'qcow2',
               'file': {'driver': 'file', 'filename': 'top.qcow2'}}}
{"return": {}}
{'execute': 'human-monitor-command',
 'arguments': {'command-line': 'qemu-io top-node "write 0 64k"'}}
wrote 65536/65536 bytes at offset 0
64 KiB, 1 ops; 0.0079 sec (7.852 MiB/sec and 125.6281 ops/sec)
{"return": ""}
{'execute': 'block-commit',
 'arguments': {'device': 'top-node', 'job-id': 'commit-job'}}
{"return": {}}
qemu-system-x86_64: block/dirty-bitmap.c:571: bdrv_set_dirty: Assertion
`!bdrv_dirty_bitmap_readonly(bitmap)' failed.
[1]    10872 abort (core dumped)  x86_64-softmmu/qemu-system-x86_64 -qmp
stdio

So there needs to be something else than just assertions to make sure
that read-only bitmaps are never written to.

Max


--VJfnXeqQKjsXDHKhrhf4kjXtCmFo9TDaN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLGnkEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQFs5
B/0aT7kgOFJZiYOASxNF697evrTIYDDS8c7HxBdQ7ZtRpQ1UlOxY/7K09uDVg9e0
4y0PNJAF9Zzjgqsb/5+7hNO87PkkyPucHD0hTOOcJE28USd9FjAMTe1LTl1U4M1P
WWr0uidmtV6OibgJAQyNP7NiBkNeyKvfG6TmpxgeFIi53RFf5JuxSbb05Ehh2/Kg
IPmHZpfQsSnTV4J5VkcYCxEEM6F/JZhoUoi1tLagLTALJ3kD2Nz8RGE7EXWJUZlb
ElmT7sXOTpNhc4cC9JvqQ7P51+fqypdLt7TEox17zqQ3HyF2HWbqF5/qDBuTYLBK
Z2nau0ZsPBECRQ1/WIyvIul8
=hGaX
-----END PGP SIGNATURE-----

--VJfnXeqQKjsXDHKhrhf4kjXtCmFo9TDaN--
