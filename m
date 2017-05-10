Received: from eggs.gnu.org ([2001:4830:134:3::10]:43903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8Lhn-0006jj-CZ
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:06:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d8Lhm-0000jH-0m
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:06:39 -0400
Received: from ozlabs.org ([2401:3900:2:1::2]:55433)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgibson@ozlabs.org>) id 1d8Lhl-0000j5-8b
	for qemu-devel@nongnu.org; Wed, 10 May 2017 03:06:37 -0400
Date: Wed, 10 May 2017 17:04:06 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170510070406.GU25748@umbus.fritz.box>
References: <1493285660-4470-1-git-send-email-peterx@redhat.com>
	<1493285660-4470-7-git-send-email-peterx@redhat.com>
	<20170501045822.GM13773@umbus.fritz.box>
	<20170508054814.GA2820@pxdev.xzpeter.org>
	<20170508060744.GG25748@umbus.fritz.box>
	<20170508073217.GD2820@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="9AazSAFPVKSPmRXK"
Content-Disposition: inline
In-Reply-To: <20170508073217.GD2820@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC PATCH 6/8] memory: introduce AddressSpaceOps
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, Paolo Bonzini <pbonzini@redhat.com>, kevin.tian@intel.com, yi.l.liu@intel.com, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>


--9AazSAFPVKSPmRXK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 08, 2017 at 03:32:17PM +0800, Peter Xu wrote:
> On Mon, May 08, 2017 at 04:07:44PM +1000, David Gibson wrote:
> > On Mon, May 08, 2017 at 01:48:14PM +0800, Peter Xu wrote:
> > > On Mon, May 01, 2017 at 02:58:22PM +1000, David Gibson wrote:
> > > > On Thu, Apr 27, 2017 at 05:34:18PM +0800, Peter Xu wrote:
> > > > > This is something similar to MemoryRegionOps, it's just for addre=
ss
> > > > > spaces to store arch-specific hooks.
> > > > >=20
> > > > > The first hook I would like to introduce is iommu_get().
> > > > >=20
> > > > > For systems that have IOMMUs, we will create a special address sp=
ace per
> > > > > device which is different from system default address space for
> > > > > it (please refer to pci_device_iommu_address_space()). Normally w=
hen
> > > > > that happens, there will be one specific IOMMU (or say, translati=
on
> > > > > unit) stands right behind that new address space.
> > > > >=20
> > > > > This iommu_get() fetches that guy behind the address space. Here,=
 the
> > > > > guy is defined as IOMMUObject, which is currently a (void *). In =
the
> > > > > future, maybe we can make it a better definition, but imho it's g=
ood
> > > > > enough for now, considering it's arch-dependent.
> > > > >=20
> > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > >=20
> > > > This doesn't make sense to me.  It would be entirely possible for a
> > > > single address space to have different regions mapped by different
> > > > IOMMUs.  Or some regions mapped by IOMMUs and others direct mapped =
to
> > > > a device or memory block.
> > >=20
> > > Oh, so it's more complicated than I thought... Then, do we really have
> > > existing use case that one device is managed by more than one IOMMU
> > > (on any of the platform)? Frankly speaking I haven't thought about
> > > complicated scenarios like this, or nested IOMMUs yet.
> >=20
> > Sort of, it depends what you count as "more than one IOMMU".
> >=20
> > spapr can - depending on guest configuration - have two IOMMU windows
> > for each guest PCI domain.  In theory the guest can set these up
> > however it wants, in practice there's usually a small (~256MiB) at PCI
> > address 0 for the benefit of 32-bit PCI devices, then a much larger
> > window up at a high address to allow better performance for 64-bit
> > capable devices.
> >=20
> > Those are the same IOMMU in the sense that they're both implemented by
> > logic built into the same virtual PCI host bridge.  However, they're
> > different IOMMUs in the sense that they have independent data
> > structures describing the mappings and are currently modelled as two
> > different IOMMU memory regions.
> >=20
> >=20
> > I don't believe we have any existing platforms with both an IOMMU and
> > a direct mapped window in a device's address space.  But it seems to
> > be just too plausible a setup to not plan for it. [1]
> >=20
> > > This patch derived from a requirement in virt-svm project (on x86).
> > > Virt-svm needs some notification mechanism for each IOMMU (or say, the
> > > IOMMU that managers the SVM-enabled device). For now, all IOMMU
> > > notifiers are per-memory-region not per-iommu, and that's imho not
> > > what virt-svm wants. Any suggestions?
> >=20
> > I don't know SVM, so I can't really make sense of that.  What format
> > does this identifier need?  What does "for one IOMMU" mean in this
> > context - i.e. what guest observable properties require the IDs to be
> > the same or to be different.
>=20
> Virt-svm should need to trap the content of a register (actually the
> data is in the memory, but, let's assume it's a mmio operation for
> simplicity, considering it is finally delivered via invalidation
> requests), then pass that info down to kernel. So the listened element
> is per-iommu not per-mr this time. When the content changed, vfio will
> need to be notified, then pass this info down.

I don't entirely follow what you're saying.  When the virtual hardware
gets an invalidate request, it looks up the unit to invalidate in
memory?  Which component gets to decide that ID?  How is it advertised
to the guest OS?

If your ID is tied to the AS now, you could just iterate through the
AS and invalidate any IOMMU MRs that are present within it.

Alternatively, if the ID is tied to something more concrete, like a
specific PCI host bridge (which incorporates the IOMMU logic), then
that device probably already has a handle on the right IOMMU MR to
invalidate it.


>=20
> Yi/others, please feel free to correct me.
>=20
> Thanks,
>=20
> >=20
> >=20
> > [1] My reasoning here is similar to the reason sPAPR allows the two
> > windows.  For PAPR, the guest is paravirtualized, so both windows
> > essentially have to be remapped IOMMU windows.  For a bare metal
> > platform it seems a very reasonable tradeoff would be to have a
> > small(ish) 32-bit IOMMU window to allow 32-bit devices to work on a
> > large RAM machine, along with a large direct mapped "bypass" window
> > for maxmimum performance for 64-bit devices.
> >=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--9AazSAFPVKSPmRXK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZErtlAAoJEGw4ysog2bOSLQUQALfGLPAWAbWiQb8NmiyntmmN
3BxxJb2OljUE2wunXhohzVkdGZ9GefmdiY/mZ1guc6fJ7HPR+EjPVMvbo/zSibyp
kOKiJD2pnpQ5VIwnFlImzKcExn0aMqzUJ9wN5HT0nfRbEMvNLomyBSxAX0fsgKG+
NiwEimCOiQfdhiCX/cZK3Pmp9k8gs110XMNuVRPts1cMBNvJWxIgCtwiALtjmYHO
XWzBuJn1YAk2Dz+9ZsCzMd1Akgjy45t4OJLvlXFdXtaDwauoEP/jyW9iyMIVQ4NL
Ld7mqTgcnFh8990+C720C5utzpZqwMDU7ZkNipi/9zT2+XZMbW3Wqb6Ol+pV/GW8
AMs+60lHh4YesjoGZbYfH4b9UMehbLtuq4HunSTfa0aYIcZwecMewabUZZl8gRO6
lt1wVTcdL6N5kkhDS7CgIqbSKz0XBJLPrdEuAOUGf+mm/8NsoXjdbz+B8xT9tB3H
qqKTUfFqdRSxm+Kax57MAjDQW21zPekG31UwgnklcFYSbNyhcMSKLz8zoTdik7G9
ZmWMlUWUdyH6h7ovnFSUbSRDIjYYbs7Oa5ppAICYF8taa70pn7cJn43qdEMtsbIZ
/98YaMoIs2biAwq2bcP0jrch8eF77VH8nkC4FBte7gUvgUXtEJt6Ur8iZs0wPdvj
Xg4E4LWMfH1pObeNEGt8
=8bWD
-----END PGP SIGNATURE-----

--9AazSAFPVKSPmRXK--
