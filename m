Received: from eggs.gnu.org ([2001:4830:134:3::10]:51684)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkYnj-0004Ir-S1
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:46:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dkYni-0002rM-66
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:46:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47672)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dkYnh-0002rA-RU
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 12:46:42 -0400
Date: Wed, 23 Aug 2017 13:46:38 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170823164638.GN19998@localhost.localdomain>
References: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
	<1503050939-227939-7-git-send-email-imammedo@redhat.com>
	<20170823143414.GI27715@localhost.localdomain>
	<20170823182902.7c2803c7@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170823182902.7c2803c7@nial.brq.redhat.com>
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

On Wed, Aug 23, 2017 at 06:29:02PM +0200, Igor Mammedov wrote:
> On Wed, 23 Aug 2017 11:34:14 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
>=20
> > On Fri, Aug 18, 2017 at 12:08:38PM +0200, Igor Mammedov wrote:
> > > Move cpu_model +-feat parsing into a separate file so that it
> > > could be reused later for parsing similar format of sparc target
> > >=20
> > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > ---
> > > CC: Richard Henderson <rth@twiddle.net>
> > > CC: Eduardo Habkost <ehabkost@redhat.com>
> > > CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > > CC: Artyom Tarasenko <atar4qemu@gmail.com>
> > > CC: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > > ---
> > >  include/qom/cpu.h                     |   2 +
> > >  default-configs/i386-bsd-user.mak     |   1 +
> > >  default-configs/i386-linux-user.mak   |   1 +
> > >  default-configs/i386-softmmu.mak      |   1 +
> > >  default-configs/x86_64-bsd-user.mak   |   1 +
> > >  default-configs/x86_64-linux-user.mak |   1 +
> > >  default-configs/x86_64-softmmu.mak    |   1 +
> > >  target/i386/cpu.c                     | 125 +---------------------=
----
> > >  util/Makefile.objs                    |   1 +
> > >  util/legacy_cpu_features_parser.c     | 161 ++++++++++++++++++++++=
++++++++++++
> > >  10 files changed, 171 insertions(+), 124 deletions(-)
> > >  create mode 100644 util/legacy_cpu_features_parser.c
> > >  =20
> > [...]
> > > diff --git a/util/legacy_cpu_features_parser.c b/util/legacy_cpu_fe=
atures_parser.c
> > > new file mode 100644
> > > index 0000000..6b352a3
> > > --- /dev/null
> > > +++ b/util/legacy_cpu_features_parser.c
> > > @@ -0,0 +1,161 @@
> > > +/* Support for legacy -cpu cpu,features CLI option with +-feat syn=
tax,
> > > + * used by x86/sparc targets
> > > + *
> > > + * Author: Andreas F=E4rber <afaerber@suse.de>
> > > + * Author: Andre Przywara <andre.przywara@amd.com>
> > > + * Author: Eduardo Habkost <ehabkost@redhat.com>
> > > + * Author: Igor Mammedov <imammedo@redhat.com>
> > > + * Author: Paolo Bonzini <pbonzini@redhat.com>
> > > + * Author: Markus Armbruster <armbru@redhat.com> =20
> >=20
> > IANAL, but I believe a
> >   Copyright (c) <YEAR> <COPYRIGHT HOLDER>
> > line is needed here.
> >=20
> > > + *
> > > + * This program is free software; you can redistribute it and/or m=
odify
> > > + * it under the terms of the GNU General Public License as publish=
ed by
> > > + * the Free Software Foundation; either version 2 of the License, =
or
> > > + * (at your option) any later version.
> > > +
> > > + * This program is distributed in the hope that it will be useful,
> > > + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> > > + * GNU General Public License for more details.
> > > +
> > > + * You should have received a copy of the GNU General Public Licen=
se along
> > > + * with this program; if not, see <http://www.gnu.org/licenses/>.
> > > + */
> > > +
> > > +#include "qemu/osdep.h"
> > > +#include "qapi/error.h"
> > > +#include "qemu/cutils.h"
> > > +#include "qom/cpu.h"
> > > +#include "qemu/error-report.h"
> > > +#include "hw/qdev-properties.h"
> > > +
> > > +static inline void feat2prop(char *s)
> > > +{
> > > +    while ((s =3D strchr(s, '_'))) {
> > > +        *s =3D '-';
> > > +    }
> > > +}
> > > +
> > > +static gint compare_string(gconstpointer a, gconstpointer b)
> > > +{
> > > +    return g_strcmp0(a, b);
> > > +}
> > > +
> > > +static void
> > > +cpu_add_feat_as_prop(const char *typename, const char *name, const=
 char *val)
> > > +{
> > > +    GlobalProperty *prop =3D g_new0(typeof(*prop), 1);
> > > +    prop->driver =3D typename;
> > > +    prop->property =3D g_strdup(name);
> > > +    prop->value =3D g_strdup(val);
> > > +    prop->errp =3D &error_fatal;
> > > +    qdev_prop_register_global(prop);
> > > +}
> > > +
> > > +/* DO NOT USE WITH NEW CODE
> > > + * Parse "+feature,-feature,feature=3Dfoo" CPU feature string
> > > + */
> > > +void cpu_legacy_parse_featurestr(const char *typename, char *featu=
res,
> > > +                                 Error **errp)
> > > +{
> > > +    /* Compatibily hack to maintain legacy +-feat semantic,
> > > +     * where +-feat overwrites any feature set by
> > > +     * feat=3Don|feat even if the later is parsed after +-feat
> > > +     * (i.e. "-x2apic,x2apic=3Don" will result in x2apic disabled)
> > > +     */
> > > +    GList *l, *plus_features =3D NULL, *minus_features =3D NULL;
> > > +    char *featurestr; /* Single 'key=3Dvalue" string being parsed =
*/
> > > +    static bool cpu_globals_initialized;
> > > +    bool ambiguous =3D false;
> > > +
> > > +    if (cpu_globals_initialized) {
> > > +        return;
> > > +    }
> > > +    cpu_globals_initialized =3D true;
> > > +
> > > +    if (!features) {
> > > +        return;
> > > +    }
> > > +
> > > +    for (featurestr =3D strtok(features, ",");
> > > +         featurestr;
> > > +         featurestr =3D strtok(NULL, ",")) {
> > > +        const char *name;
> > > +        const char *val =3D NULL;
> > > +        char *eq =3D NULL;
> > > +        char num[32];
> > > +
> > > +        /* Compatibility syntax: */
> > > +        if (featurestr[0] =3D=3D '+') {
> > > +            plus_features =3D g_list_append(plus_features,
> > > +                                          g_strdup(featurestr + 1)=
);
> > > +            continue;
> > > +        } else if (featurestr[0] =3D=3D '-') {
> > > +            minus_features =3D g_list_append(minus_features,
> > > +                                           g_strdup(featurestr + 1=
));
> > > +            continue;
> > > +        } =20
> >=20
> > These 6 lines of code (or something equivalent to them) are
> > supposed to be the only difference to the generic parsing
> > function.  I would simply make this feature (support for
> > [+-]feature) enabled by a CPUClass::plus_minus_features flag
> > handled by cpu_common_parse_features().
> I'd rather keep plus/minus nonsense  under the hood separate
> legacy function so it get reused unintentionally and keep generic
> parser clean.
>=20
> I didn't have any intent of generalizing +-feat handling
> but rather to remove code duplication between the only users
> (x86/sparc) that happened to use syntax and share the same semantics.

Generalizing it to be controlled by a CPUClass flag will make it
easier to refactor the feature parsing later to use the QemuOpts
parser.  But I agree there's no need to do that on this series.

(We might even decide to make [+-]feat work on all other
architectures.  We already agreed recently that we won't
deprecate it in x86, we could as well enable the same syntax
uniformly across all architectures.)

>=20
> As an alternative I can copy-past x86 variant into sparc
> (modulo x86 harmless fixups), that will add some code duplication
> I've tried to avoid with this patch, but it won't cause
> misunderstanding about generalizing legacy hacks.

Works for me.  We can then cleanup the x86 code and make it use
cpu_legacy_parse_featurestr() later.

>=20
> > (But this can be done as a follow-up patch.)
> >=20
> > > +
> > > +        eq =3D strchr(featurestr, '=3D');
> > > +        if (eq) {
> > > +            *eq++ =3D 0;
> > > +            val =3D eq;
> > > +        } else {
> > > +            val =3D "on";
> > > +        }
> > > +
> > > +        feat2prop(featurestr);
> > > +        name =3D featurestr;
> > > +
> > > +        if (g_list_find_custom(plus_features, name, compare_string=
)) {
> > > +            warn_report("Ambiguous CPU model string. "
> > > +                        "Don't mix both \"+%s\" and \"%s=3D%s\"",
> > > +                        name, name, val);
> > > +            ambiguous =3D true;
> > > +        }
> > > +        if (g_list_find_custom(minus_features, name, compare_strin=
g)) {
> > > +            warn_report("Ambiguous CPU model string. "
> > > +                        "Don't mix both \"-%s\" and \"%s=3D%s\"",
> > > +                        name, name, val);
> > > +            ambiguous =3D true;
> > > +        }
> > > +
> > > +        /* Special case: */
> > > +        if (!strcmp(name, "tsc-freq")) {
> > > +            int ret;
> > > +            uint64_t tsc_freq;
> > > +
> > > +            ret =3D qemu_strtosz_metric(val, NULL, &tsc_freq);
> > > +            if (ret < 0 || tsc_freq > INT64_MAX) {
> > > +                error_setg(errp, "bad numerical value %s", val);
> > > +                return;
> > > +            }
> > > +            snprintf(num, sizeof(num), "%" PRId64, tsc_freq);
> > > +            val =3D num;
> > > +            name =3D "tsc-frequency";
> > > +        } =20
> >=20
> > This is x86-specific and should stay in x86-specific code.  It
> > can probably be handled by the tsc-freq setter.
> there was reason why it wasn't moved to tsc-frequency setter,
> the former is pure integer type of property,
> while here we can get suffixed string that scales by 1000.
>=20
> Short of creating new visitor for KHz (I don't really looking forward t=
o it),
> it's simpler to leave fixup alone in legacy parser that's shared only b=
etween
> x86/sparc as it doesn't conflict with sparc and won't break anything.

It doesn't break anything, but it will move x86-specific cruft to
code that is supposed to be generic.

Creating a write-only "tsc-freq" property that accepts a string
isn't hard to do.

If you are not willing to do it in this series, you can write a
generic parser now (without x86-specific cruft), use it only on
sparc, and later we can refactor x86 so it can also use the
generic one.

>=20
>=20
> > > +
> > > +        cpu_add_feat_as_prop(typename, name, val);
> > > +    }
> > > +
> > > +    if (ambiguous) {
> > > +        warn_report("Compatibility of ambiguous CPU model "
> > > +                    "strings won't be kept on future QEMU versions=
");
> > > +    } =20
> >=20
> > As noted in the review of the x86 patch that removes the
> > plus_features/minus_features static variables, this obsolete (and
> > confusing) property ordering misfeature should be removed before
> > we make this code generic and reuse it on other architectures.
> As it's been replied removing ordering is behavioral change for
> both x86 and sparc, which is not related to series.
> If you wish, I'll post a patch that will what you suggest
> on top of series.

I would agree if sparc also implemented the weird ordering.  But
sparc does not implement it (it doesn't support feat=3D(on|off)
yet).  We shouldn't introduce that misfeature in sparc if we're
already planning to remove it.

--=20
Eduardo
