Received: from eggs.gnu.org ([2001:4830:134:3::10]:40335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gPRXi-0006ln-UL
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 07:23:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gPRXe-0000CX-MQ
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 07:23:42 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54586)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gPRXe-0000Ba-DM
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 07:23:38 -0500
Date: Wed, 21 Nov 2018 07:23:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181121072237-mutt-send-email-mst@kernel.org>
References: <1542799319-2595-1-git-send-email-liq3ea@gmail.com>
	<CAJ+F1C+FQ8WWkrw3Qup-DzyryZZ3UqHdomjzY=-kfCiHcvLWEw@mail.gmail.com>
	<20181121115718.GN26577@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20181121115718.GN26577@redhat.com>
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
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>, Li Qiang <liq3ea@gmail.com>, Jason Wang <jasowang@redhat.com>, QEMU <qemu-devel@nongnu.org>

On Wed, Nov 21, 2018 at 11:57:18AM +0000, Daniel P. Berrang=E9 wrote:
> On Wed, Nov 21, 2018 at 03:28:29PM +0400, Marc-Andr=E9 Lureau wrote:
> > Hi
> >=20
> > On Wed, Nov 21, 2018 at 3:22 PM Li Qiang <liq3ea@gmail.com> wrote:
> > >
> > > The fcntl will change the flags directly, use qemu_set_nonblock()
> > > instead.
> >=20
> > qemu_set_nonblock() will preserve the existing flags. And on windows,
> > it will register the FD to the event loop.
> > that's a reasonable thing to do, is this fixing an actual bug?
>=20
> tap.c is only built with CONFIG_POSIX. Win32 is completely separate
> in tap-win32.c.  So the event loop reg doesn't apply.
>=20
> I agree it is good to preserve fcntl flags though, so this patch
> looks desirable.
>=20
> Reviewed-by: Daniel P. Berrang=E9 <berrange@redhat.com>

Sure

Acked-by: Michael S. Tsirkin <mst@redhat.com>

but really not for this release I guess as we are in freeze.
So thanks! And pls remember to ping after the release.


>=20
> >=20
> > >
> > > Signed-off-by: Li Qiang <liq3ea@gmail.com>
> > > ---
> > >  net/tap.c | 10 +++++-----
> > >  1 file changed, 5 insertions(+), 5 deletions(-)
> > >
> > > diff --git a/net/tap.c b/net/tap.c
> > > index cc8525f154..e8aadd8d4b 100644
> > > --- a/net/tap.c
> > > +++ b/net/tap.c
> > > @@ -592,7 +592,7 @@ int net_init_bridge(const Netdev *netdev, const=
 char *name,
> > >          return -1;
> > >      }
> > >
> > > -    fcntl(fd, F_SETFL, O_NONBLOCK);
> > > +    qemu_set_nonblock(fd);
> > >      vnet_hdr =3D tap_probe_vnet_hdr(fd);
> > >      s =3D net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr);
> > >
> > > @@ -707,7 +707,7 @@ static void net_init_tap_one(const NetdevTapOpt=
ions *tap, NetClientState *peer,
> > >                  }
> > >                  return;
> > >              }
> > > -            fcntl(vhostfd, F_SETFL, O_NONBLOCK);
> > > +            qemu_set_nonblock(vhostfd);
> > >          }
> > >          options.opaque =3D (void *)(uintptr_t)vhostfd;
> > >
> > > @@ -791,7 +791,7 @@ int net_init_tap(const Netdev *netdev, const ch=
ar *name,
> > >              return -1;
> > >          }
> > >
> > > -        fcntl(fd, F_SETFL, O_NONBLOCK);
> > > +        qemu_set_nonblock(fd);
> > >
> > >          vnet_hdr =3D tap_probe_vnet_hdr(fd);
> > >
> > > @@ -839,7 +839,7 @@ int net_init_tap(const Netdev *netdev, const ch=
ar *name,
> > >                  goto free_fail;
> > >              }
> > >
> > > -            fcntl(fd, F_SETFL, O_NONBLOCK);
> > > +            qemu_set_nonblock(fd);
> > >
> > >              if (i =3D=3D 0) {
> > >                  vnet_hdr =3D tap_probe_vnet_hdr(fd);
> > > @@ -887,7 +887,7 @@ free_fail:
> > >              return -1;
> > >          }
> > >
> > > -        fcntl(fd, F_SETFL, O_NONBLOCK);
> > > +        qemu_set_nonblock(fd);
> > >          vnet_hdr =3D tap_probe_vnet_hdr(fd);
> > >
> > >          net_init_tap_one(tap, peer, "bridge", name, ifname,
> > > --
> > > 2.11.0
> > >
> > >
> >=20
> >=20
> > --=20
> > Marc-Andr=E9 Lureau
> >=20
>=20
> Regards,
> Daniel
> --=20
> |: https://berrange.com      -o-    https://www.flickr.com/photos/dberr=
ange :|
> |: https://libvirt.org         -o-            https://fstop138.berrange=
.com :|
> |: https://entangle-photo.org    -o-    https://www.instagram.com/dberr=
ange :|
