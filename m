Received: from eggs.gnu.org ([2001:4830:134:3::10]:58195)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gUpqS-0006Ne-A5
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:21:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1gUpqN-0003Pc-4A
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:21:20 -0500
Received: from forwardcorp1g.cmail.yandex.net ([2a02:6b8:0:1465::fd]:52533)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yury-kotov@yandex-team.ru>)
	id 1gUpqM-0003Nl-Jd
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 04:21:15 -0500
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <20181206063552.6701-1-xieyongji@baidu.com>
References: <20181206063552.6701-1-xieyongji@baidu.com>
MIME-Version: 1.0
Date: Thu, 06 Dec 2018 12:21:11 +0300
Message-Id: <1157991544088071@myt4-a988562a11ab.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
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
To: "elohimes@gmail.com" <elohimes@gmail.com>, "mst@redhat.com" <mst@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>
Cc: "nixun@baidu.com" <nixun@baidu.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "lilin24@baidu.com" <lilin24@baidu.com>, "zhangyu31@baidu.com" <zhangyu31@baidu.com>, "chaiwen@baidu.com" <chaiwen@baidu.com>, Xie Yongji <xieyongji@baidu.com>

Hi, it's very interesting patchset.

I also research reconnecting issue for vhost-user-blk and SPDK.
Did you support a case when vhost backend is not started but QEMU does?

Regards,
Yury

06.12.2018, 09:37, "elohimes@gmail.com" <elohimes@gmail.com>:
> From: Xie Yongji <xieyongji@baidu.com>
>
> This patchset is aimed at supporting qemu to reconnect
> vhost-user-blk backend after vhost-user-blk backend crash or
> restart.
>
> The patch 1 tries to implenment the sync connection for
> "reconnect socket".
>
> The patch 2 introduces a new message VHOST_USER_SET_VRING_INFLIGHT
> to support offering shared memory to backend to record
> its inflight I/O.
>
> The patch 3,4 are the corresponding libvhost-user patches of
> patch 2. Make libvhost-user support VHOST_USER_SET_VRING_INFLIGHT.
>
> The patch 5 supports vhost-user-blk to reconnect backend when
> connection closed.
>
> The patch 6 tells qemu that we support reconnecting now.
>
> To use it, we could start qemu with:
>
> qemu-system-x86_64 \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-chardev socket,id=3Dch=
ar0,path=3D/path/vhost.socket,reconnect=3D1,wait \
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0-device vhost-user-blk-=
pci,chardev=3Dchar0 \
>
> and start vhost-user-blk backend with:
>
> vhost-user-blk -b /path/file -s /path/vhost.socket
>
> Then we can restart vhost-user-blk at any time during VM running.
>
> Xie Yongji (6):
> =C2=A0=C2=A0char-socket: Enable "wait" option for client mode
> =C2=A0=C2=A0vhost-user: Add shared memory to record inflight I/O
> =C2=A0=C2=A0libvhost-user: Introduce vu_queue_map_desc()
> =C2=A0=C2=A0libvhost-user: Support recording inflight I/O in shared mem=
ory
> =C2=A0=C2=A0vhost-user-blk: Add support for reconnecting backend
> =C2=A0=C2=A0contrib/vhost-user-blk: enable inflight I/O recording
>
> =C2=A0chardev/char-socket.c | 5 +-
> =C2=A0contrib/libvhost-user/libvhost-user.c | 215 ++++++++++++++++++++-=
---
> =C2=A0contrib/libvhost-user/libvhost-user.h | 19 +++
> =C2=A0contrib/vhost-user-blk/vhost-user-blk.c | 3 +-
> =C2=A0hw/block/vhost-user-blk.c | 169 +++++++++++++++++--
> =C2=A0hw/virtio/vhost-user.c | 69 ++++++++
> =C2=A0hw/virtio/vhost.c | 8 +
> =C2=A0include/hw/virtio/vhost-backend.h | 4 +
> =C2=A0include/hw/virtio/vhost-user-blk.h | 4 +
> =C2=A0include/hw/virtio/vhost-user.h | 8 +
> =C2=A010 files changed, 452 insertions(+), 52 deletions(-)
>
> --
> 2.17.1
