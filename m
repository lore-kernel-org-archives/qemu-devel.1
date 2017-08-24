Received: from eggs.gnu.org ([2001:4830:134:3::10]:46491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dksRc-0007CH-2F
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:45:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1dksRZ-0003hy-C3
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:45:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36568)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1dksRZ-0003gd-1N
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 09:45:09 -0400
Date: Thu, 24 Aug 2017 10:45:05 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170824134505.GB15315@localhost.localdomain>
References: <1503050939-227939-1-git-send-email-imammedo@redhat.com>
	<1503050939-227939-7-git-send-email-imammedo@redhat.com>
	<20170823143414.GI27715@localhost.localdomain>
	<20170823182902.7c2803c7@nial.brq.redhat.com>
	<20170823164638.GN19998@localhost.localdomain>
	<20170823193739.32d9bd07@Igors-MacBook-Pro.local>
	<20170823175839.GT19998@localhost.localdomain>
	<20170824111852.37066dce@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20170824111852.37066dce@nial.brq.redhat.com>
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

On Thu, Aug 24, 2017 at 11:18:52AM +0200, Igor Mammedov wrote:
> On Wed, 23 Aug 2017 14:58:39 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
>=20
> > On Wed, Aug 23, 2017 at 07:37:39PM +0200, Igor Mammedov wrote:
> > > On Wed, 23 Aug 2017 13:46:38 -0300
> > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > >  =20
> > > > On Wed, Aug 23, 2017 at 06:29:02PM +0200, Igor Mammedov wrote: =20
> > > > > On Wed, 23 Aug 2017 11:34:14 -0300
> > > > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > > > >  =20
> > > > > > On Fri, Aug 18, 2017 at 12:08:38PM +0200, Igor Mammedov wrote=
: =20
> > > > > > > Move cpu_model +-feat parsing into a separate file so that =
it
> > > > > > > could be reused later for parsing similar format of sparc t=
arget
> > > > > > >=20
> > > > > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > > > > ---
> > > > > > > CC: Richard Henderson <rth@twiddle.net>
> > > > > > > CC: Eduardo Habkost <ehabkost@redhat.com>
> > > > > > > CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > > > > > > CC: Artyom Tarasenko <atar4qemu@gmail.com>
> > > > > > > CC: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>
> > > > > > > ---
> > > > > > >  include/qom/cpu.h                     |   2 +
> > > > > > >  default-configs/i386-bsd-user.mak     |   1 +
> > > > > > >  default-configs/i386-linux-user.mak   |   1 +
> > > > > > >  default-configs/i386-softmmu.mak      |   1 +
> > > > > > >  default-configs/x86_64-bsd-user.mak   |   1 +
> > > > > > >  default-configs/x86_64-linux-user.mak |   1 +
> > > > > > >  default-configs/x86_64-softmmu.mak    |   1 +
> > > > > > >  target/i386/cpu.c                     | 125 +-------------=
------------
> > > > > > >  util/Makefile.objs                    |   1 +
> > > > > > >  util/legacy_cpu_features_parser.c     | 161 ++++++++++++++=
++++++++++++++++++++
> > > > > > >  10 files changed, 171 insertions(+), 124 deletions(-)
> > > > > > >  create mode 100644 util/legacy_cpu_features_parser.c
> > > > > > >    =20
> > > > > > [...] =20
> > > > > > > diff --git a/util/legacy_cpu_features_parser.c b/util/legac=
y_cpu_features_parser.c
> > > > > > > new file mode 100644
> > > > > > > index 0000000..6b352a3
> > > > > > > --- /dev/null
> > > > > > > +++ b/util/legacy_cpu_features_parser.c
> > > > > > > @@ -0,0 +1,161 @@
> > > > > > > +/* Support for legacy -cpu cpu,features CLI option with +-=
feat syntax,
> > > > > > > + * used by x86/sparc targets
> > > > > > > + *
> > > > > > > + * Author: Andreas F=E4rber <afaerber@suse.de>
> > > > > > > + * Author: Andre Przywara <andre.przywara@amd.com>
> > > > > > > + * Author: Eduardo Habkost <ehabkost@redhat.com>
> > > > > > > + * Author: Igor Mammedov <imammedo@redhat.com>
> > > > > > > + * Author: Paolo Bonzini <pbonzini@redhat.com>
> > > > > > > + * Author: Markus Armbruster <armbru@redhat.com>   =20
> > > > > >=20
> > > > > > IANAL, but I believe a
> > > > > >   Copyright (c) <YEAR> <COPYRIGHT HOLDER>
> > > > > > line is needed here.
> > > > > >  =20
> > > > > > > + *
> > > > > > > + * This program is free software; you can redistribute it =
and/or modify
> > > > > > > + * it under the terms of the GNU General Public License as=
 published by
> > > > > > > + * the Free Software Foundation; either version 2 of the L=
icense, or
> > > > > > > + * (at your option) any later version.
> > > > > > > +
> > > > > > > + * This program is distributed in the hope that it will be=
 useful,
> > > > > > > + * but WITHOUT ANY WARRANTY; without even the implied warr=
anty of
> > > > > > > + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  S=
ee the
> > > > > > > + * GNU General Public License for more details.
> > > > > > > +
> > > > > > > + * You should have received a copy of the GNU General Publ=
ic License along
> > > > > > > + * with this program; if not, see <http://www.gnu.org/lice=
nses/>.
> > > > > > > + */
> > > > > > > +
> > > > > > > +#include "qemu/osdep.h"
> > > > > > > +#include "qapi/error.h"
> > > > > > > +#include "qemu/cutils.h"
> > > > > > > +#include "qom/cpu.h"
> > > > > > > +#include "qemu/error-report.h"
> > > > > > > +#include "hw/qdev-properties.h"
> > > > > > > +
> > > > > > > +static inline void feat2prop(char *s)
> > > > > > > +{
> > > > > > > +    while ((s =3D strchr(s, '_'))) {
> > > > > > > +        *s =3D '-';
> > > > > > > +    }
> > > > > > > +}
> > > > > > > +
> > > > > > > +static gint compare_string(gconstpointer a, gconstpointer =
b)
> > > > > > > +{
> > > > > > > +    return g_strcmp0(a, b);
> > > > > > > +}
> > > > > > > +
> > > > > > > +static void
> > > > > > > +cpu_add_feat_as_prop(const char *typename, const char *nam=
e, const char *val)
> > > > > > > +{
> > > > > > > +    GlobalProperty *prop =3D g_new0(typeof(*prop), 1);
> > > > > > > +    prop->driver =3D typename;
> > > > > > > +    prop->property =3D g_strdup(name);
> > > > > > > +    prop->value =3D g_strdup(val);
> > > > > > > +    prop->errp =3D &error_fatal;
> > > > > > > +    qdev_prop_register_global(prop);
> > > > > > > +}
> > > > > > > +
> > > > > > > +/* DO NOT USE WITH NEW CODE
> > > > > > > + * Parse "+feature,-feature,feature=3Dfoo" CPU feature str=
ing
> > > > > > > + */
> > > > > > > +void cpu_legacy_parse_featurestr(const char *typename, cha=
r *features,
> > > > > > > +                                 Error **errp)
> > > > > > > +{
> > > > > > > +    /* Compatibily hack to maintain legacy +-feat semantic=
,
> > > > > > > +     * where +-feat overwrites any feature set by
> > > > > > > +     * feat=3Don|feat even if the later is parsed after +-=
feat
> > > > > > > +     * (i.e. "-x2apic,x2apic=3Don" will result in x2apic d=
isabled)
> > > > > > > +     */
> > > > > > > +    GList *l, *plus_features =3D NULL, *minus_features =3D=
 NULL;
> > > > > > > +    char *featurestr; /* Single 'key=3Dvalue" string being=
 parsed */
> > > > > > > +    static bool cpu_globals_initialized;
> > > > > > > +    bool ambiguous =3D false;
> > > > > > > +
> > > > > > > +    if (cpu_globals_initialized) {
> > > > > > > +        return;
> > > > > > > +    }
> > > > > > > +    cpu_globals_initialized =3D true;
> > > > > > > +
> > > > > > > +    if (!features) {
> > > > > > > +        return;
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    for (featurestr =3D strtok(features, ",");
> > > > > > > +         featurestr;
> > > > > > > +         featurestr =3D strtok(NULL, ",")) {
> > > > > > > +        const char *name;
> > > > > > > +        const char *val =3D NULL;
> > > > > > > +        char *eq =3D NULL;
> > > > > > > +        char num[32];
> > > > > > > +
> > > > > > > +        /* Compatibility syntax: */
> > > > > > > +        if (featurestr[0] =3D=3D '+') {
> > > > > > > +            plus_features =3D g_list_append(plus_features,
> > > > > > > +                                          g_strdup(feature=
str + 1));
> > > > > > > +            continue;
> > > > > > > +        } else if (featurestr[0] =3D=3D '-') {
> > > > > > > +            minus_features =3D g_list_append(minus_feature=
s,
> > > > > > > +                                           g_strdup(featur=
estr + 1));
> > > > > > > +            continue;
> > > > > > > +        }   =20
> > > > > >=20
> > > > > > These 6 lines of code (or something equivalent to them) are
> > > > > > supposed to be the only difference to the generic parsing
> > > > > > function.  I would simply make this feature (support for
> > > > > > [+-]feature) enabled by a CPUClass::plus_minus_features flag
> > > > > > handled by cpu_common_parse_features(). =20
> > > > > I'd rather keep plus/minus nonsense  under the hood separate
> > > > > legacy function so it get reused unintentionally and keep gener=
ic
> > > > > parser clean.
> > > > >=20
> > > > > I didn't have any intent of generalizing +-feat handling
> > > > > but rather to remove code duplication between the only users
> > > > > (x86/sparc) that happened to use syntax and share the same sema=
ntics. =20
> > > >=20
> > > > Generalizing it to be controlled by a CPUClass flag will make it
> > > > easier to refactor the feature parsing later to use the QemuOpts
> > > > parser.  But I agree there's no need to do that on this series.
> > > >=20
> > > > (We might even decide to make [+-]feat work on all other
> > > > architectures.  We already agreed recently that we won't
> > > > deprecate it in x86, we could as well enable the same syntax
> > > > uniformly across all architectures.) =20
> > > I'd just stick to canonical feat=3Don|off and keep legacy to x86|sp=
arc,
> > > but it's this to discuss if future and relevant here.
> > >  =20
> > > >  =20
> > > > >=20
> > > > > As an alternative I can copy-past x86 variant into sparc
> > > > > (modulo x86 harmless fixups), that will add some code duplicati=
on
> > > > > I've tried to avoid with this patch, but it won't cause
> > > > > misunderstanding about generalizing legacy hacks. =20
> > > >=20
> > > > Works for me.  We can then cleanup the x86 code and make it use
> > > > cpu_legacy_parse_featurestr() later. =20
> > > Then, I'll just copy and replace sparc variant with x86 impl.
> > > (removing from the copy x86 only parts and making parser stricter
> > > where possible) and drop 5-6 patches that touched x86 for the purpo=
se
> > > of sharing code.
> > >=20
> > > and respin v3 tomorrow. =20
> >=20
> > I just have one worry about this plan, below:
> >=20
> > >  =20
> > > >  =20
> > > > >  =20
> > > > > > (But this can be done as a follow-up patch.)
> > > > > >  =20
> > > > > > > +
> > > > > > > +        eq =3D strchr(featurestr, '=3D');
> > > > > > > +        if (eq) {
> > > > > > > +            *eq++ =3D 0;
> > > > > > > +            val =3D eq;
> > > > > > > +        } else {
> > > > > > > +            val =3D "on";
> > > > > > > +        }
> > > > > > > +
> > > > > > > +        feat2prop(featurestr);
> > > > > > > +        name =3D featurestr;
> > > > > > > +
> > > > > > > +        if (g_list_find_custom(plus_features, name, compar=
e_string)) {
> > > > > > > +            warn_report("Ambiguous CPU model string. "
> > > > > > > +                        "Don't mix both \"+%s\" and \"%s=3D=
%s\"",
> > > > > > > +                        name, name, val);
> > > > > > > +            ambiguous =3D true;
> > > > > > > +        }
> > > > > > > +        if (g_list_find_custom(minus_features, name, compa=
re_string)) {
> > > > > > > +            warn_report("Ambiguous CPU model string. "
> > > > > > > +                        "Don't mix both \"-%s\" and \"%s=3D=
%s\"",
> > > > > > > +                        name, name, val);
> > > > > > > +            ambiguous =3D true;
> > > > > > > +        }
> > > > > > > +
> > > > > > > +        /* Special case: */
> > > > > > > +        if (!strcmp(name, "tsc-freq")) {
> > > > > > > +            int ret;
> > > > > > > +            uint64_t tsc_freq;
> > > > > > > +
> > > > > > > +            ret =3D qemu_strtosz_metric(val, NULL, &tsc_fr=
eq);
> > > > > > > +            if (ret < 0 || tsc_freq > INT64_MAX) {
> > > > > > > +                error_setg(errp, "bad numerical value %s",=
 val);
> > > > > > > +                return;
> > > > > > > +            }
> > > > > > > +            snprintf(num, sizeof(num), "%" PRId64, tsc_fre=
q);
> > > > > > > +            val =3D num;
> > > > > > > +            name =3D "tsc-frequency";
> > > > > > > +        }   =20
> > > > > >=20
> > > > > > This is x86-specific and should stay in x86-specific code.  I=
t
> > > > > > can probably be handled by the tsc-freq setter. =20
> > > > > there was reason why it wasn't moved to tsc-frequency setter,
> > > > > the former is pure integer type of property,
> > > > > while here we can get suffixed string that scales by 1000.
> > > > >=20
> > > > > Short of creating new visitor for KHz (I don't really looking f=
orward to it),
> > > > > it's simpler to leave fixup alone in legacy parser that's share=
d only between
> > > > > x86/sparc as it doesn't conflict with sparc and won't break any=
thing. =20
> > > >=20
> > > > It doesn't break anything, but it will move x86-specific cruft to
> > > > code that is supposed to be generic.
> > > >=20
> > > > Creating a write-only "tsc-freq" property that accepts a string
> > > > isn't hard to do. =20
> > > Nice idea, it might just work.
> > >  =20
> > > >=20
> > > > If you are not willing to do it in this series, you can write a
> > > > generic parser now (without x86-specific cruft), use it only on
> > > > sparc, and later we can refactor x86 so it can also use the
> > > > generic one. =20
> > > So far, I'm inclined towards opposing +-feat generalizing and keepi=
ng
> > > canonical form anywhere except of x86/sparc were we have to tolerat=
e it.
> > >=20
> > >  =20
> > > > > > > +
> > > > > > > +        cpu_add_feat_as_prop(typename, name, val);
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    if (ambiguous) {
> > > > > > > +        warn_report("Compatibility of ambiguous CPU model =
"
> > > > > > > +                    "strings won't be kept on future QEMU =
versions");
> > > > > > > +    }   =20
> > > > > >=20
> > > > > > As noted in the review of the x86 patch that removes the
> > > > > > plus_features/minus_features static variables, this obsolete =
(and
> > > > > > confusing) property ordering misfeature should be removed bef=
ore
> > > > > > we make this code generic and reuse it on other architectures=
. =20
> > > > > As it's been replied removing ordering is behavioral change for
> > > > > both x86 and sparc, which is not related to series.
> > > > > If you wish, I'll post a patch that will what you suggest
> > > > > on top of series. =20
> > > >=20
> > > > I would agree if sparc also implemented the weird ordering.  But
> > > > sparc does not implement it (it doesn't support feat=3D(on|off)
> > > > yet).  We shouldn't introduce that misfeature in sparc if we're
> > > > already planning to remove it. =20
> > > It didn't have canonic form but it gains this ability with this ser=
ies.
> > > So we could do better for it by forbidding mixed syntax from starte=
rs =20
> >=20
> > We don't need to forbid mixed syntax.  We can simply apply
> > [+-]feat and feat=3Don|off in the same order they appear in the
> > command-line.
> >=20
> > But:
> >=20
> > > (+1 for copy-past) but we have to keep minus overrides plus semanti=
cs,
> > > so ambiguous check is still there but it would lead to hard error i=
nstead of
> > > warning. =20
> >=20
> > I forgot about this additional weird semantics
> > (minus-override-plus).  :(
> >=20
> > I think we must deprecate the minus-override-plus semantics too
> > and move to command-line-order eventually (on both x86 and
> > sparc).  But to do that, we need to make the code print a warning
> > on sparc like we do on x86.
> >=20
> > If we don't remove that weird semantics before making sparc
> > support feat=3Don|off, we will have to worry about the semantics of
> > "-feat,feat=3Don" on top of that.  I would simply wait for 2
> > releases and remove minus-override-plus, before implementing
> > feat=3Don|off on sparc, to avoid creating a new set of problems.
> > Is support for feat=3Don|off on sparc a must-have for QEMU 2.11?
> Probably it isn't must have (as far as I can tell now) but
> I won't bet on it.
>=20
> Supporting both ways as far as mix is forbidden is fine,
> so I'd 'introduce' feat=3Don|off (feat=3Don|off behavior is
> inherited from QOM Boolean property, so we would have
> to cripple parser intentionally).

Yes, if you really want to rewrite the sparc parser now without
changing behavior, I think we shouldn't allow "-feat,feat=3Don".
But there's no need for the extra work: if we just wait until we
remove the minus-overrides-plus behavior everywhere before
replacing the sparc parser.

>=20
> Later we can drop minus-override-plus or whatever else,
> but outside of this series pls.

No problem to me.  I just don't want this series to create an
additional set of problems to solve on sparc.

--=20
Eduardo
