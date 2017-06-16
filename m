Received: from eggs.gnu.org ([2001:4830:134:3::10]:37888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dLxvb-00044X-5t
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 16:33:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1dLxvW-0001vh-HM
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 16:33:11 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49836)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1dLxvW-0001tm-7y
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 16:33:06 -0400
Date: Fri, 16 Jun 2017 23:33:01 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170616232937-mutt-send-email-mst@kernel.org>
References: <593FB550.6090903@intel.com>
	<26250da7-b394-4964-8842-5c45bbe85e09@redhat.com>
	<6547dfcf-ea3a-f5f6-222d-40ff274654df@redhat.com>
	<20170614180459-mutt-send-email-mst@kernel.org>
	<b59be2f1-ee8c-e660-4f82-bbe63e22b603@redhat.com>
	<59422E91.7080407@intel.com>
	<20170616061949-mutt-send-email-mst@kernel.org>
	<40a12829-6e84-e63e-ac47-6f09cc85c3cc@redhat.com>
	<20170616181607-mutt-send-email-mst@kernel.org>
	<199a82f9-b122-08de-696a-04f7c6a369c6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <199a82f9-b122-08de-696a-04f7c6a369c6@redhat.com>
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
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, Wei Wang <wei.w.wang@intel.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "stefanha@gmail.com" <stefanha@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "jan.scheurich@ericsson.com" <jan.scheurich@ericsson.com>, "armbru@redhat.com" <armbru@redhat.com>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>

On Fri, Jun 16, 2017 at 07:04:27PM +0200, Maxime Coquelin wrote:
>=20
>=20
> On 06/16/2017 05:19 PM, Michael S. Tsirkin wrote:
> > On Fri, Jun 16, 2017 at 04:57:01PM +0800, Jason Wang wrote:
> > >=20
> > >=20
> > > On 2017=E5=B9=B406=E6=9C=8816=E6=97=A5 11:22, Michael S. Tsirkin wr=
ote:
> > > > > I think the issues can be solved by VIRTIO_F_MAX_CHAIN_SIZE.
> > > > >=20
> > > > > For now, how about splitting it into two series of patches:
> > > > > 1) enable 1024 tx queue size for vhost-user, to let the users o=
f vhost-user
> > > > > to easily use 1024 queue size.
> > > > Fine with me. 1) will get property from user but override it on
> > > > !vhost-user. Do we need a protocol flag? It seems prudent but we =
get
> > > > back to cross-version migration issues that a04re still pending s=
olution.
> > > > Marc Andre, what's the status of that work?
> > > >=20
> > > > > 2) enable VIRTIO_F_MAX_CHAIN_SIZE,  to enhance robustness.
> > > > Rather, to support it for more backends.
> > >=20
> > > Ok, if we want to support different values of max chain size in the=
 future.
> > > It would be problematic for migration of cross backends, consider t=
he case
> > > when migrating from 2048 (vhost-user) to 1024 (qemu/vhost-kernel).
> > >=20
> > > Thanks
> >=20
> > That's already a problem, and it's growing with each new feature.
> > Maxime looked at supporting vhost-user backends cross-version migrati=
on,
> > I think we must merge some solution sooner rather than later, prefera=
bly
> > by the next release.
> >=20
> > Maxime, any update here? Do we need a meeting to reach consensus?
>=20
> No update, I haven't found time to progress on the topic yet.
>=20
> For those who aren't aware of my initial proposal, you may find it here=
:
> https://www.spinics.net/linux/fedora/libvir/msg142668.html
>=20
> If my understanding is correct, you were concerned about the complexity=
 of
> my
> proposal which involved too many layers. Your suggestion was to have a =
tool
> provided with qemu that would connect to vhost-user socket and query th=
e
> backend capabilities.
> I'm not 100% clear how it would work, as the trend is to start the back=
end
> in
> client mode, meaning QEMU creates the socket. In this case, should the =
tool
> create the socket and management tool request the backend to connect to=
 it?
>=20
> I think it could make sense to have a meeting, but maybe we should firs=
t
> discuss the solutions on the list for efficiency.
>=20
> For the delivery, what is QEMU v2.10 planned release date?
>=20
> Note that my solution doesn't involve QEMU, so it would not be tight to=
 QEMU
> release date. But, that doesn't mean it would be delivered sooner than
> your solution.
>=20
> Maxime

I'd say let's go with your proposal (Solution 3 above).

--=20
MST
