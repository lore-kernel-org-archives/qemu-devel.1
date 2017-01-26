Received: from eggs.gnu.org ([2001:4830:134:3::10]:58833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWdOd-0001PS-Hv
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 01:19:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1cWdOa-00017L-Dv
	for qemu-devel@nongnu.org; Thu, 26 Jan 2017 01:18:59 -0500
References: <Pine.NEB.4.64.1701251446290.11466@sdf.lonestar.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ac4f39e3-6ef7-e57d-f393-e0d069be192d@redhat.com>
Date: Thu, 26 Jan 2017 07:18:49 +0100
MIME-Version: 1.0
In-Reply-To: <Pine.NEB.4.64.1701251446290.11466@sdf.lonestar.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] target-ppc: Add MMU model
 check for booke machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Valentin Plotkin <caliborn@SDF.ORG>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, qemu-ppc@nongnu.org, Scott Wood <scottwood@freescale.com>, David Gibson <david@gibson.dropbear.id.au>

On 25.01.2017 15:50, Valentin Plotkin wrote:
> Machines bamboo, e500 and virtex-ml507 assume a certain MMU model,
> otherwise resulting in unpredictable behavior. Add apropriate checks
> into *_init functions.
>=20
> Signed-off-by: Valentin <caliborn@sdf.org>

Missing last name? ------^

Apart from that, the patch looks fine to me now, thanks for the update!

 Thomas


> ---
>  hw/ppc/e500.c          | 6 ++++++
>  hw/ppc/ppc440_bamboo.c | 6 ++++++
>  hw/ppc/virtex_ml507.c  | 7 +++++++
>  3 files changed, 19 insertions(+)
>=20
> diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
> index cf8b122..5b1958c 100644
> --- a/hw/ppc/e500.c
> +++ b/hw/ppc/e500.c
> @@ -827,6 +827,12 @@ void ppce500_init(MachineState *machine,
> PPCE500Params *params)
>          env =3D &cpu->env;
>          cs =3D CPU(cpu);
>=20
> +        if (env->mmu_model !=3D POWERPC_MMU_BOOKE206) {
> +            fprintf(stderr, "MMU model %i not supported by this
> machine.\n",
> +                env->mmu_model);
> +            exit(1);
> +        }
> +
>          if (!firstenv) {
>              firstenv =3D env;
>          }
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index 5c535b1..9d997bf 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -193,6 +193,12 @@ static void bamboo_init(MachineState *machine)
>      }
>      env =3D &cpu->env;
>=20
> +    if (env->mmu_model !=3D POWERPC_MMU_BOOKE) {
> +        fprintf(stderr, "MMU model %i not supported by this machine.\n=
",
> +            env->mmu_model);
> +        exit(1);
> +    }
> +
>      qemu_register_reset(main_cpu_reset, cpu);
>      ppc_booke_timers_init(cpu, 400000000, 0);
>      ppc_dcr_init(env, NULL, NULL);
> diff --git a/hw/ppc/virtex_ml507.c b/hw/ppc/virtex_ml507.c
> index b97d966..fdbcf22 100644
> --- a/hw/ppc/virtex_ml507.c
> +++ b/hw/ppc/virtex_ml507.c
> @@ -221,6 +221,13 @@ static void virtex_init(MachineState *machine)
>=20
>      cpu =3D ppc440_init_xilinx(&ram_size, 1, machine->cpu_model, 40000=
0000);
>      env =3D &cpu->env;
> +
> +    if (env->mmu_model !=3D POWERPC_MMU_BOOKE) {
> +        fprintf(stderr, "MMU model %i not supported by this machine.\n=
",
> +            env->mmu_model);
> +        exit(1);
> +    }
> +
>      qemu_register_reset(main_cpu_reset, cpu);
>=20
>      memory_region_allocate_system_memory(phys_ram, NULL, "ram", ram_si=
ze);
