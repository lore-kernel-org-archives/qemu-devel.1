Received: from eggs.gnu.org ([2001:4830:134:3::10]:36441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpVFu-00016A-7I
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:00:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpVFo-0004n8-Jm
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 04:00:14 -0400
Date: Wed, 6 Sep 2017 09:59:53 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170906095953.13d5fb01.cohuck@redhat.com>
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

OK, looked at this. This won't work: pci_available means "this qemu has
pci support built in". _Working_ zpci, however, depends on the presence
of the zpci feature bit: You'll have a host bridge and can define
devices that have absolutely no chance of working, since all pci
instruction will return errors. You will be in a similar situation
under kvm as under tcg: you can specify virtio-pci devices on the
command line, but they can't work.

This probably makes the 5 cases pass as they only rely on the ability
to create the device, not to do anything with them.

So, I still think the right thing to do is to switch to ccw in the
tests (and to wire up pci in tcg, but that's an orthogonal issue).
