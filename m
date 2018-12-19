Received: from eggs.gnu.org ([2001:4830:134:3::10]:37766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gZXjd-0005Ej-1M
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:01:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gZXjY-0004Wl-PU
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:01:43 -0500
Received: from mail-yb1-xb43.google.com ([2607:f8b0:4864:20::b43]:33940)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gZXjY-0004Ue-Jf
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 04:01:40 -0500
Received: by mail-yb1-xb43.google.com with SMTP id k136so7627228ybk.1
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 01:01:37 -0800 (PST)
MIME-Version: 1.0
References: <20181218100002.11219-1-xieyongji@baidu.com>
	<20181218100002.11219-2-xieyongji@baidu.com>
	<CAMxuvawx1GXar_UX5Pa_JEEW7EFnG092_PZGKiUL73wtd+s7cg@mail.gmail.com>
	<20181218152520.GB4807@redhat.com>
	<20181218104351-mutt-send-email-mst@kernel.org>
	<20181218160919.GD4807@redhat.com>
In-Reply-To: <20181218160919.GD4807@redhat.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Wed, 19 Dec 2018 17:01:25 +0800
Message-ID: <CAONzpcY9zRffMqN1mDGNcXQ-GmKdxErwXjk2RuZwd3z3VDsztw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 for-4.0 1/7] chardev: Add disconnected
 option for chardev socket
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, zhangyu31@baidu.com, Xie Yongji <xieyongji@baidu.com>, Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, lilin24@baidu.com, Yury Kotov <yury-kotov@yandex-team.ru>, "Coquelin,
	Maxime" <maxime.coquelin@redhat.com>, chaiwen@baidu.com, nixun@baidu.com

On Wed, 19 Dec 2018 at 00:09, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Tue, Dec 18, 2018 at 11:02:46AM -0500, Michael S. Tsirkin wrote:
> > On Tue, Dec 18, 2018 at 03:25:20PM +0000, Daniel P. Berrang=C3=A9 wrote=
:
> > > On Tue, Dec 18, 2018 at 04:24:26PM +0400, Marc-Andr=C3=A9 Lureau wrot=
e:
> > > > Hi
> > > >
> > > > On Tue, Dec 18, 2018 at 2:01 PM <elohimes@gmail.com> wrote:
> > > > >
> > > > > From: Xie Yongji <xieyongji@baidu.com>
> > > > >
> > > > > New option "disconnected" is added to init the chardev socket
> > > > > in disconnected state. Then we can use qemu_chr_fe_wait_connected=
()
> > > > > to connect when necessary. Now it would be used for unix domain
> > > > > socket of vhost-user-blk device to support reconnect.
> > > >
> > > > What difference does that make if you wait for connection in
> > > > qemu_chr_fe_wait_connected(), or during chardev setup?
> > > >
> > > > "disconnected" is misleading, would it be possible to reuse
> > > > "wait/nowait" instead?
> > >
> > > Currently we default to doing a blocking connect in foreground,
> > > except if reconnect is non-zero, in which case we do a connect
> > > async in the background. This "disconnected" proposal effectively
> > > does a blocking connect, but delayed to later in startup.
> > >
> > > IOW, this could already be achieved if "reconnect" were set to
> > > non-zero. If the usage doesn't want reconnect though, I tend
> > > to agree that we should use the exisiting wait/nowait options
> > > to let it be controlled. I don't see that this "disconnected"
> > > option gives a compelling benefit over using wait/nowait.
> >
> > So the tricky thing is that we can not expose the
> > device to guest until we get a connection and can query
> > it for the first time. After that is completed,
> > we can reasonably support disconnected operation at least for net.
>
> The device code would still use  qemu_chr_fe_wait_connected() in my propo=
sal,
> so that its no different to the situation with the proposed "disconnected=
"
> flag.
>

I considered resuing wait/nowait before. One problem is that we will
have a thread to do connect async if backend is not started during
chardev setup.
Then if we use qemu_chr_fe_wait_connected() manually to connect in
device code, we may have some conflict in main thread like:

qemu_chr_fe_wait_connected()
 tcp_chr_wait_connected()
  tcp_chr_connect()
   s->connected =3D 1;

    qemu_chr_socket_connected()
     check_report_connect_error()
      qemu_chr_socket_restart_timer()
       assert(s->connected =3D=3D 0) /* qemu crash */

Thanks,
Yongji
