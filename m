Received: from eggs.gnu.org ([2001:4830:134:3::10]:51597)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fT14M-0004vA-UR
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:23:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <whois.zihan.yang@gmail.com>) id 1fT14M-00073l-0l
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:23:54 -0400
Received: from mail-lf0-x236.google.com ([2a00:1450:4010:c07::236]:36678)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <whois.zihan.yang@gmail.com>)
	id 1fT14L-000733-PR
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 04:23:53 -0400
Received: by mail-lf0-x236.google.com with SMTP id u4-v6so2572410lff.3
	for <qemu-devel@nongnu.org>; Wed, 13 Jun 2018 01:23:53 -0700 (PDT)
MIME-Version: 1.0
References: <1528794804-6289-1-git-send-email-whois.zihan.yang@gmail.com>
	<20180612163301-mutt-send-email-mst@kernel.org>
In-Reply-To: <20180612163301-mutt-send-email-mst@kernel.org>
From: Zihan Yang <whois.zihan.yang@gmail.com>
Date: Wed, 13 Jun 2018 16:23:40 +0800
Message-ID: <CAKwiv-jJbcuLgygcbSBkaZw33mnamHqa5T15gMNi2CqUNN2mkA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v2 1/3] pci_expander_bridge: add type
 TYPE_PXB_PCIE_HOST
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>

Michael S. Tsirkin <mst@redhat.com> =E4=BA=8E2018=E5=B9=B46=E6=9C=8812=E6=
=97=A5=E5=91=A8=E4=BA=8C =E4=B8=8B=E5=8D=889:43=E5=86=99=E9=81=93=EF=BC=9A
>
> On Tue, Jun 12, 2018 at 05:13:22PM +0800, Zihan Yang wrote:
> > The inner host bridge created by pxb-pcie is TYPE_PXB_PCI_HOST by defau=
lt,
> > add a new type TYPE_PXB_PCIE_HOST to better utilize the ECAM of PCIe
> >
> > Signed-off-by: Zihan Yang <whois.zihan.yang@gmail.com>
>
> I have a concern that there are lots of new properties
> added here, I'm not sure how are upper layers supposed to
> manage them all.
>
> E.g. bus_nr supplied in several places, domain_nr for which
> it's not clear how it is supposed to be allocated, etc.

Indeed they seem to double the properties, but the pxb host is
an internal structure of pxb-pcie device, created in pxb-pcie's
realization procedure, and acpi-build queries host bridges instead
of pxb-pcie devices. This means that users can not directly specify
the property of pxb host bridge, but must 'inherit' from pxb-pcie
devices. I had thought about changing the acpi-build process,
but that would require more modifications.

As for the properties, bus_nr means the start bus number
of this host bridge. It is used when pxb-pcie is in pci domain 0
with q35 host to avoid bus number confliction. When it is placed
in a separate pci domain, it is not used and should be 0.

max_bus means how many buses the user desires, EACH bus in
PCIe requires 1MB configuration space, thus specifying it could
reduce the reserved memory in MMCFG as suggested by Marcel.
Typically, the user can specify

-device pxb-pcie,id=3Dbr1,bus=3D"pcie.0",sep_domain=3Don,domain_nr=3D1,max_=
bus=3D130

this will place the buses under this pxb host bridge in pci domain
1, and reserve (130 + 1) =3D 131 buses for it. The start bus number
is always 0 currently for simplicity.

> Can the management interface be simplified?
> Ideally we wouldn't have to teach libvirt new tricks,
> just generalize pxb support slightly.

We can delete 'sep_domain' property, I just find 'domain_nr'
already indicates domain number. But domain_nr and
max_bus seems unremovable, although they look 'redundant'
because they appear twice.

I'm not familiar with libvirt, but from the perspective of user,
only 2 properties are added(domain_nr and max_bus, if we
delete sep_domain), though the internal structure actually has
changed.
