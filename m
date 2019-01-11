Received: from eggs.gnu.org ([209.51.188.92]:42610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1ghrah-0004kq-2f
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 02:50:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1ghraf-0002EW-DO
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 02:50:54 -0500
Received: from mail-yw1-xc43.google.com ([2607:f8b0:4864:20::c43]:45318)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1ghraf-0002Cm-3j
	for qemu-devel@nongnu.org; Fri, 11 Jan 2019 02:50:53 -0500
Received: by mail-yw1-xc43.google.com with SMTP id d190so5453216ywd.12
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 23:50:53 -0800 (PST)
MIME-Version: 1.0
References: <20190109112728.9214-1-xieyongji@baidu.com>
	<20190109112728.9214-2-xieyongji@baidu.com>
	<20190110124946.GL2178@redhat.com>
	<CAONzpcZCTqN3CN1DBd6WdjKoTSr257Y2vOCuLOh9LBb-5K_hpg@mail.gmail.com>
	<20190110132443.GM2178@redhat.com>
	<CAONzpcZ5HXP2-9PEZW=RwunviAcPL3kYosJhUWB0g09j=pf0oQ@mail.gmail.com>
	<20190110141125.GP2178@redhat.com>
	<CAONzpcY8LdzEEqourAjw5mZR9fjtjv20HqvyOvaWVoriD4Cbjg@mail.gmail.com>
	<20190110164125.GS2178@redhat.com>
In-Reply-To: <20190110164125.GS2178@redhat.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Fri, 11 Jan 2019 15:50:40 +0800
Message-ID: <CAONzpcb4hk87JhF0Cuz4xWDto5EOaKQSVPvegiUVF+2TbYGouw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 for-4.0 1/7] char-socket: Enable
 "nowait" option on client sockets
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, Jason Wang <jasowang@redhat.com>, "Coquelin,
	Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?UTF-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, qemu-devel <qemu-devel@nongnu.org>, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Fri, 11 Jan 2019 at 00:41, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Thu, Jan 10, 2019 at 10:29:20PM +0800, Yongji Xie wrote:
> > On Thu, 10 Jan 2019 at 22:11, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> > >
> > > On Thu, Jan 10, 2019 at 10:08:54PM +0800, Yongji Xie wrote:
> > > > On Thu, 10 Jan 2019 at 21:24, Daniel P. Berrang=C3=A9 <berrange@red=
hat.com> wrote:
> > > > >
> > > > > On Thu, Jan 10, 2019 at 09:19:41PM +0800, Yongji Xie wrote:
> > > > > > On Thu, 10 Jan 2019 at 20:50, Daniel P. Berrang=C3=A9 <berrange=
@redhat.com> wrote:
> > > > > > >
> > > > > > > On Wed, Jan 09, 2019 at 07:27:22PM +0800, elohimes@gmail.com =
wrote:
> > > > > > > > From: Xie Yongji <xieyongji@baidu.com>
> > > > > > > >
> > > > > > > > Enable "nowait" option to make QEMU not do a connect
> > > > > > > > on client sockets during initialization of the chardev.
> > > > > > > > Then we can use qemu_chr_fe_wait_connected() to connect
> > > > > > > > when necessary. Now it would be used for unix domain
> > > > > > > > socket of vhost-user-blk device to support reconnect.
> > > > > > > >
> > > > > > > > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > > > > > > > Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> > > > > > > > ---
> > > > > > > >  chardev/char-socket.c | 56 +++++++++++++++++++++----------=
------------
> > > > > > > >  qapi/char.json        |  3 +--
> > > > > > > >  qemu-options.hx       |  9 ++++---
> > > > > > > >  3 files changed, 35 insertions(+), 33 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > > > > > > > index eaa8e8b68f..f803f4f7d3 100644
> > > > > > > > --- a/chardev/char-socket.c
> > > > > > > > +++ b/chardev/char-socket.c
> > > > > > > > @@ -1072,37 +1072,37 @@ static void qmp_chardev_open_socket=
(Chardev *chr,
> > > > > > > >          s->reconnect_time =3D reconnect;
> > > > > > > >      }
> > > > > > > >
> > > > > > > > -    if (s->reconnect_time) {
> > > > > > > > -        tcp_chr_connect_async(chr);
> > > > > > > > -    } else {
> > > > > > > > -        if (s->is_listen) {
> > > > > > > > -            char *name;
> > > > > > > > -            s->listener =3D qio_net_listener_new();
> > > > > > > > +    if (s->is_listen) {
> > > > > > > > +        char *name;
> > > > > > > > +        s->listener =3D qio_net_listener_new();
> > > > > > > >
> > > > > > > > -            name =3D g_strdup_printf("chardev-tcp-listener=
-%s", chr->label);
> > > > > > > > -            qio_net_listener_set_name(s->listener, name);
> > > > > > > > -            g_free(name);
> > > > > > > > +        name =3D g_strdup_printf("chardev-tcp-listener-%s"=
, chr->label);
> > > > > > > > +        qio_net_listener_set_name(s->listener, name);
> > > > > > > > +        g_free(name);
> > > > > > > >
> > > > > > > > -            if (qio_net_listener_open_sync(s->listener, s-=
>addr, errp) < 0) {
> > > > > > > > -                object_unref(OBJECT(s->listener));
> > > > > > > > -                s->listener =3D NULL;
> > > > > > > > -                goto error;
> > > > > > > > -            }
> > > > > > > > +        if (qio_net_listener_open_sync(s->listener, s->add=
r, errp) < 0) {
> > > > > > > > +            object_unref(OBJECT(s->listener));
> > > > > > > > +            s->listener =3D NULL;
> > > > > > > > +            goto error;
> > > > > > > > +        }
> > > > > > > >
> > > > > > > > -            qapi_free_SocketAddress(s->addr);
> > > > > > > > -            s->addr =3D socket_local_address(s->listener->=
sioc[0]->fd, errp);
> > > > > > > > -            update_disconnected_filename(s);
> > > > > > > > +        qapi_free_SocketAddress(s->addr);
> > > > > > > > +        s->addr =3D socket_local_address(s->listener->sioc=
[0]->fd, errp);
> > > > > > > > +        update_disconnected_filename(s);
> > > > > > > >
> > > > > > > > -            if (is_waitconnect &&
> > > > > > > > -                qemu_chr_wait_connected(chr, errp) < 0) {
> > > > > > > > -                return;
> > > > > > > > -            }
> > > > > > > > -            if (!s->ioc) {
> > > > > > > > -                qio_net_listener_set_client_func_full(s->l=
istener,
> > > > > > > > -                                                      tcp_=
chr_accept,
> > > > > > > > -                                                      chr,=
 NULL,
> > > > > > > > -                                                      chr-=
>gcontext);
> > > > > > > > -            }
> > > > > > > > +        if (is_waitconnect &&
> > > > > > > > +            qemu_chr_wait_connected(chr, errp) < 0) {
> > > > > > > > +            return;
> > > > > > > > +        }
> > > > > > > > +        if (!s->ioc) {
> > > > > > > > +            qio_net_listener_set_client_func_full(s->liste=
ner,
> > > > > > > > +                                                  tcp_chr_=
accept,
> > > > > > > > +                                                  chr, NUL=
L,
> > > > > > > > +                                                  chr->gco=
ntext);
> > > > > > > > +        }
> > > > > > > > +    } else if (is_waitconnect) {
> > > > > > > > +        if (s->reconnect_time) {
> > > > > > > > +            tcp_chr_connect_async(chr);
> > > > > > > >          } else if (qemu_chr_wait_connected(chr, errp) < 0)=
 {
> > > > > > > >              goto error;
> > > > > > > >          }
> > > > > > >
> > > > > > > This skips everything when 'is_waitconnect' is false.
> > > > > > >
> > > > > > > This combines with a bug in tests/libqtest.c which adds the '=
nowait'
> > > > > > > flag to the -chardevs it cteates. This mistake was previously=
 ignored
> > > > > > > because the chardevs were socket clients, but now we honour i=
t.
> > > > > > >
> > > > > > > We shoul remove 'nowait' from the qtest chardevs, but separat=
ely
> > > > > > > from that this code should also still attempt a non-blocking
> > > > > > > connect when is_waitconnect is false.
> > > > > > >
> > > > > >
> > > > > > Do you mean we still need to connect server in background with
> > > > > > "nowait" option? But my purpose is not to connect server until =
we
> > > > > > manually call qemu_chr_fe_wait_connected() in other place.
> > > > >
> > > > > I don't see a need to delay the connect. We can start a
> > > > > background connect right away. The later code you have
> > > > > merely needs to wait for that background connect  to
> > > > > finish, which qemu_chr_fe_wait_connected still accomplishes.
> > > > > This keeps the chardev code clearer only having 2 distinct
> > > > > code paths to worry about - blocking or non-blocking connect.
> > > > >
> > > >
> > > > Now the problem is that we have a server that only accept one
> > > > connection. And we want to read something from it during device
> > > > initializtion.
> > > >
> > > > If background connect it before we call qemu_chr_fe_wait_connected(=
)
> > > > during device initializtion, qemu_chr_fe_wait_connected() will
> > > > accomplish but we can't read anything. And we have no way to releas=
e
> > > > the background connection. So what I want to do in this patch is to
> > > > disable background connect.
> > >
> > > I'm not seeing the problem here. What I proposed results in
> > >
> > >   1. chardev starts connect()
> >
> > This should be asynchronous with "reconnect" option. Another thread
> > may connect before vhost backend?
> >
> > >   2. vhost backend waits for connect() to complete
> >
> > Sorry, I'm not sure I get your point here. Do you mean vhost backend
> > call qemu_chr_fe_wait_connected()? Seems like
> > qemu_chr_fe_wait_connected() will connect directly rather than wait
> > for connect() to complete?
>
> Ahhhh, yes, you are right.
>
> qemu_chr_fe_wait_connected will potentially cause a second connection to
> be established
>
> Looking at it the qemu_chr_fe_wait_connected() I believe it is seriously
> broken even before this patch series.
>
> The intended usage is that a device can all qemu_chr_fe_wait_connected
> to wait for a new connection to be established, and then do I/O on the
> chardev.  This does not in fact work if TLS, websock or telnet modes
> are enabled for the socket, due to a mistake introduced when we previousl=
y
> tried to fix this:
>
>   commit 1dc8a6695c731abb7461c637b2512c3670d82be4
>   Author: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>   Date:   Tue Aug 16 12:33:32 2016 +0400
>
>     char: fix waiting for TLS and telnet connection
>
> That commit fixed the problem where we continued to accept() new sockets
> when TLS/telnet was enabled, because the 's->connected' flag isn't set
> immediately.
>
> Unfortunately what this means is that when qemu_chr_fe_wait_connected
> returns, the chardev is *not* ready to read/write data. The TLS/telnet
> handshake has not been run, and is still pending in the background.
>
> So we'll end up with device backend trying todo I/O on the chardev
> at the same time as it is trying todo the TLS/telnet handshake.
>
> We need to fix qemu_chr_fe_wait_connected so that it does explicit
> synchronization wrt to any ongoing background connection process.
> It must only return once all TLS/telnet/websock handshakes have
> completed.  If we fix that correctly, then I believe it will  also
> solve the problem you're trying to address.
>

Yes, I think this should be the right way to go. To fix it, my thought
is to track the async QIOChannelSocket in SocketChardev. Then we can
easily get the connection progress in qemu_chr_fe_wait_connected(). Do
you have any suggestion?

Thanks,
Yongji
