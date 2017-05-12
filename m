Received: from eggs.gnu.org ([2001:4830:134:3::10]:34683)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d93Cd-0004hy-0T
	for qemu-devel@nongnu.org; Fri, 12 May 2017 01:33:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d93CZ-0002KE-1N
	for qemu-devel@nongnu.org; Fri, 12 May 2017 01:33:23 -0400
Received: from ozlabs.org ([103.22.144.67]:39233)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1d93CX-0002FF-Mi
	for qemu-devel@nongnu.org; Fri, 12 May 2017 01:33:18 -0400
Date: Fri, 12 May 2017 15:25:08 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170512052508.GD12908@umbus.fritz.box>
References: <1494403315-12760-1-git-send-email-peterx@redhat.com>
	<1494403315-12760-5-git-send-email-peterx@redhat.com>
	<20170511015637.GF14408@umbus.fritz.box>
	<20170511093603.GJ28293@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8w3uRX/HFJGApMzv"
Content-Disposition: inline
In-Reply-To: <20170511093603.GJ28293@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH v3 04/12] memory: fix
 address_space_get_iotlb_entry()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, yi.l.liu@intel.com, Marcel Apfelbaum <marcel@redhat.com>, Lan Tianyu <tianyu.lan@intel.com>, Jason Wang <jasowang@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>


--8w3uRX/HFJGApMzv
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 11, 2017 at 05:36:03PM +0800, Peter Xu wrote:
> On Thu, May 11, 2017 at 11:56:38AM +1000, David Gibson wrote:
> > On Wed, May 10, 2017 at 04:01:47PM +0800, Peter Xu wrote:
> > > This function has an assumption that we will definitely call translat=
e()
> > > once (or say, the addr will be located inside one IOMMU memory region=
),
> > > otherwise an empty IOTLB will be returned. Nevertheless, this is not
> > > what we want. When there is no IOMMU memory region, we should build u=
p a
> > > static mapping for the caller, instead of an invalid IOTLB.
> > >=20
> > > We won't trigger this path before VT-d passthrough mode. When
> > > passthrough mode for a vhost device is setup, VT-d is possible to
> > > disable the IOMMU region for that device. Without current patch, we'll
> > > get a vhost boot failure, and it'll be failed over to virtio userspace
> > > mode.
> >=20
> > This doesn't look right to me.  You're assuming the target is
> > address_space_memory, which might not be the case - and you should be
> > able to check from the MR you do hit.  Furthermore it doesn't look
> > like you're accounting for the trivial translation if the section's
> > offset in the address space is different from its offset in the MR.
>=20
> Do you mean this line?
>=20
>         addr =3D addr - section->offset_within_address_space
>                + section->offset_within_region;

Uh.. where is that line?  But.. wait, yes, I think I was mistaken.  I saw:
	.translated_addr =3D iova,
=09
and thought that meant you were assuming an identify mapping from iova
to translated addr.  But thinking more carefull, IIRC iova and
translated_addr are both relative to the MR, not the AS, so I think
that is correct after all.

> I thought it was calculating the relative address against that memory
> region. That should only be useful if we want to do further
> translate(), right? For the path that this patch tries to handle (when
> there is no translate() call), then this "addr" is useless here?
>=20
> Regarding to the address space assignment - do you mean, e.g., I
> should use section->address_space here instead of
> &system_address_space? If so, I can do the switch.

Yes, I think you should.

> But after all, for
> now address_space_get_iotlb_entry() is only used by vhost codes, and
> it only check against iotlb.target_as =3D=3D NULL, so the address space
> didn't count too much here...

> Another reason I used &address_space_memory is that in
> vfio_iommu_map_notify() we have a check against it:
>=20
>     if (iotlb->target_as !=3D &address_space_memory) {
>         error_report("Wrong target AS \"%s\", only system memory is allow=
ed",
>                      iotlb->target_as->name ? iotlb->target_as->name : "n=
one");
>         return;
>     }
>=20
> Or say, we have some assumptions (not only in this patch) that assumes
> this iotlb.target_as should be system_address_space.

Right, the vhost code can only handle some IOMMU setups - something
like nested IOMMUs would break it.  But this way if someone sets up a
machine with an IOMMU configuration that vhost can't handle, you'll
get an error message, rather than accesses to unexpected locations,
which could cause really hard to debug corruption.

In other words we make assumptions, but we should _test_ those
assumptions.

I also think it would make sense to use address_space_translate() if we
can, since it's an existing interface for a very similar operation.


>=20
> Thanks,
>=20
> >=20
> > I think for the fallback path you're going to want something based on
> > address_space_translate() instead.
> >=20
> > > CC: Paolo Bonzini <pbonzini@redhat.com>
> > > CC: Jason Wang <jasowang@redhat.com>
> > > CC: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  exec.c | 20 +++++++++++++++++++-
> > >  1 file changed, 19 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/exec.c b/exec.c
> > > index 072de5d..5cfdacd 100644
> > > --- a/exec.c
> > > +++ b/exec.c
> > > @@ -463,12 +463,13 @@ address_space_translate_internal(AddressSpaceDi=
spatch *d, hwaddr addr, hwaddr *x
> > >  }
> > > =20
> > >  /* Called from RCU critical section */
> > > -IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr=
 addr,
> > > +IOMMUTLBEntry address_space_get_iotlb_entry(AddressSpace *as, hwaddr=
 iova,
> > >                                              bool is_write)
> > >  {
> > >      IOMMUTLBEntry iotlb =3D {0};
> > >      MemoryRegionSection *section;
> > >      MemoryRegion *mr;
> > > +    hwaddr addr =3D iova, psize;
> > > =20
> > >      for (;;) {
> > >          AddressSpaceDispatch *d =3D atomic_rcu_read(&as->dispatch);
> > > @@ -478,6 +479,23 @@ IOMMUTLBEntry address_space_get_iotlb_entry(Addr=
essSpace *as, hwaddr addr,
> > >          mr =3D section->mr;
> > > =20
> > >          if (!mr->iommu_ops) {
> > > +            /*
> > > +             * We didn't translate() but reached here. It possibly
> > > +             * means it's a static mapping. If so (it should be RAM),
> > > +             * we set the IOTLB up.
> > > +             */
> > > +            if (!iotlb.target_as && memory_region_is_ram(mr) &&
> > > +                !memory_region_is_rom(mr)) {
> > > +                psize =3D mr->ram_block->page_size;
> > > +                iova &=3D ~(psize - 1);
> > > +                iotlb =3D (IOMMUTLBEntry) {
> > > +                    .target_as =3D &address_space_memory,
> > > +                    .iova =3D iova,
> > > +                    .translated_addr =3D iova,
> > > +                    .addr_mask =3D psize - 1,
> > > +                    .perm =3D IOMMU_RW,
> > > +                };
> > > +            }
> > >              break;
> > >          }
> > > =20
> >=20
>=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8w3uRX/HFJGApMzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZFUc0AAoJEGw4ysog2bOSE/IP/iV6ENHkdugKiP4+mijaEZFc
WV9Kxa6bai/gz64iO0qZ6JpcUpE8UBpfWvDRFOaza1EW58fRE3d3T8UyI4JbfEXs
puz5PiOPGgc/3YvX4HV6MeW9x4O9JFRTlEKm1se4u5kDq41tWx0jyWg3O3/9+7IV
cRfkI/IG/WO9HZRCa9TVk7z4NCCuJ+0utSA7W0dEl9IOoQdQr7MT6CcGeQekSM/X
GEqBxfUwcCTuzeBjjWLo8ZdYWWS3eNNGg1NlTHJAa1Dq5bkHHude2KbUXYO5JQck
fRAcB2YWheflcxiaRutBa2PqRvYV6czmiJ7AAi257Hwikq6t2LKNMLCG2e8LXNTp
Bra0W5DteKcwFe0VoOXJLFLt1F5eDHqMxo21gRPFWXItAOUJUS7pt3tXZN5TClTG
eyqA6zG6cSU2sQZ8IaqSzfZx094QOoaET8GZiPoPQOwdssBIeUr+i0fZFzxFm9pK
LFULZpi4HLFMltRbLs8c36P70EcIdhM/p5GmJx9ZvJrJfG2vFUUhZW0clO8DyeRA
r+0uhV9nBg2dYkmy3hrCB4tiq4v0CwjD88Lm8V2YkFd4ohyZ1tC6a4tmhby40R0m
O+azeda7WAlBHib+UZLIEyKYv5kQXGvHZ3qIYHOMqoj21spYCvdULLUODWTKQfLB
5y3cYeeYLZKhcGiXMc6G
=Kg6a
-----END PGP SIGNATURE-----

--8w3uRX/HFJGApMzv--
