Received: from eggs.gnu.org ([2001:4830:134:3::10]:59385)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1edvWm-000382-V6
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:10:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1edvWi-0003sW-RU
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:10:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41364)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1edvWi-0003s2-Fe
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:10:00 -0500
Date: Tue, 23 Jan 2018 10:09:52 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180123100952.GB6565@stefanha-x1.localdomain>
References: <20180119130653.24044-1-stefanha@redhat.com>
	<9048a120-a3be-404d-e977-39f40b4d4561@redhat.com>
	<20180122121751.GD31621@stefanha-x1.localdomain>
	<20180122215348-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aVD9QWMuhilNxW9f"
Content-Disposition: inline
In-Reply-To: <20180122215348-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org, zhiyong.yang@intel.com, Maxime Coquelin <maxime.coquelin@redhat.com>, Wei Wang <wei.w.wang@intel.com>


--aVD9QWMuhilNxW9f
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 22, 2018 at 10:04:18PM +0200, Michael S. Tsirkin wrote:
> On Mon, Jan 22, 2018 at 12:17:51PM +0000, Stefan Hajnoczi wrote:
> > On Mon, Jan 22, 2018 at 11:33:46AM +0800, Jason Wang wrote:
> > > On 2018=E5=B9=B401=E6=9C=8819=E6=97=A5 21:06, Stefan Hajnoczi wrote:
> > > > These patches implement the virtio-vhost-user device design that I =
have
> > > > described here:
> > > > https://stefanha.github.io/virtio/vhost-user-slave.html#x1-2830007
> > >=20
> > > Thanks for the patches, looks rather interesting and similar to split=
 device
> > > model used by Xen.
> > >=20
> > > >=20
> > > > The goal is to let the guest act as the vhost device backend for ot=
her guests.
> > > > This allows virtual networking and storage appliances to run inside=
 guests.
> > >=20
> > > So the question still, what kind of protocol do you want to run on to=
p? If
> > > it was ethernet based, virtio-net work pretty well and it can even do
> > > migration.
> > >=20
> > > > This device is particularly interesting for poll mode drivers where=
 exitless
> > > > VM-to-VM communication is possible, completely bypassing the hyperv=
isor in the
> > > > data path.
> > >=20
> > > It's better to clarify the reason of hypervisor bypassing. (performan=
ce,
> > > security or scalability).
> >=20
> > Performance - yes, definitely.  Exitless VM-to-VM is the fastest
> > possible way to communicate between VMs.  Today it can only be done
> > using ivshmem.  This patch series allows virtio devices to take
> > advantage of it and will encourage people to use virtio instead of
> > non-standard ivshmem devices.
> >=20
> > Security - I don't think this feature is a security improvement.  It
> > reduces isolation because VM1 has full shared memory access to VM2.  In
> > fact, this is a reason for users to consider carefully whether they
> > even want to use this feature.
>=20
> True without an IOMMU, however using a vIOMMU within VM2
> can protect the VM2, can't it?
[...]
> > Yes, this is the big weakness of vhost-user in general.  The IOMMU
> > feature doesn't offer good isolation
>=20
> I think that's an implementation issue, not a protocol issue.

The IOMMU feature in the vhost-user protocol adds address translation
and permissions but the underlying memory region file descriptors still
expose all of guest RAM.

An implementation that offers true isolation has to enforce the IOMMU
state on the shared memory (e.g. read & write access).

> > and even when it does, performance
> > will be an issue.
>=20
> If the IOMMU mappings are dynamic - but they are mostly
> static with e.g. dpdk, right?

Excellent idea!  My understanding is that DPDK's memory area for mbufs
is static.

The question is whether this area contains only packet payload buffers?
Then it would be feasible to map only this memory (plus vrings) and
achieve isolation.

If other data is intermingled with the packet payload buffers then it's
difficult to guarantee security since an evil VM can modify the
non-payload data to trigger race conditions, out-of-bounds memory
accesses, and other bugs.

Anyway, what you've suggested sounds like the most realistic option for
achieving isolation without losing performance.

> > > >   * Implement the VRING_KICK eventfd - currently vhost-user slaves =
must be poll
> > > >     mode drivers.
> > > >   * Optimize VRING_CALL doorbell with ioeventfd to avoid QEMU exit.
> > >=20
> > > The performance implication needs to be measured. It looks to me both=
 kick
> > > and call will introduce more latency form the point of guest.
> >=20
> > I described the irqfd + ioeventfd approach above.  It should be faster
> > than virtio-net + bridge today.
> >=20
> > > >   * vhost-user log feature
> > > >   * UUID config field for stable device identification regardless o=
f PCI
> > > >     bus addresses.
> > > >   * vhost-user IOMMU and SLAVE_REQ_FD feature
> > >=20
> > > So an assumption is the VM that implements vhost backends should be a=
t least
> > > as secure as vhost-user backend process on host. Could we have this
> > > conclusion?
> >=20
> > Yes.
> >=20
> > Sadly the vhost-user IOMMU protocol feature does not provide isolation.
> > At the moment IOMMU is basically a layer of indirection (mapping) but
> > the vhost-user backend process still has full access to guest RAM :(.
>=20
> An important feature would be to do the isolation in the qemu.
> So trust the qemu running VM2 but not VM2 itself.

I think what you suggested above about DPDK's static mappings is even
better.  It does not require trusting VM2's QEMU.  It's also simpler
than implementing isolation in QEMU.

--aVD9QWMuhilNxW9f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaZwnwAAoJEJykq7OBq3PIu+UIAKnF/e8Zzf9WeDpr8yokZbEY
Hj34mc8MOOcHA/avG61Cd/Y7FrOlT1dx7rzWyjy3Dd2lPkWobup9RfmGeEhWrR5k
H7XpL2+eb/vruvGSvlSQ0/iY14YYrLFc3BOf27vX6N9rxLMwn2Jv6ZvXMnSl+UY0
afAossM3zXB6DqqrF05MUPY0xflctsfBOZo22KjOr5qj74sxFDe1Vp0+Qz05Gvmh
WQHb0/MtZSkaVwxPeztljivb4/LppSRWpfssg4BMOjPcXTqgNM88TJctxDNV/DbJ
TtB4soZBtj67zHij27AT3c2i/w3Bp+p/L3Kx7vUWA5T1v0pX6A3MayaTHKWPKlw=
=buKO
-----END PGP SIGNATURE-----

--aVD9QWMuhilNxW9f--
