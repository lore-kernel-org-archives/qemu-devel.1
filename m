Received: from eggs.gnu.org ([209.51.188.92]:57941)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGdnS-0007vg-4i
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 02:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGdnQ-0002XH-Ma
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 02:11:50 -0400
Date: Wed, 17 Apr 2019 15:21:23 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190417052123.GM32705@umbus.fritz.box>
References: <20190417025944.16154-1-ehabkost@redhat.com>
	<20190417025944.16154-2-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XbHSybK3LHOYQtWI"
Content-Disposition: inline
In-Reply-To: <20190417025944.16154-2-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/5] cpu: Rename parse_cpu_model() to
 parse_cpu_option()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Like Xu <like.xu@linux.intel.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


--XbHSybK3LHOYQtWI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2019 at 11:59:40PM -0300, Eduardo Habkost wrote:
> The "model[,option...]" string parsed by the function is not just
> a CPU model.  Rename the function and its argument to indicate it
> expects the full "-cpu" option to be provided.
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/qom/cpu.h |  6 +++---
>  bsd-user/main.c   |  2 +-
>  exec.c            |  4 ++--
>  linux-user/main.c |  2 +-
>  vl.c              | 18 +++++++++---------
>  5 files changed, 16 insertions(+), 16 deletions(-)
>=20
> diff --git a/include/qom/cpu.h b/include/qom/cpu.h
> index 1d6099e5d4..d28c690b27 100644
> --- a/include/qom/cpu.h
> +++ b/include/qom/cpu.h
> @@ -689,15 +689,15 @@ ObjectClass *cpu_class_by_name(const char *typename=
, const char *cpu_model);
>  CPUState *cpu_create(const char *typename);
> =20
>  /**
> - * parse_cpu_model:
> - * @cpu_model: The model string including optional parameters.
> + * parse_cpu_option:
> + * @cpu_option: The -cpu option including optional parameters.
>   *
>   * processes optional parameters and registers them as global properties
>   *
>   * Returns: type of CPU to create or prints error and terminates process
>   *          if an error occurred.
>   */
> -const char *parse_cpu_model(const char *cpu_model);
> +const char *parse_cpu_option(const char *cpu_option);
> =20
>  /**
>   * cpu_has_work:
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index 0d3156974c..a6c055f5fb 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -903,7 +903,7 @@ int main(int argc, char **argv)
>      /* init tcg before creating CPUs and to get qemu_host_page_size */
>      tcg_exec_init(0);
> =20
> -    cpu_type =3D parse_cpu_model(cpu_model);
> +    cpu_type =3D parse_cpu_option(cpu_model);
>      cpu =3D cpu_create(cpu_type);
>      env =3D cpu->env_ptr;
>  #if defined(TARGET_SPARC) || defined(TARGET_PPC)
> diff --git a/exec.c b/exec.c
> index 6ab62f4eee..840677f15f 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -982,14 +982,14 @@ void cpu_exec_realizefn(CPUState *cpu, Error **errp)
>  #endif
>  }
> =20
> -const char *parse_cpu_model(const char *cpu_model)
> +const char *parse_cpu_option(const char *cpu_option)
>  {
>      ObjectClass *oc;
>      CPUClass *cc;
>      gchar **model_pieces;
>      const char *cpu_type;
> =20
> -    model_pieces =3D g_strsplit(cpu_model, ",", 2);
> +    model_pieces =3D g_strsplit(cpu_option, ",", 2);
> =20
>      oc =3D cpu_class_by_name(CPU_RESOLVING_TYPE, model_pieces[0]);
>      if (oc =3D=3D NULL) {
> diff --git a/linux-user/main.c b/linux-user/main.c
> index a0aba9cb1e..20e0f51cfa 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -660,7 +660,7 @@ int main(int argc, char **argv, char **envp)
>      if (cpu_model =3D=3D NULL) {
>          cpu_model =3D cpu_get_model(get_elf_eflags(execfd));
>      }
> -    cpu_type =3D parse_cpu_model(cpu_model);
> +    cpu_type =3D parse_cpu_option(cpu_model);
> =20
>      /* init tcg before creating CPUs and to get qemu_host_page_size */
>      tcg_exec_init(0);
> diff --git a/vl.c b/vl.c
> index c696ad2a13..c57e28d1da 100644
> --- a/vl.c
> +++ b/vl.c
> @@ -3002,7 +3002,7 @@ int main(int argc, char **argv, char **envp)
>      const char *optarg;
>      const char *loadvm =3D NULL;
>      MachineClass *machine_class;
> -    const char *cpu_model;
> +    const char *cpu_option;
>      const char *vga_model =3D NULL;
>      const char *qtest_chrdev =3D NULL;
>      const char *qtest_log =3D NULL;
> @@ -3081,7 +3081,7 @@ int main(int argc, char **argv, char **envp)
>      QLIST_INIT (&vm_change_state_head);
>      os_setup_early_signal_handling();
> =20
> -    cpu_model =3D NULL;
> +    cpu_option =3D NULL;
>      snapshot =3D 0;
> =20
>      nb_nics =3D 0;
> @@ -3133,7 +3133,7 @@ int main(int argc, char **argv, char **envp)
>              switch(popt->index) {
>              case QEMU_OPTION_cpu:
>                  /* hw initialization will check this */
> -                cpu_model =3D optarg;
> +                cpu_option =3D optarg;
>                  break;
>              case QEMU_OPTION_hda:
>              case QEMU_OPTION_hdb:
> @@ -4050,8 +4050,8 @@ int main(int argc, char **argv, char **envp)
>          qemu_set_hw_version(machine_class->hw_version);
>      }
> =20
> -    if (cpu_model && is_help_option(cpu_model)) {
> -        list_cpus(stdout, &fprintf, cpu_model);
> +    if (cpu_option && is_help_option(cpu_option)) {
> +        list_cpus(stdout, &fprintf, cpu_option);
>          exit(0);
>      }
> =20
> @@ -4299,9 +4299,9 @@ int main(int argc, char **argv, char **envp)
>       * Global properties get set up by qdev_prop_register_global(),
>       * called from user_register_global_props(), and certain option
>       * desugaring.  Also in CPU feature desugaring (buried in
> -     * parse_cpu_model()), which happens below this point, but may
> +     * parse_cpu_option()), which happens below this point, but may
>       * only target the CPU type, which can only be created after
> -     * parse_cpu_model() returned the type.
> +     * parse_cpu_option() returned the type.
>       *
>       * Machine compat properties: object_set_machine_compat_props().
>       * Accelerator compat props: object_set_accelerator_compat_props(),
> @@ -4465,8 +4465,8 @@ int main(int argc, char **argv, char **envp)
> =20
>      /* parse features once if machine provides default cpu_type */
>      current_machine->cpu_type =3D machine_class->default_cpu_type;
> -    if (cpu_model) {
> -        current_machine->cpu_type =3D parse_cpu_model(cpu_model);
> +    if (cpu_option) {
> +        current_machine->cpu_type =3D parse_cpu_option(cpu_option);
>      }
>      parse_numa_opts(current_machine);
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XbHSybK3LHOYQtWI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAly2t9EACgkQbDjKyiDZ
s5L0bRAAiDaYgA9/mGSM8Cajc0/btU6OTpEd9u65a8qY0gq1cIHAFoz7ktKe0RdS
Lb4HSby8tG/mHpZvZ9sjY2OYL5FMtyLKDJ+iiunTdmum4z2JWdBFVcoqGJw8PauP
9Y8cMD6eqoYj1elOevdOF0N3T8dq4lrdjB+OaTr/wfJHNMx6DJ3D+Fyi/YfXl3CJ
86bXbYGb7J+oZeCUZC6aA/LZ+Ytb0miDBMfNmmvKV5aDtHv8BbMI3zdhrRIZ7c+f
LV8zoWalAUJ3SuimlZf6P3fO8DvYal+gbHlDnUOJKdyq7ZfPJaE9MGt4M2LTXXjB
kdftFauAWLk4qDqUCNDx2F/i7OKSGGLi3IIMRoa6yrqCmPZOJ1oHmjb+fBdYdH1T
DrEA4nYw24GMZ8HX64IwaejqdDlpoaPQUG13Wjl9Fwa5sivvYi+nfh+WA5l0qP5i
ZXnwDeDUyYpT3L52oQdJgxEl33pYvRSTfidzdOhIUBDDo/CYQBdTyY8ZQCUcxEe9
4xjgNBSZ2nkBQp9hEAHIzfy5IEf4rie8Tn2l4iBD+fo7Ba419vxCJ0hJIS1T4E1i
y757eA5ncEbJX/k1HSrNVafqX6xkjSW1V1sVx5F4JXAKV/UJLOCKO8jbP2YwRdyj
YR6aTUdfdlWhXC0907NSUkwPdlaeIne9jLrdHCkadPVlFo7EMDQ=
=IZJz
-----END PGP SIGNATURE-----

--XbHSybK3LHOYQtWI--
