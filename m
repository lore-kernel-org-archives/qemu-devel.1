Received: from eggs.gnu.org ([209.51.188.92]:40499)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJMfY-0003OP-IL
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:30:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1hJMe8-0006QC-UK
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 14:29:30 -0400
Date: Wed, 24 Apr 2019 15:29:22 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190424182922.GJ18406@habkost.net>
References: <20190423212246.3542-1-ehabkost@redhat.com>
	<20190423212246.3542-3-ehabkost@redhat.com>
	<20190424082309.GB28615@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20190424082309.GB28615@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 2/3] machine: Use SupportStatusInfo for
 deprecation info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, mprivozn@redhat.com, Markus Armbruster <armbru@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On Wed, Apr 24, 2019 at 09:23:09AM +0100, Daniel P. Berrang=E9 wrote:
> On Tue, Apr 23, 2019 at 06:22:45PM -0300, Eduardo Habkost wrote:
> > Use SupportStatusInfo to represent deprecation information of
> > machine types.
> >=20
> > Instead of using a generic "use XXX instead" message for humans,
> > encode the suggested alternative in a machine-friendly way at the
> > 'suggested_alternatives' field.
> >=20
> > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> >  include/hw/boards.h |  7 ++++---
> >  hw/i386/pc_piix.c   |  4 +++-
> >  hw/ppc/prep.c       |  4 +++-
> >  vl.c                | 13 +++++++++----
> >  4 files changed, 19 insertions(+), 9 deletions(-)
> >=20
> > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > index e231860666..243bf3c7ce 100644
> > --- a/include/hw/boards.h
> > +++ b/include/hw/boards.h
> > @@ -8,6 +8,8 @@
> >  #include "hw/qdev.h"
> >  #include "qom/object.h"
> >  #include "qom/cpu.h"
> > +#include "qapi/qapi-types-common.h"
> > +
> > =20
> >  /**
> >   * memory_region_allocate_system_memory - Allocate a board's main me=
mory
> > @@ -105,8 +107,7 @@ typedef struct {
> > =20
> >  /**
> >   * MachineClass:
> > - * @deprecation_reason: If set, the machine is marked as deprecated.=
 The
> > - *    string should provide some clear information about what to use=
 instead.
> > + * @support_status: Support and deprecation status of machine type.
> >   * @max_cpus: maximum number of CPUs supported. Default: 1
> >   * @min_cpus: minimum number of CPUs supported. Default: 1
> >   * @default_cpus: number of CPUs instantiated if none are specified.=
 Default: 1
> > @@ -169,7 +170,7 @@ struct MachineClass {
> >      char *name;
> >      const char *alias;
> >      const char *desc;
> > -    const char *deprecation_reason;
> > +    SupportStatusInfo support_status;
> > =20
> >      void (*init)(MachineState *state);
> >      void (*reset)(void);
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index 8ad8e885c6..97bd401618 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -781,7 +781,9 @@ static void pc_i440fx_0_15_machine_options(Machin=
eClass *m)
> > =20
> >      pc_i440fx_1_0_machine_options(m);
> >      m->hw_version =3D "0.15";
> > -    m->deprecation_reason =3D "use a newer machine type instead";
> > +    m->support_status.deprecated =3D true;
> > +    m->support_status.has_suggested_alternative =3D true;
> > +    m->support_status.suggested_alternative =3D g_strdup("pc");
> >      compat_props_add(m->compat_props, compat, G_N_ELEMENTS(compat));
> >  }
> > =20
> > diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> > index 847d320465..9a02b0eec4 100644
> > --- a/hw/ppc/prep.c
> > +++ b/hw/ppc/prep.c
> > @@ -587,7 +587,9 @@ static void ppc_prep_init(MachineState *machine)
> > =20
> >  static void prep_machine_init(MachineClass *mc)
> >  {
> > -    mc->deprecation_reason =3D "use 40p machine type instead";
> > +    mc->support_status.deprecated =3D true;
> > +    mc->support_status.has_suggested_alternative =3D true;
> > +    mc->support_status.suggested_alternative =3D g_strdup("40p");
> >      mc->desc =3D "PowerPC PREP platform";
> >      mc->init =3D ppc_prep_init;
> >      mc->block_default_type =3D IF_IDE;
> > diff --git a/vl.c b/vl.c
> > index c696ad2a13..99b857ed2a 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -2610,7 +2610,7 @@ static gint machine_class_cmp(gconstpointer a, =
gconstpointer b)
> >              }
> >              printf("%-20s %s%s%s\n", mc->name, mc->desc,
> >                     mc->is_default ? " (default)" : "",
> > -                   mc->deprecation_reason ? " (deprecated)" : "");
> > +                   mc->support_status.deprecated ? " (deprecated)" :=
 "");
> >          }
> >      }
> > =20
> > @@ -4308,9 +4308,14 @@ int main(int argc, char **argv, char **envp)
> >       * called from configure_accelerator().
> >       */
> > =20
> > -    if (!qtest_enabled() && machine_class->deprecation_reason) {
> > -        error_report("Machine type '%s' is deprecated: %s",
> > -                     machine_class->name, machine_class->deprecation=
_reason);
> > +    if (!qtest_enabled() && machine_class->support_status.deprecated=
) {
> > +        error_report("Machine type '%s' is deprecated%s%s", machine_=
class->name,
> > +                     machine_class->support_status.status_message ? =
": " : "",
> > +                     machine_class->support_status.status_message ?:=
 "");
> > +        if (machine_class->support_status.suggested_alternative) {
> > +            error_report("Suggested solution: use '%s' machine type =
instead",
> > +                         machine_class->support_status.suggested_alt=
ernative);
>=20
> I'd just drop the word "Suggested solution: " as I think it is fine to =
just
> say "Use foobar machine type instead".

I'm not sure.  Can we reword this, but in a way that it still
sounds like a suggestion, not as a definitive solution?

Sometimes the provided alternative won't work for everybody.
e.g. if one day we deprecate pc-i440fx, we can't be sure that
everybody will be able to use q35 instead.

--=20
Eduardo
