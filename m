Received: from eggs.gnu.org ([2001:4830:134:3::10]:34224)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cglkt-0003nU-G4
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 00:15:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cglkr-0006uX-Sp
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 00:15:51 -0500
Date: Thu, 23 Feb 2017 16:11:29 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223051129.GA12616@umbus.fritz.box>
References: <20170223020936.29220-1-david@gibson.dropbear.id.au>
	<20170223020936.29220-4-david@gibson.dropbear.id.au>
	<1487824324.23895.10.camel@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
In-Reply-To: <1487824324.23895.10.camel@gmail.com>
Subject: Re: [Qemu-devel] [PATCH 3/6] target/ppc: SDR1 is a hypervisor
 resource
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
Cc: qemu-ppc@nongnu.org, aik@ozlabs.ru, qemu-devel@nongnu.org, agraf@suse.de, thuth@redhat.com, lvivier@redhat.com, mdroth@linux.vnet.ibm.com, paulus@samba.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 23, 2017 at 03:32:04PM +1100, Suraj Jitindar Singh wrote:
> On Thu, 2017-02-23 at 13:09 +1100, David Gibson wrote:
> > At present the SDR1 register - the base of the system's hashed page
> > table
> > (HPT) - is represented as an SPR with supervisor read and write
> > permission.
> > However, on CPUs which have a hypervisor mode, the SDR1 is a
> > hypervisor
> > only resource.=A0=A0Change the permission checking on the SPR to reflect
> > this.
> >=20
> > Now that this is done, we don't need to check for an external HPT
> > executing
> > mtsdr1: an external HPT only applies when we're emulating the
> > behaviour of
> > a hypervisor, rather than modelling the CPU's hypervisor mode
> > internally,
> > so if we're permitted to execute mtsdr1, we don't have an external
> > HPT.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > ---
> > =A0target/ppc/misc_helper.c=A0=A0=A0=A0|=A0=A08 +++-----
> > =A0target/ppc/translate_init.c | 20 ++++++++++++++++----
> > =A02 files changed, 19 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/target/ppc/misc_helper.c b/target/ppc/misc_helper.c
> > index ab432ba..fa573dd 100644
> > --- a/target/ppc/misc_helper.c
> > +++ b/target/ppc/misc_helper.c
> > @@ -82,11 +82,9 @@ void helper_store_sdr1(CPUPPCState *env,
> > target_ulong val)
> > =A0{
> > =A0=A0=A0=A0=A0PowerPCCPU *cpu =3D ppc_env_get_cpu(env);
> > =A0
> > -=A0=A0=A0=A0if (!env->external_htab) {
> > -=A0=A0=A0=A0=A0=A0=A0=A0if (env->spr[SPR_SDR1] !=3D val) {
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0ppc_store_sdr1(env, val);
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0tlb_flush(CPU(cpu));
> > -=A0=A0=A0=A0=A0=A0=A0=A0}
>=20
> It may have been the case we didn't have to check this before anyway...
> Oh well

Actually I think we did.  At least with a TCG (and maybe KVM PR)
guest, because the SDR1 was previously treated as a supervisor
resource, the guest could have issued an mtsdr1, changing the size of
the HPT.  We still would have read from the external_htab, but if the
size was changed the guest could have triggered accesses beyond the
end of it, crashing qemu.

With this check in place the behaviour of mtsdr1 was wrong (it was a
no-op instead of causing a privlieged instruction exception), but not
dangerous.

>
> > +=A0=A0=A0=A0if (env->spr[SPR_SDR1] !=3D val) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0ppc_store_sdr1(env, val);
> > +=A0=A0=A0=A0=A0=A0=A0=A0tlb_flush(CPU(cpu));
> > =A0=A0=A0=A0=A0}
> > =A0}
> > =A0
> > diff --git a/target/ppc/translate_init.c
> > b/target/ppc/translate_init.c
> > index a1405e9..c92435d 100644
> > --- a/target/ppc/translate_init.c
> > +++ b/target/ppc/translate_init.c
> > @@ -740,10 +740,22 @@ static void gen_spr_ne_601 (CPUPPCState *env)
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0&spr_read_decr, &=
spr_write_decr,
> > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x00000000);
> > =A0=A0=A0=A0=A0/* Memory management */
> > -=A0=A0=A0=A0spr_register(env, SPR_SDR1, "SDR1",
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0SPR_NOACCESS, SPR_N=
OACCESS,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0&spr_read_generic, =
&spr_write_sdr1,
> > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x00000000);
> > +#ifndef CONFIG_USER_ONLY
> > +=A0=A0=A0=A0if (env->has_hv_mode) {
> > +=A0=A0=A0=A0=A0=A0=A0=A0/* SDR1 is a hypervisor resource on CPUs which=
 have a
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0* hypervisor mode */
> > +=A0=A0=A0=A0=A0=A0=A0=A0spr_register_hv(env, SPR_SDR1, "SDR1",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0SPR_NOACCESS, SPR_NOACCESS,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0SPR_NOACCESS, SPR_NOACCESS,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0&spr_read_generic, &spr_write_sdr1,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A00x00000000);
> > +=A0=A0=A0=A0} else {
> > +=A0=A0=A0=A0=A0=A0=A0=A0spr_register(env, SPR_SDR1, "SDR1",
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0SPR_NOA=
CCESS, SPR_NOACCESS,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0&spr_re=
ad_generic, &spr_write_sdr1,
> > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A00x00000=
000);
> > +=A0=A0=A0=A0}
> > +#endif
> > =A0}
> > =A0
> > =A0/* BATs 0-3 */
>=20
> Reviewed-by: Suraj Jitindar Singh <sjitindarsingh@gmail.com>
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrm7+AAoJEGw4ysog2bOSjmIP/1Rge4ll8pRBa7JgQr5uco7K
j2pik3ZheJAglqgCcg6uD4DgDqMWQ5kq0mztjHvs/b9fKjXx97P9Y8F/VUNQe651
XUrA55cOTlR2RE31ZGGw5OX986zbkRmNU7ZK+DagahE5FSO5X+Tm2U08RaeTaTal
WF8Qjv5eSpA9CT2l9HzF47wOqSFLTLnIgK30IaUjFK7GXWaM94LDaWGskMR8m4w8
E7BnLikAxjMcN0F3wibMwk3qIxYY1i2rJEitpdA4L90UrMCz1RQQ6LO9eFn+Ew+h
cboSd368cYimECSIN1lgsIsZmNPeDEIKnenmheKYT6hFVvJvx0kDXQAakTCyblhB
DK+UiD5mYJNCNgt6xnobaLfsHAjqH5mKjGeLflMcMVkuEQ6Q1PBFivaoS4Gyy90Y
0uVENNLMu3pEGffOQIvule6NW1U8rE0FyxiVDcF0F8BTAt+IjCIs+ybnAt39NxzK
eQo62LiIwXnWKBQ+ebFkcMvkESFU6e2JElBEQaiVDV/3HiEI/5Y+VUGeY74+hsm2
Go2abJiNQz/4eKQK8twZUsYtrgbeI8dLFAMzxrFqX99VZjCFAnUFXG20KX/qhnKW
d3QEqou9eW0p6XHgjSqt2mkuoFZg+QSoPx55wy4iIJTnypk7JGSi9F+xUsE7kpz4
Cf+m1CC34Z7WYXdjcj1i
=B+gh
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
