Received: from eggs.gnu.org ([2001:4830:134:3::10]:50108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1dtuo4-000441-79
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:05:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <atar4qemu@gmail.com>) id 1dtuo2-0003Er-EM
	for qemu-devel@nongnu.org; Mon, 18 Sep 2017 08:05:44 -0400
MIME-Version: 1.0
In-Reply-To: <20170917232842.14544-1-f4bug@amsat.org>
References: <20170917232842.14544-1-f4bug@amsat.org>
From: Artyom Tarasenko <atar4qemu@gmail.com>
Date: Mon, 18 Sep 2017 14:05:19 +0200
Message-ID: <CACXAS8Bz6R-VXLq1o_Z0vNr=u4Fy6GQAMn7Rpd2QZv4t-gn=GQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] qom/cpu: move cpu_model null check to
 cpu_class_by_name()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Llu=C3=ADs_Vilanova?= <vilanova@ac.upc.edu>, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Anthony Green <green@moxielogic.com>, Aurelien Jarno <aurelien@aurel32.net>, Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Chris Wulff <crwulff@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Laurent Vivier <laurent@vivier.eu>, Marek Vasut <marex@denx.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Max Filippov <jcmvbkbc@gmail.com>, Michael Walle <michael@walle.cc>, Peter Maydell <peter.maydell@linaro.org>, Stafford Horne <shorne@gmail.com>, Yongbok Kim <yongbok.kim@imgtec.com>, qemu-devel <qemu-devel@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>, qemu-ppc@nongnu.org, Marcel Apfelbaum <marcel@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>

On Mon, Sep 18, 2017 at 1:28 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
> and clean every implementation.
>
> Suggested-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

> ---
> Based-on: 20170917232010.14183-7-f4bug@amsat.org
>
>  qom/cpu.c              | 7 ++++++-
>  target/alpha/cpu.c     | 6 +-----
>  target/arm/cpu.c       | 4 ----
>  target/cris/cpu.c      | 4 ----
>  target/lm32/cpu.c      | 4 ----
>  target/m68k/cpu.c      | 4 ----
>  target/mips/cpu.c      | 4 ----
>  target/moxie/cpu.c     | 8 +-------
>  target/openrisc/cpu.c  | 4 ----
>  target/sh4/cpu.c       | 3 ---
>  target/sparc/cpu.c     | 4 ----
>  target/tricore/cpu.c   | 4 ----
>  target/unicore32/cpu.c | 4 ----
>  target/xtensa/cpu.c    | 4 ----
>  14 files changed, 8 insertions(+), 56 deletions(-)
>
> diff --git a/qom/cpu.c b/qom/cpu.c
> index dc5392dbeb..411d8cdd2b 100644
> --- a/qom/cpu.c
> +++ b/qom/cpu.c
> @@ -311,7 +311,12 @@ static bool cpu_common_has_work(CPUState *cs)
>
>  ObjectClass *cpu_class_by_name(const char *typename, const char *cpu_mod=
el)
>  {
> -    CPUClass *cc =3D CPU_CLASS(object_class_by_name(typename));
> +    CPUClass *cc;
> +
> +    if (!cpu_model) {
> +        return NULL;
> +    }
> +    cc =3D CPU_CLASS(object_class_by_name(typename));
>
>      return cc->class_by_name(cpu_model);
>  }
> diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
> index e6c6aabdf0..b8a21f4e01 100644
> --- a/target/alpha/cpu.c
> +++ b/target/alpha/cpu.c
> @@ -127,14 +127,10 @@ static const AlphaCPUAlias alpha_cpu_aliases[] =3D =
{
>
>  static ObjectClass *alpha_cpu_class_by_name(const char *cpu_model)
>  {
> -    ObjectClass *oc =3D NULL;
> +    ObjectClass *oc;
>      char *typename;
>      int i;
>
> -    if (cpu_model =3D=3D NULL) {
> -        return NULL;
> -    }
> -
>      oc =3D object_class_by_name(cpu_model);
>      if (oc !=3D NULL && object_class_dynamic_cast(oc, TYPE_ALPHA_CPU) !=
=3D NULL &&
>          !object_class_is_abstract(oc)) {
> diff --git a/target/arm/cpu.c b/target/arm/cpu.c
> index 412e94c7ad..ea219c2dde 100644
> --- a/target/arm/cpu.c
> +++ b/target/arm/cpu.c
> @@ -906,10 +906,6 @@ static ObjectClass *arm_cpu_class_by_name(const char=
 *cpu_model)
>      char *typename;
>      char **cpuname;
>
> -    if (!cpu_model) {
> -        return NULL;
> -    }
> -
>      cpuname =3D g_strsplit(cpu_model, ",", 1);
>      typename =3D g_strdup_printf("%s-" TYPE_ARM_CPU, cpuname[0]);
>      oc =3D object_class_by_name(typename);
> diff --git a/target/cris/cpu.c b/target/cris/cpu.c
> index ceebfed79b..88d93f2d11 100644
> --- a/target/cris/cpu.c
> +++ b/target/cris/cpu.c
> @@ -69,10 +69,6 @@ static ObjectClass *cris_cpu_class_by_name(const char =
*cpu_model)
>      ObjectClass *oc;
>      char *typename;
>
> -    if (cpu_model =3D=3D NULL) {
> -        return NULL;
> -    }
> -
>  #if defined(CONFIG_USER_ONLY)
>      if (strcasecmp(cpu_model, "any") =3D=3D 0) {
>          return object_class_by_name("crisv32-" TYPE_CRIS_CPU);
> diff --git a/target/lm32/cpu.c b/target/lm32/cpu.c
> index 2b8c36b6d0..bf081f56d2 100644
> --- a/target/lm32/cpu.c
> +++ b/target/lm32/cpu.c
> @@ -246,10 +246,6 @@ static ObjectClass *lm32_cpu_class_by_name(const cha=
r *cpu_model)
>      ObjectClass *oc;
>      char *typename;
>
> -    if (cpu_model =3D=3D NULL) {
> -        return NULL;
> -    }
> -
>      typename =3D g_strdup_printf("%s-" TYPE_LM32_CPU, cpu_model);
>      oc =3D object_class_by_name(typename);
>      g_free(typename);
> diff --git a/target/m68k/cpu.c b/target/m68k/cpu.c
> index 55bf24bae6..8c70e0805c 100644
> --- a/target/m68k/cpu.c
> +++ b/target/m68k/cpu.c
> @@ -87,10 +87,6 @@ static ObjectClass *m68k_cpu_class_by_name(const char =
*cpu_model)
>      ObjectClass *oc;
>      char *typename;
>
> -    if (cpu_model =3D=3D NULL) {
> -        return NULL;
> -    }
> -
>      typename =3D g_strdup_printf("%s-" TYPE_M68K_CPU, cpu_model);
>      oc =3D object_class_by_name(typename);
>      g_free(typename);
> diff --git a/target/mips/cpu.c b/target/mips/cpu.c
> index 1a9a3ed94d..c15b894362 100644
> --- a/target/mips/cpu.c
> +++ b/target/mips/cpu.c
> @@ -166,10 +166,6 @@ static ObjectClass *mips_cpu_class_by_name(const cha=
r *cpu_model)
>      ObjectClass *oc;
>      char *typename;
>
> -    if (cpu_model =3D=3D NULL) {
> -        return NULL;
> -    }
> -
>      typename =3D mips_cpu_type_name(cpu_model);
>      oc =3D object_class_by_name(typename);
>      g_free(typename);
> diff --git a/target/moxie/cpu.c b/target/moxie/cpu.c
> index 748d02f29e..30bd44fcad 100644
> --- a/target/moxie/cpu.c
> +++ b/target/moxie/cpu.c
> @@ -89,13 +89,7 @@ static void moxie_cpu_initfn(Object *obj)
>
>  static ObjectClass *moxie_cpu_class_by_name(const char *cpu_model)
>  {
> -    ObjectClass *oc;
> -
> -    if (cpu_model =3D=3D NULL) {
> -        return NULL;
> -    }
> -
> -    oc =3D object_class_by_name(cpu_model);
> +    ObjectClass *oc =3D object_class_by_name(cpu_model);
>      if (oc !=3D NULL && (!object_class_dynamic_cast(oc, TYPE_MOXIE_CPU) =
||
>                         object_class_is_abstract(oc))) {
>          return NULL;
> diff --git a/target/openrisc/cpu.c b/target/openrisc/cpu.c
> index a979f0bf8b..af9cdcc102 100644
> --- a/target/openrisc/cpu.c
> +++ b/target/openrisc/cpu.c
> @@ -108,10 +108,6 @@ static ObjectClass *openrisc_cpu_class_by_name(const=
 char *cpu_model)
>      ObjectClass *oc;
>      char *typename;
>
> -    if (cpu_model =3D=3D NULL) {
> -        return NULL;
> -    }
> -
>      typename =3D g_strdup_printf("%s-" TYPE_OPENRISC_CPU, cpu_model);
>      oc =3D object_class_by_name(typename);
>      g_free(typename);
> diff --git a/target/sh4/cpu.c b/target/sh4/cpu.c
> index 6ce7cba5a9..252440e019 100644
> --- a/target/sh4/cpu.c
> +++ b/target/sh4/cpu.c
> @@ -133,9 +133,6 @@ static ObjectClass *superh_cpu_class_by_name(const ch=
ar *cpu_model)
>      ObjectClass *oc;
>      GSList *list, *item;
>
> -    if (cpu_model =3D=3D NULL) {
> -        return NULL;
> -    }
>      if (strcasecmp(cpu_model, "any") =3D=3D 0) {
>          return object_class_by_name(TYPE_SH7750R_CPU);
>      }
> diff --git a/target/sparc/cpu.c b/target/sparc/cpu.c
> index 0806d699e6..beab90f3e6 100644
> --- a/target/sparc/cpu.c
> +++ b/target/sparc/cpu.c
> @@ -730,10 +730,6 @@ static ObjectClass *sparc_cpu_class_by_name(const ch=
ar *cpu_model)
>      ObjectClass *oc;
>      char *typename;
>
> -    if (cpu_model =3D=3D NULL) {
> -        return NULL;
> -    }
> -
>      typename =3D sparc_cpu_type_name(cpu_model);
>      oc =3D object_class_by_name(typename);
>      g_free(typename);
> diff --git a/target/tricore/cpu.c b/target/tricore/cpu.c
> index 5ab5b56454..871eb35453 100644
> --- a/target/tricore/cpu.c
> +++ b/target/tricore/cpu.c
> @@ -120,10 +120,6 @@ static ObjectClass *tricore_cpu_class_by_name(const =
char *cpu_model)
>      ObjectClass *oc;
>      char *typename;
>
> -    if (!cpu_model) {
> -        return NULL;
> -    }
> -
>      typename =3D g_strdup_printf("%s-" TYPE_TRICORE_CPU, cpu_model);
>      oc =3D object_class_by_name(typename);
>      g_free(typename);
> diff --git a/target/unicore32/cpu.c b/target/unicore32/cpu.c
> index c9b78ce68e..138acc9dd8 100644
> --- a/target/unicore32/cpu.c
> +++ b/target/unicore32/cpu.c
> @@ -44,10 +44,6 @@ static ObjectClass *uc32_cpu_class_by_name(const char =
*cpu_model)
>      ObjectClass *oc;
>      char *typename;
>
> -    if (cpu_model =3D=3D NULL) {
> -        return NULL;
> -    }
> -
>      typename =3D g_strdup_printf("%s-" TYPE_UNICORE32_CPU, cpu_model);
>      oc =3D object_class_by_name(typename);
>      g_free(typename);
> diff --git a/target/xtensa/cpu.c b/target/xtensa/cpu.c
> index 85897df0a8..dcdc765a86 100644
> --- a/target/xtensa/cpu.c
> +++ b/target/xtensa/cpu.c
> @@ -83,10 +83,6 @@ static ObjectClass *xtensa_cpu_class_by_name(const cha=
r *cpu_model)
>      ObjectClass *oc;
>      char *typename;
>
> -    if (cpu_model =3D=3D NULL) {
> -        return NULL;
> -    }
> -
>      typename =3D g_strdup_printf("%s-" TYPE_XTENSA_CPU, cpu_model);
>      oc =3D object_class_by_name(typename);
>      g_free(typename);
> --
> 2.14.1
>



--=20
Regards,
Artyom Tarasenko

SPARC and PPC PReP under qemu blog: http://tyom.blogspot.com/search/label/q=
emu
