Received: from eggs.gnu.org ([209.51.188.92]:50605)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyr34-0004vz-3g
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 23:42:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1gyr2w-0005kz-9a
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 23:42:21 -0500
Date: Wed, 27 Feb 2019 15:27:30 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190227042729.GZ6872@umbus.fritz.box>
References: <154943058200.27958.11497653677605446596.stgit@lep8c.aus.stglabs.ibm.com>
	<154943078167.27958.5009288263168039462.stgit@lep8c.aus.stglabs.ibm.com>
	<20190212014953.GI1884@umbus.fritz.box>
	<fbc178dd-ee93-1675-b8e5-ccfec72ab66a@linux.ibm.com>
	<20190217230211.GA2765@umbus.fritz.box>
	<88da2809-61f8-0a7a-d2c4-54cb0f3e5e35@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="KC8n6y+EC4k2kdZR"
Content-Disposition: inline
In-Reply-To: <88da2809-61f8-0a7a-d2c4-54cb0f3e5e35@linux.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH 3/4] spapr: Add NVDIMM device support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Shivaprasad G Bhat <sbhat@linux.ibm.com>
Cc: qemu-devel@nongnu.org, xiaoguangrong.eric@gmail.com, mst@redhat.com, bharata@linux.ibm.com, qemu-ppc@nongnu.org, vaibhav@linux.ibm.com, imammedo@redhat.com


--KC8n6y+EC4k2kdZR
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 18, 2019 at 09:45:13PM +0530, Shivaprasad G Bhat wrote:
>=20
>=20
> On 02/18/2019 04:32 AM, David Gibson wrote:
> > On Fri, Feb 15, 2019 at 04:41:09PM +0530, Shivaprasad G Bhat wrote:
> > > Thanks for the comments David. Please find my replies inline..
[snip]
> > > > > +
> > > > > +    qemu_uuid_unparse(&uuid, buf);
> > > > > +    _FDT((fdt_setprop_string(fdt, offset, "ibm,unit-guid", buf))=
);
> > > > > +
> > > > > +    _FDT((fdt_setprop_cell(fdt, offset, "ibm,my-drc-index", drc_=
idx)));
> > > > > +
> > > > > +    /*NB : What it should be? */
> > > > > +    _FDT(fdt_setprop_cell(fdt, offset, "ibm,latency-attribute", =
828));
> > > > > +
> > > > > +    _FDT((fdt_setprop_u64(fdt, offset, "ibm,block-size",
> > > > > +                          SPAPR_MINIMUM_SCM_BLOCK_SIZE)));
> > > > > +    _FDT((fdt_setprop_u64(fdt, offset, "ibm,number-of-blocks",
> > > > > +                          size / SPAPR_MINIMUM_SCM_BLOCK_SIZE)));
> > > > > +    _FDT((fdt_setprop_cell(fdt, offset, "ibm,metadata-size", lab=
el_size)));
> > > > > +
> > > > > +    return offset;
> > > > > +}
> > > > > +
> > > > > +static void spapr_add_nvdimm(DeviceState *dev, uint64_t addr,
> > > > > +                             uint64_t size, uint32_t node,
> > > > > +                             Error **errp)
> > > > > +{
> > > > > +    sPAPRMachineState *spapr =3D SPAPR_MACHINE(qdev_get_hotplug_=
handler(dev));
> > > > > +    sPAPRDRConnector *drc;
> > > > > +    bool hotplugged =3D spapr_drc_hotplugged(dev);
> > > > > +    NVDIMMDevice *nvdimm =3D NVDIMM(OBJECT(dev));
> > > > > +    void *fdt;
> > > > > +    int fdt_offset, fdt_size;
> > > > > +    Error *local_err =3D NULL;
> > > > > +
> > > > > +    spapr_dr_connector_new(OBJECT(spapr), TYPE_SPAPR_DRC_PMEM,
> > > > > +                           addr / SPAPR_MINIMUM_SCM_BLOCK_SIZE);
> > > > > +    drc =3D spapr_drc_by_id(TYPE_SPAPR_DRC_PMEM,
> > > > > +                          addr / SPAPR_MINIMUM_SCM_BLOCK_SIZE);
> > > > > +    g_assert(drc);
> > > > Creating the DRC in the hotplug path looks bogus.  Generally the DRC
> > > > has to exist before you can even attempt to plug the device.
> > > We dont really know how many DRC to create. Unlike memory hotplug
> > > where we know how many LMBs are required to fit till the maxmem, in t=
his
> > > case we dont know how many NVDIMM devices=A0 guest can have. That is =
the
> > > reason I am creating the DRC on demand. I'll see if it is possible to
> > > address this
> > > by putting a cap on maximum number of NVDIMM devices a guest can have.
> > Urgh, PAPR.  First it specifies a crappy hotplug model that requires
> > zillions of fixed attachment points to be instantiated, then it breaks
> > its own model.
> >=20
> > But.. I still don't really understand how this works.
> >=20
> > a) How does the guest know the DRC index to use for the new NVDIMM?
> >     Generally that comes from the device tree, but the guest doesn't
> >     get new device tree information until it calls configure-connector
> >     for which it needs the DRC index.
> The DRC is passed in the device tree blob passed as payload of hotplug
> interrupt

Um.. there is no device tree blob as paylod of a hotplug interrupt.
The guest only gets device tree information when it makes
configure-connector calls.

I see that there is a drc identifier field though, so I guess you're
getting the DRC from that.  In existing cases the guest looks that up
in the *existing* device tree to find infomation about that DRC.  I
guess in the case of NVDIMMs here it doesn't need any more info.

> from which the guest picks the DRC index and makes the subsequent calls.
> > b) AFAICT, NVDIMMs would also require HPT space, much like regular
> >     memory would.  PowerVM doesn't have HPT resizing, so surely it must
> >     already have some sort of cap on the amount of NVDIMM space in
> >     order to size the HPT correctly.
> On Power KVM we will enforce the NVDIMM is mapped within the maxmem,
> however the spec allows outside of it. Coming back to the original point =
of
> creating the DRCs at the hotplug time, we could impose a limit on the
> number of NVDIMM devices that could be hotplugged so that we can
> create the DRCs at the machine init time.

Ah, so NVDIMMs live within the same maxmem limit as regular memory.
Ok, I guess that makes sense.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--KC8n6y+EC4k2kdZR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlx2EbEACgkQbDjKyiDZ
s5KL3BAAmhrW4C/Y9bomClX2i2l/g/olwBwHQrkuwt8rvQxx3Hvwcb0/AmOTe9of
UmRvBHjw0GmKUMzrUlo+wRj+QtjskGNEa95ZJIlQSrtTASYAA8C+p5AlrZR2DxjT
xecVbsTrmLxxBBwUhi9lj1WIJ2dvYp0owDdBLLRhV80T10b6psBLy7yMZlj0yFE1
peXgYKPSwyJwKYgnd903QNClk1ajQVhoiURgAwZDhix3ZdARtZnqxaHyaCAGbciQ
Mbt8j+P8upZeS0ioVpOlGvTmiAhsgN66e5u2cpPuokRE0PsWhF8kb1xm1fgfn1VE
vOyhKoA5tTbZGOWiH+0QV7qp678MAIBKyrTGwdyB403w6mCeluFNnScEaM09Uw9n
7rj7Hx8BIr+Y/niNSyx7Pu+Ww4CrxxRiFJsld98HQO2HOsZ3UrNqU++JeHuZaG90
NUVJnEG6rJns3M5Ev9vXC7iGU1zO5DYHC9QeE9qZiZPCSdCNyjgxG27R7sn7Y+Jv
jDUKf4OA7+bbRYvIy0jqWyvDIFKxe1GLKHF5ZGbnUB2hvHaTUopDm3i1faTInM0N
k+0U8u+3pRGZeZ1/P3cjKiskJuYu/lr0RjZQJCTU0FAV6bKOSZPUE00/51XEhDTB
wAxziyn7oQMJ+xhJvYCrvnD3ZgepsgCXe7Xlw0Bbte4WNEE/PL8=
=qTua
-----END PGP SIGNATURE-----

--KC8n6y+EC4k2kdZR--
