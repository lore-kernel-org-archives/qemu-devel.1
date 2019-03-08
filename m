Received: from eggs.gnu.org ([209.51.188.92]:46861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h27fq-0002Sw-DA
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 00:03:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1h27fp-0002l5-8f
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 00:03:58 -0500
Date: Fri, 8 Mar 2019 15:34:56 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190308043456.GU7722@umbus.fritz.box>
References: <20190307050518.64968-1-aik@ozlabs.ru>
	<20190307050518.64968-4-aik@ozlabs.ru>
	<20190307150232.7384b7ce@w520.home>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="ePFeKdkqS71SfxAJ"
Content-Disposition: inline
In-Reply-To: <20190307150232.7384b7ce@w520.home>
Subject: Re: [Qemu-devel] [PATCH qemu v4 3/3] spapr: Support NVIDIA V100 GPU
 with NVLink2
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Gavin Shan <gwshan@linux.vnet.ibm.com>, Sam Bobroff <sbobroff@linux.ibm.com>, Piotr Jaroszynski <pjaroszynski@nvidia.com>, Leonardo Augusto =?iso-8859-1?Q?Guimar=E3es?= Garcia <lagarcia@br.ibm.com>, Jose Ricardo Ziviani <joserz@linux.ibm.com>, Daniel Henrique Barboza <danielhb413@gmail.com>


--ePFeKdkqS71SfxAJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 07, 2019 at 03:02:32PM -0700, Alex Williamson wrote:
> On Thu,  7 Mar 2019 16:05:18 +1100
> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> > diff --git a/hw/vfio/pci-quirks.c b/hw/vfio/pci-quirks.c
> > index 40a12001f580..15ec0b4c2723 100644
> > --- a/hw/vfio/pci-quirks.c
> > +++ b/hw/vfio/pci-quirks.c
> > @@ -2180,3 +2180,123 @@ int vfio_add_virt_caps(VFIOPCIDevice *vdev, Err=
or **errp)
> > =20
> >      return 0;
> >  }
> > +
> > +static void vfio_pci_nvlink2_get_tgt(Object *obj, Visitor *v,
> > +                                     const char *name,
> > +                                     void *opaque, Error **errp)
> > +{
> > +    uint64_t tgt =3D (uint64_t) opaque;
> > +    visit_type_uint64(v, name, &tgt, errp);
> > +}
> > +
> > +static void vfio_pci_nvlink2_get_link_speed(Object *obj, Visitor *v,
> > +                                                 const char *name,
> > +                                                 void *opaque, Error *=
*errp)
> > +{
> > +    uint32_t link_speed =3D (uint32_t)(uint64_t) opaque;
> > +    visit_type_uint32(v, name, &link_speed, errp);
> > +}
> > +
> > +int vfio_pci_nvidia_v100_ram_init(VFIOPCIDevice *vdev, Error **errp)
> > +{
> > +    int ret;
> > +    void *p;
> > +    struct vfio_region_info *nv2region =3D NULL;
> > +    struct vfio_info_cap_header *hdr;
> > +    MemoryRegion *nv2mr =3D g_malloc0(sizeof(*nv2mr));
>=20
> This is leaked in the below error paths and there's no cleanup on
> finalize.  I assume these devices don't support hotplug, but they could
> at least use the existing quirk infrastructure so as not to set a bad
> precedent.=20
>=20
> > +
> > +    ret =3D vfio_get_dev_region_info(&vdev->vbasedev,
> > +                                   VFIO_REGION_TYPE_PCI_VENDOR_TYPE |
> > +                                   PCI_VENDOR_ID_NVIDIA,
> > +                                   VFIO_REGION_SUBTYPE_NVIDIA_NVLINK2_=
RAM,
> > +                                   &nv2region);
> > +    if (ret) {
> > +        return ret;
> > +    }
> > +
> > +    p =3D mmap(NULL, nv2region->size, PROT_READ | PROT_WRITE | PROT_EX=
EC,
> > +             MAP_SHARED, vdev->vbasedev.fd, nv2region->offset);
> > +
> > +    if (!p) {
> > +        return -errno;
> > +    }
>=20
> I think the above suggestion requires simply defining a quirk above:
>=20
> VFIOQuirk *quirk;
>=20
> Initializing it with one MemoryRegion here:
>=20
> quirk =3D vfio_quirk_alloc(1);
>=20
> > +
> > +    memory_region_init_ram_ptr(nv2mr, OBJECT(vdev), "nvlink2-mr",
>=20
> s/nv2mr/quirk->mem/
>=20
> > +                               nv2region->size, p);
>=20
> Then adding it to the device, for instance assuming there's always a
> BAR0, attach it there:
>=20
> QLIST_INSERT_HEAD(&vdev->bars[0].quirks, quirk, next);
>=20
> At least then it pretends to support cleanup.

This does simplify the cleanup of the extra MRs.  It is a bit odd to
attach it specifically to a BAR that's not otherwise tied to these
resources (both the NV2 memory and ATSD are special NVLink extensions,
not attached to a PCI BAR).


--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--ePFeKdkqS71SfxAJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlyB8PAACgkQbDjKyiDZ
s5Ialw//Zi3OlusQw5Xw0ud7c8GZ3OAfMYWRl4S3Z8XqNNXeuBjnWhG+unUS3ym5
QSUXpRZCE5Vpb9H0hhFnbF7GYbmc1Cs5DJD2uxpOQvwyPWsn1PYw637mK5SxfNqk
p3q9JZxplQ49engq9JSHVO9pO7NAqo2U/JAW5YuUULwEFzpwOfCjoQvfzh++jSRo
TFdpAlILNqIrW/S37G61KtEr3bYHk/tRc4czaWLZrG32nAMzQlmTYRVKy05c1z49
SVadP8sICbY1AKEdi8Jpb+bQZuhnK/6uM9Ecooij8athLP54N8jbOdIhIUIfHS49
i8x/iaXs5iGMvlkRiGUTB7rAhRkCA1Rs1OzK3HDh6v0BsFewt1JclAeFBYooX7hK
IiWloOS+XyhVyZkX4kaMMJzKkWiLiyP22GvHirdFWDqzyuDAp8HH4Myvu/gCdzJy
8HRQtJee5EAZ7tOdd3V3SyZCEaRqCO/JR08fIuHZMSy3+Jk6OGUwoql1z5d127MW
S5nYLqkRKI3VmxMOuod7BqIri42qGGFzHj9m9PmfvoFfU8lgkOMj2cXDMs1QxwF5
qd3FxnwiW6ZGIlkgV0ei97XuwksXDa2bqYSzHXzgmlgg2o6PE8hk/+SztOTre8t2
F89maTxRy80b4eAT8q7WHJ6R1kWCZFZg50SiNr794i1gXPJcSyY=
=E34v
-----END PGP SIGNATURE-----

--ePFeKdkqS71SfxAJ--
