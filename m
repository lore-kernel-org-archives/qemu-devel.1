Received: from eggs.gnu.org ([209.51.188.92]:57991)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghb4G-0005zK-My
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:12:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1ghb3e-0000y2-40
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:11:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36922)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1ghb3d-0000xr-Rp
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 09:11:42 -0500
Date: Thu, 10 Jan 2019 14:11:25 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20190110141125.GP2178@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20190109112728.9214-1-xieyongji@baidu.com>
	<20190109112728.9214-2-xieyongji@baidu.com>
	<20190110124946.GL2178@redhat.com>
	<CAONzpcZCTqN3CN1DBd6WdjKoTSr257Y2vOCuLOh9LBb-5K_hpg@mail.gmail.com>
	<20190110132443.GM2178@redhat.com>
	<CAONzpcZ5HXP2-9PEZW=RwunviAcPL3kYosJhUWB0g09j=pf0oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAONzpcZ5HXP2-9PEZW=RwunviAcPL3kYosJhUWB0g09j=pf0oQ@mail.gmail.com>
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
To: Yongji Xie <elohimes@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Jason Wang <jasowang@redhat.com>, "Coquelin, Maxime" <maxime.coquelin@redhat.com>, Yury Kotov <yury-kotov@yandex-team.ru>, =?utf-8?B?0JXQstCz0LXQvdC40Lkg0K/QutC+0LLQu9C10LI=?= <wrfsh@yandex-team.ru>, qemu-devel <qemu-devel@nongnu.org>, zhangyu31@baidu.com, chaiwen@baidu.com, nixun@baidu.com, lilin24@baidu.com, Xie Yongji <xieyongji@baidu.com>

On Thu, Jan 10, 2019 at 10:08:54PM +0800, Yongji Xie wrote:
> On Thu, 10 Jan 2019 at 21:24, Daniel P. Berrang=C3=A9 <berrange@redhat.=
com> wrote:
> >
> > On Thu, Jan 10, 2019 at 09:19:41PM +0800, Yongji Xie wrote:
> > > On Thu, 10 Jan 2019 at 20:50, Daniel P. Berrang=C3=A9 <berrange@red=
hat.com> wrote:
> > > >
> > > > On Wed, Jan 09, 2019 at 07:27:22PM +0800, elohimes@gmail.com wrot=
e:
> > > > > From: Xie Yongji <xieyongji@baidu.com>
> > > > >
> > > > > Enable "nowait" option to make QEMU not do a connect
> > > > > on client sockets during initialization of the chardev.
> > > > > Then we can use qemu_chr_fe_wait_connected() to connect
> > > > > when necessary. Now it would be used for unix domain
> > > > > socket of vhost-user-blk device to support reconnect.
> > > > >
> > > > > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > > > > Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> > > > > ---
> > > > >  chardev/char-socket.c | 56 +++++++++++++++++++++--------------=
--------
> > > > >  qapi/char.json        |  3 +--
> > > > >  qemu-options.hx       |  9 ++++---
> > > > >  3 files changed, 35 insertions(+), 33 deletions(-)
> > > > >
> > > > > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > > > > index eaa8e8b68f..f803f4f7d3 100644
> > > > > --- a/chardev/char-socket.c
> > > > > +++ b/chardev/char-socket.c
> > > > > @@ -1072,37 +1072,37 @@ static void qmp_chardev_open_socket(Cha=
rdev *chr,
> > > > >          s->reconnect_time =3D reconnect;
> > > > >      }
> > > > >
> > > > > -    if (s->reconnect_time) {
> > > > > -        tcp_chr_connect_async(chr);
> > > > > -    } else {
> > > > > -        if (s->is_listen) {
> > > > > -            char *name;
> > > > > -            s->listener =3D qio_net_listener_new();
> > > > > +    if (s->is_listen) {
> > > > > +        char *name;
> > > > > +        s->listener =3D qio_net_listener_new();
> > > > >
> > > > > -            name =3D g_strdup_printf("chardev-tcp-listener-%s"=
, chr->label);
> > > > > -            qio_net_listener_set_name(s->listener, name);
> > > > > -            g_free(name);
> > > > > +        name =3D g_strdup_printf("chardev-tcp-listener-%s", ch=
r->label);
> > > > > +        qio_net_listener_set_name(s->listener, name);
> > > > > +        g_free(name);
> > > > >
> > > > > -            if (qio_net_listener_open_sync(s->listener, s->add=
r, errp) < 0) {
> > > > > -                object_unref(OBJECT(s->listener));
> > > > > -                s->listener =3D NULL;
> > > > > -                goto error;
> > > > > -            }
> > > > > +        if (qio_net_listener_open_sync(s->listener, s->addr, e=
rrp) < 0) {
> > > > > +            object_unref(OBJECT(s->listener));
> > > > > +            s->listener =3D NULL;
> > > > > +            goto error;
> > > > > +        }
> > > > >
> > > > > -            qapi_free_SocketAddress(s->addr);
> > > > > -            s->addr =3D socket_local_address(s->listener->sioc=
[0]->fd, errp);
> > > > > -            update_disconnected_filename(s);
> > > > > +        qapi_free_SocketAddress(s->addr);
> > > > > +        s->addr =3D socket_local_address(s->listener->sioc[0]-=
>fd, errp);
> > > > > +        update_disconnected_filename(s);
> > > > >
> > > > > -            if (is_waitconnect &&
> > > > > -                qemu_chr_wait_connected(chr, errp) < 0) {
> > > > > -                return;
> > > > > -            }
> > > > > -            if (!s->ioc) {
> > > > > -                qio_net_listener_set_client_func_full(s->liste=
ner,
> > > > > -                                                      tcp_chr_=
accept,
> > > > > -                                                      chr, NUL=
L,
> > > > > -                                                      chr->gco=
ntext);
> > > > > -            }
> > > > > +        if (is_waitconnect &&
> > > > > +            qemu_chr_wait_connected(chr, errp) < 0) {
> > > > > +            return;
> > > > > +        }
> > > > > +        if (!s->ioc) {
> > > > > +            qio_net_listener_set_client_func_full(s->listener,
> > > > > +                                                  tcp_chr_acce=
pt,
> > > > > +                                                  chr, NULL,
> > > > > +                                                  chr->gcontex=
t);
> > > > > +        }
> > > > > +    } else if (is_waitconnect) {
> > > > > +        if (s->reconnect_time) {
> > > > > +            tcp_chr_connect_async(chr);
> > > > >          } else if (qemu_chr_wait_connected(chr, errp) < 0) {
> > > > >              goto error;
> > > > >          }
> > > >
> > > > This skips everything when 'is_waitconnect' is false.
> > > >
> > > > This combines with a bug in tests/libqtest.c which adds the 'nowa=
it'
> > > > flag to the -chardevs it cteates. This mistake was previously ign=
ored
> > > > because the chardevs were socket clients, but now we honour it.
> > > >
> > > > We shoul remove 'nowait' from the qtest chardevs, but separately
> > > > from that this code should also still attempt a non-blocking
> > > > connect when is_waitconnect is false.
> > > >
> > >
> > > Do you mean we still need to connect server in background with
> > > "nowait" option? But my purpose is not to connect server until we
> > > manually call qemu_chr_fe_wait_connected() in other place.
> >
> > I don't see a need to delay the connect. We can start a
> > background connect right away. The later code you have
> > merely needs to wait for that background connect  to
> > finish, which qemu_chr_fe_wait_connected still accomplishes.
> > This keeps the chardev code clearer only having 2 distinct
> > code paths to worry about - blocking or non-blocking connect.
> >
>=20
> Now the problem is that we have a server that only accept one
> connection. And we want to read something from it during device
> initializtion.
>=20
> If background connect it before we call qemu_chr_fe_wait_connected()
> during device initializtion, qemu_chr_fe_wait_connected() will
> accomplish but we can't read anything. And we have no way to release
> the background connection. So what I want to do in this patch is to
> disable background connect.

I'm not seeing the problem here. What I proposed results in=20

  1. chardev starts connect()
  2. vhost backend waits for connect() to complete
  3. vhost backend reads from chardev

vs the flow

  1. vhost backend starts connect()
  2. vhost backend waits for connect() to complete
  3. vhost backend reads from chardev

in both cases there's only a single connection established to the
server

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
