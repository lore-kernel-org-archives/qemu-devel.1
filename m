Received: from eggs.gnu.org ([2001:4830:134:3::10]:43763)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ee178-00052p-3d
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:07:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1ee173-0002We-FN
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:07:58 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47264)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1ee173-0002Vf-5j
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 11:07:53 -0500
Date: Tue, 23 Jan 2018 18:07:43 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180123180515-mutt-send-email-mst@kernel.org>
References: <20180119130653.24044-1-stefanha@redhat.com>
	<9048a120-a3be-404d-e977-39f40b4d4561@redhat.com>
	<20180122121751.GD31621@stefanha-x1.localdomain>
	<20180122215348-mutt-send-email-mst@kernel.org>
	<b0568f2d-928c-5124-757e-fe5b706c4df7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b0568f2d-928c-5124-757e-fe5b706c4df7@redhat.com>
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
To: Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, zhiyong.yang@intel.com, Maxime Coquelin <maxime.coquelin@redhat.com>, Wei Wang <wei.w.wang@intel.com>

On Tue, Jan 23, 2018 at 06:01:15PM +0800, Jason Wang wrote:
>=20
>=20
> On 2018=E5=B9=B401=E6=9C=8823=E6=97=A5 04:04, Michael S. Tsirkin wrote:
> > On Mon, Jan 22, 2018 at 12:17:51PM +0000, Stefan Hajnoczi wrote:
> > > On Mon, Jan 22, 2018 at 11:33:46AM +0800, Jason Wang wrote:
> > > > On 2018=E5=B9=B401=E6=9C=8819=E6=97=A5 21:06, Stefan Hajnoczi wro=
te:
> > > > > These patches implement the virtio-vhost-user device design tha=
t I have
> > > > > described here:
> > > > > https://stefanha.github.io/virtio/vhost-user-slave.html#x1-2830=
007
> > > > Thanks for the patches, looks rather interesting and similar to s=
plit device
> > > > model used by Xen.
> > > >=20
> > > > > The goal is to let the guest act as the vhost device backend fo=
r other guests.
> > > > > This allows virtual networking and storage appliances to run in=
side guests.
> > > > So the question still, what kind of protocol do you want to run o=
n top? If
> > > > it was ethernet based, virtio-net work pretty well and it can eve=
n do
> > > > migration.
> > > >=20
> > > > > This device is particularly interesting for poll mode drivers w=
here exitless
> > > > > VM-to-VM communication is possible, completely bypassing the hy=
pervisor in the
> > > > > data path.
> > > > It's better to clarify the reason of hypervisor bypassing. (perfo=
rmance,
> > > > security or scalability).
> > > Performance - yes, definitely.  Exitless VM-to-VM is the fastest
> > > possible way to communicate between VMs.  Today it can only be done
> > > using ivshmem.  This patch series allows virtio devices to take
> > > advantage of it and will encourage people to use virtio instead of
> > > non-standard ivshmem devices.
> > >=20
> > > Security - I don't think this feature is a security improvement.  I=
t
> > > reduces isolation because VM1 has full shared memory access to VM2.=
  In
> > > fact, this is a reason for users to consider carefully whether they
> > > even want to use this feature.
> > True without an IOMMU, however using a vIOMMU within VM2
> > can protect the VM2, can't it?
>=20
> It's not clear to me how to do this. E.g need a way to report failure t=
o VM2
> or #PF?

Why would there be a failure? qemu running vm1 would be responsible for
preventing access to vm2's memory not mapped through an IOMMU.
Basically munmap these.

> >=20
> > > Scalability - much for the same reasons as the Performance section
> > > above.  Bypassing the hypervisor eliminates scalability bottlenecks
> > > (e.g. host network stack and bridge).
> > >=20
> > > > Probably not for the following cases:
> > > >=20
> > > > 1) kick/call
> > > I disagree here because kick/call is actually very efficient!
> > >=20
> > > VM1's irqfd is the ioeventfd for VM2.  When VM2 writes to the ioeve=
ntfd
> > > there is a single lightweight vmexit which injects an interrupt int=
o
> > > VM1.  QEMU is not involved and the host kernel scheduler is not inv=
olved
> > > so this is a low-latency operation.
>=20
> Right, looks like I was wrong. But consider irqfd may do wakup which me=
ans
> scheduler is still needed.
>=20
> > > I haven't tested this yet but the ioeventfd code looks like this wi=
ll
> > > work.
> > >=20
> > > > 2) device IOTLB / IOMMU transaction (or any other case that backe=
nds needs
> > > > metadata from qemu).
> > > Yes, this is the big weakness of vhost-user in general.  The IOMMU
> > > feature doesn't offer good isolation
> > I think that's an implementation issue, not a protocol issue.
> >=20
> >=20
> > > and even when it does, performance
> > > will be an issue.
> > If the IOMMU mappings are dynamic - but they are mostly
> > static with e.g. dpdk, right?
> >=20
> >=20
> > > > >    * Implement "Additional Device Resources over PCI" for share=
d memory,
> > > > >      doorbells, and notifications instead of hardcoding a BAR w=
ith magic
> > > > >      offsets into virtio-vhost-user:
> > > > >      https://stefanha.github.io/virtio/vhost-user-slave.html#x1=
-2920007
> > > > Does this mean we need to standardize vhost-user protocol first?
> > > Currently the draft spec says:
> > >=20
> > >    This section relies on definitions from the Vhost-user Protocol =
[1].
> > >=20
> > >    [1] https://git.qemu.org/?p=3Dqemu.git;a=3Dblob_plain;f=3Ddocs/i=
nterop/vhost-user.txt;hb=3DHEAD
> > >=20
> > > Michael: Is it okay to simply include this link?
> >=20
> > It is OK to include normative and non-normative references,
> > they go in the introduction and then you refer to them
> > anywhere in the document.
> >=20
> >=20
> > I'm still reviewing the draft.  At some level, this is a general tunn=
el
> > feature, it can tunnel any protocol. That would be one way to
> > isolate it.
>=20
> Right, but it should not be the main motivation, consider we can tunnel=
 any
> protocol on top of ethernet too.
>=20
> >=20
> > > > >    * Implement the VRING_KICK eventfd - currently vhost-user sl=
aves must be poll
> > > > >      mode drivers.
> > > > >    * Optimize VRING_CALL doorbell with ioeventfd to avoid QEMU =
exit.
> > > > The performance implication needs to be measured. It looks to me =
both kick
> > > > and call will introduce more latency form the point of guest.
> > > I described the irqfd + ioeventfd approach above.  It should be fas=
ter
> > > than virtio-net + bridge today.
> > >=20
> > > > >    * vhost-user log feature
> > > > >    * UUID config field for stable device identification regardl=
ess of PCI
> > > > >      bus addresses.
> > > > >    * vhost-user IOMMU and SLAVE_REQ_FD feature
> > > > So an assumption is the VM that implements vhost backends should =
be at least
> > > > as secure as vhost-user backend process on host. Could we have th=
is
> > > > conclusion?
> > > Yes.
> > >=20
> > > Sadly the vhost-user IOMMU protocol feature does not provide isolat=
ion.
> > > At the moment IOMMU is basically a layer of indirection (mapping) b=
ut
> > > the vhost-user backend process still has full access to guest RAM :=
(.
> > An important feature would be to do the isolation in the qemu.
> > So trust the qemu running VM2 but not VM2 itself.
>=20
> Agree, we'd better not consider VM is as secure as qemu.
>=20
> >=20
> >=20
> > > > Btw, it's better to have some early numbers, e.g what testpmd rep=
orts during
> > > > forwarding.
> > > I need to rely on others to do this (and many other things!) becaus=
e
> > > virtio-vhost-user isn't the focus of my work.
> > >=20
> > > These patches were written to demonstrate my suggestions for vhost-=
pci.
> > > They were written at work but also on weekends, early mornings, and=
 late
> > > nights to avoid delaying Wei and Zhiyong's vhost-pci work too much.
>=20
> Thanks a lot for the effort! If anyone want to benchmark, I would expec=
t
> compare the following three solutions:
>=20
> 1) vhost-pci
> 2) virtio-vhost-user
> 3) testpmd with two vhost-user ports
>=20
>=20
> Performance number is really important to show the advantages of new id=
eas.
>=20
> > >=20
> > > If this approach has merit then I hope others will take over and I'=
ll
> > > play a smaller role addressing some of the todo items and cleanups.
>=20
> It looks to me the advantages are 1) generic virtio layer (vhost-pci ca=
n
> achieve this too if necessary) 2) some kind of code reusing (vhost pmd)=
. And
> I'd expect they have similar performance result consider no major
> differences between them.
>=20
> Thanks
>=20
> > > Stefan
> >=20
