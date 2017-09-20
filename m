Received: from eggs.gnu.org ([2001:4830:134:3::10]:53942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dufeR-0004KQ-NK
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:06:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dufeL-0002LL-LA
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:06:55 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44728)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1dufeL-0002Jk-CB
	for qemu-devel@nongnu.org; Wed, 20 Sep 2017 10:06:49 -0400
Date: Wed, 20 Sep 2017 11:21:16 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170920112116.6885549f@nial.brq.redhat.com>
In-Reply-To: <20170917232010.14183-7-f4bug@amsat.org>
References: <20170917232010.14183-1-f4bug@amsat.org>
	<20170917232010.14183-7-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 6/6] mips: replace cpu_mips_init() with
 cpu_generic_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Yongbok Kim <yongbok.kim@imgtec.com>, Marcel Apfelbaum <marcel@redhat.com>, qemu-devel@nongnu.org, =?UTF-8?B?SGVydsOp?= Poussineau <hpoussin@reactos.org>, James Hogan <james.hogan@imgtec.com>, Thomas Huth <thuth@redhat.com>

On Sun, 17 Sep 2017 20:20:10 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

Hi Philippe,

since series were sitting unmerged on list for a long time
path won't apply due to context changes on top of
 [PATCH v2 0/5] generalize parsing of cpu_model  (x86/arm)
for which Eduardo posted pull req yesterday.

Could you rebase this patch on top of pull req
(it's only this one patch, the rest applies fine)

> From: Igor Mammedov <imammedo@redhat.com>
>=20
> now cpu_mips_init() reimplements subset of cpu_generic_init()
> tasks, so just drop it and use cpu_generic_init() directly.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Herv=C3=A9 Poussineau <hpoussin@reactos.org>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> [PMD: use internal.h instead of cpu.h]
> Tested-by: James Hogan <james.hogan@imgtec.com>
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> ---
>  target/mips/cpu.h       |  3 +--
>  hw/mips/cps.c           |  2 +-
>  hw/mips/mips_fulong2e.c |  2 +-
>  hw/mips/mips_jazz.c     |  2 +-
>  hw/mips/mips_malta.c    |  2 +-
>  hw/mips/mips_mipssim.c  |  2 +-
>  hw/mips/mips_r4k.c      |  2 +-
>  target/mips/translate.c | 17 -----------------
>  8 files changed, 7 insertions(+), 25 deletions(-)
>=20
> diff --git a/target/mips/cpu.h b/target/mips/cpu.h
> index 2f81e0f950..66265e4eb6 100644
> --- a/target/mips/cpu.h
> +++ b/target/mips/cpu.h
> @@ -737,10 +737,9 @@ enum {
>   */
>  #define CPU_INTERRUPT_WAKE CPU_INTERRUPT_TGT_INT_0
> =20
> -MIPSCPU *cpu_mips_init(const char *cpu_model);
>  int cpu_mips_signal_handler(int host_signum, void *pinfo, void *puc);
> =20
> -#define cpu_init(cpu_model) CPU(cpu_mips_init(cpu_model))
> +#define cpu_init(cpu_model) cpu_generic_init(TYPE_MIPS_CPU, cpu_model)
>  bool cpu_supports_cps_smp(const char *cpu_model);
>  bool cpu_supports_isa(const char *cpu_model, unsigned int isa);
>  void cpu_set_exception_base(int vp_index, target_ulong address);
> diff --git a/hw/mips/cps.c b/hw/mips/cps.c
> index 4ef337d5c4..708899cf92 100644
> --- a/hw/mips/cps.c
> +++ b/hw/mips/cps.c
> @@ -71,7 +71,7 @@ static void mips_cps_realize(DeviceState *dev, Error **=
errp)
>      bool itu_present =3D false;
> =20
>      for (i =3D 0; i < s->num_vp; i++) {
> -        cpu =3D cpu_mips_init(s->cpu_model);
> +        cpu =3D MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, s->cpu_model));
>          if (cpu =3D=3D NULL) {
>              error_setg(errp, "%s: CPU initialization failed",  __func__);
>              return;
> diff --git a/hw/mips/mips_fulong2e.c b/hw/mips/mips_fulong2e.c
> index 3532399a13..5d9462ec35 100644
> --- a/hw/mips/mips_fulong2e.c
> +++ b/hw/mips/mips_fulong2e.c
> @@ -280,7 +280,7 @@ static void mips_fulong2e_init(MachineState *machine)
>      if (cpu_model =3D=3D NULL) {
>          cpu_model =3D "Loongson-2E";
>      }
> -    cpu =3D cpu_mips_init(cpu_model);
> +    cpu =3D MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
>      if (cpu =3D=3D NULL) {
>          fprintf(stderr, "Unable to find CPU definition\n");
>          exit(1);
> diff --git a/hw/mips/mips_jazz.c b/hw/mips/mips_jazz.c
> index df2262a2a8..c1402de1ce 100644
> --- a/hw/mips/mips_jazz.c
> +++ b/hw/mips/mips_jazz.c
> @@ -151,7 +151,7 @@ static void mips_jazz_init(MachineState *machine,
>      if (cpu_model =3D=3D NULL) {
>          cpu_model =3D "R4000";
>      }
> -    cpu =3D cpu_mips_init(cpu_model);
> +    cpu =3D MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
>      if (cpu =3D=3D NULL) {
>          fprintf(stderr, "Unable to find CPU definition\n");
>          exit(1);
> diff --git a/hw/mips/mips_malta.c b/hw/mips/mips_malta.c
> index af678f5784..9ecdc818b1 100644
> --- a/hw/mips/mips_malta.c
> +++ b/hw/mips/mips_malta.c
> @@ -931,7 +931,7 @@ static void create_cpu_without_cps(const char *cpu_mo=
del,
>      int i;
> =20
>      for (i =3D 0; i < smp_cpus; i++) {
> -        cpu =3D cpu_mips_init(cpu_model);
> +        cpu =3D MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
>          if (cpu =3D=3D NULL) {
>              fprintf(stderr, "Unable to find CPU definition\n");
>              exit(1);
> diff --git a/hw/mips/mips_mipssim.c b/hw/mips/mips_mipssim.c
> index 07fc4c2300..1166834f54 100644
> --- a/hw/mips/mips_mipssim.c
> +++ b/hw/mips/mips_mipssim.c
> @@ -163,7 +163,7 @@ mips_mipssim_init(MachineState *machine)
>          cpu_model =3D "24Kf";
>  #endif
>      }
> -    cpu =3D cpu_mips_init(cpu_model);
> +    cpu =3D MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
>      if (cpu =3D=3D NULL) {
>          fprintf(stderr, "Unable to find CPU definition\n");
>          exit(1);
> diff --git a/hw/mips/mips_r4k.c b/hw/mips/mips_r4k.c
> index 2f5ced7409..de212f5c13 100644
> --- a/hw/mips/mips_r4k.c
> +++ b/hw/mips/mips_r4k.c
> @@ -193,7 +193,7 @@ void mips_r4k_init(MachineState *machine)
>          cpu_model =3D "24Kf";
>  #endif
>      }
> -    cpu =3D cpu_mips_init(cpu_model);
> +    cpu =3D MIPS_CPU(cpu_generic_init(TYPE_MIPS_CPU, cpu_model));
>      if (cpu =3D=3D NULL) {
>          fprintf(stderr, "Unable to find CPU definition\n");
>          exit(1);
> diff --git a/target/mips/translate.c b/target/mips/translate.c
> index f7128bc91d..d16d879df7 100644
> --- a/target/mips/translate.c
> +++ b/target/mips/translate.c
> @@ -20523,23 +20523,6 @@ void cpu_mips_realize_env(CPUMIPSState *env)
>      mvp_init(env, env->cpu_model);
>  }
> =20
> -MIPSCPU *cpu_mips_init(const char *cpu_model)
> -{
> -    ObjectClass *oc;
> -    MIPSCPU *cpu;
> -
> -    oc =3D cpu_class_by_name(TYPE_MIPS_CPU, cpu_model);
> -    if (oc =3D=3D NULL) {
> -        return NULL;
> -    }
> -
> -    cpu =3D MIPS_CPU(object_new(object_class_get_name(oc)));
> -
> -    object_property_set_bool(OBJECT(cpu), true, "realized", NULL);
> -
> -    return cpu;
> -}
> -
>  bool cpu_supports_cps_smp(const char *cpu_model)
>  {
>      const mips_def_t *def =3D cpu_mips_find_by_name(cpu_model);
