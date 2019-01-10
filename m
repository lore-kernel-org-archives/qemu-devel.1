Received: from eggs.gnu.org ([209.51.188.92]:45758)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1ghaFY-0001uk-Ob
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:19:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <elohimes@gmail.com>) id 1ghaFX-0001Jd-Su
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:19:56 -0500
Received: from mail-yb1-xb42.google.com ([2607:f8b0:4864:20::b42]:35724)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <elohimes@gmail.com>) id 1ghaFX-0001Hh-Nq
	for qemu-devel@nongnu.org; Thu, 10 Jan 2019 08:19:55 -0500
Received: by mail-yb1-xb42.google.com with SMTP id f187so4408746ybb.2
	for <qemu-devel@nongnu.org>; Thu, 10 Jan 2019 05:19:55 -0800 (PST)
MIME-Version: 1.0
References: <20190109112728.9214-1-xieyongji@baidu.com>
	<20190109112728.9214-2-xieyongji@baidu.com>
	<20190110124946.GL2178@redhat.com>
In-Reply-To: <20190110124946.GL2178@redhat.com>
From: Yongji Xie <elohimes@gmail.com>
Date: Thu, 10 Jan 2019 21:19:41 +0800
Message-ID: <CAONzpcZCTqN3CN1DBd6WdjKoTSr257Y2vOCuLOh9LBb-5K_hpg@mail.gmail.com>
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

On Thu, 10 Jan 2019 at 20:50, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> On Wed, Jan 09, 2019 at 07:27:22PM +0800, elohimes@gmail.com wrote:
> > From: Xie Yongji <xieyongji@baidu.com>
> >
> > Enable "nowait" option to make QEMU not do a connect
> > on client sockets during initialization of the chardev.
> > Then we can use qemu_chr_fe_wait_connected() to connect
> > when necessary. Now it would be used for unix domain
> > socket of vhost-user-blk device to support reconnect.
> >
> > Signed-off-by: Xie Yongji <xieyongji@baidu.com>
> > Signed-off-by: Zhang Yu <zhangyu31@baidu.com>
> > ---
> >  chardev/char-socket.c | 56 +++++++++++++++++++++----------------------
> >  qapi/char.json        |  3 +--
> >  qemu-options.hx       |  9 ++++---
> >  3 files changed, 35 insertions(+), 33 deletions(-)
> >
> > diff --git a/chardev/char-socket.c b/chardev/char-socket.c
> > index eaa8e8b68f..f803f4f7d3 100644
> > --- a/chardev/char-socket.c
> > +++ b/chardev/char-socket.c
> > @@ -1072,37 +1072,37 @@ static void qmp_chardev_open_socket(Chardev *ch=
r,
> >          s->reconnect_time =3D reconnect;
> >      }
> >
> > -    if (s->reconnect_time) {
> > -        tcp_chr_connect_async(chr);
> > -    } else {
> > -        if (s->is_listen) {
> > -            char *name;
> > -            s->listener =3D qio_net_listener_new();
> > +    if (s->is_listen) {
> > +        char *name;
> > +        s->listener =3D qio_net_listener_new();
> >
> > -            name =3D g_strdup_printf("chardev-tcp-listener-%s", chr->l=
abel);
> > -            qio_net_listener_set_name(s->listener, name);
> > -            g_free(name);
> > +        name =3D g_strdup_printf("chardev-tcp-listener-%s", chr->label=
);
> > +        qio_net_listener_set_name(s->listener, name);
> > +        g_free(name);
> >
> > -            if (qio_net_listener_open_sync(s->listener, s->addr, errp)=
 < 0) {
> > -                object_unref(OBJECT(s->listener));
> > -                s->listener =3D NULL;
> > -                goto error;
> > -            }
> > +        if (qio_net_listener_open_sync(s->listener, s->addr, errp) < 0=
) {
> > +            object_unref(OBJECT(s->listener));
> > +            s->listener =3D NULL;
> > +            goto error;
> > +        }
> >
> > -            qapi_free_SocketAddress(s->addr);
> > -            s->addr =3D socket_local_address(s->listener->sioc[0]->fd,=
 errp);
> > -            update_disconnected_filename(s);
> > +        qapi_free_SocketAddress(s->addr);
> > +        s->addr =3D socket_local_address(s->listener->sioc[0]->fd, err=
p);
> > +        update_disconnected_filename(s);
> >
> > -            if (is_waitconnect &&
> > -                qemu_chr_wait_connected(chr, errp) < 0) {
> > -                return;
> > -            }
> > -            if (!s->ioc) {
> > -                qio_net_listener_set_client_func_full(s->listener,
> > -                                                      tcp_chr_accept,
> > -                                                      chr, NULL,
> > -                                                      chr->gcontext);
> > -            }
> > +        if (is_waitconnect &&
> > +            qemu_chr_wait_connected(chr, errp) < 0) {
> > +            return;
> > +        }
> > +        if (!s->ioc) {
> > +            qio_net_listener_set_client_func_full(s->listener,
> > +                                                  tcp_chr_accept,
> > +                                                  chr, NULL,
> > +                                                  chr->gcontext);
> > +        }
> > +    } else if (is_waitconnect) {
> > +        if (s->reconnect_time) {
> > +            tcp_chr_connect_async(chr);
> >          } else if (qemu_chr_wait_connected(chr, errp) < 0) {
> >              goto error;
> >          }
>
> This skips everything when 'is_waitconnect' is false.
>
> This combines with a bug in tests/libqtest.c which adds the 'nowait'
> flag to the -chardevs it cteates. This mistake was previously ignored
> because the chardevs were socket clients, but now we honour it.
>
> We shoul remove 'nowait' from the qtest chardevs, but separately
> from that this code should also still attempt a non-blocking
> connect when is_waitconnect is false.
>

Do you mean we still need to connect server in background with
"nowait" option? But my purpose is not to connect server until we
manually call qemu_chr_fe_wait_connected() in other place.

> ie
>
>     } else if (is_waitconnect) {
>         if (s->reconnect_time || !is_waitconnect) {

"!is_waitconnect" should always be false here?

Thanks,
Yongji
