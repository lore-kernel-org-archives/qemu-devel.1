Received: from eggs.gnu.org ([2001:4830:134:3::10]:56450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ewIlN-00018x-OC
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 22:37:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1ewIlK-0004iD-FL
	for qemu-devel@nongnu.org; Wed, 14 Mar 2018 22:37:05 -0400
Date: Wed, 14 Mar 2018 20:36:45 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180314203645.3dac9c71@t450s.home>
In-Reply-To: <423b0a12-ed99-e9e1-eae0-d0cfd1a4d6bf@ozlabs.ru>
References: <20180212051954.GE11634@umbus.fritz.box>
	<0a57f0ec-4300-f4f3-3957-4bced8b57e14@ozlabs.ru>
	<20180212090653.42bdd2e2@w520.home>
	<0c594a0b-488c-b5f8-e8ed-ffa8f4a98088@ozlabs.ru>
	<20180213053630.GL11634@umbus.fritz.box>
	<20180213054124.GN11634@umbus.fritz.box>
	<8282d070-b2d3-7e43-3da9-b17c77b99a67@ozlabs.ru>
	<20180214013323.GA5247@umbus.fritz.box>
	<843efd62-7a39-8536-91ad-1abea2beb190@ozlabs.ru>
	<20180214085541.5491705f@w520.home>
	<20180216052824.GI2074@umbus.fritz.box>
	<c11af933-3f08-f2c8-0552-ce43ac8f5741@ozlabs.ru>
	<a29658e8-d2da-161d-d9b8-41f186969927@ozlabs.ru>
	<821596dc-35b0-60cf-3e1f-3df0809b2f8e@ozlabs.ru>
	<8e909bd8-2c24-abde-aa42-fd3f46ff649e@ozlabs.ru>
	<20180313105606.18d0d8af@w520.home>
	<423b0a12-ed99-e9e1-eae0-d0cfd1a4d6bf@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH qemu v7 2/4] vfio/pci: Relax DMA map errors
 for MMIO regions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Auger Eric <eric.auger@redhat.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Wed, 14 Mar 2018 13:40:21 +1100
Alexey Kardashevskiy <aik@ozlabs.ru> wrote:

> On 14/3/18 3:56 am, Alex Williamson wrote:
> > Actually making sure it compiles would have been nice:
> >=20
> > qemu.git/hw/vfio/common.c: In function =E2=80=98vfio_listener_region_ad=
d=E2=80=99:
> > qemu.git/hw/vfio/common.c:550:40: error: invalid operands to binary & (=
have =E2=80=98Int128 {aka struct Int128}=E2=80=99 and =E2=80=98hwaddr {aka =
long long unsigned int}=E2=80=99)
> >          if ((iova & pgmask) || (llsize & pgmask)) {
> >                                         ^
> > qemu.git/hw/vfio/common.c: In function =E2=80=98vfio_listener_region_de=
l=E2=80=99:
> > qemu.git/hw/vfio/common.c:669:50: error: invalid operands to binary & (=
have =E2=80=98Int128 {aka struct Int128}=E2=80=99 and =E2=80=98hwaddr {aka =
long long unsigned int}=E2=80=99)
> >          try_unmap =3D !((iova & pgmask) || (llsize & pgmask));
> >                                                   ^
> > Clearly llsize needs to be wrapped in int128_get64() here.  Should I
> > presume that testing of this patch is equally lacking?  =20
>=20
> No.
>=20
> I do not know how but this definitely compiles for me with these:
>=20
> gcc (GCC) 4.8.5 20150623 (Red Hat 4.8.5-16)
> gcc (GCC) 6.3.1 20161221 (Red Hat 6.3.1-1)
>=20
> I always thought Int128 is a struct but it turns out there are __uint128_t
> and __int128_t and everywhere I compile (including x86_64 laptop) there is
> CONFIG_INT128=3Dy in config-host.mak, hence no error.
>=20
> I can see that you fixed it (thanks for that!) but how do you compile it =
to
> get this error? There is no way to disable gcc's types and even 4.8.5 can
> do these. Thanks,

Hmm, I always try to do a 32bit build before I send a pull request,
that's where I started this time.  I thought an Int128 was always a
structure, so I figured it always failed.  Good to know there was more
than just my testing on this commit.  Since it's in, we can fix it
during the freeze if it turns out to be broken.  Thanks,

Alex
