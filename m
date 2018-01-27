Received: from eggs.gnu.org ([2001:4830:134:3::10]:40026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1efG1d-0003YX-7a
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:15:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <samuel.thibault@ens-lyon.org>) id 1efG1c-0006SW-0s
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:15:25 -0500
Received: from hera.aquilenet.fr ([2a0c:e300::1]:35978)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <samuel.thibault@ens-lyon.org>)
	id 1efG1b-0006R6-Gz
	for qemu-devel@nongnu.org; Fri, 26 Jan 2018 21:15:23 -0500
Date: Sat, 27 Jan 2018 03:15:19 +0100
From: Samuel Thibault <samuel.thibault@gnu.org>
Message-ID: <20180127021519.owj7hsn43zzt4jst@var.youpi.perso.aquilenet.fr>
References: <20180126183636.7586-1-samuel.thibault@ens-lyon.org>
	<11f250c0-ce8e-3529-bbf2-d6275e0c1747@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11f250c0-ce8e-3529-bbf2-d6275e0c1747@vivier.eu>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] linux-user: Fix sched_getaffinity mask size
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org, Riku Voipio <riku.voipio@iki.fi>

Laurent Vivier, on ven. 26 janv. 2018 21:34:38 +0100, wrote:
> Le 26/01/2018 =C3=A0 19:36, Samuel Thibault a =C3=A9crit=C2=A0:
> > We properly computed the capped mask size to be put to the applicatio=
n
> > buffer, but didn't actually it. Also, we need to return the capped ma=
sk
> > size instead of 0 on success.
> >=20
> > Signed-off-by: Samuel Thibault <samuel.thibault@ens-lyon.org>
> > ---
> >  linux-user/syscall.c | 7 ++++++-
> >  1 file changed, 6 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> > index 74378947f0..cf2369aac2 100644
> > --- a/linux-user/syscall.c
> > +++ b/linux-user/syscall.c
> > @@ -10496,10 +10496,15 @@ abi_long do_syscall(void *cpu_env, int num,=
 abi_long arg1,
> >                          ret =3D -TARGET_EINVAL;
> >                          break;
> >                      }
> > -                    ret =3D arg2;
> > +                } else if (arg2 > ret) {
> > +                    arg2 =3D ret;
> >                  }
> > =20
> >                  ret =3D host_to_target_cpu_mask(mask, mask_size, arg=
3, arg2);
> > +
> > +                if (ret =3D=3D 0) {
> > +                    ret =3D arg2;
> > +                }
> >              }
> >          }
> >          break;
> >=20
>=20
> Modified code was:
>=20
>     if (copy_to_user(arg3, mask, ret)) {
>         goto efault;
>     }
>=20
> so the change should only be:
>=20
>     if (host_to_target_cpu_mask(mask, mask_size, arg3, ret)) {
>         goto efault;
>     }

That depends whether host_to_target_cpu_mask wants to return something
else than -TARGET_EFAULT, but at some point I don't care about
bikeshedding.

Samuel
