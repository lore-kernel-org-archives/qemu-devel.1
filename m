Received: from eggs.gnu.org ([2001:4830:134:3::10]:43028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1dcPMS-0004n7-5C
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 01:04:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1dcPMQ-0008Ma-93
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 01:04:52 -0400
Received: from mail-io0-x241.google.com ([2607:f8b0:4001:c06::241]:38198)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a175818323@gmail.com>)
	id 1dcPMQ-0008KS-2z
	for qemu-devel@nongnu.org; Tue, 01 Aug 2017 01:04:50 -0400
Received: by mail-io0-x241.google.com with SMTP id o9so686384iod.5
	for <qemu-devel@nongnu.org>; Mon, 31 Jul 2017 22:04:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170726113222.52aad9a6@w520.home>
References: <4E0AFA5F-44D6-4624-A99F-68A7FE52F397@meituan.com>
	<4b31a711-a52e-25d3-4a7c-1be8521097d9@redhat.com>
	<F99BFE80-FC15-40A0-BB3E-1B53B6CF9B05@meituan.com>
	<859362e8-0d98-3865-8bad-a15bfa218167@redhat.com>
	<20170726092931.0678689e@w520.home>
	<20170726190348-mutt-send-email-mst@kernel.org>
	<20170726113222.52aad9a6@w520.home>
From: Bob Chen <a175818323@gmail.com>
Date: Tue, 1 Aug 2017 13:04:46 +0800
Message-ID: <CAMxP3BTFgwJtjh78hNBCoxBp1WsnZMZLsqzb3McqCq=-SX0a4g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?B?6ZmI5Y2a?= <chenbo02@meituan.com>, qemu-devel@nongnu.org

Hi,

This is a sketch of my hardware topology.

          CPU0         <- QPI ->        CPU1
           |                             |
    Root Port(at PCIe.0)        Root Port(at PCIe.1)
       /        \                   /       \
    Switch    Switch             Switch    Switch
     /   \      /  \              /   \    /    \
   GPU   GPU  GPU  GPU          GPU   GPU GPU   GPU


And below are the p2p bandwidth test results.

Host=EF=BC=9A
   D\D     0      1      2      3      4      5      6      7
     0 426.91  25.32  19.72  19.72  19.69  19.68  19.75  19.66
     1  25.31 427.61  19.74  19.72  19.66  19.68  19.74  19.73
     2  19.73  19.73 429.49  25.33  19.66  19.74  19.73  19.74
     3  19.72  19.71  25.36 426.68  19.70  19.71  19.77  19.74
     4  19.72  19.72  19.73  19.75 425.75  25.33  19.72  19.71
     5  19.71  19.75  19.76  19.75  25.35 428.11  19.69  19.70
     6  19.76  19.72  19.79  19.78  19.73  19.74 425.75  25.35
     7  19.69  19.75  19.79  19.75  19.72  19.72  25.39 427.15

VM=EF=BC=9A
   D\D     0      1      2      3      4      5      6      7
     0 427.38  10.52  18.99  19.11  19.75  19.62  19.75  19.71
     1  10.53 426.68  19.28  19.19  19.73  19.71  19.72  19.73
     2  18.88  19.30 426.92  10.48  19.66  19.71  19.67  19.68
     3  18.93  19.18  10.45 426.94  19.69  19.72  19.67  19.72
     4  19.60  19.66  19.69  19.70 428.13  10.49  19.40  19.57
     5  19.52  19.74  19.72  19.69  10.44 426.45  19.68  19.61
     6  19.63  19.50  19.72  19.64  19.59  19.66 426.91  10.47
     7  19.69  19.75  19.70  19.69  19.66  19.74  10.45 426.23


In the VM, the bandwidth between two GPUs under the same physical switch is
obviously lower, as per the reasons you said in former threads.

But what confused me most is that GPUs under different switches could
achieve the same speed, as well as in the Host. Does that mean after IOMMU
address translation, data traversing has utilized QPI bus by default? Even
these two devices do not belong to the same PCIe bus?

In a word, I'm trying to build a massive deep-learning/HPC infrastructure
for the cloud environment. Nvidia itself released a solution based on
dockers, and I believe qemu/VMs could also do it. Hopefully I could get
some help from the community.

The emulated switch you suggested looks like a good option to me, I will
have a try.


Thanks,
Bob


2017-07-27 1:32 GMT+08:00 Alex Williamson <alex.williamson@redhat.com>:

> On Wed, 26 Jul 2017 19:06:58 +0300
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>
> > On Wed, Jul 26, 2017 at 09:29:31AM -0600, Alex Williamson wrote:
> > > On Wed, 26 Jul 2017 09:21:38 +0300
> > > Marcel Apfelbaum <marcel@redhat.com> wrote:
> > >
> > > > On 25/07/2017 11:53, =E9=99=88=E5=8D=9A wrote:
> > > > > To accelerate data traversing between devices under the same PCIE
> Root
> > > > > Port or Switch.
> > > > >
> > > > > See https://lists.nongnu.org/archive/html/qemu-devel/2017-
> 07/msg07209.html
> > > > >
> > > >
> > > > Hi,
> > > >
> > > > It may be possible, but maybe PCIe Switch assignment is not
> > > > the only way to go.
> > > >
> > > > Adding Alex and Michael for their input on this matter.
> > > > More info at:
> > > > https://lists.nongnu.org/archive/html/qemu-devel/2017-
> 07/msg07209.html
> > >
> > > I think you need to look at where the IOMMU is in the topology and wh=
at
> > > address space the devices are working in when assigned to a VM to
> > > realize that it doesn't make any sense to assign switch ports to a VM=
.
> > > GPUs cannot do switch level peer to peer when assigned because they a=
re
> > > operating in an I/O virtual address space.  This is why we configure
> > > ACS on downstream ports to prevent peer to peer.  Peer to peer
> > > transactions must be forwarded upstream by the switch ports in order =
to
> > > reach the IOMMU for translation.  Note however that we do populate pe=
er
> > > to peer mappings within the IOMMU, so if the hardware supports it, th=
e
> > > IOMMU can reflect the transaction back out to the I/O bus to reach th=
e
> > > other device without CPU involvement.
> > >
> > > Therefore I think the better solution, if it encourages the NVIDIA
> > > driver to do the right thing, is to use emulated switches.  Assigning
> > > the physical switch would really do nothing more than make the PCIe
> link
> > > information more correct in the VM, everything else about the switch
> > > would be emulated.  Even still, unless you have an I/O topology which
> > > integrates the IOMMU into the switch itself, the data flow still need=
s
> > > to go all the way to the root complex to hit the IOMMU before being
> > > reflected to the other device.  Direct peer to peer between downstrea=
m
> > > switch ports operates in the wrong address space.  Thanks,
> > >
> > > Alex
> >
> > That's true of course. What would make sense would be for
> > hardware vendors to add ATS support to their cards.
> >
> > Then peer to peer should be allowed by hypervisor for translated
> transactions.
> >
> > Gives you the performance benefit without the security issues.
> >
> > Does anyone know whether any hardware implements this?
>
> GPUs often do implement ATS and the ACS DT (Direct Translated P2P)
> capability should handle routing requests with the Address Type field
> indicating a translated address directly between downstream ports.  DT
> is however not part of the standard set of ACS bits that we enable.  It
> seems like it might be fairly easy to poke the DT enable bit with
> setpci from userspace to test whether this "just works", providing of
> course you can get the driver to attempt to do peer to peer and ATS is
> already functioning on the GPU.  If so, then we should look at where
> in the code to do that enabling automatically.  Thanks,
>
> Alex
>
>
