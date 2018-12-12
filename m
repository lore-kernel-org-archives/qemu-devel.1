Received: from eggs.gnu.org ([2001:4830:134:3::10]:44261)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gWv5s-0000ES-Jb
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 22:21:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gWv5r-0000vq-Iy
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 22:21:52 -0500
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:34248)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gWv5r-0000vR-AN
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 22:21:51 -0500
Received: by mail-yb1-xb44.google.com with SMTP id k136so3996080ybk.1
	for <qemu-devel@nongnu.org>; Tue, 11 Dec 2018 19:21:51 -0800 (PST)
MIME-Version: 1.0
References: <20181206063552.6701-1-xieyongji@baidu.com>
	<561e0d7a-af2f-caad-aec3-c15952665687@redhat.com>
	<20181206085849-mutt-send-email-mst@kernel.org>
	<cf555a3d-0312-0b61-d18a-12ca295520a0@redhat.com>
	<CAONzpcaXTBgPTH0WSfq-=RwHLkuqi1mhKcv4C=0_O67_hV8A2Q@mail.gmail.com>
	<5794e090-9a9b-ca30-1066-ef697c9b67be@redhat.com>
In-Reply-To: <5794e090-9a9b-ca30-1066-ef697c9b67be@redhat.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Wed, 12 Dec 2018 11:21:38 +0800
Message-ID: <CAONzpcZKAXrgbJc6H3d82zUt6VUVSo36HLg__OvuDWoBk9zTvg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: jasowang@redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>, zhangyu31@baidu.com, Xie Yongji <xieyongji@baidu.com>, lilin24@baidu.com, qemu-devel@nongnu.org, chaiwen@baidu.com, marcandre.lureau@redhat.com, nixun@baidu.com

On Wed, 12 Dec 2018 at 11:00, Jason Wang <jasowang@redhat.com> wrote:
>
>
> On 2018/12/12 =E4=B8=8A=E5=8D=8810:48, Yongji Xie wrote:
> > On Mon, 10 Dec 2018 at 17:32, Jason Wang <jasowang@redhat.com> wrote:
> >>
> >> On 2018/12/6 =E4=B8=8B=E5=8D=889:59, Michael S. Tsirkin wrote:
> >>> On Thu, Dec 06, 2018 at 09:57:22PM +0800, Jason Wang wrote:
> >>>> On 2018/12/6 =E4=B8=8B=E5=8D=882:35,elohimes@gmail.com  wrote:
> >>>>> From: Xie Yongji<xieyongji@baidu.com>
> >>>>>
> >>>>> This patchset is aimed at supporting qemu to reconnect
> >>>>> vhost-user-blk backend after vhost-user-blk backend crash or
> >>>>> restart.
> >>>>>
> >>>>> The patch 1 tries to implenment the sync connection for
> >>>>> "reconnect socket".
> >>>>>
> >>>>> The patch 2 introduces a new message VHOST_USER_SET_VRING_INFLIGHT
> >>>>> to support offering shared memory to backend to record
> >>>>> its inflight I/O.
> >>>>>
> >>>>> The patch 3,4 are the corresponding libvhost-user patches of
> >>>>> patch 2. Make libvhost-user support VHOST_USER_SET_VRING_INFLIGHT.
> >>>>>
> >>>>> The patch 5 supports vhost-user-blk to reconnect backend when
> >>>>> connection closed.
> >>>>>
> >>>>> The patch 6 tells qemu that we support reconnecting now.
> >>>>>
> >>>>> To use it, we could start qemu with:
> >>>>>
> >>>>> qemu-system-x86_64 \
> >>>>>            -chardev socket,id=3Dchar0,path=3D/path/vhost.socket,rec=
onnect=3D1,wait \
> >>>>>            -device vhost-user-blk-pci,chardev=3Dchar0 \
> >>>>>
> >>>>> and start vhost-user-blk backend with:
> >>>>>
> >>>>> vhost-user-blk -b /path/file -s /path/vhost.socket
> >>>>>
> >>>>> Then we can restart vhost-user-blk at any time during VM running.
> >>>> I wonder whether or not it's better to handle this at the level of v=
irtio
> >>>> protocol itself instead of vhost-user level. E.g expose last_avail_i=
dx to
> >>>> driver might be sufficient?
> >>>>
> >>>> Another possible issue is, looks like you need to deal with differen=
t kinds
> >>>> of ring layouts e.g packed virtqueues.
> >>>>
> >>>> Thanks
> >>> I'm not sure I understand your comments here.
> >>> All these would be guest-visible extensions.
> >>
> >> Looks not, it only introduces a shared memory between qemu and
> >> vhost-user backend?
> >>
> >>
> >>> Possible for sure but how is this related to
> >>> a patch supporting transparent reconnects?
> >>
> >> I might miss something. My understanding is that we support transparen=
t
> >> reconnects, but we can't deduce an accurate last_avail_idx and this is
> >> what capability this series try to add. To me, this series is function=
al
> >> equivalent to expose last_avail_idx (or avail_idx_cons) in available
> >> ring. So the information is inside guest memory, vhost-user backend ca=
n
> >> access it and update it directly. I believe this is some modern NIC di=
d
> >> as well (but index is in MMIO area of course).
> >>
> > Hi Jason,
> >
> > If my understand is correct, it might be not enough to only expose
> > last_avail_idx.
> > Because we would not process descriptors in the same order in which the=
y have
> > been made available sometimes. If so, we can't get correct inflight
> > I/O information
> > from available ring.
>
>
> You can get this with the help of the both used ring and last_avail_idx
> I believe. Or maybe you can give us an example?
>

A simple example, we assume ring size is 8:

1. guest fill avail ring

avail ring: 0 1 2 3 4 5 6 7
used ring:

2. vhost-user backend complete 4,5,6,7 and fill used ring

avail ring: 0 1 2 3 4 5 6 7
used ring: 4 5 6 7

3. guest fill avail ring again

avail ring: 4 5 6 7 4 5 6 7
used ring: 4 5 6 7

4. vhost-user backend crash

The inflight descriptors 0, 1, 2, 3 lost.

Thanks,
Yongji
