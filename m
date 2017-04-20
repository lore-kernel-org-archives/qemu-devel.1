Received: from eggs.gnu.org ([2001:4830:134:3::10]:54075)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d14HN-00059f-Kg
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 01:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d14HM-00009k-FG
	for qemu-devel@nongnu.org; Thu, 20 Apr 2017 01:05:17 -0400
Date: Thu, 20 Apr 2017 15:04:29 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170420050429.GD13992@umbus.fritz.box>
References: <20170418221724.5707-1-ehabkost@redhat.com>
	<20170418221724.5707-4-ehabkost@redhat.com>
	<CAFEAcA_Ky5SecogNFq3+RO8pX4sqxvsSbw0KihAv=8teqCSJbw@mail.gmail.com>
	<20170419125001.GU25239@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="pQhZXvAqiZgbeUkD"
Content-Disposition: inline
In-Reply-To: <20170419125001.GU25239@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [RFC v2 3/6] pci: Rename and change signatures of
 pci_bus_new() & related functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Alexey Kardashevskiy <aik@ozlabs.ru>, David Gibson <dgibson@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Alexander Graf <agraf@suse.de>, Aurelien Jarno <aurelien@aurel32.net>, Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Paul Burton <paul.burton@imgtec.com>, Richard Henderson <rth@twiddle.net>, Scott Wood <scottwood@freescale.com>, Yongbok Kim <yongbok.kim@imgtec.com>, qemu-arm <qemu-arm@nongnu.org>, "qemu-ppc@nongnu.org" <qemu-ppc@nongnu.org>


--pQhZXvAqiZgbeUkD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 19, 2017 at 09:50:01AM -0300, Eduardo Habkost wrote:
> On Wed, Apr 19, 2017 at 09:41:42AM +0100, Peter Maydell wrote:
> > On 18 April 2017 at 23:17, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > > pci_bus_new*() and pci_register_bus() work only when the 'parent'
> > > argument is a PCI_HOST_BRIDGE object. Rename them to reflect that they
> > > are meant to initialize a bus that's in a PCI host bridge.
> > >
> > > The new function names are:
> > > * pci_host_bus_init() (replacing pci_bus_new())
> > > * pci_host_bus_init_inplace() (replacing pci_bus_new_inplace())
> > > * pci_host_bus_init_irqs() (replacing pci_register_bus())
> >=20
> > This is moving these functions away from the convention that
> > we seem to mostly follow for buses (eg ISA, SCSI) of
> > foo_bus_new() to allocate and return a new bus, and
> > foo_bus_new_inplace() to initialize a bus that's inline in
> > some other struct.
> >=20
> > I'm not sure this is a good idea unless we have a plan to
> > convert all the other QOM buses and document that this is
> > the right way to implement init for a bus.
>=20
> The point of the rename is that those functions are doing more
> than just allocating a PCIBus. They do some initialization of
> PCIHostState as well. That's why non-root PCI buses can't be
> created by pci_bus_new*() today.

Hm, yeah.

So.. for what's now pci_register_bus() is it even worth keeping a
helper?  Could we just require that callers call the other init
function then call pci_bus_irqs().  That would be one less name to
come up with.

For the others, what about
	pci_common_root_bus_new()
	pci_common_root_bus_init_inplace()
?

> Maybe the answer here is to move the PCI_HOST_BRIDGE-specific
> code somewhere else, and make pci_bus_new*() more generic. This
> would allow us to reuse pci_bus_new*() when creating non-root PCI
> buses, later.

That might work even better.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--pQhZXvAqiZgbeUkD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJY+EFdAAoJEGw4ysog2bOSXqUQAJc6NVR9euDF5VoL3+4bIU5u
vtNWoK6pISy831mbKsKSIpLQQ+x+lrZaOrtlP8IjLoQWwxywNKybg+EIw8KEwmlW
R4zJll5gxGdr3On6qI4TJ9QowRc1nWKNZAk0DLRlq26+Hcucb7hU4pwbnL9448RT
eCOioV00nV5pKk1PsnNXu89EpvklwASUWB52nSIuFbg4p4xzBEZnWFq5Uh/rS2aH
gkBD2pyxb736tl30SsEAYBOjQUmQS4ULnfu6GkNaMpD0+VmTChiF8eUoixdU1z3k
0LIFSh4uaSiBDlD/CnlyTMQ0f9/g3HFepqpzW+QMS1KJ5xESKw4l8kAukICdNci+
luKT0j7FEkTzThLUp+26DfTx59yxSOqt3l87Z0BC3MYV8vzwqReTxyIwBZ0DALli
QCNzJLODndxLByqO6WNIzrGarMbLis8IUXbF427AUBVepLh/Cs7eEe1ohLCk4NtP
/xOLVcu3mRdVoeeTOjrI8Trr+P9NEkD9BULRQkcEKX6P5oAD8/iag3dDO6YOC45D
nyP2LgN7KqccnjQnZxWu/kBU2uBw/dAi/8GIh/q2xakuIcb7NGqAcjIM0PrPThSW
ErcK9JJ9rlHHWcNUfUJfjmRHtuQb1WE+tlgeBGzrhpd80kZeJP1zDfy52mRv1nx3
+AwjG2nhvfCbkymP3xGJ
=csp7
-----END PGP SIGNATURE-----

--pQhZXvAqiZgbeUkD--
