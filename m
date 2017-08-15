Received: from eggs.gnu.org ([2001:4830:134:3::10]:36620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dhTui-0006k7-KT
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 00:57:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dhTuh-0004ie-Ib
	for qemu-devel@nongnu.org; Tue, 15 Aug 2017 00:57:12 -0400
Date: Tue, 15 Aug 2017 14:04:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170815040409.GN3452@umbus.fritz.box>
References: <150273295665.11087.17582111045419718285.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U6leaJ20qZQc29iB"
Content-Disposition: inline
In-Reply-To: <150273295665.11087.17582111045419718285.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH] ppc: fix ppc_set_compat() with KVM PR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, Suraj Jitindar Singh <sjitindarsingh@gmail.com>


--U6leaJ20qZQc29iB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 14, 2017 at 07:49:16PM +0200, Greg Kurz wrote:
> When running in KVM PR mode, kvmppc_set_compat() always fail because the
> current PR implementation doesn't handle KVM_REG_PPC_ARCH_COMPAT. Now that
> the machine code inconditionally calls ppc_set_compat_all() at reset time
> to restore the compat mode default value (commit 66d5c492dd3a9), it is
> impossible to start a guest with PR:
>=20
> qemu-system-ppc64: Unable to set CPU compatibility mode in KVM:
>  Invalid argument
>=20
> A tentative patch [1] was recently sent by Suraj to address the issue, but
> it would prevent the compat mode to be turned off on reset. And we really
> don't want to explicitely check for KVM PR. During the patch's review,
> David suggested that we should only call the KVM ioctl() if the compat
> PVR changes. This allows at least to run with KVM PR, provided no compat
> mode is requested from the command line (which should be the case when
> running PR nested). This is what this patch does.

I'm not sure that's true any more, since we now prefer compat modes
during CAS.  I guess we could exclude the compat modes from the
advertised list based on what KVM supports, but that seems pretty
awkward.

> While here, we also fix the side effect where KVM would fail but we would
> change the CPU state in QEMU anyway.
>=20
> [1] http://patchwork.ozlabs.org/patch/782039/
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>

In any case, this makes things better than they were, so I'm applying.

> ---
>  target/ppc/compat.c |    9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/ppc/compat.c b/target/ppc/compat.c
> index f1b67faa97e3..f8729fe46d61 100644
> --- a/target/ppc/compat.c
> +++ b/target/ppc/compat.c
> @@ -140,16 +140,17 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t compa=
t_pvr, Error **errp)
> =20
>      cpu_synchronize_state(CPU(cpu));
> =20
> -    cpu->compat_pvr =3D compat_pvr;
> -    env->spr[SPR_PCR] =3D pcr & pcc->pcr_mask;
> -
> -    if (kvm_enabled()) {
> +    if (kvm_enabled() && cpu->compat_pvr !=3D compat_pvr) {
>          int ret =3D kvmppc_set_compat(cpu, cpu->compat_pvr);
>          if (ret < 0) {
>              error_setg_errno(errp, -ret,
>                               "Unable to set CPU compatibility mode in KV=
M");
> +            return;
>          }
>      }
> +
> +    cpu->compat_pvr =3D compat_pvr;
> +    env->spr[SPR_PCR] =3D pcr & pcc->pcr_mask;
>  }
> =20
>  typedef struct {
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--U6leaJ20qZQc29iB
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmScrcACgkQbDjKyiDZ
s5Ilpw/8C64LsbF97swdbikuY/+LsvhhIMjtZLgYpGC7csWS73yBNlHaI5RgnE2S
0NZ0DiXZexWqy64LfbtTRhcZNmeY7MgiF/8uAz9WdbbPuCCHoDHEHZokCoYAdcdT
VAEACjjR38hvZnYkfx16XSrcNwehPOBUN0ltGXbplrCWhcyqtPKxnts49XhBAPM7
+FuJfx7acNlNevo159/QYLyCroXBfYg+hOuMo/al/JMatbOuRdU9PyfLRQ/a7vEZ
ce9zQzPF5V7WHyzELW2C3ak5/nCa5XYzEBxikszF9MyUvE7vbQvPxmZCUgfC49DX
Ohq4eiD9IhlXa5hzMSuaykQgemBSiEUmuyDkIqqO08yTuzfg78ipcvL14azbmy7O
TabanOB9ZZB+zJnaC2g9hdThDowgJrQUJMzpSqi8c2Qilms4WieFFOJYNF991Kop
MzyBVrWMrxLJeebkRKuJLhZcZog0DZ79StCH90qqVYqWHjxafL9PrEGkdaEaR/OT
vawkN0dc6kPOySotoHZxQQiJfvmFa2Kv9jyxXS1IduuRWSmCRFWqe3F6Lt0mWCbs
dLXFPt0sPHteduVY9UfQeFgOYIYQyS40qW52eGyuDwB3Ev002uJyqARdfqpnkwdo
uiUfYjFC8SsHTyO91IPrRDn03yOLLbu653iMh4sGUrWghYyvbKw=
=Enlc
-----END PGP SIGNATURE-----

--U6leaJ20qZQc29iB--
