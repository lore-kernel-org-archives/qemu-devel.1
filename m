Received: from eggs.gnu.org ([2001:4830:134:3::10]:51354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ej4T9-0001az-Ag
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:43:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ej4T6-0002EN-4s
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:43:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53248)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ej4T5-0002CH-SQ
	for qemu-devel@nongnu.org; Tue, 06 Feb 2018 09:43:32 -0500
Date: Tue, 6 Feb 2018 15:43:20 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180206154320.288acdc2@redhat.com>
In-Reply-To: <20180205224205.GA3291@localhost.localdomain>
References: <cover.1517532021.git.alistair.francis@xilinx.com>
	<56ba11cee61d769a9a2816fa990d472ab1480906.1517532021.git.alistair.francis@xilinx.com>
	<20180202182326.GB22556@localhost.localdomain>
	<20180205122235.03fdeaad@redhat.com>
	<20180205135401.GA3300@localhost.localdomain>
	<20180205154202.7d1269a9@redhat.com>
	<20180205224205.GA3291@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v5 1/6] machine: Convert the valid cpu
 types to use cpu_model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Alistair Francis <alistair.francis@xilinx.com>, qemu-devel@nongnu.org, peter.maydell@linaro.org, f4bug@amsat.org, marcel@redhat.com, alistair23@gmail.com

On Mon, 5 Feb 2018 20:42:05 -0200
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Mon, Feb 05, 2018 at 03:42:02PM +0100, Igor Mammedov wrote:
> > On Mon, 5 Feb 2018 11:54:01 -0200
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >  =20
> > > On Mon, Feb 05, 2018 at 12:22:35PM +0100, Igor Mammedov wrote: =20
> > > > On Fri, 2 Feb 2018 16:23:26 -0200
> > > > Eduardo Habkost <ehabkost@redhat.com> wrote:
> > > >    =20
> > > > > On Thu, Feb 01, 2018 at 04:42:05PM -0800, Alistair Francis wrote:=
   =20
> > > > > > As cpu_type is not a user visible string let's convert the
> > > > > > valid_cpu_types to compare against cpu_model instead. This way =
we have a
> > > > > > user friendly string to report back.
> > > > > >=20
> > > > > > Once we have a cpu_type to cpu_model conversion this patch shou=
ld be
> > > > > > reverted and we should use cpu_type instead.
> > > > > >=20
> > > > > > Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> > > > > > ---
> > > > > >=20
> > > > > >  hw/core/machine.c | 11 +++++------
> > > > > >  1 file changed, 5 insertions(+), 6 deletions(-)
> > > > > >=20
> > > > > > diff --git a/hw/core/machine.c b/hw/core/machine.c
> > > > > > index cdc1163dc6..de5bac1c84 100644
> > > > > > --- a/hw/core/machine.c
> > > > > > +++ b/hw/core/machine.c
> > > > > > @@ -776,13 +776,12 @@ void machine_run_board_init(MachineState =
*machine)
> > > > > >      /* If the machine supports the valid_cpu_types check and t=
he user
> > > > > >       * specified a CPU with -cpu check here that the user CPU =
is supported.
> > > > > >       */
> > > > > > -    if (machine_class->valid_cpu_types && machine->cpu_type) {
> > > > > > -        ObjectClass *class =3D object_class_by_name(machine->c=
pu_type);
> > > > > > +    if (machine_class->valid_cpu_types && machine->cpu_model) {
> > > > > >          int i;
> > > > > > =20
> > > > > >          for (i =3D 0; machine_class->valid_cpu_types[i]; i++) {
> > > > > > -            if (object_class_dynamic_cast(class,
> > > > > > -                                          machine_class->valid=
_cpu_types[i])) {
> > > > > > +            if (!strcmp(machine->cpu_model,
> > > > > > +                        machine_class->valid_cpu_types[i])) { =
    =20
> > > > >=20
> > > > > I would rename valid_cpu_types to valid_cpu_models to make the
> > > > > new semantics clearer.
> > > > >=20
> > > > > Anyway, I have bad and good news:
> > > > >=20
> > > > > The bad news is Igor already sent patches last week that remove
> > > > > MachineState::cpu_model, so this conflicts with his series.  Now
> > > > > parse_cpu_model() will be the only place where the original CPU m=
odel name is
> > > > > available, but the function needs to work on *-user too.  See:
> > > > > "[PATCH v3 23/25] Use cpu_create(type) instead of cpu_init(cpu_mo=
del)".
> > > > >=20
> > > > > The good news is that I think we can fix this very easily if
> > > > > validation is done at the same place where parse_cpu_model() is
> > > > > called.  e.g.:
> > > > >=20
> > > > >     current_machine->cpu_type =3D machine_class->default_cpu_type;
> > > > >     if (cpu_model) {
> > > > >         current_machine->cpu_type =3D parse_cpu_model(cpu_model);
> > > > >=20
> > > > >         if (machine_class->valid_cpu_models) {
> > > > >             ObjectClass *class =3D object_class_by_name(machine->=
cpu_type);
> > > > >             int i;
> > > > >=20
> > > > >             for (i =3D 0; machine_class->valid_cpu_models[i]; i++=
) {
> > > > >                 const char *valid_model =3D machine_class->valid_=
cpu_models[i];
> > > > >                 ObjectClass *valid_class =3D cpu_class_by_name(ma=
chine->cpu_type, valid_model);
> > > > >                 if (object_class_dynamic_cast(class,
> > > > >                                               object_class_get_na=
me(valid_class))) {
> > > > >                      /* Valid CPU type, we're good to go */
> > > > >                      break;
> > > > >                 }
> > > > >             }
> > > > >             if (!machine_class->valid_cpu_models[i]) {
> > > > >                 error_report("Invalid CPU model: %s", cpu_model);
> > > > >                 error_printf("The valid CPU models are: %s",
> > > > >                              machine_class->valid_cpu_models[0]);
> > > > >                 for (i =3D 1; machine_class->valid_cpu_models[i];=
 i++) {
> > > > >                     error_printf(", %s", machine_class->valid_cpu=
_models[i]);
> > > > >                 }
> > > > >                 error_printf("\n");
> > > > >                 exit(1);
> > > > >             }
> > > > >         }
> > > > >     }
> > > > >=20
> > > > > This can be done inside main(), or moved inside
> > > > > machine_run_board_init() if main() pass cpu_model as argument to
> > > > > the function.
> > > > >=20
> > > > > On either case, I think it's a good idea to do validation and
> > > > > printing of error messages closer to the code that parses the
> > > > > command-line options.  This way we separate parsing/validation
> > > > > from initialization.   =20
> > > > I agree it's better like you suggest as at least it prevents
> > > > ms->cpu_model creeping back into boards code.
> > > >=20
> > > > But I still dislike (hate) an idea of new code adding non
> > > > canonized cpu_model strings back in the boards code.
> > > > It's just a matter of time when someone would use them
> > > > and cpu_model parsing will creep back into boards.
> > > >=20
> > > > It would be much better to if we add=20
> > > >    char *MachineClass::cpu_name_by_type_name(char *cpu_type)
> > > > callback and let machines in this patchset to set it,
> > > > something along following lines which is not much of
> > > > refactoring and allows for gradual conversion:
> > > >=20
> > > > diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> > > > index 9631670..85cca84 100644
> > > > --- a/target/arm/cpu.h
> > > > +++ b/target/arm/cpu.h
> > > > @@ -2885,4 +2885,6 @@ static inline void *arm_get_el_change_hook_op=
aque(ARMCPU *cpu)
> > > >      return cpu->el_change_hook_opaque;
> > > >  }
> > > > =20
> > > > +char *arm_cpu_name_by_type_name(const char *typename);
> > > > +
> > > >  #endif
> > > > diff --git a/hw/arm/netduino2.c b/hw/arm/netduino2.c
> > > > index f936017..ae6adb7 100644
> > > > --- a/hw/arm/netduino2.c
> > > > +++ b/hw/arm/netduino2.c
> > > > @@ -46,6 +46,7 @@ static void netduino2_machine_init(MachineClass *=
mc)
> > > >      mc->desc =3D "Netduino 2 Machine";
> > > >      mc->init =3D netduino2_init;
> > > >      mc->ignore_memory_transaction_failures =3D true;
> > > > +    mc->cpu_name_by_type_name =3D arm_cpu_name_by_type_name:   =20
> > >=20
> > > I really don't want to introduce a new arch-specific hook just
> > > for that.  We should move CPU type lookup logic to common code
> > > and make it unnecessary to write new hooks. =20
> > unfortunately cpu_model (cpu name part) is target specific
> > and it's translation to type and back is target specific mayhem. =20
>=20
> Why can't the model<->type translation be represented as data?
> We could have simple cpu_type_name_suffix + an alias table.
>=20
> We have at least 4 arches that return a constant at
> class_by_name.  We have at least 10 arches that simply add a
> suffix to the CPU model name.  We must make them use common code
> instead of requiring them to implement yet another hook[1].
True, some of them could use generic hook and reduce
code duplication greatly, we should do it regardless of whether
table or target specific func approach is used.

> In addition to the ones above, we have 3 that seem to just need
> an alias table (cris, superh, alpha).  ppc can probably also use
> an alias table for the ppc_cpu_class_by_pvr() stuff.  sparc just
> needs whitespaces translated to '-' (sparc), which can be done
> using an alias table.
>=20
> In the end I couldn't find any example that can't be represented
> by a suffix + alias table.

Table based approach is possible but it won't be as simple
as you've just pictured it.

=46rom what I recall from cpu_class_by_name cleanups table should be able
to describe cases like (sometimes combination of them):
   * 1:1 mapping - where cpu_model =3D=3D cpu_type
   * cpu_model <=3D=3D> cpu_model + suffix  - most common usecase
   * cpu_model <=3D=3D> prefix cpu_model  - riscv patches on list are tryin=
g to add such cpu types
   * NULL =3D> some_fixed type
   * case (in) sensitive flag
   * garbage =3D> some_fixed type
   * substitutions
   * aliases (sometimes dynamic depending on --enable-kvm (PPC))
Maybe something else.

We can think about it at leisure but I can't say if new approach
complexity it's worth of the effort.
=20
It would be nice see impl, but it's a lot of refactoring that's
clearly out of scope of this series.
I'd prefer small incremental refactoring (if possible) that
won't scare people of and easy to review vs a huge one.

> > So I'd prefer having both back and forth functions together in
> > one place. And common code to call them when necessary.
> >=20
> > We could do global cpu_name_by_type_name() instead of hook,
> > which I'd prefer even more but then conversion can't be done
> > only for one target but rather for all targets at once. =20
>=20
> I don't mind letting a few targets override default behavior with
> a hook if really necessary, but I have a problem with requiring
> all targets to implement what's basically the same boilerplate
> code to add/remove a string suffix and translating aliases.
it could be generic helper if target does the same plus
not mandatory at that (in case target/board doesn't care
about valid cpus).

> > > I agree it would be better if we had a cpu_name_by_type_name()
> > > function, but I would like to have it implemented cleanly. =20
> > In some cases(targets) it can be common helper, but in other
> > cases it's not so.
> > My suggestion though allows to do gradual conversion and
> > avoid putting cpu_model names back in board's code (which I just manged=
 to remove).
> > Once all targets converted and relevant code is isolated
> > we can attempt to generalize it if it's possible or at least
> > make of it global per target helper to get rid of
> > temporary machine hook.
> >=20
> > (seeing this series reposted with cpu_model names in boards code,
> > it doesn't looks like author would like to implement tree-wide
> > generalization first) =20
>=20
> Well, if nobody is willing to generalize all target-specific code
> right now, I don't see the harm in having cpu_model-based tables
> in a few boards in the meantime (as this patch series does).  But
> I do see harm in requiring all our 20 targets to implement yet
> another hook and increasing the costs of cleaning up the mess
> later.
If we use MachineClass hook then it might be done per target
on demand, so no one would require that every target should
implement it.
Also there could be a generic helper for targets that do the same.
Machine which needs to enable valid_cpus, will have to use generic
hook impl or provide target specific if it's special case.

Though I do see harm in adding cpu_model tables in boards code
vs target specific hooks on demand as that will be copy-pasted
in other boards afterwards (number of which is bigger compared
to targets count) and ultimately it would duplicate cpu_name
strings in every board vs hook approach where cpu_model could
be calculated from cpu_type by a function (generic or
target specific).

Good thing about hook is that it's non intrusive and
isolates(consolidates) existing cpu_type -> cpu_model
conversion in multiple places into one place.
Then later it would be easier to generalize if someone
decides to do it.
