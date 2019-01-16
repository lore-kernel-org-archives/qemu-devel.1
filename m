Received: from eggs.gnu.org ([209.51.188.92]:47659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gjmSK-0002Hs-Ix
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:46:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gjmSD-0004lW-VF
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:46:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:24832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gjmSD-0004cx-IO
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:46:05 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B68D03697E
	for <qemu-devel@nongnu.org>; Wed, 16 Jan 2019 14:46:00 +0000 (UTC)
Date: Wed, 16 Jan 2019 12:45:43 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190116144543.GA14807@habkost.net>
References: <cover.1547420060.git.crobinso@redhat.com>
	<1ac81ba920b03d153f80236fea5aa81321e054fa.1547420060.git.crobinso@redhat.com>
	<20190115165614.GL16157@redhat.com>
	<624086124c9a2673c627203f3310fd63495e00c0.camel@redhat.com>
	<20190116113953.GO20275@redhat.com>
	<d3fd5d3bf9a6823b24756b4f376e20903ac1a575.camel@redhat.com>
	<20190116124445.GS20275@redhat.com>
	<2b4954e50ad51e7b3bdaf6b7b183254e2a1cd70d.camel@redhat.com>
	<20190116143722.GY20275@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190116143722.GY20275@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [libvirt] [PATCH 4/6] qemu: Wire up disk
 model=virtio-{non-}transitional
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: Andrea Bolognani <abologna@redhat.com>, Cole Robinson <crobinso@redhat.com>, libvirt-list@redhat.com, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, Jan 16, 2019 at 02:37:22PM +0000, Daniel P. Berrang=E9 wrote:
> On Wed, Jan 16, 2019 at 03:31:49PM +0100, Andrea Bolognani wrote:
> > On Wed, 2019-01-16 at 12:44 +0000, Daniel P. Berrang=E9 wrote:
> > > On Wed, Jan 16, 2019 at 01:29:13PM +0100, Andrea Bolognani wrote:
> > > > On Wed, 2019-01-16 at 11:39 +0000, Daniel P. Berrang=E9 wrote:
> > > > > In the
> > > > > future they may add properties to, or change the defaults on, t=
he
> > > > > -transitional or -non-transitional devices only, associated wit=
h
> > > > > new machine type versions. If libvirt forever uses the old devi=
ces,
> > > > > then we loose ability to take advantage of that.
> > > >=20
> > > > Regardless of what libvirt ends up doing, from the QEMU user poin=
t
> > > > of view I think it would be very surprising if eg. virtio-blk-pci
> > > > plugged into a PCIe slot behaved differently from
> > > > virtio-blk-pci-non-transitional plugged into the very same slot, =
or
> > > > if virtio-net-pci,disable-legacy=3Dfalse,disable-modern=3Dfalse b=
ehaved
> > > > differently from virtio-net-pci-transitional regardless of the sl=
ot
> > > > it's plugged into, so moving away from that consistency should be=
 a
> > > > non-goal IMHO.
> > > >=20
> > [...]
> > >=20
> > > In this message Eduardo said virtio-blk-pci,disable-legacy and
> > > virtio-blk-pci-non-transitional are only compatible with the
> > > pc-4.0 machine types and earlier. There's no compat guarantee
> > > of compat for future machine types:
> > >=20
> > >   https://lists.gnu.org/archive/html/qemu-devel/2018-11/msg03762.ht=
ml
> > >=20
> > > If we didn't use the new QEMU device models right now, we could end
> > > up trapped forever. The safe futureproof approach is to always use
> > > the new devices models if available, and use disable-legacy for old
> > > QEMU versions only, which we know will have old machine types for
> > > which the compat guarantee is available.
> >=20
> > Well, let's see if Eduardo is willing to reconsider the policy on
> > compatibility between virtio-*-pci-{,non-}transitional and plain
> > virtio-*-pci going forward based on the principle-of-least-surprise
> > rationale outlined above :)
>=20
> I think we should use the new devices no matter what. Libvirt generally
> always strives to follow the latest QEMU best practice, even when new &
> old way of doing something are functionally identical. Eventually we
> would drop support for QEU < 4.0 and the old way would go away entirely=
.

It would also allow us to deprecate the old devices, which would
be welcome.  Always using the new devices when available would be
my recommendation.

But I don't want to create unnecessary obstacles for libvirt, so
if there's a real benefit in promising compatibility between both
device types, we can still promise that on the QEMU side.
Breaking compatibility on purpose is very unlikely, and the most
likely accidents could be detected by
tests/acceptance/virtio_version.py.

--=20
Eduardo
