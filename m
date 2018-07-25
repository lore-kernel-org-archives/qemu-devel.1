Received: from eggs.gnu.org ([2001:4830:134:3::10]:46693)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fiHFj-0006Dw-U0
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 06:42:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fiHFg-0002HZ-Va
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 06:42:43 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54980 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1fiHFg-0002HL-O4
	for qemu-devel@nongnu.org; Wed, 25 Jul 2018 06:42:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 45D8F72622
	for <qemu-devel@nongnu.org>; Wed, 25 Jul 2018 10:42:40 +0000 (UTC)
Date: Wed, 25 Jul 2018 12:42:36 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20180725104236.GC23742@vader>
References: <20180720154425.31285-1-marcandre.lureau@redhat.com>
	<20180720154425.31285-3-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ncSAzJYg3Aa9+CRW"
Content-Disposition: inline
In-Reply-To: <20180720154425.31285-3-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] RFC: seccomp: prefer
 SCMP_ACT_KILL_PROCESS if available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, pmoore@redhat.com


--ncSAzJYg3Aa9+CRW
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20/07/2018 - 17:44:25, Marc-Andr=C3=A9 Lureau wrote:
> The upcoming libseccomp release should have SCMP_ACT_KILL_PROCESS
> action (https://github.com/seccomp/libseccomp/issues/96).
>=20
> SCMP_ACT_KILL_PROCESS is preferable to immediately terminate the
> offending process, rather than having the SIGSYS handler running.
>=20
> Use SECCOMP_GET_ACTION_AVAIL to check availability of kernel support,
> as libseccomp will fallback on SCMP_ACT_KILL otherwise, and we still
> prefer SCMP_ACT_TRAP.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qemu-seccomp.c | 30 +++++++++++++++++++++++++++++-
>  1 file changed, 29 insertions(+), 1 deletion(-)
>=20
> diff --git a/qemu-seccomp.c b/qemu-seccomp.c
> index b117a92559..505887d5af 100644
> --- a/qemu-seccomp.c
> +++ b/qemu-seccomp.c
> @@ -20,6 +20,7 @@
>  #include <sys/prctl.h>
>  #include <seccomp.h>
>  #include "sysemu/seccomp.h"
> +#include <linux/seccomp.h>
> =20
>  /* For some architectures (notably ARM) cacheflush is not supported until
>   * libseccomp 2.2.3, but configure enforces that we are using a more rec=
ent
> @@ -107,12 +108,39 @@ static const struct QemuSeccompSyscall blacklist[] =
=3D {
>      { SCMP_SYS(sched_get_priority_min), QEMU_SECCOMP_SET_RESOURCECTL },
>  };
> =20
> +static inline int
> +qemu_seccomp(unsigned int operation, unsigned int flags, void *args)
> +{
> +#ifdef __NR_seccomp
> +    return syscall(__NR_seccomp, operation, flags, args);
> +#else
> +    return -1;
> +#endif
> +}
> +
> +static uint32_t qemu_seccomp_get_kill_action(void)
> +{
> +#if defined(SECCOMP_GET_ACTION_AVAIL) && defined(SCMP_ACT_KILL_PROCESS) =
&& \
> +    defined(SECCOMP_RET_KILL_PROCESS)
> +    {
> +        uint32_t action =3D SECCOMP_RET_KILL_PROCESS;
> +
> +        if (qemu_seccomp(SECCOMP_GET_ACTION_AVAIL, 0, &action) =3D=3D 0)=
 {
> +            return SCMP_ACT_KILL_PROCESS;
> +        }
> +    }
> +#endif
> +
> +    return SCMP_ACT_TRAP;
> +}
> +
> =20
>  static int seccomp_start(uint32_t seccomp_opts)
>  {
>      int rc =3D 0;
>      unsigned int i =3D 0;
>      scmp_filter_ctx ctx;
> +    uint32_t action =3D qemu_seccomp_get_kill_action();
> =20
>      ctx =3D seccomp_init(SCMP_ACT_ALLOW);
>      if (ctx =3D=3D NULL) {
> @@ -125,7 +153,7 @@ static int seccomp_start(uint32_t seccomp_opts)
>              continue;
>          }
> =20
> -        rc =3D seccomp_rule_add_array(ctx, SCMP_ACT_TRAP, blacklist[i].n=
um,
> +        rc =3D seccomp_rule_add_array(ctx, action, blacklist[i].num,
>                                      blacklist[i].narg, blacklist[i].arg_=
cmp);
>          if (rc < 0) {
>              goto seccomp_return;
> --=20
> 2.18.0.232.gb7bd9486b0
>=20

Acked-by: Eduardo Otubo <otubo@redhat.com>

--=20
Eduardo Otubo

--ncSAzJYg3Aa9+CRW
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbWFQcAAoJEN8y58Dw//mi1qsH/jtAQiFdJCBaMaM+UXTioslx
FKgOXW4RrtkEGXhbrN9HDITOKxeH92Mx7KQkmZw8kMarp5LY6Rq7U7gDrlbPLN6P
5QxL8nHEv12q2Duuy5NVoX0Cr0ubLQJOgO0SSdBM16vGmEEUv8z6rKZMpk9mWyhg
CXkiSVU0XXReRdSXeCqlREj/Fmzcb+goXLmj9qcpyDSuMxd2LyAXHM3JnjbE8Jyu
PfW/hfOqVNmH6d6RyKcyg4ecyaII8Hwyo8+PtMAIjv9bHw9fvdkB7xVc1pJ2P6/+
1LgdeUzI7BwtsoAaCTj/wfutM91KLzFezkCmpYOTtN2Ucm0LCDKdS2JCIWf9PAE=
=vWSA
-----END PGP SIGNATURE-----

--ncSAzJYg3Aa9+CRW--
