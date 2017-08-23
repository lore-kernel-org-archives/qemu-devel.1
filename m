Received: from eggs.gnu.org ([2001:4830:134:3::10]:42166)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkWjo-0005kX-VQ
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:34:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkWja-0000Qi-G7
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:34:32 -0400
Received: from mx1.redhat.com ([209.132.183.28]:56470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dkWja-0000Q5-6g
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:34:18 -0400
Date: Wed, 23 Aug 2017 11:34:14 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170823143414.GI27715@localhost.localdomain>
References: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
	<1503050939-227939-7-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <1503050939-227939-7-git-send-email-imammedo@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.11 06/27] x86: extract legacy cpu
 features format parser
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On Fri, Aug 18, 2017 at 12:08:38PM +0200, Igor Mammedov wrote:
> Move cpu_model +-feat parsing into a separate file so that it
> could be reused later for parsing similar format of sparc target
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---
> CC: Richard Henderson <rth@twiddle.net>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> CC: Artyom Tarasenko <atar4qemu@gmail.com>
> CC: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> ---
>  include/qom/cpu.h                     |   2 +
>  default-configs/i386-bsd-user.mak     |   1 +
>  default-configs/i386-linux-user.mak   |   1 +
>  default-configs/i386-softmmu.mak      |   1 +
>  default-configs/x86_64-bsd-user.mak   |   1 +
>  default-configs/x86_64-linux-user.mak |   1 +
>  default-configs/x86_64-softmmu.mak    |   1 +
>  target/i386/cpu.c                     | 125 +-------------------------
>  util/Makefile.objs                    |   1 +
>  util/legacy_cpu_features_parser.c     | 161 ++++++++++++++++++++++++++=
++++++++
>  10 files changed, 171 insertions(+), 124 deletions(-)
>  create mode 100644 util/legacy_cpu_features_parser.c
>=20
[...]
> diff --git a/util/legacy_cpu_features_parser.c b/util/legacy_cpu_featur=
es_parser.c
> new file mode 100644
> index 0000000..6b352a3
> --- /dev/null
> +++ b/util/legacy_cpu_features_parser.c
> @@ -0,0 +1,161 @@
> +/* Support for legacy -cpu cpu,features CLI option with +-feat syntax,
> + * used by x86/sparc targets
> + *
> + * Author: Andreas F=E4rber <afaerber@suse.de>
> + * Author: Andre Przywara <andre.przywara@amd.com>
> + * Author: Eduardo Habkost <ehabkost@redhat.com>
> + * Author: Igor Mammedov <imammedo@redhat.com>
> + * Author: Paolo Bonzini <pbonzini@redhat.com>
> + * Author: Markus Armbruster <armbru@redhat.com>

IANAL, but I believe a
  Copyright (c) <YEAR> <COPYRIGHT HOLDER>
line is needed here.

> + *
> + * This program is free software; you can redistribute it and/or modif=
y
> + * it under the terms of the GNU General Public License as published b=
y
> + * the Free Software Foundation; either version 2 of the License, or
> + * (at your option) any later version.
> +
> + * This program is distributed in the hope that it will be useful,
> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> + * GNU General Public License for more details.
> +
> + * You should have received a copy of the GNU General Public License a=
long
> + * with this program; if not, see <http://www.gnu.org/licenses/>.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "qapi/error.h"
> +#include "qemu/cutils.h"
> +#include "qom/cpu.h"
> +#include "qemu/error-report.h"
> +#include "hw/qdev-properties.h"
> +
> +static inline void feat2prop(char *s)
> +{
> +    while ((s =3D strchr(s, '_'))) {
> +        *s =3D '-';
> +    }
> +}
> +
> +static gint compare_string(gconstpointer a, gconstpointer b)
> +{
> +    return g_strcmp0(a, b);
> +}
> +
> +static void
> +cpu_add_feat_as_prop(const char *typename, const char *name, const cha=
r *val)
> +{
> +    GlobalProperty *prop =3D g_new0(typeof(*prop), 1);
> +    prop->driver =3D typename;
> +    prop->property =3D g_strdup(name);
> +    prop->value =3D g_strdup(val);
> +    prop->errp =3D &error_fatal;
> +    qdev_prop_register_global(prop);
> +}
> +
> +/* DO NOT USE WITH NEW CODE
> + * Parse "+feature,-feature,feature=3Dfoo" CPU feature string
> + */
> +void cpu_legacy_parse_featurestr(const char *typename, char *features,
> +                                 Error **errp)
> +{
> +    /* Compatibily hack to maintain legacy +-feat semantic,
> +     * where +-feat overwrites any feature set by
> +     * feat=3Don|feat even if the later is parsed after +-feat
> +     * (i.e. "-x2apic,x2apic=3Don" will result in x2apic disabled)
> +     */
> +    GList *l, *plus_features =3D NULL, *minus_features =3D NULL;
> +    char *featurestr; /* Single 'key=3Dvalue" string being parsed */
> +    static bool cpu_globals_initialized;
> +    bool ambiguous =3D false;
> +
> +    if (cpu_globals_initialized) {
> +        return;
> +    }
> +    cpu_globals_initialized =3D true;
> +
> +    if (!features) {
> +        return;
> +    }
> +
> +    for (featurestr =3D strtok(features, ",");
> +         featurestr;
> +         featurestr =3D strtok(NULL, ",")) {
> +        const char *name;
> +        const char *val =3D NULL;
> +        char *eq =3D NULL;
> +        char num[32];
> +
> +        /* Compatibility syntax: */
> +        if (featurestr[0] =3D=3D '+') {
> +            plus_features =3D g_list_append(plus_features,
> +                                          g_strdup(featurestr + 1));
> +            continue;
> +        } else if (featurestr[0] =3D=3D '-') {
> +            minus_features =3D g_list_append(minus_features,
> +                                           g_strdup(featurestr + 1));
> +            continue;
> +        }

These 6 lines of code (or something equivalent to them) are
supposed to be the only difference to the generic parsing
function.  I would simply make this feature (support for
[+-]feature) enabled by a CPUClass::plus_minus_features flag
handled by cpu_common_parse_features().

(But this can be done as a follow-up patch.)

> +
> +        eq =3D strchr(featurestr, '=3D');
> +        if (eq) {
> +            *eq++ =3D 0;
> +            val =3D eq;
> +        } else {
> +            val =3D "on";
> +        }
> +
> +        feat2prop(featurestr);
> +        name =3D featurestr;
> +
> +        if (g_list_find_custom(plus_features, name, compare_string)) {
> +            warn_report("Ambiguous CPU model string. "
> +                        "Don't mix both \"+%s\" and \"%s=3D%s\"",
> +                        name, name, val);
> +            ambiguous =3D true;
> +        }
> +        if (g_list_find_custom(minus_features, name, compare_string)) =
{
> +            warn_report("Ambiguous CPU model string. "
> +                        "Don't mix both \"-%s\" and \"%s=3D%s\"",
> +                        name, name, val);
> +            ambiguous =3D true;
> +        }
> +
> +        /* Special case: */
> +        if (!strcmp(name, "tsc-freq")) {
> +            int ret;
> +            uint64_t tsc_freq;
> +
> +            ret =3D qemu_strtosz_metric(val, NULL, &tsc_freq);
> +            if (ret < 0 || tsc_freq > INT64_MAX) {
> +                error_setg(errp, "bad numerical value %s", val);
> +                return;
> +            }
> +            snprintf(num, sizeof(num), "%" PRId64, tsc_freq);
> +            val =3D num;
> +            name =3D "tsc-frequency";
> +        }

This is x86-specific and should stay in x86-specific code.  It
can probably be handled by the tsc-freq setter.

> +
> +        cpu_add_feat_as_prop(typename, name, val);
> +    }
> +
> +    if (ambiguous) {
> +        warn_report("Compatibility of ambiguous CPU model "
> +                    "strings won't be kept on future QEMU versions");
> +    }

As noted in the review of the x86 patch that removes the
plus_features/minus_features static variables, this obsolete (and
confusing) property ordering misfeature should be removed before
we make this code generic and reuse it on other architectures.

> +
> +    for (l =3D plus_features; l; l =3D l->next) {
> +        const char *name =3D l->data;
> +        cpu_add_feat_as_prop(typename, name, "on");
> +    }
> +    if (plus_features) {
> +        g_list_free_full(plus_features, g_free);
> +    }
> +
> +    for (l =3D minus_features; l; l =3D l->next) {
> +        const char *name =3D l->data;
> +        cpu_add_feat_as_prop(typename, name, "off");
> +    }
> +    if (minus_features) {
> +        g_list_free_full(minus_features, g_free);
> +    }
> +}
> --=20
> 2.7.4
>=20
>=20

--=20
Eduardo
