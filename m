Received: from eggs.gnu.org ([2001:4830:134:3::10]:45726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIG7o-0002x3-St
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:10:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dIG7l-0000mA-MH
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:10:28 -0400
Received: from 17.mo5.mail-out.ovh.net ([46.105.56.132]:53510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dIG7l-0000lA-Fa
	for qemu-devel@nongnu.org; Tue, 06 Jun 2017 11:10:25 -0400
Received: from player734.ha.ovh.net (b6.ovh.net [213.186.33.56])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 322A61039EC
	for <qemu-devel@nongnu.org>; Tue,  6 Jun 2017 17:10:23 +0200 (CEST)
Date: Tue, 6 Jun 2017 17:10:08 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170606171008.31bea859@bahia.ttt.fr.ibm.com>
In-Reply-To: <CAFEAcA94hHrYU_MU9vHxvryAAvYXa6YCgECdqSqDN7GW9zFSxQ@mail.gmail.com>
References: <20170525035132.24268-1-david@gibson.dropbear.id.au>
	<20170525035132.24268-14-david@gibson.dropbear.id.au>
	<CAFEAcA94hHrYU_MU9vHxvryAAvYXa6YCgECdqSqDN7GW9zFSxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/PARVdta+xa239i/KLMU6HW3";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PULL 13/18] spapr: add pre_plug function for
 memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, Laurent Vivier <lvivier@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, sursingh@redhat.com, Alexander Graf <agraf@suse.de>, Michael Roth <mdroth@linux.vnet.ibm.com>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>, sbobroff@redhat.com

--Sig_/PARVdta+xa239i/KLMU6HW3
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Tue, 6 Jun 2017 16:00:32 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 25 May 2017 at 04:51, David Gibson <david@gibson.dropbear.id.au> wrote:
> > From: Laurent Vivier <lvivier@redhat.com>
> >
> > This allows to manage errors before the memory
> > has started to be hotplugged. We already have
> > the function for the CPU cores. =20
>=20
> > +static void spapr_memory_pre_plug(HotplugHandler *hotplug_dev, DeviceS=
tate *dev,
> > +                                  Error **errp)
> > +{
> > +    PCDIMMDevice *dimm =3D PC_DIMM(dev);
> > +    PCDIMMDeviceClass *ddc =3D PC_DIMM_GET_CLASS(dimm);
> > +    MemoryRegion *mr =3D ddc->get_memory_region(dimm);
> > +    uint64_t size =3D memory_region_size(mr);
> > +    char *mem_dev;
> > +
> > +    if (size % SPAPR_MEMORY_BLOCK_SIZE) {
> > +        error_setg(errp, "Hotplugged memory size must be a multiple of=
 "
> > +                      "%lld MB", SPAPR_MEMORY_BLOCK_SIZE / M_BYTE);
> > +        return;
> > +    }
> > +
> > +    mem_dev =3D object_property_get_str(OBJECT(dimm), PC_DIMM_MEMDEV_P=
ROP, NULL);
> > +    if (mem_dev && !kvmppc_is_mem_backend_page_size_ok(mem_dev)) {
> > +        error_setg(errp, "Memory backend has bad page size. "
> > +                   "Use 'memory-backend-file' with correct mem-path.");
> > +        return;
> > +    }
> > +} =20
>=20
> Coverity points out that this leaks memory -- object_property_get_str()
> returns a copy of a string which the caller is supposed to free, but
> this code doesn't free it. (CID 1375942.)
>=20

Yeah, I've received the Coverity report as well. This is a regression intro=
duced
in 2.9 by commit df58713396f8 ("hw/ppc/spapr: Check for valid page size whe=
n hot
plugging memory") actually.

The same commit also introduces a similar leak in
kvmppc_is_mem_backend_page_size_ok().

I'm about to send a series to fix both.

Cheers.

--
Greg

> thanks
> -- PMM
>=20


--Sig_/PARVdta+xa239i/KLMU6HW3
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlk2xdAACgkQAvw66wEB28LNKACdFclQ+DG1xIiTmiVfj+xkaJ6V
MFUAn1oHeYJ8AoXb8kM6RETepB/iaXv2
=qU0W
-----END PGP SIGNATURE-----

--Sig_/PARVdta+xa239i/KLMU6HW3--
