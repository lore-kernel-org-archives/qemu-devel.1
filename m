Received: from eggs.gnu.org ([2001:4830:134:3::10]:50627)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gUuD2-0008J6-W2
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 09:01:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gUuCB-0004pj-5B
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 09:00:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35442)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gUuCA-0004oL-Sr
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 09:00:03 -0500
Date: Thu, 6 Dec 2018 08:59:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181206085849-mutt-send-email-mst@kernel.org>
References: <20181206063552.6701-1-xieyongji@baidu.com>
	<561e0d7a-af2f-caad-aec3-c15952665687@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <561e0d7a-af2f-caad-aec3-c15952665687@redhat.com>
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
Cc: elohimes@gmail.com, marcandre.lureau@redhat.com, nixun@baidu.com, qemu-devel@nongnu.org, lilin24@baidu.com, zhangyu31@baidu.com, chaiwen@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Thu, Dec 06, 2018 at 09:57:22PM +0800, Jason Wang wrote:
>=20
> On 2018/12/6 =E4=B8=8B=E5=8D=882:35, elohimes@gmail.com wrote:
> > From: Xie Yongji <xieyongji@baidu.com>
> >=20
> > This patchset is aimed at supporting qemu to reconnect
> > vhost-user-blk backend after vhost-user-blk backend crash or
> > restart.
> >=20
> > The patch 1 tries to implenment the sync connection for
> > "reconnect socket".
> >=20
> > The patch 2 introduces a new message VHOST_USER_SET_VRING_INFLIGHT
> > to support offering shared memory to backend to record
> > its inflight I/O.
> >=20
> > The patch 3,4 are the corresponding libvhost-user patches of
> > patch 2. Make libvhost-user support VHOST_USER_SET_VRING_INFLIGHT.
> >=20
> > The patch 5 supports vhost-user-blk to reconnect backend when
> > connection closed.
> >=20
> > The patch 6 tells qemu that we support reconnecting now.
> >=20
> > To use it, we could start qemu with:
> >=20
> > qemu-system-x86_64 \
> >          -chardev socket,id=3Dchar0,path=3D/path/vhost.socket,reconne=
ct=3D1,wait \
> >          -device vhost-user-blk-pci,chardev=3Dchar0 \
> >=20
> > and start vhost-user-blk backend with:
> >=20
> > vhost-user-blk -b /path/file -s /path/vhost.socket
> >=20
> > Then we can restart vhost-user-blk at any time during VM running.
>=20
>=20
> I wonder whether or not it's better to handle this at the level of virt=
io
> protocol itself instead of vhost-user level. E.g expose last_avail_idx =
to
> driver might be sufficient?
>=20
> Another possible issue is, looks like you need to deal with different k=
inds
> of ring layouts e.g packed virtqueues.
>=20
> Thanks

I'm not sure I understand your comments here.
All these would be guest-visible extensions.
Possible for sure but how is this related to
a patch supporting transparent reconnects?

>=20
> >=20
> > Xie Yongji (6):
> >    char-socket: Enable "wait" option for client mode
> >    vhost-user: Add shared memory to record inflight I/O
> >    libvhost-user: Introduce vu_queue_map_desc()
> >    libvhost-user: Support recording inflight I/O in shared memory
> >    vhost-user-blk: Add support for reconnecting backend
> >    contrib/vhost-user-blk: enable inflight I/O recording
> >=20
> >   chardev/char-socket.c                   |   5 +-
> >   contrib/libvhost-user/libvhost-user.c   | 215 ++++++++++++++++++++-=
---
> >   contrib/libvhost-user/libvhost-user.h   |  19 +++
> >   contrib/vhost-user-blk/vhost-user-blk.c |   3 +-
> >   hw/block/vhost-user-blk.c               | 169 +++++++++++++++++--
> >   hw/virtio/vhost-user.c                  |  69 ++++++++
> >   hw/virtio/vhost.c                       |   8 +
> >   include/hw/virtio/vhost-backend.h       |   4 +
> >   include/hw/virtio/vhost-user-blk.h      |   4 +
> >   include/hw/virtio/vhost-user.h          |   8 +
> >   10 files changed, 452 insertions(+), 52 deletions(-)
> >=20
