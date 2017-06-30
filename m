Received: from eggs.gnu.org ([2001:4830:134:3::10]:55874)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQnYP-0000pP-Em
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 00:29:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dQnYM-00060e-9o
	for qemu-devel@nongnu.org; Fri, 30 Jun 2017 00:29:13 -0400
Date: Fri, 30 Jun 2017 14:03:17 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170630040317.GA13989@umbus.fritz.box>
References: <20170629045940.11242-1-sjitindarsingh@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="qDbXVdCdHGoSgWSk"
Content-Disposition: inline
In-Reply-To: <20170629045940.11242-1-sjitindarsingh@gmail.com>
Subject: Re: [Qemu-devel] [PATCH] target/ppc: Only set PCR in kvm if
 actually in a compat mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, agraf@suse.de, qemu-devel@nongnu.org


--qDbXVdCdHGoSgWSk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 29, 2017 at 02:59:39PM +1000, Suraj Jitindar Singh wrote:
> The Processor Compatibility Register (PCR) I used to set the
> compatibility mode of the processor using the SET_ONE_REG ioctl on
> KVM_REG_PPC_ARCH_COMPAT. Previously this was only called when a compat
> mode was actually in use, however a recent patch made it unconditional.
> Calling this in KVM_PR fails as there is no handler for that call and it
> is thus impossible to start a machine with KVM_PR.
>=20
> Change ppc_set_compat() so that the ioctl is only actually called if a
> compat mode is in use. This means that a KVM_PR guest can boot.
> Additionally the current behaviour for KVM_HV is preserved where a compat
> mode of 0 set pcr and arch_compat in the vcore struct to zero, both of
> which are initialised to zero anyway.
>=20
> Fixes: 37f516defa2e ("pseries: Reset CPU compatibility mode")
>=20
> Signed-off-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>

This doesn't seem quite right.  With this change, how would we ever
turn compatibility mode _off_ (which could happen on reset if nothing
else).  Really we should add this pseudo-register to KVM PR, although
I'm fine with also having a qemu workaround to let it work with older
PR versions.

>=20
> ---
>=20
> Based on: dwg/ppc-for-2.10
>=20
>  target/ppc/compat.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/compat.c b/target/ppc/compat.c
> index f1b67fa..4482206 100644
> --- a/target/ppc/compat.c
> +++ b/target/ppc/compat.c
> @@ -143,7 +143,7 @@ void ppc_set_compat(PowerPCCPU *cpu, uint32_t compat_=
pvr, Error **errp)
>      cpu->compat_pvr =3D compat_pvr;
>      env->spr[SPR_PCR] =3D pcr & pcc->pcr_mask;
> =20
> -    if (kvm_enabled()) {
> +    if (kvm_enabled() && compat_pvr) {
>          int ret =3D kvmppc_set_compat(cpu, cpu->compat_pvr);
>          if (ret < 0) {
>              error_setg_errno(errp, -ret,

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--qDbXVdCdHGoSgWSk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZVc2FAAoJEGw4ysog2bOSMhIQAK50AK1XoORaZ49P+vmYVVTQ
Y9wm8zsVLqVUU6o8lR5KdeHyVZ5FpJLA+nDRrYxYiqXejhAQGPe8espH00QVfkKc
prT8VmOm9H3Q2w/Di831atlmsASNZqBpiMbrO+MhEe8diL5bbFQ9AAkifjFXLYQ7
J2QMTH//bYV3pek9ISkKrc3o06zq++hBIpJDuyTVRj77V0bFA53qML0SPdqee3YN
gp5AWx/JTkskvwITSnNhvUnTo2LzZ2Cr/zaqHcfNj+ADgCzg601CJapyNDDFpotA
6IXZaok3F4cPxtz8uNOEExxAiy/2TGtmM1Qo/CHLu1tLfrYX53MAfVBRd6557yB+
L+tyV4Gm44WYzOfygJjIUEZGWtT5ghZjWI/6RsIpJztSbzPTgyfscP+679kW2bfF
rrWaBRHto341J2lressMJx410RsPUphhWtf0yZeZykZtcZ8IGoRduZTO8fWFjFp7
DAQN8jr4s0YBo5aFoilo7ZrkLhYAiJp2BUwIISOohPMs1t5jCkCU2hyd1wG0O177
icatHH93KEMGuf0CZyqjgBBGerJcV7RfhKynC3ybhts8muwJOcHAYuXjYA1m3y0U
YgKsZnJHrvS20O5P1rdHsDberwHJMQvtOupF7Q1d+aQHjjDZdMY1mId/73ZL6fwY
HfzlBbnNVMTn6eGBvC7N
=yymP
-----END PGP SIGNATURE-----

--qDbXVdCdHGoSgWSk--
