Received: from eggs.gnu.org ([2001:4830:134:3::10]:43586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1dmdxt-0007gc-AX
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:41:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1dmdxr-00005C-Su
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:41:49 -0400
Received: from mail-io0-x234.google.com ([2607:f8b0:4001:c06::234]:33545)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a175818323@gmail.com>)
	id 1dmdxr-00004z-Mv
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 06:41:47 -0400
Received: by mail-io0-x234.google.com with SMTP id s101so16812923ioe.0
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 03:41:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170822205940-mutt-send-email-mst@kernel.org>
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
	<20170822205940-mutt-send-email-mst@kernel.org>
From: Bob Chen <a175818323@gmail.com>
Date: Tue, 29 Aug 2017 18:41:44 +0800
Message-ID: <CAMxP3BSNPjRZGOULZ0zKBq8v5Rqv9f5xasx+BD57c=oAS5tSWg@mail.gmail.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?B?6ZmI5Y2a?= <chenbo02@meituan.com>, qemu-devel@nongnu.org

The topology is already having all GPUs directly attached to root bus 0. In
this situation you can't see the LnkSta attribute in any capabilities.

The other way of using emulated switch would somehow show this attribute,
at 8 GT/s, although the real bandwidth is low as usual.

2017-08-23 2:06 GMT+08:00 Michael S. Tsirkin <mst@redhat.com>:

> On Tue, Aug 22, 2017 at 10:56:59AM -0600, Alex Williamson wrote:
> > On Tue, 22 Aug 2017 15:04:55 +0800
> > Bob Chen <a175818323@gmail.com> wrote:
> >
> > > Hi,
> > >
> > > I got a spec from Nvidia which illustrates how to enable GPU p2p in
> > > virtualization environment. (See attached)
> >
> > Neat, looks like we should implement a new QEMU vfio-pci option,
> > something like nvidia-gpudirect-p2p-id=3D.  I don't think I'd want to
> > code the policy of where to enable it into QEMU or the kernel, so we'd
> > push it up to management layers or users to decide.
> >
> > > The key is to append the legacy pci capabilities list when setting up
> the
> > > hypervisor, with a Nvidia customized capability config.
> > >
> > > I added some hack in hw/vfio/pci.c and managed to implement that.
> > >
> > > Then I found the GPU was able to recognize its peer, and the latency
> has
> > > dropped. =E2=9C=85
> > >
> > > However the bandwidth didn't improve, but decreased instead. =E2=9D=
=8C
> > >
> > > Any suggestions?
> >
> > What's the VM topology?  I've found that in a Q35 configuration with
> > GPUs downstream of an emulated root port, the NVIDIA driver in the
> > guest will downshift the physical link rate to 2.5GT/s and never
> > increase it back to 8GT/s.  I believe this is because the virtual
> > downstream port only advertises Gen1 link speeds.
>
>
> Fixing that would be nice, and it's great that you now actually have a
> reproducer that can be used to test it properly.
>
> Exposing higher link speeds is a bit of work since there are now all
> kind of corner cases to cover as guests may play with link speeds and we
> must pretend we change it accordingly.  An especially interesting
> question is what to do with the assigned device when guest tries to play
> with port link speed. It's kind of similar to AER in that respect.
>
> I guess we can just ignore it for starters.
>
> >  If the GPUs are on
> > the root complex (ie. pcie.0) the physical link will run at 2.5GT/s
> > when the GPU is idle and upshift to 8GT/s under load.  This also
> > happens if the GPU is exposed in a conventional PCI topology to the
> > VM.  Another interesting data point is that an older Kepler GRID card
> > does not have this issue, dynamically shifting the link speed under
> > load regardless of the VM PCI/e topology, while a new M60 using the
> > same driver experiences this problem.  I've filed a bug with NVIDIA as
> > this seems to be a regression, but it appears (untested) that the
> > hypervisor should take the approach of exposing full, up-to-date PCIe
> > link capabilities and report a link status matching the downstream
> > devices.
>
>
> > I'd suggest during your testing, watch lspci info for the GPU from the
> > host, noting the behavior of LnkSta (Link Status) to check if the
> > devices gets stuck at 2.5GT/s in your VM configuration and adjust the
> > topology until it works, likely placing the GPUs on pcie.0 for a Q35
> > based machine.  Thanks,
> >
> > Alex
>
