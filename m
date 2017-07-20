Received: from eggs.gnu.org ([2001:4830:134:3::10]:51318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dYLc1-0007rX-Vm
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 20:16:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dYLc0-0005lx-JK
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 20:16:09 -0400
Date: Fri, 21 Jul 2017 09:58:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170720235822.GA3717@umbus.fritz.box>
References: <1500568290-7966-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
In-Reply-To: <1500568290-7966-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-2.10] Use qemu_tolower() and
 qemu_toupper(), not tolower() and toupper()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, patches@linaro.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Kamil Rytarowski <kamil@netbsd.org>, qemu-ppc@nongnu.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 20, 2017 at 05:31:30PM +0100, Peter Maydell wrote:
> On NetBSD, where tolower() and toupper() are implemented using an
> array lookup, the compiler warns if you pass a plain 'char'
> to these functions:
>=20
> gdbstub.c:914:13: warning: array subscript has type 'char'
>=20
> This reflects the fact that toupper() and tolower() give
> undefined behaviour if they are passed a value that isn't
> a valid 'unsigned char' or EOF.
>=20
> We have qemu_tolower() and qemu_toupper() to avoid this problem;
> use them.
>=20
> (The use in scsi-generic.c does not trigger the warning because
> it passes a uint8_t; we switch it anyway, for consistency.)
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

ppc parts

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  gdbstub.c                  | 2 +-
>  hw/s390x/s390-virtio-ccw.c | 2 +-
>  hw/scsi/scsi-generic.c     | 2 +-
>  target/ppc/monitor.c       | 4 ++--
>  4 files changed, 5 insertions(+), 5 deletions(-)
>=20
> diff --git a/gdbstub.c b/gdbstub.c
> index f936ddd..2a94030 100644
> --- a/gdbstub.c
> +++ b/gdbstub.c
> @@ -911,7 +911,7 @@ static int gdb_handle_vcont(GDBState *s, const char *=
p)
> =20
>          cur_action =3D *p++;
>          if (cur_action =3D=3D 'C' || cur_action =3D=3D 'S') {
> -            cur_action =3D tolower(cur_action);
> +            cur_action =3D qemu_tolower(cur_action);
>              res =3D qemu_strtoul(p + 1, &p, 16, &tmp);
>              if (res) {
>                  goto out;
> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> index ce3921e..1c7af39 100644
> --- a/hw/s390x/s390-virtio-ccw.c
> +++ b/hw/s390x/s390-virtio-ccw.c
> @@ -318,7 +318,7 @@ static void machine_set_loadparm(Object *obj, const c=
har *val, Error **errp)
>      int i;
> =20
>      for (i =3D 0; i < sizeof(ms->loadparm) && val[i]; i++) {
> -        uint8_t c =3D toupper(val[i]); /* mimic HMC */
> +        uint8_t c =3D qemu_toupper(val[i]); /* mimic HMC */
> =20
>          if (('A' <=3D c && c <=3D 'Z') || ('0' <=3D c && c <=3D '9') || =
(c =3D=3D '.') ||
>              (c =3D=3D ' ')) {
> diff --git a/hw/scsi/scsi-generic.c b/hw/scsi/scsi-generic.c
> index a55ff87..7e1cbab 100644
> --- a/hw/scsi/scsi-generic.c
> +++ b/hw/scsi/scsi-generic.c
> @@ -406,7 +406,7 @@ static int read_naa_id(const uint8_t *p, uint64_t *p_=
wwn)
>          }
>          *p_wwn =3D 0;
>          for (i =3D 8; i < 24; i++) {
> -            char c =3D toupper(p[i]);
> +            char c =3D qemu_toupper(p[i]);
>              c -=3D (c >=3D '0' && c <=3D '9' ? '0' : 'A' - 10);
>              *p_wwn =3D (*p_wwn << 4) | c;
>          }
> diff --git a/target/ppc/monitor.c b/target/ppc/monitor.c
> index b8f30e9..1491511 100644
> --- a/target/ppc/monitor.c
> +++ b/target/ppc/monitor.c
> @@ -115,14 +115,14 @@ int target_get_monitor_def(CPUState *cs, const char=
 *name, uint64_t *pval)
>      CPUPPCState *env =3D &cpu->env;
> =20
>      /* General purpose registers */
> -    if ((tolower(name[0]) =3D=3D 'r') &&
> +    if ((qemu_tolower(name[0]) =3D=3D 'r') &&
>          ppc_cpu_get_reg_num(name + 1, ARRAY_SIZE(env->gpr), &regnum)) {
>          *pval =3D env->gpr[regnum];
>          return 0;
>      }
> =20
>      /* Floating point registers */
> -    if ((tolower(name[0]) =3D=3D 'f') &&
> +    if ((qemu_tolower(name[0]) =3D=3D 'f') &&
>          ppc_cpu_get_reg_num(name + 1, ARRAY_SIZE(env->fpr), &regnum)) {
>          *pval =3D env->fpr[regnum];
>          return 0;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--5vNYLRcllDrimb99
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAllxQ5kACgkQbDjKyiDZ
s5J0bhAA0IUgocl/2Nsh/DVbVZfXVn7BLFMC5r8jH3/laFW/0WKWBRulbNeYtX1W
nTVpVHV05VKthu/YzhNGPoXiRq0oMznLy8QnAF9rYc+aslGr2GJoSRlE7EmHkVYg
tWjhN3lNVCXNpHuejEgAINZIJpeybQoPUO7EnA9Fc1umBrpdxwh6iTpu9t2cfom1
jf4/JslJ5s9hjHmQ0G0uRHOUEZxQLEskH9W80HpgVSJw2ttTWRrEEOtSCIAi8ob2
+wvRrzh/n3VseVm3Ncu0ZErmJ35sYs92ygpDB7Jh990dfoF4FHrCjmWTruuteK1g
2oonE7xGC3Nrx/cnBnex09bTsS+D8TW2ERdPc3PhYkd2eEtipaC1gI3U9wOcDWmX
9XOC6alVONeUCzm+aI+RO6mUGciHW8KY8I8kpceVp5eOPr3DICNawjZspFCd7akA
z9mYq/ibc6STMQZx47KePd3kY3758scWIehIue08wYpLnyUYhQn7d77RWkCaTAic
hywoVFgJWCGYoXaoC/yBL+vM7573aUWxdPFxijORkWGIvtxGmBl48T0khkJDu7hJ
lmwqIKh22pkCGiaHCJtL0GPTQs3G56nMoVSzvKWLa9mJK8IghaPk+obljT+BEci3
q4CvEs1fLtABa+ZluYm3Hl1KNkYJZMbECnJfPkVTb5Pw8p+dehg=
=sZb8
-----END PGP SIGNATURE-----

--5vNYLRcllDrimb99--
