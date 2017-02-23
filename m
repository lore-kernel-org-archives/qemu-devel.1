Received: from eggs.gnu.org ([2001:4830:134:3::10]:40593)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgjkf-0003wP-6m
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:07:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgjkc-0005Lo-Iu
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:07:29 -0500
Date: Thu, 23 Feb 2017 14:07:11 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223030711.GC12577@umbus.fritz.box>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<20170222033423.GK12577@umbus.fritz.box>
	<e58f7cfa-c03c-ca25-a973-7894253d2dcc@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kJMkLA1uPhjFFA+D"
Content-Disposition: inline
In-Reply-To: <e58f7cfa-c03c-ca25-a973-7894253d2dcc@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 00/22] ppc/xics: simplify ICS and ICP
 creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--kJMkLA1uPhjFFA+D
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 22, 2017 at 11:55:40AM +0100, C=E9dric Le Goater wrote:
> On 02/22/2017 04:34 AM, David Gibson wrote:
> > On Thu, Feb 16, 2017 at 02:47:23PM +0100, C=E9dric Le Goater wrote:
> >> Hello,
> >>
> >> The goal behind this series is to simplify the XICS interface by
> >> moving back in the machine the way the ICS and ICP objects interact
> >> together. It's up to the machine to implement this "fabric" logic by
> >> providing a set of handlers of a QOM interface. These handlers are
> >> used to grab an ICS or an ICP object and also do irq resends. This
> >> idea was suggested by David Gibson.
> >>
> >> The patchset is organised as follow. It starts with a preliminary
> >> cleanup to get rid of the set_nr_irqs() and set_nr_servers()
> >> handlers. It also moves the creation of the ICS and ICP objects from
> >> the XICS object to the sPAPR machine. This simplifies the code
> >> significantly and prepares ground for future changes.
> >>
> >> As the sPAPR machine only makes use of a single ICS, we can store it
> >> at the machine level. This lets us remove dependencies on the list of
> >> ICS of the XICS object and simplify even more the code for the
> >> following changes.
> >>
> >> The QOM interface to interact with the ICS and ICP objects is then
> >> introduced. These are moved under the machine and cleanups are done
> >> accordingly.
> >>
> >> Finally, the XICSState classes are removed as they have been
> >> deprecated by the QOM interface.
> >>
> >>
> >> After the initial cleanups, which are rather big, I have tried to keep
> >> the each patch small enough to ease the review and to spot any
> >> problem. Each should be bisectable. The tree is available here :
> >>
> >> 	   https://github.com/legoater/qemu/tree/ppc-2.9
> >=20
> > So, after you posted this, I discover the patch I sent the other day -
> > changing XICS away from a SysBusDevice breaks the postcopy migration
> > test on KVM.  I haven't had a chance to debug this yet, so for the
> > time being I've pulled my patch from ppc-for-2.9.  I've moved it into
> > a new 'xics-cleanup' branch.
>=20
> It is even worse than that, the kernel does not start. This is because
> the ICS and ICP objects are not reseted  anymore and so the mfrr and
> irq priority values are incorrect : 0x0 instead of 0xFF.=20
>=20
> Before that patch, the reset was implicit because the device was a=20
> SysBusDevice and all the devices were reseted when the bus was. =20
>=20
> Other devices (not on a bus or/and QOM objects) need to register on=20
> SysBus to be reseted :
>  =20
> 	qdev_set_parent_bus(dev, sysbus_get_default());
>=20
> or use a handler for :
>=20
> 	qemu_register_reset()
>=20
> which will be called by qemu_devices_reset()
>=20
> I fell into this trap a few times with PowerNV and I should have=20
> spotted it before adding my Reviewed-by. Sorry about that.

Ah!  Well, thanks for spotting it now and saving me the debugging.

>=20
> So, to move on, we can use the fix below (You can merge it in your=20
> patch). I also updated my branch with it :=20
>=20
> 	https://github.com/legoater/qemu/commits/ppc-2.9
>=20
> I have checked that KVM and TCG migration still worked with the=20
> patchset and also rebased PowerNV on it. All seem to work. Tell
> me if you want a resend. The patchset needs some review any how=20
> and there should be some comment to address so it might be a bit=20
> too early for a resend.=20
>=20
>=20
>=20
> FYI, the xics-cleanup branch has some issue with migration :
>=20
> qemu-system-ppc64: VQ 0 size 0x80 < last_avail_idx 0x9f9 - used_idx 0x0
> qemu-system-ppc64: Failed to load virtio-blk:virtio
> qemu-system-ppc64: error while loading state for instance 0x0 of device '=
pci@800000020000000:01.0/virtio-blk'
>=20
> This is most probably a temporary regression, unrelated to XICS=20
> though.

Hmm.  I'm lss sure.  This series changes the qom paths of ics and icp
devices, which I'd expect to mess with migration, though I haven't had
a chance to actually check yet.

So, as mentioned in one of my patch comments it hadn't been my
intention for the ICS and ICPs to assume that the machine implements
the fabric, but rather to replace their current "concrete" xics
pointer with a xics interface pointer that would point to the (spapr)
machine in practice.

Apart from that I'm pretty happy with the endpoint you reach.  I'm a
bit less convinced about the path taken to get there.  I'm not sure if
it's worth the churn of doing this reorg, but I think we'd get there
more clearly and with less intermediate abstraction violations if it
was done by:

     1. Introduce the xics qom interface, but have it implemented by
        the existing xics object
     2. Change the ics and icp to only interact with the xics object
        via the qom interface
     3. Implement the qom interface in the spapr machine
     4. Change to spapr directly creating ics and icp objects,
        pointing back to itself as the xics interface provider
     5. Remove the xics concrete object

This also has the advantage that the qom path changing parts are
isolated to step (4), meaning problems with migration should be easier
to localize.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kJMkLA1uPhjFFA+D
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrlHdAAoJEGw4ysog2bOSHY8P/jX/CGlQxUWXqGjH0mP34qi7
wQZfJkpE91TW3EyAYQwm5DArxLkZuFdnsgQxNx+WrzmUKjHuL10amqfVF6E75w/b
L+cI9VrUVssDVKbuVhS+fvZjsj9QinryHXBP5TedwXSi9B1KjlYn4Cb7EhaqJ40W
qUf24h9/jKaUM0jYU0Bz+o2l8m8OVHjZS4tlO6ckV7QUXHqp2q0w13Q8Wv+oy1Ga
2t6POZYfc9daoVDkKoYAnxv9sgxgAqbKdRxbZ0nEKgkFdPxKcwb/o4oSEGpCaVMY
OkPk2s5b4jXd9NUfVNqqV1VY6FDbxzIFBtTQLKD3y1EDaQDfiWZ1UvQDTuE7sJAd
COaM2+SjaYdLCMB0lK1QF1AzK00nqurLpuAiLfmwwR+J+DVKr1n5S71VUdjYYv9t
F6qe9KompeKzvS4CAt3fsh6JJlCKQYpd2KisiCqQ7+DaYdu5T7v8Mthf4OBqcKGC
4Lz7xPKj0KH0LbtA3d0B4GVaslgpA9hHr6UX9cpHvfHNZ3KcLzc/ltF7ew7MG9LO
y5gJEo7a1VFMunnPurqjzctprDYRsXm1nfaqEHu/C2ykgRh9rHBEga/N8kzYI54w
jsBkZCJrVN7EwMRMzjD28UU6mh5WCJyiKAaPiWyf51320XCnSLBtMHNQBoQGEnc1
9UDllrMs6A4HMTfoxdAx
=yn7z
-----END PGP SIGNATURE-----

--kJMkLA1uPhjFFA+D--
