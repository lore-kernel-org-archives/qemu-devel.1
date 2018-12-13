Received: from eggs.gnu.org ([2001:4830:134:3::10]:36671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gXSPU-0005PC-P7
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gXSPR-0000ex-Hh
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59542)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gXSPR-0000bw-8Q
	for qemu-devel@nongnu.org; Thu, 13 Dec 2018 09:56:17 -0500
Date: Thu, 13 Dec 2018 09:56:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181213095516-mutt-send-email-mst@kernel.org>
References: <cf555a3d-0312-0b61-d18a-12ca295520a0@redhat.com>
	<CAONzpcaXTBgPTH0WSfq-=RwHLkuqi1mhKcv4C=0_O67_hV8A2Q@mail.gmail.com>
	<5794e090-9a9b-ca30-1066-ef697c9b67be@redhat.com>
	<CAONzpcZKAXrgbJc6H3d82zUt6VUVSo36HLg__OvuDWoBk9zTvg@mail.gmail.com>
	<7520e2cd-59cc-c133-f913-e7397df684dd@redhat.com>
	<CAONzpcbekTuN80r3Vb3CA7MqYBuVOOmV=6wfCNOb5z6QyrLZvg@mail.gmail.com>
	<cc6a464a-3193-f95b-08e5-c67e95d72dd5@redhat.com>
	<CAONzpcZ_RqUujdSoVCPUHH0A2g4hHY=oM9x-04e-6WugYFQOiw@mail.gmail.com>
	<ce6eb03a-8157-bd4a-a467-9c2d6b2fa7fd@redhat.com>
	<CAONzpcaGgS0mDm-9q7BZOvuMmCBokwXXkL-ZCUJfedX5m0HoCA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAONzpcaGgS0mDm-9q7BZOvuMmCBokwXXkL-ZCUJfedX5m0HoCA@mail.gmail.com>
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
To: Yongji Xie <elohimes@gmail.com>
Cc: jasowang@redhat.com, zhangyu31@baidu.com, Xie Yongji <xieyongji@baidu.com>, lilin24@baidu.com, qemu-devel@nongnu.org, chaiwen@baidu.com, marcandre.lureau@redhat.com, nixun@baidu.com

On Thu, Dec 13, 2018 at 11:41:06AM +0800, Yongji Xie wrote:
> On Thu, 13 Dec 2018 at 10:58, Jason Wang <jasowang@redhat.com> wrote:
> >
> >
> > On 2018/12/12 =E4=B8=8B=E5=8D=885:18, Yongji Xie wrote:
> > >>>> Ok, then we can simply forbid increasing the avail_idx in this c=
ase?
> > >>>>
> > >>>> Basically, it's a question of whether or not it's better to done=
 it in
> > >>>> the level of virtio instead of vhost. I'm pretty sure if we expo=
se
> > >>>> sufficient information, it could be done without touching vhost-=
user.
> > >>>> And we won't deal with e.g migration and other cases.
> > >>>>
> > >>> OK, I get your point. That's indeed an alternative way. But this =
feature seems
> > >>> to be only useful to vhost-user backend.
> > >> I admit I could not think of a use case other than vhost-user.
> > >>
> > >>
> > >>>    I'm not sure whether it make sense to
> > >>> touch virtio protocol for this feature.
> > >> Some possible advantages:
> > >>
> > >> - Feature could be determined and noticed by user or management la=
yer.
> > >>
> > >> - There's no need to invent ring layout specific protocol to recor=
d in
> > >> flight descriptors. E.g if my understanding is correct, for this s=
eries
> > >> and for the example above, it still can not work for packed virtqu=
eue
> > >> since descriptor id is not sufficient (descriptor could be overwri=
tten
> > >> by used one). You probably need to have a (partial) copy of descri=
ptor
> > >> ring for this.
> > >>
> > >> - No need to deal with migration, all information was in guest mem=
ory.
> > >>
> > > Yes, we have those advantages. But seems like handle this in vhost-=
user
> > > level could be easier to be maintained in production environment. W=
e can
> > > support old guest. And the bug fix will not depend on guest kernel =
updating.
> >
> >
> > Yes. But the my main concern is the layout specific data structure. I=
f
> > it could be done through a generic structure (can it?), it would be
> > fine. Otherwise, I believe we don't want another negotiation about wh=
at
> > kind of layout that backend support for reconnect.
> >
>=20
> Yes, the current layout in shared memory didn't support packed virtqueu=
e because
> the information of one descriptor in descriptor ring will not be
> available once device fetch it.
>=20
> I also thought about a generic structure before. But I failed... So I
> tried another way
> to acheive that in this series. In QEMU side, we just provide a shared
> memory to backend
> and we didn't define anything for this memory. In backend side, they
> should know how to
> use those memory to record inflight I/O no matter what kind of
> virtqueue they used.
> Thus,  If we updates virtqueue for new virtio spec in the feature, we
> don't need to touch
> QEMU and guest. What do you think about it?
>=20
> Thanks,
> Yongji

I think that's a good direction to take, yes.
Backends need to be very careful about the layout,
with versioning etc.

--=20
MST
