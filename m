Received: from eggs.gnu.org ([2001:4830:134:3::10]:51271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dLP7N-0004ZF-AO
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 03:23:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dLP7M-0002QP-17
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 03:23:01 -0400
Date: Thu, 15 Jun 2017 15:20:44 +0800
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170615072044.GI2614@umbus>
References: <1497505464-12796-1-git-send-email-bharata@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="J+eNKFoVC4T1DV3f"
Content-Disposition: inline
In-Reply-To: <1497505464-12796-1-git-send-email-bharata@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [FIX PATCH] target/ppc: Proper cleanup when
 ppc_cpu_realizefn fails
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bharata B Rao <bharata@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--J+eNKFoVC4T1DV3f
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 15, 2017 at 11:14:24AM +0530, Bharata B Rao wrote:
> If ppc_cpu_realizefn() fails after cpu_exec_realizefn() has been
> called, we will have to undo whatever cpu_exec_realizefn() did
> by explicitly calling cpu_exec_unrealizeffn() which is currently
> missing. Failure to do this proper cleanup will result in CPU
> which was never fully realized to linger on the cpus list causing
> SIGSEGV later (for eg when running "info cpus").
>=20
> Signed-off-by: Bharata B Rao <bharata@linux.vnet.ibm.com>

Applied to ppc-for-2.10.

> ---
>  target/ppc/translate_init.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>=20
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index e837cd2..53aff5a 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -9825,14 +9825,14 @@ static void ppc_cpu_realizefn(DeviceState *dev, E=
rror **errp)
>          error_append_hint(errp, "Adjust the number of cpus to %d "
>                            "or try to raise the number of threads per cor=
e\n",
>                            cpu->cpu_dt_id * smp_threads / max_smt);
> -        return;
> +        goto unrealize;
>      }
>  #endif
> =20
>      if (tcg_enabled()) {
>          if (ppc_fixup_cpu(cpu) !=3D 0) {
>              error_setg(errp, "Unable to emulate selected CPU with TCG");
> -            return;
> +            goto unrealize;
>          }
>      }
> =20
> @@ -9841,14 +9841,14 @@ static void ppc_cpu_realizefn(DeviceState *dev, E=
rror **errp)
>          error_setg(errp, "CPU does not possess a BookE or 4xx MMU. "
>                     "Please use qemu-system-ppc or qemu-system-ppc64 inst=
ead "
>                     "or choose another CPU model.");
> -        return;
> +        goto unrealize;
>      }
>  #endif
> =20
>      create_ppc_opcodes(cpu, &local_err);
>      if (local_err !=3D NULL) {
>          error_propagate(errp, local_err);
> -        return;
> +        goto unrealize;
>      }
>      init_ppc_proc(cpu);
> =20
> @@ -10033,6 +10033,10 @@ static void ppc_cpu_realizefn(DeviceState *dev, =
Error **errp)
>          fflush(stdout);
>      }
>  #endif
> +    return;
> +
> +unrealize:
> +    cpu_exec_unrealizefn(cs);
>  }
> =20
>  static void ppc_cpu_unrealizefn(DeviceState *dev, Error **errp)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--J+eNKFoVC4T1DV3f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZQjVMAAoJEGw4ysog2bOSFjwP/2x9vyb7xDaRL+Ve1pWanxQu
mmH483zL7Rtdm68HmWilnqD2kPgJ/NcPmJvDaok9PsurKSS/+GzcTIY52F4fEprC
gsS7bwhYC8r/ylZH9HQWqm7L3dR5ZNVvPKqLOM3Pn5+3ELlH9P2TwoUPhTCkzh/q
cu+CeVWUa0aXv118ZR+ofow2yez3tygUIlXdCZptm3r9+FOM7m3lqEbOoP9OdDgG
YvvoPz5thLKad0ohoE+rUoXwR8AiPFj5E+NnJkQ4IjNsz9HItID6FTRaEG9TzEIh
qmqVnw/e0XiGgiIDzqf7K814wQeo4iFyYWZ+gyKx2xD1MlHIm6aqZ1M+Z54SzFOg
cYBbih116EYVCAT85y9z/Mi44W31f2VLJDll17vp1kVgGnUu+nkOqiKR4sIlfUwV
woTZmxcuGPAgFfq+Al7NU+wxHcwRKqh8JE5+INsvbRPhITkRGTV5KceRxDgQMSx2
KbGMiyrCn2q/FlkjL9gh4odDkvnygDdEhVOHfs9jHhQsZVj1waZmDPTt37Nlh4XW
lLARrcTAJ7VSLOEOgYX/1gimDPMyvS14CLW2ytqQGb+eyF4dP39ba19D1sm8g4tW
Ue/lDU2LuteF5KpiDgZDNMcxux0lsU7RRHNCtJxcpXLDjh3G/HyZuyxFOSWjD5uQ
kgYY3Wre4au0y5072ImR
=15/m
-----END PGP SIGNATURE-----

--J+eNKFoVC4T1DV3f--
