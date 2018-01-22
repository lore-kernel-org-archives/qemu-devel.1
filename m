Received: from eggs.gnu.org ([2001:4830:134:3::10]:53270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ediKV-0003do-Oi
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:04:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ediKS-0005C5-Gv
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:04:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ediKS-0005BM-7J
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 15:04:28 -0500
Date: Mon, 22 Jan 2018 22:04:18 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180122215348-mutt-send-email-mst@kernel.org>
References: <20180119130653.24044-1-stefanha@redhat.com>
	<9048a120-a3be-404d-e977-39f40b4d4561@redhat.com>
	<20180122121751.GD31621@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180122121751.GD31621@stefanha-x1.localdomain>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC 0/2] virtio-vhost-user: add virtio-vhost-user
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, zhiyong.yang@intel.com, Maxime Coquelin <maxime.coquelin@redhat.com>, Wei Wang <wei.w.wang@intel.com>

On Mon, Jan 22, 2018 at 12:17:51PM +0000, Stefan Hajnoczi wrote:
> On Mon, Jan 22, 2018 at 11:33:46AM +0800, Jason Wang wrote:
> > On 2018=E5=B9=B401=E6=9C=8819=E6=97=A5 21:06, Stefan Hajnoczi wrote:
> > > These patches implement the virtio-vhost-user device design that I =
have
> > > described here:
> > > https://stefanha.github.io/virtio/vhost-user-slave.html#x1-2830007
> >=20
> > Thanks for the patches, looks rather interesting and similar to split=
 device
> > model used by Xen.
> >=20
> > >=20
> > > The goal is to let the guest act as the vhost device backend for ot=
her guests.
> > > This allows virtual networking and storage appliances to run inside=
 guests.
> >=20
> > So the question still, what kind of protocol do you want to run on to=
p? If
> > it was ethernet based, virtio-net work pretty well and it can even do
> > migration.
> >=20
> > > This device is particularly interesting for poll mode drivers where=
 exitless
> > > VM-to-VM communication is possible, completely bypassing the hyperv=
isor in the
> > > data path.
> >=20
> > It's better to clarify the reason of hypervisor bypassing. (performan=
ce,
> > security or scalability).
>=20
> Performance - yes, definitely.  Exitless VM-to-VM is the fastest
> possible way to communicate between VMs.  Today it can only be done
> using ivshmem.  This patch series allows virtio devices to take
> advantage of it and will encourage people to use virtio instead of
> non-standard ivshmem devices.
>=20
> Security - I don't think this feature is a security improvement.  It
> reduces isolation because VM1 has full shared memory access to VM2.  In
> fact, this is a reason for users to consider carefully whether they
> even want to use this feature.

True without an IOMMU, however using a vIOMMU within VM2
can protect the VM2, can't it?

> Scalability - much for the same reasons as the Performance section
> above.  Bypassing the hypervisor eliminates scalability bottlenecks
> (e.g. host network stack and bridge).
>=20
> > Probably not for the following cases:
> >=20
> > 1) kick/call
>=20
> I disagree here because kick/call is actually very efficient!
>=20
> VM1's irqfd is the ioeventfd for VM2.  When VM2 writes to the ioeventfd
> there is a single lightweight vmexit which injects an interrupt into
> VM1.  QEMU is not involved and the host kernel scheduler is not involve=
d
> so this is a low-latency operation.
>=20
> I haven't tested this yet but the ioeventfd code looks like this will
> work.
>=20
> > 2) device IOTLB / IOMMU transaction (or any other case that backends =
needs
> > metadata from qemu).
>=20
> Yes, this is the big weakness of vhost-user in general.  The IOMMU
> feature doesn't offer good isolation

I think that's an implementation issue, not a protocol issue.


> and even when it does, performance
> will be an issue.

If the IOMMU mappings are dynamic - but they are mostly
static with e.g. dpdk, right?


> > >   * Implement "Additional Device Resources over PCI" for shared mem=
ory,
> > >     doorbells, and notifications instead of hardcoding a BAR with m=
agic
> > >     offsets into virtio-vhost-user:
> > >     https://stefanha.github.io/virtio/vhost-user-slave.html#x1-2920=
007
> >=20
> > Does this mean we need to standardize vhost-user protocol first?
>=20
> Currently the draft spec says:
>=20
>   This section relies on definitions from the Vhost-user Protocol [1].
>=20
>   [1] https://git.qemu.org/?p=3Dqemu.git;a=3Dblob_plain;f=3Ddocs/intero=
p/vhost-user.txt;hb=3DHEAD
>=20
> Michael: Is it okay to simply include this link?


It is OK to include normative and non-normative references,
they go in the introduction and then you refer to them
anywhere in the document.


I'm still reviewing the draft.  At some level, this is a general tunnel
feature, it can tunnel any protocol. That would be one way to
isolate it.

> > >   * Implement the VRING_KICK eventfd - currently vhost-user slaves =
must be poll
> > >     mode drivers.
> > >   * Optimize VRING_CALL doorbell with ioeventfd to avoid QEMU exit.
> >=20
> > The performance implication needs to be measured. It looks to me both=
 kick
> > and call will introduce more latency form the point of guest.
>=20
> I described the irqfd + ioeventfd approach above.  It should be faster
> than virtio-net + bridge today.
>=20
> > >   * vhost-user log feature
> > >   * UUID config field for stable device identification regardless o=
f PCI
> > >     bus addresses.
> > >   * vhost-user IOMMU and SLAVE_REQ_FD feature
> >=20
> > So an assumption is the VM that implements vhost backends should be a=
t least
> > as secure as vhost-user backend process on host. Could we have this
> > conclusion?
>=20
> Yes.
>=20
> Sadly the vhost-user IOMMU protocol feature does not provide isolation.
> At the moment IOMMU is basically a layer of indirection (mapping) but
> the vhost-user backend process still has full access to guest RAM :(.

An important feature would be to do the isolation in the qemu.
So trust the qemu running VM2 but not VM2 itself.


> > Btw, it's better to have some early numbers, e.g what testpmd reports=
 during
> > forwarding.
>=20
> I need to rely on others to do this (and many other things!) because
> virtio-vhost-user isn't the focus of my work.
>=20
> These patches were written to demonstrate my suggestions for vhost-pci.
> They were written at work but also on weekends, early mornings, and lat=
e
> nights to avoid delaying Wei and Zhiyong's vhost-pci work too much.
>=20
> If this approach has merit then I hope others will take over and I'll
> play a smaller role addressing some of the todo items and cleanups.
>=20
> Stefan
