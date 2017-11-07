Received: from eggs.gnu.org ([2001:4830:134:3::10]:58939)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eBzye-00075F-VM
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 04:15:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1eBzya-0000wl-8q
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 04:15:24 -0500
Date: Tue, 7 Nov 2017 10:15:06 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20171107091506.GA4706@localhost.localdomain>
References: <201711071518033155528@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201711071518033155528@zte.com.cn>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] about qemu-img info on block dev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: wang.guang55@zte.com.cn
Cc: mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, wang.yong155@zte.com.cn

Am 07.11.2017 um 08:18 hat wang.guang55@zte.com.cn geschrieben:
> hello
>=20
>=20
> if we create a qcow2 file on a block dev.
>=20
>=20
> we can,t get the right disk size by qemu-img info=E3=80=82
>=20
>=20
>=20
>=20
>=20
>=20
> [root@host-120-79 qemu]# ./qemu-img create -f qcow2 /dev/zs/lvol0 1G
>=20
> Formatting '/dev/zs/lvol0', fmt=3Dqcow2 size=3D1073741824 cluster_size=3D=
65536 lazy_refcounts=3Doff refcount_bits=3D16
>=20
> [root@host-120-79 qemu]# ./qemu-img info /dev/zs/lvol0=20
>=20
> image: /dev/zs/lvol0
>=20
> file format: qcow2
>=20
> virtual size: 1.0G (1073741824 bytes)
>=20
> disk size: 0
>=20
> cluster_size: 65536
>=20
> Format specific information:
>=20
>     compat: 1.1
>=20
>     lazy refcounts: false
>=20
>     refcount bits: 16
>=20
>     corrupt: false
>=20
>=20
>=20
>=20
>=20
>=20
> Then we get disk size from L1 table and L2 table in qcow2_get_allocated=
_file_size.
>=20
>=20
> May be we can submit the patch to qemu master??

No, qcow2 is the wrong layer to do this. If anything,
raw_get_allocated_file_size() could be changed to return the full file
size for block devices. However, even this is not necessarily the right
number, the block device could actually be thin provisioned and the
kernel doesn't tell us how many blocks are actually allocated. So I
think 0 for "we don't know" is in fact the right answer.

Kevin
