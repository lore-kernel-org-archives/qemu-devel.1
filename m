Received: from eggs.gnu.org ([2001:4830:134:3::10]:39103)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0qL-0005Wt-6O
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 20:20:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dt0qI-0007hx-0y
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 20:20:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dt0qH-0007hf-OF
	for qemu-devel@nongnu.org; Fri, 15 Sep 2017 20:20:17 -0400
Date: Fri, 15 Sep 2017 21:20:13 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170916002013.GD21016@localhost.localdomain>
References: <20170830225225.27925-1-f4bug@amsat.org>
	<20170830225225.27925-8-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170830225225.27925-8-f4bug@amsat.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 7/7] mips: update mips_cpu_list() to use
 object_class_get_list()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: Igor Mammedov <imammedo@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Aurelien Jarno <aurelien@aurel32.net>, Marcel Apfelbaum <marcel@redhat.com>, James Hogan <james.hogan@imgtec.com>, Yongbok Kim <yongbok.kim@imgtec.com>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org

On Wed, Aug 30, 2017 at 07:52:25PM -0300, Philippe Mathieu-Daud=E9 wrote:
> while here, move it from translate_init.c to helper.c
>=20
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> Tested-by: Igor Mammedov <imammedo@redhat.com>
> Tested-by: James Hogan <james.hogan@imgtec.com>
> ---
>  target/mips/helper.c         | 46 ++++++++++++++++++++++++++++++++++++=
++++++++
>  target/mips/translate_init.c | 10 ----------
>  2 files changed, 46 insertions(+), 10 deletions(-)
>=20
> diff --git a/target/mips/helper.c b/target/mips/helper.c
> index ea076261af..8d12b0088a 100644
> --- a/target/mips/helper.c
> +++ b/target/mips/helper.c
> @@ -1093,3 +1093,49 @@ void QEMU_NORETURN do_raise_exception_err(CPUMIP=
SState *env,
> =20
>      cpu_loop_exit_restore(cs, pc);
>  }
> +
> +/* Sort alphabetically by type name, except for "any". */
> +static gint mips_cpu_list_compare(gconstpointer a, gconstpointer b)
> +{
> +    ObjectClass *class_a =3D (ObjectClass *)a;
> +    ObjectClass *class_b =3D (ObjectClass *)b;
> +    const char *name_a, *name_b;
> +
> +    name_a =3D object_class_get_name(class_a);
> +    name_b =3D object_class_get_name(class_b);
> +    if (strcmp(name_a, "any-" TYPE_MIPS_CPU) =3D=3D 0) {
> +        return 1;
> +    } else if (strcmp(name_b, "any-" TYPE_MIPS_CPU) =3D=3D 0) {
> +        return -1;
> +    } else {
> +        return strcmp(name_a, name_b);
> +    }

This works, but I'd prefer to do like x86 and have a
MIPSCPUClass::ordering field.

(Or, even better: to add a generic CPUClass::ordering field so
all architectures can use the same method to order the model
list)

> +}
> +
> +static void mips_cpu_list_entry(gpointer data, gpointer user_data)
> +{
> +    ObjectClass *oc =3D data;
> +    CPUListState *s =3D user_data;
> +    const char *typename;
> +    char *name;
> +
> +    typename =3D object_class_get_name(oc);
> +    name =3D g_strndup(typename, strlen(typename) - strlen("-" TYPE_MI=
PS_CPU));
> +    (*s->cpu_fprintf)(s->file, "  %s\n", name);
> +    g_free(name);
> +}
> +
> +void mips_cpu_list(FILE *f, fprintf_function cpu_fprintf)
> +{
> +    CPUListState s =3D {
> +        .file =3D f,
> +        .cpu_fprintf =3D cpu_fprintf,
> +    };
> +    GSList *list;
> +
> +    list =3D object_class_get_list(TYPE_MIPS_CPU, false);
> +    list =3D g_slist_sort(list, mips_cpu_list_compare);
> +    (*cpu_fprintf)(f, "Available CPUs:\n");
> +    g_slist_foreach(list, mips_cpu_list_entry, &s);
> +    g_slist_free(list);
> +}

I think it's about time we implement a generic mechanism to list
CPU models using the QOM hierarchy, but this is out of the scope
of this series.


> diff --git a/target/mips/translate_init.c b/target/mips/translate_init.=
c
> index 8bbded46c4..b75f4c9065 100644
> --- a/target/mips/translate_init.c
> +++ b/target/mips/translate_init.c
> @@ -767,16 +767,6 @@ static const mips_def_t *cpu_mips_find_by_name (co=
nst char *name)
>      return NULL;
>  }
> =20
> -void mips_cpu_list (FILE *f, fprintf_function cpu_fprintf)
> -{
> -    int i;
> -
> -    for (i =3D 0; i < ARRAY_SIZE(mips_defs); i++) {
> -        (*cpu_fprintf)(f, "MIPS '%s'\n",
> -                       mips_defs[i].name);
> -    }
> -}
> -
>  #ifndef CONFIG_USER_ONLY
>  static void no_mmu_init (CPUMIPSState *env, const mips_def_t *def)
>  {
> --=20
> 2.14.1
>=20
>=20

--=20
Eduardo
