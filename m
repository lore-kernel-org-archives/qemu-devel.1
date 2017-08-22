Received: from eggs.gnu.org ([2001:4830:134:3::10]:52869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dkDZb-0007An-4v
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 14:06:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dkDZW-0008Pz-6a
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 14:06:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53486)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dkDZV-0008Pf-Tl
	for qemu-devel@nongnu.org; Tue, 22 Aug 2017 14:06:38 -0400
Date: Tue, 22 Aug 2017 21:06:30 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170822205940-mutt-send-email-mst@kernel.org>
References: <20170726113222.52aad9a6@w520.home>
	<CAMxP3BTFgwJtjh78hNBCoxBp1WsnZMZLsqzb3McqCq=-SX0a4g@mail.gmail.com>
	<20170731234626.7664be18@w520.home>
	<CAMxP3BTfMad-ycWHqmW+aVM7rv2CJSv-dmEFUveGBqAWvfbBjQ@mail.gmail.com>
	<20170801090158.35d18f10@w520.home>
	<CAMxP3BRkzXBRPZw9fpCu-w4Fusn6ng_knk1cAz=EDBAiw9UnqA@mail.gmail.com>
	<20170807095224.5438ef8c@w520.home>
	<20170808230043-mutt-send-email-mst@kernel.org>
	<CAMxP3BR=WHKJxcWKH27dcC7DTKGD2y7r12teAUSmMkwp1VDafA@mail.gmail.com>
	<20170822105659.75b5c7e0@w520.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170822105659.75b5c7e0@w520.home>
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
Cc: Bob Chen <a175818323@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>, =?utf-8?B?6ZmI5Y2a?= <chenbo02@meituan.com>, qemu-devel@nongnu.org

On Tue, Aug 22, 2017 at 10:56:59AM -0600, Alex Williamson wrote:
> On Tue, 22 Aug 2017 15:04:55 +0800
> Bob Chen <a175818323@gmail.com> wrote:
>=20
> > Hi,
> >=20
> > I got a spec from Nvidia which illustrates how to enable GPU p2p in
> > virtualization environment. (See attached)
>=20
> Neat, looks like we should implement a new QEMU vfio-pci option,
> something like nvidia-gpudirect-p2p-id=3D.  I don't think I'd want to
> code the policy of where to enable it into QEMU or the kernel, so we'd
> push it up to management layers or users to decide.
> =20
> > The key is to append the legacy pci capabilities list when setting up=
 the
> > hypervisor, with a Nvidia customized capability config.
> >=20
> > I added some hack in hw/vfio/pci.c and managed to implement that.
> >=20
> > Then I found the GPU was able to recognize its peer, and the latency =
has
> > dropped. =E2=9C=85
> >=20
> > However the bandwidth didn't improve, but decreased instead. =E2=9D=8C
> >=20
> > Any suggestions?
>=20
> What's the VM topology?  I've found that in a Q35 configuration with
> GPUs downstream of an emulated root port, the NVIDIA driver in the
> guest will downshift the physical link rate to 2.5GT/s and never
> increase it back to 8GT/s.  I believe this is because the virtual
> downstream port only advertises Gen1 link speeds.


Fixing that would be nice, and it's great that you now actually have a
reproducer that can be used to test it properly.

Exposing higher link speeds is a bit of work since there are now all
kind of corner cases to cover as guests may play with link speeds and we
must pretend we change it accordingly.  An especially interesting
question is what to do with the assigned device when guest tries to play
with port link speed. It's kind of similar to AER in that respect.

I guess we can just ignore it for starters.

>  If the GPUs are on
> the root complex (ie. pcie.0) the physical link will run at 2.5GT/s
> when the GPU is idle and upshift to 8GT/s under load.  This also
> happens if the GPU is exposed in a conventional PCI topology to the
> VM.  Another interesting data point is that an older Kepler GRID card
> does not have this issue, dynamically shifting the link speed under
> load regardless of the VM PCI/e topology, while a new M60 using the
> same driver experiences this problem.  I've filed a bug with NVIDIA as
> this seems to be a regression, but it appears (untested) that the
> hypervisor should take the approach of exposing full, up-to-date PCIe
> link capabilities and report a link status matching the downstream
> devices.


> I'd suggest during your testing, watch lspci info for the GPU from the
> host, noting the behavior of LnkSta (Link Status) to check if the
> devices gets stuck at 2.5GT/s in your VM configuration and adjust the
> topology until it works, likely placing the GPUs on pcie.0 for a Q35
> based machine.  Thanks,
>=20
> Alex
