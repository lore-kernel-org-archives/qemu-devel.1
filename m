Received: from eggs.gnu.org ([2001:4830:134:3::10]:48548)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eCsNX-0001AE-D6
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 14:20:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eCsNT-0008Ng-UX
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 14:20:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51762)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1eCsNT-0008NH-OT
	for qemu-devel@nongnu.org; Thu, 09 Nov 2017 14:20:39 -0500
Date: Thu, 9 Nov 2017 20:20:33 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171109202033.1a0fb72b.cohuck@redhat.com>
In-Reply-To: <92ed4a36-5db9-9f76-069f-cd663bbe8aee@amsat.org>
References: <1510075479-17224-1-git-send-email-pmorel@linux.vnet.ibm.com>
	<1510075479-17224-2-git-send-email-pmorel@linux.vnet.ibm.com>
	<20171109173802.7a43dcc3.cohuck@redhat.com>
	<92ed4a36-5db9-9f76-069f-cd663bbe8aee@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 1/7] s390x/pci: factor out endianess
 conversion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Pierre Morel <pmorel@linux.vnet.ibm.com>, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, qemu-devel@nongnu.org, agraf@suse.de

On Thu, 9 Nov 2017 15:55:46 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> On 11/09/2017 01:38 PM, Cornelia Huck wrote:
> > On Tue,  7 Nov 2017 18:24:33 +0100
> > Pierre Morel <pmorel@linux.vnet.ibm.com> wrote:
> >  =20
> >> There are two places where the same endianness conversion
> >> is done.
> >> Let's factor this out into a static function.
> >>
> >> Signed-off-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
> >> Reviewed-by: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
> >> ---
> >>  hw/s390x/s390-pci-inst.c | 58 ++++++++++++++++++++++++++-------------=
---------
> >>  1 file changed, 32 insertions(+), 26 deletions(-)
> >>
> >> diff --git a/hw/s390x/s390-pci-inst.c b/hw/s390x/s390-pci-inst.c
> >> index 8e088f3..8fcb02d 100644
> >> --- a/hw/s390x/s390-pci-inst.c
> >> +++ b/hw/s390x/s390-pci-inst.c
> >> @@ -314,6 +314,35 @@ out:
> >>      return 0;
> >>  }
> >> =20
> >> +/**
> >> + * This function swaps the data at ptr according from one
> >> + * endianness to the other.
> >> + * valid data in the uint64_t data field. =20
> >=20
> > I'm not sure what that line is supposed to mean?
> >  =20
> >> + * @ptr: a pointer to a uint64_t data field
> >> + * @len: the length of the valid data, must be 1,2,4 or 8
> >> + */
> >> +static int zpci_endian_swap(uint64_t *ptr, uint8_t len)
> >> +{
> >> +    uint64_t data =3D *ptr;
> >> +    switch (len) {
> >> +    case 1:
> >> +        break;
> >> +    case 2:
> >> +        data =3D bswap16(data);
> >> +        break;
> >> +    case 4:
> >> +        data =3D bswap32(data);
> >> +        break;
> >> +    case 8:
> >> +        data =3D bswap64(data);
> >> +        break;
> >> +    default:
> >> +        return -EINVAL;
> >> +    }
> >> +    *ptr =3D data;
> >> +    return 0;
> >> +} =20
>=20
> This is usually care taken by memory::adjust_endianness() ...

Yes, but that's not a memory region write.

>=20
> > I was expecting more code to use a similar pattern, but it seems
> > surprisingly uncommon. =20
>=20
> Which ring a bell for latent bug?

Looking at this, it seems there *is* a latent bug, which has not popped
up so far as the pci instructions are not wired up in tcg yet. This
code is only called from the kvm path...

>=20
> This remind me of a similar issue on ppc:
>=20
> http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg05121.html
> ...
> http://lists.nongnu.org/archive/html/qemu-devel/2017-02/msg05666.html
