Received: from eggs.gnu.org ([209.51.188.92]:32966)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1ghY5p-0005fQ-Ma
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 06:01:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1ghY3o-0000Rr-2G
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:59:40 -0500
Received: from mail-yb1-xb44.google.com ([2607:f8b0:4864:20::b44]:46055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1ghY3n-0000RR-SF
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 05:59:40 -0500
Received: by mail-yb1-xb44.google.com with SMTP id q2so4238809ybd.12
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 02:59:39 -0800 (PST)
MIME-Version: 1.0
References: <20190109112728.9214-1-xieyongji@baidu.com>
	<20190110102551.GD19025@stefanha-x1.localdomain>
In-Reply-To: <20190110102551.GD19025@stefanha-x1.localdomain>
From: Yongji Xie <elohimes@gmail.com>
Date: Thu, 10 Jan 2019 18:59:27 +0800
Message-ID: <CAONzpcYgVWUFg1uSHOLzOS5en2vHP_=oNXQvWQEZd9FdYi2uxA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, Jason Wang <jasowang@redhat.com>, "Coquelin,
	Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, nixun@baidu.com, qemu-devel <qemu-devel@nongnu.org>, lilin24@baidu.com, zhangyu31@baidu.com, chaiwen@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Thu, 10 Jan 2019 at 18:25, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Wed, Jan 09, 2019 at 07:27:21PM +0800, elohimes@gmail.com wrote:
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
>
> Can you describe the problem that the inflight I/O shared memory region
> solves?
>

The backend need to get inflight I/O and do I/O replay after restart.
Now we can only get used_idx in used_ring. It's not enough. Because we
might not process descriptors in the same order which they have been
made available sometimes. A simple example:
https://patchwork.kernel.org/cover/10715305/#22375607. So we need a
shared memory to track inflight I/O.

Thanks,
Yongji
