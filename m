Received: from eggs.gnu.org ([2001:4830:134:3::10]:52761)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gUo0R-0006l7-2Q
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 02:23:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gUo0P-0004ey-Un
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 02:23:30 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:43857)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gUo0P-0004dK-KO
	for qemu-devel@nongnu.org; Thu, 06 Dec 2018 02:23:29 -0500
Received: by mail-wr1-x443.google.com with SMTP id r10so22115469wrs.10
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 23:23:29 -0800 (PST)
MIME-Version: 1.0
References: <20181206063552.6701-1-xieyongji@baidu.com>
In-Reply-To: <20181206063552.6701-1-xieyongji@baidu.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Thu, 6 Dec 2018 11:23:17 +0400
Message-ID: <CAJ+F1C+PrJ2RTNqFQ-Jv8xVrDE+Ozp+YOWoSP9sW0pfwUW1ibA@mail.gmail.com>
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
To: Yongji Xie <elohimes@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, nixun@baidu.com, QEMU <qemu-devel@nongnu.org>, lilin24@baidu.com, zhangyu31@baidu.com, chaiwen@baidu.com, xieyongji@baidu.com

Hi

On Thu, Dec 6, 2018 at 10:36 AM <elohimes@gmail.com> wrote:
>
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
>         -chardev socket,id=3Dchar0,path=3D/path/vhost.socket,reconnect=3D=
1,wait \
>         -device vhost-user-blk-pci,chardev=3Dchar0 \

Why do you want qemu to be the client since it is actually the one
that serves and remains alive?  Why make it try to reconnect regularly
when it could instead wait for a connection to come up?

>
> and start vhost-user-blk backend with:
>
> vhost-user-blk -b /path/file -s /path/vhost.socket
>
> Then we can restart vhost-user-blk at any time during VM running.
>
> Xie Yongji (6):
>   char-socket: Enable "wait" option for client mode
>   vhost-user: Add shared memory to record inflight I/O
>   libvhost-user: Introduce vu_queue_map_desc()
>   libvhost-user: Support recording inflight I/O in shared memory
>   vhost-user-blk: Add support for reconnecting backend
>   contrib/vhost-user-blk: enable inflight I/O recording
>
>  chardev/char-socket.c                   |   5 +-
>  contrib/libvhost-user/libvhost-user.c   | 215 ++++++++++++++++++++----
>  contrib/libvhost-user/libvhost-user.h   |  19 +++
>  contrib/vhost-user-blk/vhost-user-blk.c |   3 +-
>  hw/block/vhost-user-blk.c               | 169 +++++++++++++++++--
>  hw/virtio/vhost-user.c                  |  69 ++++++++
>  hw/virtio/vhost.c                       |   8 +
>  include/hw/virtio/vhost-backend.h       |   4 +
>  include/hw/virtio/vhost-user-blk.h      |   4 +
>  include/hw/virtio/vhost-user.h          |   8 +
>  10 files changed, 452 insertions(+), 52 deletions(-)
>
> --
> 2.17.1
>
>


--=20
Marc-Andr=C3=A9 Lureau
