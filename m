Received: from eggs.gnu.org ([2001:4830:134:3::10]:41713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHLZK-0005L1-1J
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 22:19:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eHLZI-0005OB-Vu
	for qemu-devel@nongnu.org; Tue, 21 Nov 2017 22:19:22 -0500
Date: Wed, 22 Nov 2017 13:33:34 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171122023334.GC2380@umbus.fritz.box>
References: <20171120100347.8601-1-clg@kaod.org>
	<20171120100347.8601-2-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="L6iaP+gRLNZHKoI4"
Content-Disposition: inline
In-Reply-To: <20171120100347.8601-2-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH for-2.12 v3 1/3] spapr/rtas: disable the
 decrementer interrupt when a CPU is unplugged
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>


--L6iaP+gRLNZHKoI4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 20, 2017 at 11:03:45AM +0100, C=E9dric Le Goater wrote:
> When a CPU is stopped with the 'stop-self' RTAS call, its state
> 'halted' is switched to 1 and, in this case, the MSR is not taken into
> account anymore in the cpu_has_work() routine. Only the pending
> hardware interrupts are checked with their LPCR:PECE* enablement bit.
>=20
> If the DECR timer fires after 'stop-self' is called and before the CPU
> 'stop' state is reached, the nearly-dead CPU will have some work to do
> and the guest will crash. This case happens very frequently with the
> not yet upstream P9 XIVE exploitation mode. In XICS mode, the DECR is
> occasionally fired but after 'stop' state, so no work is to be done
> and the guest survives.
>=20
> I suspect there is a race between the QEMU mainloop triggering the
> timers and the TCG CPU thread but I could not quite identify the root
> cause. To be safe, let's disable in the LPCR all the exceptions which
> can cause an exit while the CPU is in power-saving mode and reenable
> them when the CPU is started.
>=20
> For this purpose, we introduce a little helper routine to calculate
> the PECE bits for a processor variant. We could also use the mask
> value LPCR_PECE_L_MASK for the P8 and P9 processors. bit 47 and 48 are
> reserved on P7 but it is still compatible.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

I'm not thrilled about addressing this without 100% knowing what's
going on, but this seems like a sensible change in any case, so I'm ok
with applying something like this.

A detail however..

[snip]
>  #if !defined(CONFIG_USER_ONLY)
> +
> +target_ulong cpu_ppc_papr_pece_bits(CPUPPCState *env)
> +{
> +    switch (env->mmu_model) {
> +    case POWERPC_MMU_3_00:
> +        return LPCR_PDEE | LPCR_HDEE | LPCR_EEE | LPCR_DEE | LPCR_OEE;
> +    default:
> +        /* P7 and P8 has slightly different PECE bits, mostly because P8=
 adds
> +         * bit 47 and 48 which are reserved on P7. Here we set them all,=
 which
> +         * will work as expected for both implementations
> +         */
> +        return LPCR_P8_PECE0 | LPCR_P8_PECE1 | LPCR_P8_PECE2 | LPCR_P8_P=
ECE3 |
> +            LPCR_P8_PECE4;
> +    }
> +}

=2E.since we're working in this area, might as well clean up this
inappropriate use of mmu_model.  Two options which I'd be ok with:

1) Add a pece_bits field to the PowerPCCPUClass, correctly initialized
for the various processors.

2) A similar helper but using ppc_check_compat() to check the arch
level, instead of using env->mmu_model.
--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--L6iaP+gRLNZHKoI4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloU4foACgkQbDjKyiDZ
s5LB4xAAjkd1A+hUxkOfPembIo/1dK0InoWEUzbYP+CZrcPpgGpBdNOi6NB9rMEi
BHQdyi2YVJxhZlsiDw70PrCL8C0W5xlYlIHTDur48M3cptCBVNHRzoWw7pgEBIfY
rIYJLaVixUZQtt0DWSugKIDib26mHfGEHAYB/O29pPDAVod2WAa2Zojd1uUG7d1Z
puYODzvvrPaiadhRHew0BOZOJNlfvM4X2Pgt6DiW6soEGjRpTsxncW9IN0kVs9NR
lhuFlIXQW8YvjPntNvuOMGwPddUTZPjdAAcjsCfyrFo/w1AYr7kk8qwVFeMYKkAk
yRYsh6Dxb+dmZGGRSoxUJFW6C+dO9Goyj33rlgjcGLWD3r7NuqyUsQTSKw8fRDr9
MNI4826c4rZ2wqovzeYRV3pO4Kp4YB7YL4woQQbw9a7R4GK5MjqYYE/OzNihVUtc
3Vb1ssEFnWJTTmxNE6aB7SUjfls6Su48pviPrZKRateqrFflNwu7k8EEaGpY7u1h
05oUOkynVuDpWGtMrxAaRWY9FfVKEa7i/naWXqVqmGPJmIZHu3RGd3k9cQD1cx+0
EUJ4toyE2/gjri374buUoSAE/YeVO8vPug+0LI2XgX7yX8ed+6Zo2FSJG3CxHZf8
AHDiRrwTYinFJtd01L47t4Rchi9KVh3w28afVyVQ3y1QP83T11c=
=dLP2
-----END PGP SIGNATURE-----

--L6iaP+gRLNZHKoI4--
