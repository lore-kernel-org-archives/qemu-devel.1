Received: from eggs.gnu.org ([2001:4830:134:3::10]:51779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1daQAm-0005vG-5r
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:32:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1daQAh-0003mW-6W
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:32:36 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47076)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1daQAg-0003lG-UA
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 13:32:31 -0400
Date: Wed, 26 Jul 2017 11:32:22 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170726113222.52aad9a6@w520.home>
In-Reply-To: <20170726190348-mutt-send-email-mst@kernel.org>
References: <4E0AFA5F-44D6-4624-A99F-68A7FE52F397@meituan.com>
	<4b31a711-a52e-25d3-4a7c-1be8521097d9@redhat.com>
	<F99BFE80-FC15-40A0-BB3E-1B53B6CF9B05@meituan.com>
	<859362e8-0d98-3865-8bad-a15bfa218167@redhat.com>
	<20170726092931.0678689e@w520.home>
	<20170726190348-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] =?utf-8?q?About_virtio_device_hotplug_in_Q35!_?=
 =?utf-8?b?44CQ5aSW5Z+f6YKu5Lu2LuiwqOaFjuafpemYheOAkQ==?=
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?B?6ZmI5Y2a?= <chenbo02@meituan.com>, qemu-devel@nongnu.org

On Wed, 26 Jul 2017 19:06:58 +0300
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Wed, Jul 26, 2017 at 09:29:31AM -0600, Alex Williamson wrote:
> > On Wed, 26 Jul 2017 09:21:38 +0300
> > Marcel Apfelbaum <marcel@redhat.com> wrote:
> >  =20
> > > On 25/07/2017 11:53, =E9=99=88=E5=8D=9A wrote: =20
> > > > To accelerate data traversing between devices under the same PCIE R=
oot=20
> > > > Port or Switch.
> > > >=20
> > > > See https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg072=
09.html
> > > >    =20
> > >=20
> > > Hi,
> > >=20
> > > It may be possible, but maybe PCIe Switch assignment is not
> > > the only way to go.
> > >=20
> > > Adding Alex and Michael for their input on this matter.
> > > More info at:
> > > https://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg07209.htm=
l =20
> >=20
> > I think you need to look at where the IOMMU is in the topology and what
> > address space the devices are working in when assigned to a VM to
> > realize that it doesn't make any sense to assign switch ports to a VM.
> > GPUs cannot do switch level peer to peer when assigned because they are
> > operating in an I/O virtual address space.  This is why we configure
> > ACS on downstream ports to prevent peer to peer.  Peer to peer
> > transactions must be forwarded upstream by the switch ports in order to
> > reach the IOMMU for translation.  Note however that we do populate peer
> > to peer mappings within the IOMMU, so if the hardware supports it, the
> > IOMMU can reflect the transaction back out to the I/O bus to reach the
> > other device without CPU involvement.
> >=20
> > Therefore I think the better solution, if it encourages the NVIDIA
> > driver to do the right thing, is to use emulated switches.  Assigning
> > the physical switch would really do nothing more than make the PCIe link
> > information more correct in the VM, everything else about the switch
> > would be emulated.  Even still, unless you have an I/O topology which
> > integrates the IOMMU into the switch itself, the data flow still needs
> > to go all the way to the root complex to hit the IOMMU before being
> > reflected to the other device.  Direct peer to peer between downstream
> > switch ports operates in the wrong address space.  Thanks,
> >=20
> > Alex =20
>=20
> That's true of course. What would make sense would be for
> hardware vendors to add ATS support to their cards.
>=20
> Then peer to peer should be allowed by hypervisor for translated transact=
ions.
>=20
> Gives you the performance benefit without the security issues.
>=20
> Does anyone know whether any hardware implements this?

GPUs often do implement ATS and the ACS DT (Direct Translated P2P)
capability should handle routing requests with the Address Type field
indicating a translated address directly between downstream ports.  DT
is however not part of the standard set of ACS bits that we enable.  It
seems like it might be fairly easy to poke the DT enable bit with
setpci from userspace to test whether this "just works", providing of
course you can get the driver to attempt to do peer to peer and ATS is
already functioning on the GPU.  If so, then we should look at where
in the code to do that enabling automatically.  Thanks,

Alex
