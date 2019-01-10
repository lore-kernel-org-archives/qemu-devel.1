Received: from eggs.gnu.org ([209.51.188.92]:35612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1ghYDp-0002VY-9L
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 06:10:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1ghYDo-0006xJ-Hr
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 06:10:01 -0500
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41]:35054)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1ghYDo-0006wN-96
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 06:10:00 -0500
Received: by mail-yw1-xc41.google.com with SMTP id h32so4235883ywk.2
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 03:10:00 -0800 (PST)
MIME-Version: 1.0
References: <20190109112728.9214-1-xieyongji@baidu.com>
	<CAJ+F1CLPFUnJANJs3SSine9YRXXqpR+gh6wHOLD=ivWpyURmJA@mail.gmail.com>
In-Reply-To: <CAJ+F1CLPFUnJANJs3SSine9YRXXqpR+gh6wHOLD=ivWpyURmJA@mail.gmail.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Thu, 10 Jan 2019 19:09:47 +0800
Message-ID: <CAONzpcYAfHo+uWRZxVY6+iE2wyTtC7dpm-h+rU-Nipz3xz=RwA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 for-4.0 0/7] vhost-user-blk: Add support
 for backend reconnecting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>, Maxime Coquelin <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, nixun@baidu.com, QEMU <qemu-devel@nongnu.org>, lilin24@baidu.com, zhangyu31@baidu.com, chaiwen@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Thu, 10 Jan 2019 at 18:39, Marc-Andr=C3=A9 Lureau
<marcandre.lureau@gmail.com> wrote:
>
> Hi
>
> On Wed, Jan 9, 2019 at 3:28 PM <elohimes@gmail.com> wrote:
> >
> > From: Xie Yongji <xieyongji@baidu.com>
> >
> > This patchset is aimed at supporting qemu to reconnect
> > vhost-user-blk backend after vhost-user-blk backend crash or
> > restart.
> >
> > The patch 1 uses exisiting wait/nowait options to make QEMU not
> > do a connect on client sockets during initialization of the chardev.
> >
> > The patch 2 introduces two new messages VHOST_USER_GET_INFLIGHT_FD
> > and VHOST_USER_SET_INFLIGHT_FD to support providing shared
> > memory to backend.
> >
> > The patch 3,4 are the corresponding libvhost-user patches of
> > patch 2. Make libvhost-user support VHOST_USER_GET_INFLIGHT_FD
> > and VHOST_USER_SET_INFLIGHT_FD.
> >
> > The patch 5 allows vhost-user-blk to use the two new messages
> > to get/set inflight buffer from/to backend.
> >
> > The patch 6 supports vhost-user-blk to reconnect backend when
> > connection closed.
> >
> > The patch 7 introduces VHOST_USER_PROTOCOL_F_SLAVE_SHMFD
> > to vhost-user-blk backend which is used to tell qemu that
> > we support reconnecting now.
> >
> > To use it, we could start qemu with:
> >
> > qemu-system-x86_64 \
> >         -chardev socket,id=3Dchar0,path=3D/path/vhost.socket,nowait,rec=
onnect=3D1, \
> >         -device vhost-user-blk-pci,chardev=3Dchar0 \
> >
> > and start vhost-user-blk backend with:
> >
> > vhost-user-blk -b /path/file -s /path/vhost.socket
> >
> > Then we can restart vhost-user-blk at any time during VM running.
> >
> > V3 to V4:
> > - Drop messages VHOST_USER_GET_SHM_SIZE and VHOST_USER_SET_SHM_FD
> > - Introduce two new messages VHOST_USER_GET_INFLIGHT_FD
> >   and VHOST_USER_SET_INFLIGHT_FD
> > - Allocate inflight buffer in backend rather than in qemu
> > - Document a recommended format for inflight buffer
> >
> > V2 to V3:
> > - Using exisiting wait/nowait options to control connection on
> >   client sockets instead of introducing "disconnected" option.
> > - Support the case that vhost-user backend restart during initialzation
> >   of vhost-user-blk device.
> >
> > V1 to V2:
> > - Introduce "disconnected" option for chardev instead of reuse "wait"
> >   option
> > - Support the case that QEMU starts before vhost-user backend
> > - Drop message VHOST_USER_SET_VRING_INFLIGHT
> > - Introduce two new messages VHOST_USER_GET_SHM_SIZE
> >   and VHOST_USER_SET_SHM_FD
> >
> > Xie Yongji (7):
> >   char-socket: Enable "nowait" option on client sockets
>
> This patch breaks make check.
>
> It would be nice to add a test for the new nowait behaviour.
>

Oh, sorry. I'll fix this issue and add one test for "nowait" option. Thank =
you!

Thanks,
Yongji
