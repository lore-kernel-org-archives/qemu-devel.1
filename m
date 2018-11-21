Received: from eggs.gnu.org ([2001:4830:134:3::10]:52423)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gPQgW-0000xO-AY
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:28:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gPQgV-0006er-Ba
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:28:44 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40454)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <marcandre.lureau@gmail.com>)
	id 1gPQgV-0006ck-30
	for qemu-devel@nongnu.org; Wed, 21 Nov 2018 06:28:43 -0500
Received: by mail-wr1-x444.google.com with SMTP id p4so5290010wrt.7
	for <qemu-devel@nongnu.org>; Wed, 21 Nov 2018 03:28:42 -0800 (PST)
MIME-Version: 1.0
References: <1542799319-2595-1-git-send-email-liq3ea@gmail.com>
In-Reply-To: <1542799319-2595-1-git-send-email-liq3ea@gmail.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 21 Nov 2018 15:28:29 +0400
Message-ID: <CAJ+F1C+FQ8WWkrw3Qup-DzyryZZ3UqHdomjzY=-kfCiHcvLWEw@mail.gmail.com>
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
To: Li Qiang <liq3ea@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, QEMU <qemu-devel@nongnu.org>

Hi

On Wed, Nov 21, 2018 at 3:22 PM Li Qiang <liq3ea@gmail.com> wrote:
>
> The fcntl will change the flags directly, use qemu_set_nonblock()
> instead.

qemu_set_nonblock() will preserve the existing flags. And on windows,
it will register the FD to the event loop.
that's a reasonable thing to do, is this fixing an actual bug?

>
> Signed-off-by: Li Qiang <liq3ea@gmail.com>
> ---
>  net/tap.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
>
> diff --git a/net/tap.c b/net/tap.c
> index cc8525f154..e8aadd8d4b 100644
> --- a/net/tap.c
> +++ b/net/tap.c
> @@ -592,7 +592,7 @@ int net_init_bridge(const Netdev *netdev, const char =
*name,
>          return -1;
>      }
>
> -    fcntl(fd, F_SETFL, O_NONBLOCK);
> +    qemu_set_nonblock(fd);
>      vnet_hdr =3D tap_probe_vnet_hdr(fd);
>      s =3D net_tap_fd_init(peer, "bridge", name, fd, vnet_hdr);
>
> @@ -707,7 +707,7 @@ static void net_init_tap_one(const NetdevTapOptions *=
tap, NetClientState *peer,
>                  }
>                  return;
>              }
> -            fcntl(vhostfd, F_SETFL, O_NONBLOCK);
> +            qemu_set_nonblock(vhostfd);
>          }
>          options.opaque =3D (void *)(uintptr_t)vhostfd;
>
> @@ -791,7 +791,7 @@ int net_init_tap(const Netdev *netdev, const char *na=
me,
>              return -1;
>          }
>
> -        fcntl(fd, F_SETFL, O_NONBLOCK);
> +        qemu_set_nonblock(fd);
>
>          vnet_hdr =3D tap_probe_vnet_hdr(fd);
>
> @@ -839,7 +839,7 @@ int net_init_tap(const Netdev *netdev, const char *na=
me,
>                  goto free_fail;
>              }
>
> -            fcntl(fd, F_SETFL, O_NONBLOCK);
> +            qemu_set_nonblock(fd);
>
>              if (i =3D=3D 0) {
>                  vnet_hdr =3D tap_probe_vnet_hdr(fd);
> @@ -887,7 +887,7 @@ free_fail:
>              return -1;
>          }
>
> -        fcntl(fd, F_SETFL, O_NONBLOCK);
> +        qemu_set_nonblock(fd);
>          vnet_hdr =3D tap_probe_vnet_hdr(fd);
>
>          net_init_tap_one(tap, peer, "bridge", name, ifname,
> --
> 2.11.0
>
>


--=20
Marc-Andr=C3=A9 Lureau
