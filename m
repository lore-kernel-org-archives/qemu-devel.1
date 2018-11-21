Received: from eggs.gnu.org ([2001:4830:134:3::10]:54755)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gPQmd-0003fQ-5L
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:35:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1gPQmc-0007c0-9v
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:35:03 -0500
Received: from mail-it1-x144.google.com ([2607:f8b0:4864:20::144]:54426)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1gPQmc-0007am-1m
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:35:02 -0500
Received: by mail-it1-x144.google.com with SMTP id a205-v6so8282347itd.4
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 03:35:01 -0800 (PST)
MIME-Version: 1.0
References: <1542799319-2595-1-git-send-email-liq3ea@gmail.com>
	<CAJ+F1C+FQ8WWkrw3Qup-DzyryZZ3UqHdomjzY=-kfCiHcvLWEw@mail.gmail.com>
In-Reply-To: <CAJ+F1C+FQ8WWkrw3Qup-DzyryZZ3UqHdomjzY=-kfCiHcvLWEw@mail.gmail.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 21 Nov 2018 19:34:25 +0800
Message-ID: <CAKXe6SL_CNQ1xoyDM8Lx9FGVhGrAsCUFh=6ujx2ESPp6YUxkxw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] net: tap: use qemu_set_nonblock
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, mst@redhat.com, Qemu Developers <qemu-devel@nongnu.org>

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> =E4=BA=8E2018=E5=B9=B41=
1=E6=9C=8821=E6=97=A5=E5=91=A8=E4=B8=89 =E4=B8=8B=E5=8D=887:28=E5=86=99=E9=
=81=93=EF=BC=9A

> Hi
>
> On Wed, Nov 21, 2018 at 3:22 PM Li Qiang <liq3ea@gmail.com> wrote:
> >
> > The fcntl will change the flags directly, use qemu_set_nonblock()
> > instead.
>
> qemu_set_nonblock() will preserve the existing flags. And on windows,
> it will register the FD to the event loop.
>

Oh, I don't consider the windows behavior. I'm not sure is this the
expected behavior.


> that's a reasonable thing to do, is this fixing an actual bug?
>

No, I just think there is no reason to change other flags in linux.

Thanks,
Li Qiang


>
> >
> > Signed-off-by: Li Qiang <liq3ea@gmail.com>
> > ---
> >  net/tap.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/net/tap.c b/net/tap.c
> > index cc8525f154..e8aadd8d4b 100644
> > --- a/net/tap.c
> > +++ b/net/tap.c
> > @@ -592,7 +592,7 @@ int net_init_bridge(const Netdev *netdev, const cha=
r
> *name,
> >          return -1;
> >      }
> >
> > -    fcntl(fd, F_SETFL, O_NONBLOCK);
> > +    qemu_set_nonblock(fd);
> >      vnet_hdr =3D tap_probe_vnet_hdr(fd);
> >      s =3D net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr);
> >
> > @@ -707,7 +707,7 @@ static void net_init_tap_one(const NetdevTapOptions
> *tap, NetClientState *peer,
> >                  }
> >                  return;
> >              }
> > -            fcntl(vhostfd, F_SETFL, O_NONBLOCK);
> > +            qemu_set_nonblock(vhostfd);
> >          }
> >          options.opaque =3D (void *)(uintptr_t)vhostfd;
> >
> > @@ -791,7 +791,7 @@ int net_init_tap(const Netdev *netdev, const char
> *name,
> >              return -1;
> >          }
> >
> > -        fcntl(fd, F_SETFL, O_NONBLOCK);
> > +        qemu_set_nonblock(fd);
> >
> >          vnet_hdr =3D tap_probe_vnet_hdr(fd);
> >
> > @@ -839,7 +839,7 @@ int net_init_tap(const Netdev *netdev, const char
> *name,
> >                  goto free_fail;
> >              }
> >
> > -            fcntl(fd, F_SETFL, O_NONBLOCK);
> > +            qemu_set_nonblock(fd);
> >
> >              if (i =3D=3D 0) {
> >                  vnet_hdr =3D tap_probe_vnet_hdr(fd);
> > @@ -887,7 +887,7 @@ free_fail:
> >              return -1;
> >          }
> >
> > -        fcntl(fd, F_SETFL, O_NONBLOCK);
> > +        qemu_set_nonblock(fd);
> >          vnet_hdr =3D tap_probe_vnet_hdr(fd);
> >
> >          net_init_tap_one(tap, peer, "bridge", name, ifname,
> > --
> > 2.11.0
> >
> >
>
>
> --
> Marc-Andr=C3=A9 Lureau
>
