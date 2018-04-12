Received: from eggs.gnu.org ([2001:4830:134:3::10]:50895)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f6SAf-0004ho-6X
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 22:41:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f6SAb-00041u-7b
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 22:41:09 -0400
Received: from ozlabs.org ([203.11.71.1]:50303)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1f6SAa-00040E-Hl
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 22:41:05 -0400
Date: Thu, 12 Apr 2018 12:36:02 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180412023602.GF9425@umbus.fritz.box>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-6-git-send-email-yi.l.liu@linux.intel.com>
	<20180306103352.GB3158@sky-dev>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="QXO0/MSS4VvK6f+D"
Content-Disposition: inline
In-Reply-To: <20180306103352.GB3158@sky-dev>
Subject: Re: [Qemu-devel] [PATCH v3 05/12] hw/pci: introduce PCISVAOps to
 PCIDevice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, pbonzini@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com


--QXO0/MSS4VvK6f+D
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2018 at 06:33:52PM +0800, Liu, Yi L wrote:
> On Mon, Mar 05, 2018 at 02:31:44PM +1100, David Gibson wrote:
> > On Thu, Mar 01, 2018 at 06:31:55PM +0800, Liu, Yi L wrote:
> > > This patch intoduces PCISVAOps for virt-SVA.
> > >
> > > So far, to setup virt-SVA for assigned SVA capable device, needs to
> > > config host translation structures. e.g. for VT-d, needs to set the
> > > guest pasid table to host and enable nested translation. Besides,
> > > vIOMMU emulator needs to forward guest's cache invalidation to host.
> > > On VT-d, it is guest's invalidation to 1st level translation related
> > > cache, such invalidation should be forwarded to host.
> > >
> > > Proposed PCISVAOps are:
> > > * sva_bind_guest_pasid_table: set the guest pasid table to host, and
> > >                               enable nested translation in host
> > > * sva_register_notifier: register sva_notifier to forward guest's
> > >                          cache invalidation to host
> > > * sva_unregister_notifier: unregister sva_notifier
> > >
> > > The PCISVAOps should be provided by vfio or modules alike. Mainly for
> > > assigned SVA capable devices.
> > >
> > > Take virt-SVA on VT-d as an exmaple:
> > > If a guest wants to setup virt-SVA for an assigned SVA capable device,
> > > it programs its context entry. vIOMMU emulator captures guest's conte=
xt
> > > entry programming, and figure out the target device. vIOMMU emulator
> > > use the pci_device_sva_bind_pasid_table() API to bind the guest pasid
> > > table to host.
> > >
> > > Guest would also program its pasid table. vIOMMU emulator captures
> > > guest's pasid entry programming. In Qemu, needs to allocate an
> > > AddressSpace to stand for the pasid tagged address space and Qemu also
> > > needs to register sva_notifier to forward future cache invalidation
> > > request to host.
> > >
> > > Allocating AddressSpace to stand for the pasid tagged address space is
> > > for the emulation of emulated SVA capable devices. Emulated SVA capab=
le
> > > devices may issue SVA aware DMAs, Qemu needs to emulate read/write to=
 a
> > > pasid tagged AddressSpace. Thus needs an abstraction for such address
> > > space in Qemu.
> > >
> > > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
> >
> > So PCISVAOps is roughly equivalent to the cluster-of-PASIDs context I
> > was suggesting in my earlier comments,
>=20
> yes, it is. The purpose is to expose pasid table bind and sva notfier
> registration/unregistration to vIOMMU emulators.
>=20
> > however it's only an ops
> > structure.  That means you can't easily share a context between
> > multiple PCI devices which is unfortunate because:
> >     * The simplest use case for SVA I can see would just put the
> >       same set of PASIDs into place for every SVA capable device
>=20
> Do you mean for emulated SVA capable device?

Not necessarily.  I'd expect that model could be useful for both
emulated and passthrough SVA capable devices.

> >     * Sometimes the IOMMU can't determine exactly what device a DMA
> >       came from.  Now the bridge cases where this applies are probably
> >       unlikely with SVA devices, but I wouldn't want to bet on it.  In
> >       addition, the chances some manufacturer will eventually put out
> >       a buggy multifunction SVA capable device that use the wrong RIDs
> >       for the secondary functions is pretty darn high.
>=20
> I'm not sure I 100% got your point here. Do yu mean physical device?
> In PCIE TLP, DMA packet should have a RID field?

Yes, but that RID isn't accurate in all cases.

One case is if you have a PCIe device behind both a PCIe->PCI and
PCI->PCIe bridge.  Now obviously SVA won't work in that case, but it
would be good to at least detect it and refuse to attempt SVA.

Another case is with a buggy device that just sends the wrong RID.  In
particular there are some multifunction devices that use function 0's
RID for all functions.  Obviously that's a hardware bug and we can't
expect everything to work in this case.  But forcing all the functions
to share an SVAContext in this case - like we alreayd force them to
share an IOMMU group - allows us to reason about what will and won't work

> And it looks more like
> a hardware layer trouble. For this series, it only provides necessary
> software support to make sure guest's SVA operation is well prepared
> before the SVA device issues the SVA aware DMA. e.g. link guest's pasid
> table to host, and config iommu translation in nested mode.
>=20
> >
> > So I think instead you want a cluster-of-PASIDs object which has an
> > ops table including both these and the per-PASID calls from the
> > earlier patches (but the per-PASID calls would now take an explicit
> > PASID value).
>=20
> I didn't quite get "including both these and the per-PASID calls".
> What do you mean by "these"? Do you mean the PCISVAOps?

I mean that I think PCISVAOps should become a full object including an
ops table, not just an ops table.  That table would include the things
currently in PCISVAOps.  It would also include callbacks for the
things that are in your per-PASID object in this draft, but those
callbacks would now need to take an explicit PASIC parameter.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--QXO0/MSS4VvK6f+D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrOxhAACgkQbDjKyiDZ
s5LxDA//QDyqH+u9kmBtY0Nqdy6yW/mXynrnd03COVZL2fwWwmU8VfQLvOz3RMLO
2NSkgEirMsEIMOOAZwQ+4O1E04fZbxzeCPDoBeB5kKdjpB8JObDnsEFRtXNg70j/
ZpIseqypgchff1oZ2QRXbxj6dq+gqSZIP/nqS7Zxjxeuefd/sjS3PC04qJ64m1Jp
eo1gz/eIVeJmon3DRlaa+igxJjRy6bwReNdfShQ2zUrXAx6f6rPspGtsxYhLnIUK
78qGTod1KYa+snYx17yCd13VvklLUFZ64GepdcmqaBtHxWdm2f961YpBt/2V9cB1
yjl/+PNdnSipeLzMPp5Afics2Z90n65cEbRsytUAba+KC6dnYzYgtGaeKUrToSP4
f2q3/TOTxCoT3/6sx44u/lzzn7KrVSP7RBPQBVFCOyH7qBKWxpL1EPx84DHqwDYG
F6AwmTnorBmilOj3Bm2CDMr0DahqXdKEJZwwW0uRBKtT1399jdptNU/3LkLsU9yE
CZjqJF6jr0tN/m4qxw08m/ZsO++mi9f4dXEbU98dilOF/XnsX4ea5kgEAmM7oor8
QckLErbO6eFiUSBCFpoWQRGX27WND3avqOU5QgcCCRa7uytBjnbPSKd2M9Ml7I0m
2qZ+DRcJG4m1W/qlipfKZywYbqB+moyd2GbCfp4vulzE5Fhj6CI=
=xDZA
-----END PGP SIGNATURE-----

--QXO0/MSS4VvK6f+D--
