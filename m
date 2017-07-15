Received: from eggs.gnu.org ([2001:4830:134:3::10]:53305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dWD23-0007CX-QJ
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 22:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dWD22-0002Wm-9N
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 22:42:11 -0400
Date: Sat, 15 Jul 2017 12:36:04 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170715023604.GF17539@umbus.fritz.box>
References: <1500040339-119465-1-git-send-email-imammedo@redhat.com>
	<1500040339-119465-29-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="cz6wLo+OExbGG7q/"
Content-Disposition: inline
In-Reply-To: <1500040339-119465-29-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 28/28] ppc: replace cpu_ppc_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-ppc@nongnu.org


--cz6wLo+OExbGG7q/
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2017 at 03:52:19PM +0200, Igor Mammedov wrote:
> it's just a wrapper, drop it and use cpu_generic_init() directly
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> CC: Alexander Graf <agraf@suse.de>
> CC: David Gibson <david@gibson.dropbear.id.au>
> CC: "Herv=E9 Poussineau" <hpoussin@reactos.org>
> CC: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> CC: qemu-ppc@nongnu.org
> ---
>  target/ppc/cpu.h            | 3 +--
>  hw/ppc/e500.c               | 3 ++-
>  hw/ppc/mac_newworld.c       | 3 ++-
>  hw/ppc/mac_oldworld.c       | 3 ++-
>  hw/ppc/ppc440_bamboo.c      | 2 +-
>  hw/ppc/ppc4xx_devs.c        | 2 +-
>  hw/ppc/prep.c               | 5 +++--
>  hw/ppc/virtex_ml507.c       | 2 +-
>  target/ppc/translate_init.c | 5 -----
>  9 files changed, 13 insertions(+), 15 deletions(-)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 6ee2a26..696cbeb 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1276,7 +1276,6 @@ extern const struct VMStateDescription vmstate_ppc_=
cpu;
>  #endif
> =20
>  /***********************************************************************=
******/
> -PowerPCCPU *cpu_ppc_init(const char *cpu_model);
>  void ppc_translate_init(void);
>  const char *ppc_cpu_lookup_alias(const char *alias);
>  /* you can call this signal handler from your SIGBUS and SIGSEGV
> @@ -1353,7 +1352,7 @@ static inline uint64_t ppc_dump_gpr(CPUPPCState *en=
v, int gprn)
>  int ppc_dcr_read (ppc_dcr_t *dcr_env, int dcrn, uint32_t *valp);
>  int ppc_dcr_write (ppc_dcr_t *dcr_env, int dcrn, uint32_t val);
> =20
> -#define cpu_init(cpu_model) CPU(cpu_ppc_init(cpu_model))
> +#define cpu_init(cpu_model) cpu_generic_init(TYPE_POWERPC_CPU, cpu_model)
> =20
>  #define cpu_signal_handler cpu_ppc_signal_handler
>  #define cpu_list ppc_cpu_list
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index 62f1857..f0596f3 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -819,7 +819,8 @@ void ppce500_init(MachineState *machine, PPCE500Param=
s *params)
>          CPUState *cs;
>          qemu_irq *input;
> =20
> -        cpu =3D cpu_ppc_init(machine->cpu_model);
> +        cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
> +                                           machine->cpu_model));
>          if (cpu =3D=3D NULL) {
>              fprintf(stderr, "Unable to initialize CPU!\n");
>              exit(1);
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index bae1c0a..72c98e9 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -187,7 +187,8 @@ static void ppc_core99_init(MachineState *machine)
>  #endif
>      }
>      for (i =3D 0; i < smp_cpus; i++) {
> -        cpu =3D cpu_ppc_init(machine->cpu_model);
> +        cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
> +                                           machine->cpu_model));
>          if (cpu =3D=3D NULL) {
>              fprintf(stderr, "Unable to find PowerPC CPU definition\n");
>              exit(1);
> diff --git a/hw/ppc/mac_oldworld.c b/hw/ppc/mac_oldworld.c
> index 97bb854..6fc2a19 100644
> --- a/hw/ppc/mac_oldworld.c
> +++ b/hw/ppc/mac_oldworld.c
> @@ -116,7 +116,8 @@ static void ppc_heathrow_init(MachineState *machine)
>      if (machine->cpu_model =3D=3D NULL)
>          machine->cpu_model =3D "G3";
>      for (i =3D 0; i < smp_cpus; i++) {
> -        cpu =3D cpu_ppc_init(machine->cpu_model);
> +        cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
> +                                           machine->cpu_model));
>          if (cpu =3D=3D NULL) {
>              fprintf(stderr, "Unable to find PowerPC CPU definition\n");
>              exit(1);
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index 9d997bf..ca26398 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -186,7 +186,7 @@ static void bamboo_init(MachineState *machine)
>      if (machine->cpu_model =3D=3D NULL) {
>          machine->cpu_model =3D "440EP";
>      }
> -    cpu =3D cpu_ppc_init(machine->cpu_model);
> +    cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, machine->cpu_=
model));
>      if (cpu =3D=3D NULL) {
>          fprintf(stderr, "Unable to initialize CPU!\n");
>          exit(1);
> diff --git a/hw/ppc/ppc4xx_devs.c b/hw/ppc/ppc4xx_devs.c
> index e7f413e..6b38ed7 100644
> --- a/hw/ppc/ppc4xx_devs.c
> +++ b/hw/ppc/ppc4xx_devs.c
> @@ -56,7 +56,7 @@ PowerPCCPU *ppc4xx_init(const char *cpu_model,
>      CPUPPCState *env;
> =20
>      /* init CPUs */
> -    cpu =3D cpu_ppc_init(cpu_model);
> +    cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, cpu_model));
>      if (cpu =3D=3D NULL) {
>          fprintf(stderr, "Unable to find PowerPC %s CPU definition\n",
>                  cpu_model);
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 36d3dcd..00f3321 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -520,7 +520,8 @@ static void ppc_prep_init(MachineState *machine)
>      if (machine->cpu_model =3D=3D NULL)
>          machine->cpu_model =3D "602";
>      for (i =3D 0; i < smp_cpus; i++) {
> -        cpu =3D cpu_ppc_init(machine->cpu_model);
> +        cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU,
> +                                           machine->cpu_model));
>          if (cpu =3D=3D NULL) {
>              fprintf(stderr, "Unable to find PowerPC CPU definition\n");
>              exit(1);
> @@ -724,7 +725,7 @@ static void ibm_40p_init(MachineState *machine)
>      if (!machine->cpu_model) {
>          machine->cpu_model =3D "604";
>      }
> -    cpu =3D cpu_ppc_init(machine->cpu_model);
> +    cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, machine->cpu_=
model));
>      if (!cpu) {
>          error_report("could not initialize CPU '%s'",
>                       machine->cpu_model);
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index fdbcf22..d5fdc16 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -96,7 +96,7 @@ static PowerPCCPU *ppc440_init_xilinx(ram_addr_t *ram_s=
ize,
>      CPUPPCState *env;
>      qemu_irq *irqs;
> =20
> -    cpu =3D cpu_ppc_init(cpu_model);
> +    cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, cpu_model));
>      if (cpu =3D=3D NULL) {
>          fprintf(stderr, "Unable to initialize CPU!\n");
>          exit(1);
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index 783bf98..b4eaabb 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -10250,11 +10250,6 @@ const char *ppc_cpu_lookup_alias(const char *ali=
as)
>      return NULL;
>  }
> =20
> -PowerPCCPU *cpu_ppc_init(const char *cpu_model)
> -{
> -    return POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, cpu_model));
> -}
> -
>  PowerPCCPUClass *ppc_cpu_get_family_class(PowerPCCPUClass *pcc)
>  {
>      ObjectClass *oc =3D OBJECT_CLASS(pcc);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--cz6wLo+OExbGG7q/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAllpf5IACgkQbDjKyiDZ
s5KzYw/+LrPI/Y/4BjyMdyAbtboxt5a4Z7NY0BjmXTHvuO76RILgFfcUQqgHLXlP
ukZENJBmwql6ek3uR6TMsqFbxR6ExWZZIYpLyGsyTsLOlpHrIUEe3Urr8ktMpWxi
SePcBELKtQfvQJfrK70s5ilSYW2GdafbOMOd8vldl407JVXg8L4IoAEygHwPYleT
TxdohuKsnD8aJ6MWm8yMCjiWst+hK8tvgTH3jfb36CNlBLW6S1Djqoud2VN50oE5
0MAmC8Hi8gyhrTzSPop8qC2CPhXwdXjuA6sXNq4B3xZZMZQoAisLrIxYI4IEOUAm
ck0H+DyZeuzJubLBsdb2QoPXyb6a8UY9yQh8109mDhBjgSIZcBnNrmtEm+f3/9lm
9F+8leyM2gqoXA80ns5VBK1OcGi6L9C/311a3FcWuuTYLFbMiHwp86iRIAVPVedq
Ura4i/6DouA6f0w8NMC3i3znXD7zRbZKaXznO7YHx15UvlFvT40WWF7cstZeamtu
c1x+rSU9mkupRCfrSdtg7mZu0HwkLL16dQtSxsLG/bysBV8FvSyC0oaLBkrO3Dlg
ycpaVbvsb5RRGwswIsXogX82jhfSVNu88Udxvk3FzouNusoAMcYwBzOMk1MRwQ7Q
5vM08+7kxny57x0jlyg8dmAle4EtscIeQoD72yn4wZq+GlMazAg=
=Ffx9
-----END PGP SIGNATURE-----

--cz6wLo+OExbGG7q/--
