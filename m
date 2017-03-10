Received: from eggs.gnu.org ([2001:4830:134:3::10]:57398)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cmMQB-0005nC-66
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 10:25:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <abologna@redhat.com>) id 1cmMQ2-0001Pq-0J
	for qemu-devel@nongnu.org; Fri, 10 Mar 2017 10:25:29 -0500
Message-ID: <1489159521.3805.43.camel@redhat.com>
From: Andrea Bolognani <abologna@redhat.com>
Date: Fri, 10 Mar 2017 16:25:21 +0100
In-Reply-To: <20170303032507.16142-16-david@gibson.dropbear.id.au>
References: <20170303032507.16142-1-david@gibson.dropbear.id.au>
	<20170303032507.16142-16-david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PULL 15/17] spapr_pci: Advertise access to PCIe
 extended config space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>, peter.maydell@linaro.org
Cc: lvivier@redhat.com, thuth@redhat.com, mdroth@linux.vnet.ibm.com, aik@ozlabs.ru, agraf@suse.de, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, sjitindarsingh@gmail.com, sam.bobroff@au1.ibm.com

On Fri, 2017-03-03 at 14:25 +1100, David Gibson wrote:
> The (paravirtual) PCI host bridge on the 'pseries' machine in most
> regards acts like a regular PCI bus, rather than a PCIe bus.=C2=A0=C2=A0=
Despite
> this, though, it does allow access to the PCIe extended config space.
>=C2=A0
> We already implemented the RTAS methods to allow this access.. but
> forgot to put the markers into the device tree so that guest's know it
> is there.=C2=A0=C2=A0This adds them in.
>=C2=A0
> With this, a pseries guest is able to view extended config space on
> (for example an e1000e device.=C2=A0=C2=A0This should be enough to allo=
w guests
> to use at least some PCIe devices.
>=C2=A0
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> ---
>=C2=A0=C2=A0hw/ppc/spapr_pci.c | 4 ++++
>=C2=A0=C2=A01 file changed, 4 insertions(+)
>=C2=A0
> diff --git a/hw/ppc/spapr_pci.c b/hw/ppc/spapr_pci.c
> index 2a3499e..919d3c2 100644
> --- a/hw/ppc/spapr_pci.c
> +++ b/hw/ppc/spapr_pci.c
> @@ -1321,6 +1321,10 @@ static int spapr_populate_pci_child_dt(PCIDevice=
 *dev, void *fdt, int offset,
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0_FDT(fdt_setprop(fdt, offset, "assig=
ned-addresses",
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0(uint8_=
t *)rp.assigned, rp.assigned_len));
>=C2=A0=C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0if (pci_is_express(dev)) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0_FDT(fdt_setprop_cell(=
fdt, offset, "ibm,pci-config-space-type", 0x1));
> +=C2=A0=C2=A0=C2=A0=C2=A0}
> +
>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return 0;
>=C2=A0=C2=A0}

I've just realized that this is not tied to the pseries-2.9
machine type, which means existing guests will suddenly get
access to the Extended Config Space after upgrading QEMU.

I'm not sure this will cause any issue in practice, but it
seems like it would be safer to enable the Extended Config
Space only for pseries-2.9 and newer machine types.

--=C2=A0
Andrea Bolognani / Red Hat / Virtualization
