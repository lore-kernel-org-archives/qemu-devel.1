Received: from eggs.gnu.org ([2001:4830:134:3::10]:49549)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f4JSL-0003Ov-DW
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 00:58:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1f4JSK-00034u-E9
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 00:58:33 -0400
Date: Fri, 6 Apr 2018 14:58:19 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180406045819.GC3212@umbus.fritz.box>
References: <20180405021437.16761-1-david@gibson.dropbear.id.au>
	<20180405021437.16761-10-david@gibson.dropbear.id.au>
	<20180405140619.5f6112b9@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="HG+GLK89HZ1zG0kk"
Content-Disposition: inline
In-Reply-To: <20180405140619.5f6112b9@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH for-2.13 09/13] target/ppc: Move 1T segment
 and AMR options to PPCHash64Options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, clg@kaod.org, bharata@linux.vnet.ibm.com


--HG+GLK89HZ1zG0kk
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 05, 2018 at 02:06:19PM +0200, Greg Kurz wrote:
> On Thu,  5 Apr 2018 12:14:33 +1000
> David Gibson <david@gibson.dropbear.id.au> wrote:
>=20
> > Currently env->mmu_model is a bit of an unholy mess of an enum of disti=
nct
> > MMU types, with various flag bits as well.  This makes which bits of the
> > field should be compared pretty confusing.
> >=20
> > Make a start on cleaning that up by moving two of the flags bits -
> > POWERPC_MMU_1TSEG and POWERPC_MMU_AMR - which are specific to the 64-bit
> > hash MMU into a new flags field in PPCHash64Options structure.
> >=20
> > Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> > Reviewed-by: C=E9dric Le Goater <clg@kaod.org>
> > Reviewed-by: Greg Kurz <groug@kaod.org>
> > ---
>=20
> While investigating a migration failure from an older QEMU, I realized
> this patch has a problem. The *cpu->hash64_opts structure is zeroed in
> kvm_fixup_page_sizes(), which has now the unwanted effect of clearing
> the cpu->hash64_opts->flags as well.
>=20
> We only need to zero the segment page sizes actually. The following
> fixes migration:
>=20
> @@ -442,7 +442,7 @@ static void kvm_fixup_page_sizes(PowerPCCPU *cpu)
>      }
> =20
>      /* Convert to QEMU form */
> -    memset(cpu->hash64_opts, 0, sizeof(*cpu->hash64_opts));
> +    memset(&cpu->hash64_opts->sps, 0, sizeof(cpu->hash64_opts->sps));
> =20
>      /* If we have HV KVM, we need to forbid CI large pages if our
>       * host page size is smaller than 64K.

Ah, good catch.  I mistakenly thought that kvm_fixup_page_sizes() was
completely rewriting those flags as well.  I've made this fix now.

I'm also currently working on some other patches which amongst other
things get rid of kvm_fixup_page_sizes(), because it's completely
broken by design.  But might as well not break things excessively in
the meantime.

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--HG+GLK89HZ1zG0kk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlrG/mgACgkQbDjKyiDZ
s5Ieeg/9GKZEgBE/+6afBredaOdTOC0s4ZK9KNiaQoEVxl/8MzQrsQ6K6+z2eGb9
si69zPJd1smjzEvUpgIaVpC7J8wTjhPT0wTfBjXpeljTUoMAEA6qu7cx1Y2e+vpp
7hqZ0sP6wVmsGxBpwbvv3J5e3kX1X6pRNmKaaVIaQg8t5wfOvDAE5KG33Fmm2NY7
TUk+6hrAUi/lQ1x9emVL9IxCDIWr5+OOyis+RIX9Ad3O4bl/qKMHS2aWWqyleryZ
1MtoHdvNCyAnxtEU2f/ylxfceXU5B4yiUVpdyArnzi1S1b9AKedSxQm7P/7uZOp7
8hxF9++t88aKkyWKFOrA7otOYspC93ET6bSCAhg4LyuiOLoimusFn3io0eEyINBU
7pMHSxL55Gbm6rD6FU/yZr1lsD+nw/dkq7CAcRvs+1h/rJkq51mQKlH7Rgs9msdq
Fi6Qu1w4v5bOMoxEuwVF5B0b5HTazqzyfEwGtyKEJKaEfFhAdh24t+VXp6Ybk5cA
gM4eD7X3JvxgA96iNQi9b6eIioVQfq5nxnEoeFWr6fElP7qDMXyvrzOyiHfPKwHM
ULDx72OybftnC2LAT7ZzkzqQA5ltUQIOQ6AWQUUoeCmv+mCAlf63xlBWAed6OFOS
qbGFDPg6jj0sgic3dk9+o04FTAWRGEW7gnpNezh9QQJZPQUq7g0=
=Fx7G
-----END PGP SIGNATURE-----

--HG+GLK89HZ1zG0kk--
