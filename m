Received: from eggs.gnu.org ([2001:4830:134:3::10]:43002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gXnaD-0003Z8-9R
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:32:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gXna9-0001DI-2P
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:32:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:5101)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gXna8-0001CI-J8
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 08:32:44 -0500
Date: Fri, 14 Dec 2018 08:31:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181214082455-mutt-send-email-mst@kernel.org>
References: <5794e090-9a9b-ca30-1066-ef697c9b67be@redhat.com>
	<CAONzpcZKAXrgbJc6H3d82zUt6VUVSo36HLg__OvuDWoBk9zTvg@mail.gmail.com>
	<7520e2cd-59cc-c133-f913-e7397df684dd@redhat.com>
	<CAONzpcbekTuN80r3Vb3CA7MqYBuVOOmV=6wfCNOb5z6QyrLZvg@mail.gmail.com>
	<cc6a464a-3193-f95b-08e5-c67e95d72dd5@redhat.com>
	<CAONzpcZ_RqUujdSoVCPUHH0A2g4hHY=oM9x-04e-6WugYFQOiw@mail.gmail.com>
	<ce6eb03a-8157-bd4a-a467-9c2d6b2fa7fd@redhat.com>
	<CAONzpcaGgS0mDm-9q7BZOvuMmCBokwXXkL-ZCUJfedX5m0HoCA@mail.gmail.com>
	<20181213095516-mutt-send-email-mst@kernel.org>
	<fdccd7a0-80b8-0449-3da2-807f588fda5e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fdccd7a0-80b8-0449-3da2-807f588fda5e@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-4.0 0/6] vhost-user-blk: Add support
 for backend reconnecting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: Yongji Xie <elohimes@gmail.com>, nixun@baidu.com, zhangyu31@baidu.com, lilin24@baidu.com, qemu-devel@nongnu.org, chaiwen@baidu.com, marcandre.lureau@redhat.com, Xie Yongji <xieyongji@baidu.com>, maxime.coquelin@redhat.com

On Fri, Dec 14, 2018 at 12:36:01PM +0800, Jason Wang wrote:
>=20
> On 2018/12/13 =E4=B8=8B=E5=8D=8810:56, Michael S. Tsirkin wrote:
> > On Thu, Dec 13, 2018 at 11:41:06AM +0800, Yongji Xie wrote:
> > > On Thu, 13 Dec 2018 at 10:58, Jason Wang <jasowang@redhat.com> wrot=
e:
> > > >=20
> > > > On 2018/12/12 =E4=B8=8B=E5=8D=885:18, Yongji Xie wrote:
> > > > > > > > Ok, then we can simply forbid increasing the avail_idx in=
 this case?
> > > > > > > >=20
> > > > > > > > Basically, it's a question of whether or not it's better =
to done it in
> > > > > > > > the level of virtio instead of vhost. I'm pretty sure if =
we expose
> > > > > > > > sufficient information, it could be done without touching=
 vhost-user.
> > > > > > > > And we won't deal with e.g migration and other cases.
> > > > > > > >=20
> > > > > > > OK, I get your point. That's indeed an alternative way. But=
 this feature seems
> > > > > > > to be only useful to vhost-user backend.
> > > > > > I admit I could not think of a use case other than vhost-user=
.
> > > > > >=20
> > > > > >=20
> > > > > > >     I'm not sure whether it make sense to
> > > > > > > touch virtio protocol for this feature.
> > > > > > Some possible advantages:
> > > > > >=20
> > > > > > - Feature could be determined and noticed by user or manageme=
nt layer.
> > > > > >=20
> > > > > > - There's no need to invent ring layout specific protocol to =
record in
> > > > > > flight descriptors. E.g if my understanding is correct, for t=
his series
> > > > > > and for the example above, it still can not work for packed v=
irtqueue
> > > > > > since descriptor id is not sufficient (descriptor could be ov=
erwritten
> > > > > > by used one). You probably need to have a (partial) copy of d=
escriptor
> > > > > > ring for this.
> > > > > >=20
> > > > > > - No need to deal with migration, all information was in gues=
t memory.
> > > > > >=20
> > > > > Yes, we have those advantages. But seems like handle this in vh=
ost-user
> > > > > level could be easier to be maintained in production environmen=
t. We can
> > > > > support old guest. And the bug fix will not depend on guest ker=
nel updating.
> > > >=20
> > > > Yes. But the my main concern is the layout specific data structur=
e. If
> > > > it could be done through a generic structure (can it?), it would =
be
> > > > fine. Otherwise, I believe we don't want another negotiation abou=
t what
> > > > kind of layout that backend support for reconnect.
> > > >=20
> > > Yes, the current layout in shared memory didn't support packed virt=
queue because
> > > the information of one descriptor in descriptor ring will not be
> > > available once device fetch it.
> > >=20
> > > I also thought about a generic structure before. But I failed... So=
 I
> > > tried another way
> > > to acheive that in this series. In QEMU side, we just provide a sha=
red
> > > memory to backend
> > > and we didn't define anything for this memory. In backend side, the=
y
> > > should know how to
> > > use those memory to record inflight I/O no matter what kind of
> > > virtqueue they used.
> > > Thus,  If we updates virtqueue for new virtio spec in the feature, =
we
> > > don't need to touch
> > > QEMU and guest. What do you think about it?
> > >=20
> > > Thanks,
> > > Yongji
> > I think that's a good direction to take, yes.
> > Backends need to be very careful about the layout,
> > with versioning etc.
>=20
>=20
> I'm not sure this could be done 100% transparent to qemu. E.g you need =
to
> deal with reset I think and you need to carefully choose the size of th=
e
> region. Which means you need negotiate the size, layout through backend=
.

I am not sure I follow. The point is all this state is internal to the
backend. QEMU does not care at all - it just helps a little by hanging
on to it.

> And
> need to deal with migration with them.

Good catch.
There definitely is an issue in that you can not migrate with backend
being disconnected: migration needs to flush the backend and we can't
when it's disconnected.  This needs to be addressed.
I think it's cleanest to just defer migration
until backend does reconnect.


Backend cross version migration is all messed up in vhost user, I agree.
There was a plan to fix it that was never executed unfortunately.
Maxime, do you still plan to look into it?

> This is another sin of splitting
> virtio dataplane from qemu anyway.
>=20
>=20
> Thanks

It wasn't split as such - dpdk was never a part of qemu.  We just
enabled it without fuse hacks.

--=20
MST
