Received: from eggs.gnu.org ([2001:4830:134:3::10]:46737)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gZpuM-0000aD-EW
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 23:26:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1gZpuL-0000JR-Fw
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 23:26:02 -0500
Received: from mail-yw1-xc44.google.com ([2607:f8b0:4864:20::c44]:35774)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1gZpuL-0000IQ-Ac
	for qemu-devel@nongnu.org; Wed, 19 Dec 2018 23:26:01 -0500
Received: by mail-yw1-xc44.google.com with SMTP id h32so171302ywk.2
	for <qemu-devel@nongnu.org>; Wed, 19 Dec 2018 20:26:00 -0800 (PST)
MIME-Version: 1.0
References: <20181218100002.11219-1-xieyongji@baidu.com>
	<20181218100002.11219-2-xieyongji@baidu.com>
	<CAMxuvawx1GXar_UX5Pa_JEEW7EFnG092_PZGKiUL73wtd+s7cg@mail.gmail.com>
	<20181218152520.GB4807@redhat.com>
	<20181218104351-mutt-send-email-mst@kernel.org>
	<20181218160919.GD4807@redhat.com>
	<20181219105418-mutt-send-email-mst@kernel.org>
In-Reply-To: <20181219105418-mutt-send-email-mst@kernel.org>
From: Yongji Xie <elohimes@gmail.com>
Date: Thu, 20 Dec 2018 12:25:47 +0800
Message-ID: <CAONzpcY5L4xpGwBgFOdEAYW3RQoXFy9QpTSf1Er3EijXhgCr_A@mail.gmail.com>
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, zhangyu31@baidu.com, Xie Yongji <xieyongji@baidu.com>, Jason Wang <jasowang@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, lilin24@baidu.com, Yury Kotov <yury-kotov@yandex-team.ru>, "Coquelin,
	Maxime" <maxime.coquelin@redhat.com>, chaiwen@baidu.com, nixun@baidu.com

On Wed, 19 Dec 2018 at 23:55, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Dec 18, 2018 at 04:09:19PM +0000, Daniel P. Berrang=C3=A9 wrote:
> > On Tue, Dec 18, 2018 at 11:02:46AM -0500, Michael S. Tsirkin wrote:
> > > On Tue, Dec 18, 2018 at 03:25:20PM +0000, Daniel P. Berrang=C3=A9 wro=
te:
> > > > On Tue, Dec 18, 2018 at 04:24:26PM +0400, Marc-Andr=C3=A9 Lureau wr=
ote:
> > > > > Hi
> > > > >
> > > > > On Tue, Dec 18, 2018 at 2:01 PM <elohimes@gmail.com> wrote:
> > > > > >
> > > > > > From: Xie Yongji <xieyongji@baidu.com>
> > > > > >
> > > > > > New option "disconnected" is added to init the chardev socket
> > > > > > in disconnected state. Then we can use qemu_chr_fe_wait_connect=
ed()
> > > > > > to connect when necessary. Now it would be used for unix domain
> > > > > > socket of vhost-user-blk device to support reconnect.
> > > > >
> > > > > What difference does that make if you wait for connection in
> > > > > qemu_chr_fe_wait_connected(), or during chardev setup?
> > > > >
> > > > > "disconnected" is misleading, would it be possible to reuse
> > > > > "wait/nowait" instead?
> > > >
> > > > Currently we default to doing a blocking connect in foreground,
> > > > except if reconnect is non-zero, in which case we do a connect
> > > > async in the background. This "disconnected" proposal effectively
> > > > does a blocking connect, but delayed to later in startup.
> > > >
> > > > IOW, this could already be achieved if "reconnect" were set to
> > > > non-zero. If the usage doesn't want reconnect though, I tend
> > > > to agree that we should use the exisiting wait/nowait options
> > > > to let it be controlled. I don't see that this "disconnected"
> > > > option gives a compelling benefit over using wait/nowait.
> > >
> > > So the tricky thing is that we can not expose the
> > > device to guest until we get a connection and can query
> > > it for the first time. After that is completed,
> > > we can reasonably support disconnected operation at least for net.
> >
> > The device code would still use  qemu_chr_fe_wait_connected() in my pro=
posal,
> > so that its no different to the situation with the proposed "disconnect=
ed"
> > flag.
> >
> > Regards,
> > Daniel
>
> I guess so, but wouldn't it be confusing to users that one says
> "nowait" and qemu still waits for a connection and does not
> run the VM? That's different from how nowait behaves normally.
>

With this patch:

diff --git a/chardev/char-socket.c b/chardev/char-socket.c
index 2464d7a..ffe3a60 100644
--- a/chardev/char-socket.c
+++ b/chardev/char-socket.c
@@ -97,7 +97,10 @@ static void qemu_chr_socket_restart_timer(Chardev *chr)
     SocketChardev *s =3D SOCKET_CHARDEV(chr);
     char *name;

-    assert(s->connected =3D=3D 0);
+    if (s->connected) {
+        return;
+    }
+
     name =3D g_strdup_printf("chardev-socket-reconnect-%s", chr->label);
     s->reconnect_timer =3D qemu_chr_timeout_add_ms(chr,
                                                  s->reconnect_time * 1000,

We can use qemu_chr_fe_wait_connected() without adding redundant
"wait" or "disconnected" option.
The disadavantage is that backend may have two connection from qemu
during initialization. But I think backend should support this case.

Thanks,
Yongji
