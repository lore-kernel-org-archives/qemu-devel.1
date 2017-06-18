Received: from eggs.gnu.org ([2001:4830:134:3::10]:37525)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dMg9C-0008QG-7c
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 15:46:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dMg99-0006vp-5v
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 15:46:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:32832)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dMg98-0006v8-Sp
	for qemu-devel@nongnu.org; Sun, 18 Jun 2017 15:46:07 -0400
Date: Sun, 18 Jun 2017 22:46:01 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170618224025-mutt-send-email-mst@kernel.org>
References: <26250da7-b394-4964-8842-5c45bbe85e09@redhat.com>
	<6547dfcf-ea3a-f5f6-222d-40ff274654df@redhat.com>
	<20170614180459-mutt-send-email-mst@kernel.org>
	<b59be2f1-ee8c-e660-4f82-bbe63e22b603@redhat.com>
	<59422E91.7080407@intel.com>
	<20170616061949-mutt-send-email-mst@kernel.org>
	<40a12829-6e84-e63e-ac47-6f09cc85c3cc@redhat.com>
	<5943AE93.7020502@intel.com>
	<20170616181040-mutt-send-email-mst@kernel.org>
	<5944EA2E.9030608@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5944EA2E.9030608@intel.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] Re: [virtio-dev] Re:
 [PATCH v1] virtio-net: enable configurable tx queue size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Wang <wei.w.wang@intel.com>
Cc: Jason Wang <jasowang@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "stefanha@gmail.com" <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jan.scheurich@ericsson.com" <jan.scheurich@ericsson.com>, "armbru@redhat.com" <armbru@redhat.com>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

On Sat, Jun 17, 2017 at 04:37:02PM +0800, Wei Wang wrote:
> On 06/16/2017 11:15 PM, Michael S. Tsirkin wrote:
> > On Fri, Jun 16, 2017 at 06:10:27PM +0800, Wei Wang wrote:
> > > On 06/16/2017 04:57 PM, Jason Wang wrote:
> > > >=20
> > > > On 2017=E5=B9=B406=E6=9C=8816=E6=97=A5 11:22, Michael S. Tsirkin =
wrote:
> > > > > > I think the issues can be solved by VIRTIO_F_MAX_CHAIN_SIZE.
> > > > > >=20
> > > > > > For now, how about splitting it into two series of patches:
> > > > > > 1) enable 1024 tx queue size for vhost-user, to let the users=
 of
> > > > > > vhost-user
> > > > > > to easily use 1024 queue size.
> > > > > Fine with me. 1) will get property from user but override it on
> > > > > !vhost-user. Do we need a protocol flag? It seems prudent but w=
e get
> > > > > back to cross-version migration issues that are still pending s=
olution.
> > > What do you have in mind about the protocol flag?
> > Merely this: older clients might be confused if they get
> > a s/g with 1024 entries.
>=20
> I don't disagree to add that. But the client (i.e. vhost-user
> slave) is a host userspace program, and it seems that users can
> easily patch their host side applications if there is any issue,
> maybe we also don't need to be too prudent about that, do we?

I won't insist on this but it might not be easy. For example, are there
clients that want to forward the packet to host kernel as a s/g?

>=20
> Also, the usage of the protocol flag looks like a duplicate of what
> we plan to add in the next step - the virtio common feature flag,
> VIRTIO_F_MAX_CHAIN_SIZE, which is more general and can be used
> across different backends.
>
> > > Btw, I just tested the patch of 1), and it works fine with migratio=
n from
> > > the
> > > patched to non-patched version of QEMU. I'll send it out. Please ha=
ve a
> > > check.
> > >=20
> > >=20
> > > > > Marc Andre, what's the status of that work?
> > > > >=20
> > > > > > 2) enable VIRTIO_F_MAX_CHAIN_SIZE,  to enhance robustness.
> > > > > Rather, to support it for more backends.
> > > > Ok, if we want to support different values of max chain size in t=
he
> > > > future. It would be problematic for migration of cross backends,
> > > > consider the case when migrating from 2048 (vhost-user) to 1024
> > > > (qemu/vhost-kernel).
> > > >=20
> > > I think that wouldn't be a problem. If there is a possibility to ch=
ange the
> > > backend resulting in a change of config.max_change_size, a configur=
ation
> > > change notification can be injected to the guest, then guest will r=
ead and
> > > get the new value.
> > >=20
> > > Best,
> > > Wei
> > This might not be supportable by all guests. E.g. some requests might
> > already be in the queue. I'm not against reconfiguring devices across
> > migration but I think it's a big project. As a 1st step I would focus=
 on
> > keeping configuration consistent across migrations.
> >=20
>=20
> Would it be common and fair for vendors to migrate from a new QEMU
> to an old QEMU, which would downgrade the services that they provide
> to their users?
>=20
> Even for any reason that downgrade happens, I think it is
> sensible to sacrifice something (e.g. drop the unsupported
> requests from the queue) for the transition, right?
>=20
> On the other side, packet drop is normally handled at the packet
> protocol layer, e.g. TCP. Also, usually some amount of packet drop
> is acceptable during live migration.
>=20
> Best,
> Wei

This isn't how people expect migration to be handled ATM.
For now, I suggest we assume both sides need to be consistent.

--=20
MST
