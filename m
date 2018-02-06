Received: from eggs.gnu.org ([2001:4830:134:3::10]:57376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejBgO-0004n8-VR
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 17:25:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1ejBgL-0008IL-RK
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 17:25:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:37014)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1ejBgL-0008H0-Hc
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 17:25:41 -0500
Date: Tue, 6 Feb 2018 20:25:38 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180206222538.GE13301@localhost.localdomain>
References: <1516694904-64879-24-git-send-email-imammedo@redhat.com>
	<1517850509-111036-1-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1517850509-111036-1-git-send-email-imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 23/25] Use cpu_create(type) instead of
 cpu_init(cpu_model)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, "Emilio G. Cota" <cota@braap.org>, Paolo Bonzini <pbonzini@redhat.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>

On Mon, Feb 05, 2018 at 06:08:29PM +0100, Igor Mammedov wrote:
> With all targets defining CPU_RESOLVING_TYPE, refactor
> cpu_parse_cpu_model(type, cpu_model) to parse_cpu_model(cpu_model)
> so that callers won't have to know internal resolving cpu
> type. Place it in exec.c so it could be called from both
> target independed vl.c and *-user/main.c.
>=20
> That allows us to stop abusing cpu type from
>   MachineClass::default_cpu_type
> as resolver class in vl.c which were confusing part of
> cpu_parse_cpu_model().
>=20
> Also with new parse_cpu_model(), the last users of cpu_init()
> in null-machine.c and bsd/linux-user targets could be switched
> to cpu_create() API and cpu_init() API will be removed by
> follow up patch.
>=20
> With no longer users left remove MachineState::cpu_model field,
> new code should use MachineState::cpu_type instead and
> leave cpu_model parsing to generic code in vl.c.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> v4:
>   - actually remove no longer used MachineState::cpu_model field
>     that I've lost somewhere during respins
>=20
>   - squash in [PATCH v3 25/25] cpu: get rid of cpu_generic_init()
>     as after rework/rebase cpu_generic_init() is being removed by
>     this patch and only check removal was left in 25/25, which
>     should be removed together with cpu_generic_init() in this patch
>=20
> CC: Richard Henderson <richard.henderson@linaro.org>
> CC: "Emilio G. Cota" <cota@braap.org>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: "Alex Benn=E9e" <alex.bennee@linaro.org>
> CC: "Philippe Mathieu-Daud=E9" <f4bug@amsat.org>
>=20
> fixup: Use cpu_create(type) instead of  cpu_init(cpu_model)
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  include/hw/boards.h    |  1 -
>  include/qom/cpu.h      | 16 ++--------------
>  bsd-user/main.c        |  4 +++-
>  exec.c                 | 23 +++++++++++++++++++++++
>  hw/core/null-machine.c |  6 +++---
>  linux-user/main.c      |  8 ++++++--
>  qom/cpu.c              | 48 ++----------------------------------------=
------
>  vl.c                   | 10 +++-------
>  8 files changed, 42 insertions(+), 74 deletions(-)

Less 32 lines.  Nice.  :)


[...]
> @@ -335,22 +304,9 @@ static ObjectClass *cpu_common_class_by_name(const=
 char *cpu_model)
>  static void cpu_common_parse_features(const char *typename, char *feat=
ures,
>                                        Error **errp)
>  {
> -    char *featurestr; /* Single "key=3Dvalue" string being parsed */
>      char *val;
> -    static bool cpu_globals_initialized;
> -
> -    /* TODO: all callers of ->parse_features() need to be changed to
> -     * call it only once, so we can remove this check (or change it
> -     * to assert(!cpu_globals_initialized).
> -     * Current callers of ->parse_features() are:
> -     * - cpu_generic_init()
> -     */
> -    if (cpu_globals_initialized) {
> -        return;

Suggestion: replace this with assert(!cpu_globals_initialized)
just to make sure there are no bugs that make us register CPU
globals twice.

This shouldn't block the patch, though:

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

> -    }
> -    cpu_globals_initialized =3D true;
> -
> -    featurestr =3D features ? strtok(features, ",") : NULL;
> +    /* Single "key=3Dvalue" string being parsed */
> +    char *featurestr =3D features ? strtok(features, ",") : NULL;
> =20
>      while (featurestr) {
>          val =3D strchr(featurestr, '=3D');
[...]

--=20
Eduardo
