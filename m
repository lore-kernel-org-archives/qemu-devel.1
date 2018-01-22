Received: from eggs.gnu.org ([2001:4830:134:3::10]:56716)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1edb31-0007RX-UR
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:18:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1edb2y-0007lN-PF
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:17:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44452)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1edb2y-0007l4-Fw
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 07:17:56 -0500
Date: Mon, 22 Jan 2018 12:17:51 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180122121751.GD31621@stefanha-x1.localdomain>
References: <20180119130653.24044-1-stefanha@redhat.com>
	<9048a120-a3be-404d-e977-39f40b4d4561@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="9UV9rz0O2dU/yYYn"
Content-Disposition: inline
In-Reply-To: <9048a120-a3be-404d-e977-39f40b4d4561@redhat.com>
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
Cc: qemu-devel@nongnu.org, mst@redhat.com, zhiyong.yang@intel.com, Maxime Coquelin <maxime.coquelin@redhat.com>, Wei Wang <wei.w.wang@intel.com>


--9UV9rz0O2dU/yYYn
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2018 at 11:33:46AM +0800, Jason Wang wrote:
> On 2018=E5=B9=B401=E6=9C=8819=E6=97=A5 21:06, Stefan Hajnoczi wrote:
> > These patches implement the virtio-vhost-user device design that I have
> > described here:
> > https://stefanha.github.io/virtio/vhost-user-slave.html#x1-2830007
>=20
> Thanks for the patches, looks rather interesting and similar to split dev=
ice
> model used by Xen.
>=20
> >=20
> > The goal is to let the guest act as the vhost device backend for other =
guests.
> > This allows virtual networking and storage appliances to run inside gue=
sts.
>=20
> So the question still, what kind of protocol do you want to run on top? If
> it was ethernet based, virtio-net work pretty well and it can even do
> migration.
>=20
> > This device is particularly interesting for poll mode drivers where exi=
tless
> > VM-to-VM communication is possible, completely bypassing the hypervisor=
 in the
> > data path.
>=20
> It's better to clarify the reason of hypervisor bypassing. (performance,
> security or scalability).

Performance - yes, definitely.  Exitless VM-to-VM is the fastest
possible way to communicate between VMs.  Today it can only be done
using ivshmem.  This patch series allows virtio devices to take
advantage of it and will encourage people to use virtio instead of
non-standard ivshmem devices.

Security - I don't think this feature is a security improvement.  It
reduces isolation because VM1 has full shared memory access to VM2.  In
fact, this is a reason for users to consider carefully whether they
even want to use this feature.

Scalability - much for the same reasons as the Performance section
above.  Bypassing the hypervisor eliminates scalability bottlenecks
(e.g. host network stack and bridge).

> Probably not for the following cases:
>=20
> 1) kick/call

I disagree here because kick/call is actually very efficient!

VM1's irqfd is the ioeventfd for VM2.  When VM2 writes to the ioeventfd
there is a single lightweight vmexit which injects an interrupt into
VM1.  QEMU is not involved and the host kernel scheduler is not involved
so this is a low-latency operation.

I haven't tested this yet but the ioeventfd code looks like this will
work.

> 2) device IOTLB / IOMMU transaction (or any other case that backends needs
> metadata from qemu).

Yes, this is the big weakness of vhost-user in general.  The IOMMU
feature doesn't offer good isolation and even when it does, performance
will be an issue.

> >   * Implement "Additional Device Resources over PCI" for shared memory,
> >     doorbells, and notifications instead of hardcoding a BAR with magic
> >     offsets into virtio-vhost-user:
> >     https://stefanha.github.io/virtio/vhost-user-slave.html#x1-2920007
>=20
> Does this mean we need to standardize vhost-user protocol first?

Currently the draft spec says:

  This section relies on definitions from the Vhost-user Protocol [1].

  [1] https://git.qemu.org/?p=3Dqemu.git;a=3Dblob_plain;f=3Ddocs/interop/vh=
ost-user.txt;hb=3DHEAD

Michael: Is it okay to simply include this link?

> >   * Implement the VRING_KICK eventfd - currently vhost-user slaves must=
 be poll
> >     mode drivers.
> >   * Optimize VRING_CALL doorbell with ioeventfd to avoid QEMU exit.
>=20
> The performance implication needs to be measured. It looks to me both kick
> and call will introduce more latency form the point of guest.

I described the irqfd + ioeventfd approach above.  It should be faster
than virtio-net + bridge today.

> >   * vhost-user log feature
> >   * UUID config field for stable device identification regardless of PCI
> >     bus addresses.
> >   * vhost-user IOMMU and SLAVE_REQ_FD feature
>=20
> So an assumption is the VM that implements vhost backends should be at le=
ast
> as secure as vhost-user backend process on host. Could we have this
> conclusion?

Yes.

Sadly the vhost-user IOMMU protocol feature does not provide isolation.
At the moment IOMMU is basically a layer of indirection (mapping) but
the vhost-user backend process still has full access to guest RAM :(.

> Btw, it's better to have some early numbers, e.g what testpmd reports dur=
ing
> forwarding.

I need to rely on others to do this (and many other things!) because
virtio-vhost-user isn't the focus of my work.

These patches were written to demonstrate my suggestions for vhost-pci.
They were written at work but also on weekends, early mornings, and late
nights to avoid delaying Wei and Zhiyong's vhost-pci work too much.

If this approach has merit then I hope others will take over and I'll
play a smaller role addressing some of the todo items and cleanups.

Stefan

--9UV9rz0O2dU/yYYn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaZdZvAAoJEJykq7OBq3PIiaYH/jV9/KCijKRbG/QoqNP1IcVG
JU+27iDJUBi9mESnVT2rRbBOv51hn5Vk6BdtX0cRuk7Ba1NvV3BpBNkw2m9gzmCs
rU1AfF9x+I9tkeHLsWzXjWoz32qusll4caKYdd6pdXOrr4k/yCFP9xujQY/64+oF
Y2mkg3jxETUUn/IHgpFAQoLrxuT0K7xxIduhCtcyGrIqJ9CIHTF3KJnUo1urN3xm
fdmssIdPDxwyWSpAb9jxx+jQ7qVcaxY9IQkx9qR3N2OP1CMmZ1mHWoEy5jkgSdD1
0foC8ZSCHLXGnkme2apdW41kARlKJ8aH7fUl2OmxN0cKAbRhuRLbj4yW/G+uFzI=
=foW0
-----END PGP SIGNATURE-----

--9UV9rz0O2dU/yYYn--
