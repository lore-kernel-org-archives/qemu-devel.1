Received: from eggs.gnu.org ([2001:4830:134:3::10]:43338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fdGQQ-0004fU-Rm
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:49:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1fdGQN-0000Xg-P0
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:49:02 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42770 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1fdGQN-0000XP-CY
	for qemu-devel@nongnu.org; Wed, 11 Jul 2018 10:48:59 -0400
Date: Wed, 11 Jul 2018 16:48:55 +0200
From: Eduardo Otubo <otubo@redhat.com>
Message-ID: <20180711144855.GE14423@vader>
References: <20180710145557.12902-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="so9zsI5B81VjUb/o"
Content-Disposition: inline
In-Reply-To: <20180710145557.12902-1-marcandre.lureau@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] seccomp: allow sched_setscheduler() with
 SCHED_IDLE policy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, eskultet@redhat.com, kraxel@redhat.com, berrange@redhat.com, gschafer@gmail.com


--so9zsI5B81VjUb/o
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 10/07/2018 - 16:55:57, Marc-Andr=C3=A9 Lureau wrote:
> Current and upcoming mesa releases rely on a shader disk cash. It uses
> a thread job queue with low priority, set with
> sched_setscheduler(SCHED_IDLE). However, that syscall is rejected by
> the "resourcecontrol" seccomp qemu filter.
>=20
> Since it should be safe to allow lowering thread priority, let's allow
> scheduling thread to idle policy.
>=20
> Related to:
> https://bugzilla.redhat.com/show_bug.cgi?id=3D1594456
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  qemu-seccomp.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>=20
> diff --git a/qemu-seccomp.c b/qemu-seccomp.c
> index 148e4c6f24..9cd8eb9499 100644
> --- a/qemu-seccomp.c
> +++ b/qemu-seccomp.c
> @@ -34,6 +34,12 @@
>  struct QemuSeccompSyscall {
>      int32_t num;
>      uint8_t set;
> +    uint8_t narg;
> +    const struct scmp_arg_cmp *arg_cmp;
> +};
> +
> +const struct scmp_arg_cmp sched_setscheduler_arg[] =3D {
> +    SCMP_A1(SCMP_CMP_NE, SCHED_IDLE)
>  };
> =20
>  static const struct QemuSeccompSyscall blacklist[] =3D {
> @@ -92,7 +98,8 @@ static const struct QemuSeccompSyscall blacklist[] =3D {
>      { SCMP_SYS(setpriority),            QEMU_SECCOMP_SET_RESOURCECTL },
>      { SCMP_SYS(sched_setparam),         QEMU_SECCOMP_SET_RESOURCECTL },
>      { SCMP_SYS(sched_getparam),         QEMU_SECCOMP_SET_RESOURCECTL },
> -    { SCMP_SYS(sched_setscheduler),     QEMU_SECCOMP_SET_RESOURCECTL },
> +    { SCMP_SYS(sched_setscheduler),     QEMU_SECCOMP_SET_RESOURCECTL,
> +      ARRAY_SIZE(sched_setscheduler_arg), sched_setscheduler_arg },
>      { SCMP_SYS(sched_getscheduler),     QEMU_SECCOMP_SET_RESOURCECTL },
>      { SCMP_SYS(sched_setaffinity),      QEMU_SECCOMP_SET_RESOURCECTL },
>      { SCMP_SYS(sched_getaffinity),      QEMU_SECCOMP_SET_RESOURCECTL },
> @@ -118,7 +125,8 @@ static int seccomp_start(uint32_t seccomp_opts)
>              continue;
>          }
> =20
> -        rc =3D seccomp_rule_add(ctx, SCMP_ACT_KILL, blacklist[i].num, 0);
> +        rc =3D seccomp_rule_add_array(ctx, SCMP_ACT_KILL, blacklist[i].n=
um,
> +                                    blacklist[i].narg, blacklist[i].arg_=
cmp);
>          if (rc < 0) {
>              goto seccomp_return;
>          }
> --=20
> 2.18.0.129.ge3331758f1
>=20

Acked-by: Eduardo Otubo <otubo@redhat.com>

Patch looks safe enough for me. If everyone else is OK with this I'll send a
pull-request tomorrow morning.

--so9zsI5B81VjUb/o
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbRhjXAAoJEN8y58Dw//miVIMH/Rplt5ij0SkTXIkeaZua00hD
o9MQ3AKO12SPb9qhQWcHco7F2k3DQ63g4UhlSUF8xh7JZ3HEyy1OtRTC2TVwNVtS
p2LgZ2PYFEky/0fMTFpP0azybA5p1KJaeYeGKBIB3d1ptjM2O+P+2e1HHR/NG0eo
JdFJ7PQ+ZJvAF0tYxLS7qeaS8cu0HrWd1Aqi38u5F7br0UI8auXeK6F+EYjlphHV
1x44AOspmFBAoad85ll55GTKzSdiVkLfssb2ZhO+KugXI3++bkTGwrLC+CE9ZIyj
qKIblbPAsf7ZK+ymdqsXwE3eQfDrggAbo9yUj8XLcLvPt3B84v2ApvWjAG5rt+Q=
=TVDJ
-----END PGP SIGNATURE-----

--so9zsI5B81VjUb/o--
