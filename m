Received: from eggs.gnu.org ([209.51.188.92]:42366)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1grzT3-0003Bc-F4
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 01:16:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1grzT0-0004zE-8C
	for qemu-devel@nongnu.org; Fri, 08 Feb 2019 01:16:53 -0500
Date: Fri, 8 Feb 2019 16:20:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190208052027.GA6434@umbus.fritz.box>
References: <20190206165133.12246-1-farosas@linux.ibm.com>
	<20190206165133.12246-2-farosas@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20190206165133.12246-2-farosas@linux.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 1/1] target/ppc: Enable reporting of
 SPRs to GDB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fabiano Rosas <farosas@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, aik@ozlabs.ru, groug@kaod.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 06, 2019 at 02:51:33PM -0200, Fabiano Rosas wrote:
> This allows reading and writing of SPRs via GDB:
>=20
> (gdb) p/x $srr1
> $1 =3D 0x8000000002803033
>=20
> (gdb) p/x $pvr
> $2 =3D 0x4b0201
> (gdb) set $pvr=3D0x4b0000
> (gdb) p/x $pvr
> $3 =3D 0x4b0000
>=20
> The `info` command can also be used:
> (gdb) info registers spr
>=20
> For this purpose, GDB needs to be provided with an XML description of
> the registers (see the gdb-xml directory for examples) and a set of
> callbacks for reading and writing the registers must be defined.
>=20
> The XML file in this case is created dynamically, based on the SPRs
> already defined in the machine. This way we avoid the need for several
> XML files to suit each possible ppc machine.
>=20
> The gdb_{get,set}_spr_reg callbacks take an index based on the order
> the registers appear in the XML file. This index does not match the
> actual location of the registers in the env->spr array so the
> gdb_find_spr_idx function does that conversion.
>=20
> Note: GDB currently needs to know the guest endianness in order to
> properly print the registers values. This is done automatically by GDB
> when provided with the ELF file or explicitly with the `set endian
> <big|little>` command.
>=20
> Signed-off-by: Fabiano Rosas <farosas@linux.ibm.com>

I've applied this to ppc-for-4.0 because it does something we don't
currently do.  I'm still a bit baffled by the endian handling, but we
can fix that later if necessary.

> ---
>  target/ppc/cpu-qom.h            |  4 +++
>  target/ppc/cpu.h                |  5 +++
>  target/ppc/gdbstub.c            | 61 ++++++++++++++++++++++++++++++++
>  target/ppc/translate_init.inc.c | 62 +++++++++++++++++++++++++++++++--
>  4 files changed, 130 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/cpu-qom.h b/target/ppc/cpu-qom.h
> index 4ea67692e2..3130802304 100644
> --- a/target/ppc/cpu-qom.h
> +++ b/target/ppc/cpu-qom.h
> @@ -179,6 +179,10 @@ typedef struct PowerPCCPUClass {
>      uint32_t flags;
>      int bfd_mach;
>      uint32_t l1_dcache_size, l1_icache_size;
> +#ifndef CONFIG_USER_ONLY
> +    unsigned int gdb_num_sprs;
> +    const char *gdb_spr_xml;
> +#endif
>      const PPCHash64Options *hash64_opts;
>      struct ppc_radix_page_info *radix_page_info;
>      void (*init_proc)(CPUPPCState *env);
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 2c22292e7f..78af7e4608 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -230,6 +230,7 @@ struct ppc_spr_t {
>      void (*oea_write)(DisasContext *ctx, int spr_num, int gpr_num);
>      void (*hea_read)(DisasContext *ctx, int gpr_num, int spr_num);
>      void (*hea_write)(DisasContext *ctx, int spr_num, int gpr_num);
> +    unsigned int gdb_id;
>  #endif
>      const char *name;
>      target_ulong default_value;
> @@ -1263,6 +1264,10 @@ int ppc_cpu_gdb_read_register(CPUState *cpu, uint8=
_t *buf, int reg);
>  int ppc_cpu_gdb_read_register_apple(CPUState *cpu, uint8_t *buf, int reg=
);
>  int ppc_cpu_gdb_write_register(CPUState *cpu, uint8_t *buf, int reg);
>  int ppc_cpu_gdb_write_register_apple(CPUState *cpu, uint8_t *buf, int re=
g);
> +#ifndef CONFIG_USER_ONLY
> +void ppc_gdb_gen_spr_xml(PowerPCCPU *cpu);
> +const char *ppc_gdb_get_dynamic_xml(CPUState *cs, const char *xml_name);
> +#endif
>  int ppc64_cpu_write_elf64_note(WriteCoreDumpFunction f, CPUState *cs,
>                                 int cpuid, void *opaque);
>  int ppc32_cpu_write_elf32_note(WriteCoreDumpFunction f, CPUState *cs,
> diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
> index 19565b584d..fbf3821f4b 100644
> --- a/target/ppc/gdbstub.c
> +++ b/target/ppc/gdbstub.c
> @@ -319,3 +319,64 @@ int ppc_cpu_gdb_write_register_apple(CPUState *cs, u=
int8_t *mem_buf, int n)
>      }
>      return r;
>  }
> +
> +#ifndef CONFIG_USER_ONLY
> +void ppc_gdb_gen_spr_xml(PowerPCCPU *cpu)
> +{
> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> +    CPUPPCState *env =3D &cpu->env;
> +    GString *xml;
> +    char *spr_name;
> +    unsigned int num_regs =3D 0;
> +    int i;
> +
> +    if (pcc->gdb_spr_xml) {
> +        return;
> +    }
> +
> +    xml =3D g_string_new("<?xml version=3D\"1.0\"?>");
> +    g_string_append(xml, "<!DOCTYPE target SYSTEM \"gdb-target.dtd\">");
> +    g_string_append(xml, "<feature name=3D\"org.qemu.power.spr\">");
> +
> +    for (i =3D 0; i < ARRAY_SIZE(env->spr_cb); i++) {
> +        ppc_spr_t *spr =3D &env->spr_cb[i];
> +
> +        if (!spr->name) {
> +            continue;
> +        }
> +
> +        spr_name =3D g_ascii_strdown(spr->name, -1);
> +        g_string_append_printf(xml, "<reg name=3D\"%s\"", spr_name);
> +        g_free(spr_name);
> +
> +        g_string_append_printf(xml, " bitsize=3D\"%d\"", TARGET_LONG_BIT=
S);
> +        g_string_append(xml, " group=3D\"spr\"/>");
> +
> +        /*
> +         * GDB identifies registers based on the order they are
> +         * presented in the XML. These ids will not match QEMU's
> +         * representation (which follows the PowerISA).
> +         *
> +         * Store the position of the current register description so
> +         * we can make the correspondence later.
> +         */
> +        spr->gdb_id =3D num_regs;
> +        num_regs++;
> +    }
> +
> +    g_string_append(xml, "</feature>");
> +
> +    pcc->gdb_num_sprs =3D num_regs;
> +    pcc->gdb_spr_xml =3D g_string_free(xml, false);
> +}
> +
> +const char *ppc_gdb_get_dynamic_xml(CPUState *cs, const char *xml_name)
> +{
> +    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cs);
> +
> +    if (strcmp(xml_name, "power-spr.xml") =3D=3D 0) {
> +        return pcc->gdb_spr_xml;
> +    }
> +    return NULL;
> +}
> +#endif
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 59e0b86762..9295f78d5f 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -8979,6 +8979,10 @@ static void init_ppc_proc(PowerPCCPU *cpu)
>      /* PowerPC implementation specific initialisations (SPRs, timers, ..=
=2E) */
>      (*pcc->init_proc)(env);
> =20
> +#if !defined(CONFIG_USER_ONLY)
> +    ppc_gdb_gen_spr_xml(cpu);
> +#endif
> +
>      /* MSR bits & flags consistency checks */
>      if (env->msr_mask & (1 << 25)) {
>          switch (env->flags & (POWERPC_FLAG_SPE | POWERPC_FLAG_VRE)) {
> @@ -9475,6 +9479,55 @@ static bool avr_need_swap(CPUPPCState *env)
>  #endif
>  }
> =20
> +#if !defined(CONFIG_USER_ONLY)
> +static int gdb_find_spr_idx(CPUPPCState *env, int n)
> +{
> +    int i;
> +
> +    for (i =3D 0; i < ARRAY_SIZE(env->spr_cb); i++) {
> +        ppc_spr_t *spr =3D &env->spr_cb[i];
> +
> +        if (spr->name && spr->gdb_id =3D=3D n) {
> +            return i;
> +        }
> +    }
> +    return -1;
> +}
> +
> +static int gdb_get_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
> +{
> +    int reg;
> +    int len;
> +
> +    reg =3D gdb_find_spr_idx(env, n);
> +    if (reg < 0) {
> +        return 0;
> +    }
> +
> +    len =3D TARGET_LONG_SIZE;
> +    stn_p(mem_buf, len, env->spr[reg]);
> +    ppc_maybe_bswap_register(env, mem_buf, len);
> +    return len;
> +}
> +
> +static int gdb_set_spr_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
> +{
> +    int reg;
> +    int len;
> +
> +    reg =3D gdb_find_spr_idx(env, n);
> +    if (reg < 0) {
> +        return 0;
> +    }
> +
> +    len =3D TARGET_LONG_SIZE;
> +    ppc_maybe_bswap_register(env, mem_buf, len);
> +    env->spr[reg] =3D ldn_p(mem_buf, len);
> +
> +    return len;
> +}
> +#endif
> +
>  static int gdb_get_float_reg(CPUPPCState *env, uint8_t *mem_buf, int n)
>  {
>      if (n < 32) {
> @@ -9704,7 +9757,10 @@ static void ppc_cpu_realize(DeviceState *dev, Erro=
r **errp)
>          gdb_register_coprocessor(cs, gdb_get_vsx_reg, gdb_set_vsx_reg,
>                                   32, "power-vsx.xml", 0);
>      }
> -
> +#ifndef CONFIG_USER_ONLY
> +    gdb_register_coprocessor(cs, gdb_get_spr_reg, gdb_set_spr_reg,
> +                             pcc->gdb_num_sprs, "power-spr.xml", 0);
> +#endif
>      qemu_init_vcpu(cs);
> =20
>      pcc->parent_realize(dev, errp);
> @@ -10467,7 +10523,9 @@ static void ppc_cpu_class_init(ObjectClass *oc, v=
oid *data)
>  #endif
> =20
>      cc->gdb_num_core_regs =3D 71;
> -
> +#ifndef CONFIG_USER_ONLY
> +    cc->gdb_get_dynamic_xml =3D ppc_gdb_get_dynamic_xml;
> +#endif
>  #ifdef USE_APPLE_GDB
>      cc->gdb_read_register =3D ppc_cpu_gdb_read_register_apple;
>      cc->gdb_write_register =3D ppc_cpu_gdb_write_register_apple;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--C7zPtVaVf+AK4Oqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlxdEZsACgkQbDjKyiDZ
s5J0Lg//YFny+R5ouQ2nUfctxeAa4xzxkUHYwN9kF0d7vrwIfNWB9Q61/Of8LE6x
HWYgvWXvdhtFPeB85K4PwH5yGxlcFzNyYlK/pGLGkCZi7SrXZOndc1WW8R6IGxEP
PY7a6cIzJqbQYZwFNxqbrPHN9kdpsJwsw0gp2iLaA9M8tJlgrI/0SA7ySnsOeFPA
h0Jlv+u1Llb8UX/A5ZewHhjPjoqQ2NGmAnjR2n9NloyppHvzhb3YFn08SEzJlYhK
uDwhdSh32LOHqoBTGPVHcGjFSGvgYi/ifoBEkvhsvlP/ckD13YDdBG12ISQdpqOB
uW2j5n+CpcbZhSBvKvuSUlBZdfUL25orKeifpiPN6JpwXUAZdk8vhMrZ9wz8rZii
7SMoAiaFw2diuWL5qkR1VzqEGGm4s+9JA8cgCp15o5NWFFy2cSeXdNFfN2y0ESDh
3v6NdZmJAyBXETfstAmSaORNU/b1QmvZI0EQYkQvwbowyODBD9Jb4cgK01Pk4RxF
22eTIKWPzk2VEogk8JgH3021PPfUCH2YYLmVLzO0Wt3WL2ozuXMmFBC6jI+y8OG2
vYeNBhuknk+vRnvQw8wIszlSWf2bf9QVZ8QHSSflvqgdw8qqLAI8SH+JWckWjFbq
WUFkTiNtl1yVy6shTHNS5msuJ9tjXDUQVGIhWNlkXcJ3PAFPFy0=
=QfVG
-----END PGP SIGNATURE-----

--C7zPtVaVf+AK4Oqc--
