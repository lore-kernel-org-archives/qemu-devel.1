Received: from eggs.gnu.org ([2001:4830:134:3::10]:49842)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpUaI-0006RI-Ok
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 03:17:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpUaH-00067U-Se
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 03:17:14 -0400
Date: Wed, 6 Sep 2017 09:17:01 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170906091701.6d0fe044.cohuck@redhat.com>
In-Reply-To: <4af30c89-15a8-c3e6-3563-aa4c8e76c577@linux.vnet.ibm.com>
References: <20170905151614.31303-1-cohuck@redhat.com>
	<4af30c89-15a8-c3e6-3563-aa4c8e76c577@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/3] iotests: cure s390x failures by
 switching to ccw
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QingFeng Hao <haoqf@linux.vnet.ibm.com>
Cc: kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, qemu-devel@nongnu.org, borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, david@redhat.com, Yi Min Zhao <zyimin@linux.vnet.ibm.com>

On Wed, 6 Sep 2017 14:57:48 +0800
QingFeng Hao <haoqf@linux.vnet.ibm.com> wrote:

> =E5=9C=A8 2017/9/5 23:16, Cornelia Huck =E5=86=99=E9=81=93:
> > Recent changes in s390x made pci support dependant on the zpci cpu
> > feature, which is not provided on all models (and not on by default).
> > This means we cannot instatiate pci devices on a standard qemu
> > invocation for s390x. Moreover, the zpci instructions are not even
> > wired up for tcg yet, so actually doing anything with those pci devices
> > is bound to fail on tcg.
> >
> > Let's follow the existing example in 068 and switch to the (default)
> > virtio-ccw transport on s390x. The changes for 051 and 067 are split
> > out as they require adding an output file for s390x (the actual command
> > lines are part of the output). =20
> We also found this error and YiMin suggested to change the code in ccw_in=
it
> as below:
>=20
> if (pci_available) {
>  =C2=A0=C2=A0=C2=A0 DeviceState *dev =3D qdev_create(NULL, TYPE_S390_PCI_=
HOST_BRIDGE);
>  =C2=A0=C2=A0=C2=A0 ...
> }
> We tested it and it can make the 5 cases passed.
> How do you think this? :-)

I can take a look at this.

But I think we want to prefer ccw for s390x in the tests in any case,
for the reasons stated above.

> Thanks!
>=20
> >
> > Cornelia Huck (3):
> >    iotests: use -ccw on s390x for 040, 139, and 182
> >    iotests: use -ccw on s390x for 051
> >    iotests: use -ccw on s390x for 067
> >
> >   tests/qemu-iotests/040                     |   6 +-
> >   tests/qemu-iotests/051                     |   9 +-
> >   tests/qemu-iotests/051.s390-ccw-virtio.out | 434 ++++++++++++++++++++=
+++++++
> >   tests/qemu-iotests/067                     |  11 +-
> >   tests/qemu-iotests/067.s390-ccw-virtio.out | 458 ++++++++++++++++++++=
+++++++++
> >   tests/qemu-iotests/139                     |  12 +-
> >   tests/qemu-iotests/182                     |  13 +-
> >   7 files changed, 936 insertions(+), 7 deletions(-)
> >   create mode 100644 tests/qemu-iotests/051.s390-ccw-virtio.out
> >   create mode 100644 tests/qemu-iotests/067.s390-ccw-virtio.out
> > =20
>=20
