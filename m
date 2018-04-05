Received: from eggs.gnu.org ([2001:4830:134:3::10]:58795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1f4CUQ-0004V9-T7
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 17:32:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1f4CUN-0007pB-8x
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 17:32:14 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59618
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1f4CUN-0007ow-3n
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 17:32:11 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w35LTnmo095245
	for <qemu-devel@nongnu.org>; Thu, 5 Apr 2018 17:32:10 -0400
Received: from e18.ny.us.ibm.com (e18.ny.us.ibm.com [129.33.205.208])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h5tthj97u-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 17:32:10 -0400
Received: from localhost
	by e18.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Thu, 5 Apr 2018 17:32:09 -0400
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
From: Michael Roth <mdroth@linux.vnet.ibm.com>
In-Reply-To: <41774c00-7462-f2b0-9314-3b3d7e0f9fb0@redhat.com>
References: <1518116908-10852-1-git-send-email-mst@redhat.com>
	<1518116908-10852-12-git-send-email-mst@redhat.com>
	<41774c00-7462-f2b0-9314-3b3d7e0f9fb0@redhat.com>
Date: Thu, 05 Apr 2018 16:32:01 -0500
Message-Id: <152296392100.15508.4909516390524737427@sif>
Subject: Re: [Qemu-devel] [PULL 11/26] pci-bridge/i82801b11: clear bridge
 registers on platform reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, qemu-stable@nongnu.org

Quoting Laszlo Ersek (2018-03-23 13:42:07)
> Michael, Peter,
> =

> On 02/08/18 20:09, Michael S. Tsirkin wrote:
> > From: Laszlo Ersek <lersek@redhat.com>
> > =

> > The "i82801b11-bridge" device model is a descendant of "base-pci-bridge"
> > (TYPE_PCI_BRIDGE). However, unlike other similar devices, such as
> > =

> > - pci-bridge,
> > - pcie-pci-bridge,
> > - PCIE Root Port,
> > - xio3130 switch upstream and downstream ports,
> > - dec-21154-p2p-bridge,
> > - pbm-bridge,
> > - xilinx-pcie-root,
> > =

> > "i82801b11-bridge" does not clear the bridge specific registers at
> > platform reset.
> > =

> > This is a problem because devices on "i82801b11-bridge" continue to
> > respond to config space cycles after platform reset, when addressed with
> > the bus number that was previously programmed into the secondary bus
> > number register of "i82801b11-bridge". This error breaks OVMF's search =
for
> > extra (PXB) root buses, for example.
> > =

> > The device class reset method for "i82801b11-bridge" is currently NULL;
> > set it directly to pci_bridge_reset(), like the last three bridge models
> > in the above listing do.
> > =

> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Marcel Apfelbaum <marcel@redhat.com>
> > Cc: qemu-stable@nongnu.org
> > Ref: https://bugzilla.redhat.com/show_bug.cgi?id=3D1541839
> > Signed-off-by: Laszlo Ersek <lersek@redhat.com>
> > Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>
> > Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  hw/pci-bridge/i82801b11.c | 1 +
> >  1 file changed, 1 insertion(+)
> > =

> > diff --git a/hw/pci-bridge/i82801b11.c b/hw/pci-bridge/i82801b11.c
> > index cb522bf..ebf7f5f 100644
> > --- a/hw/pci-bridge/i82801b11.c
> > +++ b/hw/pci-bridge/i82801b11.c
> > @@ -98,6 +98,7 @@ static void i82801b11_bridge_class_init(ObjectClass *=
klass, void *data)
> >      k->realize =3D i82801b11_bridge_realize;
> >      k->config_write =3D pci_bridge_write_config;
> >      dc->vmsd =3D &i82801b11_bridge_dev_vmstate;
> > +    dc->reset =3D pci_bridge_reset;
> >      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> >  }
> >  =

> > =

> =

> this patch didn't get included in the 2.11.1 round-up:
> =

> http://mid.mail-archive.com/20180206191515.25830-1-mdroth@linux.vnet.ibm.=
com
> =

> (The patch was posted, CC stable, between Mike's round-up set and the
> actual 2.11.1 release.)

Looks like I had it tagged as pending but the PULL got held up for a while
and it didn't hit master till the day before release. I'm okay with
cherry-picking from a maintainer tree but generally only do it if I get
poked about it or it's on my radar for other reasons.

> =

> Can we please make sure that the commit doesn't miss the 2.11.2 bus?
> 2.12 is still a month out, and without this patch, rebooting an UEFI
> guest OS (with OVMF) hangs, on certain VM configs (see the commit message=
).
> =

> (Apologies if there is a "queue" or "next" branch for stable releases --
> in that case I should have probably checked that branch before sending
> this email.)

There's https://github.com/mdroth/qemu/commits/stable-2.11-staging but
as you can see it generally doesn't see much action in-between releases.

Will start queueing patches for 2.11.2 soon and make sure it gets in,
but probably looking at a similar release timeframe as 2.12.

Thanks for the heads up!

> =

> The commit hash on the master branch is
> ed247f40db84c8bd4bb7d10948702cd47cc4d5ae; it's part of v2.12.0-rc0.
> =

> Thanks!
> Laszlo
>=20
