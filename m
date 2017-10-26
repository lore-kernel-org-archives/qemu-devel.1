Received: from eggs.gnu.org ([2001:4830:134:3::10]:46759)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changlimin@h3c.com>) id 1e7Wd5-00089E-UU
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 21:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <changlimin@h3c.com>) id 1e7Wd2-0000SL-P2
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 21:06:39 -0400
Received: from smtp.h3c.com ([60.191.123.56]:48869 helo=h3cmg01-ex.h3c.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <changlimin@h3c.com>) id 1e7Wd1-0000Ng-Vs
	for qemu-devel@nongnu.org; Wed, 25 Oct 2017 21:06:36 -0400
From: Changlimin <changlimin@h3c.com>
Date: Thu, 26 Oct 2017 01:06:12 +0000
Message-ID: <BC29A004BA570342A4CC0044A3845572CFCE5962@H3CMLB12-EX.srv.huawei-3com.com>
References: <BC29A004BA570342A4CC0044A3845572CFCE5592@H3CMLB12-EX.srv.huawei-3com.com>
	<20171025133115.GA23458@lemon>
In-Reply-To: <20171025133115.GA23458@lemon>
Content-Language: zh-CN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] Block format 'raw' does not support the option
 'locking' when disable image locking with option locking=off
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

share-rw=3Don is good for raw format file, but bad for qcow2 format file:

Failed to get "write" lock
Is another process using the image?

Is this intented?

BR
Chang Limin

-----Original Message-----
From: Fam Zheng [mailto:famz@redhat.com]=20
Sent: Wednesday, October 25, 2017 9:31 PM
To: changlimin 00148 (Cloud)
Cc: qemu-devel@nongnu.org
Subject: Re: [Qemu-devel] Block format 'raw' does not support the option 'l=
ocking' when disable image locking with option locking=3Doff

On Wed, 10/25 08:15, Changlimin wrote:
> Hi,
> When running Oracle RAC, one image is shared between multiple vms, so I w=
ant to disable locking with option locking=3Doff, But Block format 'raw' do=
es not support the option 'locking'.
> How to disable locking?
>=20
> The version is git e822e81e350825dd94f41ee2538ff1432b812eb9
>=20
> The command line is
> -drive=20
> file=3D/var/lib/libvirt/images/r0605-share.img,format=3Draw,if=3Dnone,id=
=3Ddri
> ve-virtio-disk1,cache=3Ddirectsync,aio=3Dnative,locking=3Doff \ -device=20
> virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0xa,drive=3Ddrive-virtio-dis=
k1,id
> =3Dvirtio-disk1 \

Hi, in this case you probably want to use share-rw=3Don:

 -device virtio-blk-pci,share-rw=3Don,scsi=3Doff,...

The -drive option is the same. This is more semantically correct than locki=
ng=3Doff as it means "the device can share the image with other QEMUs".

But for really disabling locking with "locking=3Doff", the right syntax is:

 -drive file.filename=3D/var/lib/...,file.locking=3Doff \

or alternatively:

 -drive driver=3Dfile,filename=3D/var/lib/...,locking=3Doff \

Fam
