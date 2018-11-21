Received: from eggs.gnu.org ([2001:4830:134:3::10]:36413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gPRLq-0006qm-Cj
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 07:11:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1gPR8L-0008OH-6d
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:57:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1gPR8K-0008Ki-BH
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:57:29 -0500
Date: Wed, 21 Nov 2018 11:57:18 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20181121115718.GN26577@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <1542799319-2595-1-git-send-email-liq3ea@gmail.com>
	<CAJ+F1C+FQ8WWkrw3Qup-DzyryZZ3UqHdomjzY=-kfCiHcvLWEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+FQ8WWkrw3Qup-DzyryZZ3UqHdomjzY=-kfCiHcvLWEw@mail.gmail.com>
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
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Li Qiang <liq3ea@gmail.com>, Jason Wang <jasowang@redhat.com>, QEMU <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>

On Wed, Nov 21, 2018 at 03:28:29PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Nov 21, 2018 at 3:22 PM Li Qiang <liq3ea@gmail.com> wrote:
> >
> > The fcntl will change the flags directly, use qemu_set_nonblock()
> > instead.
>=20
> qemu_set_nonblock() will preserve the existing flags. And on windows,
> it will register the FD to the event loop.
> that's a reasonable thing to do, is this fixing an actual bug?

tap.c is only built with CONFIG_POSIX. Win32 is completely separate
in tap-win32.c.  So the event loop reg doesn't apply.

I agree it is good to preserve fcntl flags though, so this patch
looks desirable.

Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>


>=20
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
> > @@ -592,7 +592,7 @@ int net_init_bridge(const Netdev *netdev, const c=
har *name,
> >          return -1;
> >      }
> >
> > -    fcntl(fd, F_SETFL, O_NONBLOCK);
> > +    qemu_set_nonblock(fd);
> >      vnet_hdr =3D tap_probe_vnet_hdr(fd);
> >      s =3D net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr);
> >
> > @@ -707,7 +707,7 @@ static void net_init_tap_one(const NetdevTapOptio=
ns *tap, NetClientState *peer,
> >                  }
> >                  return;
> >              }
> > -            fcntl(vhostfd, F_SETFL, O_NONBLOCK);
> > +            qemu_set_nonblock(vhostfd);
> >          }
> >          options.opaque =3D (void *)(uintptr_t)vhostfd;
> >
> > @@ -791,7 +791,7 @@ int net_init_tap(const Netdev *netdev, const char=
 *name,
> >              return -1;
> >          }
> >
> > -        fcntl(fd, F_SETFL, O_NONBLOCK);
> > +        qemu_set_nonblock(fd);
> >
> >          vnet_hdr =3D tap_probe_vnet_hdr(fd);
> >
> > @@ -839,7 +839,7 @@ int net_init_tap(const Netdev *netdev, const char=
 *name,
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
>=20
>=20
> --=20
> Marc-Andr=C3=A9 Lureau
>=20

Regards,
Daniel
--=20
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberran=
ge :|
|: https://libvirt.org         -o-            https://fstop138.berrange.c=
om :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberran=
ge :|
