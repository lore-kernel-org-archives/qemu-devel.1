Received: from eggs.gnu.org ([209.51.188.92]:58566)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <like.xu@intel.com>) id 1gjFsQ-0002dy-O9
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 22:58:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <like.xu@intel.com>) id 1gjFsO-0007je-VY
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 22:58:58 -0500
Received: from mga04.intel.com ([192.55.52.120]:7804)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <like.xu@intel.com>) id 1gjFsO-0007gm-Jj
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 22:58:56 -0500
From: "Xu, Like" <like.xu@intel.com>
Date: Tue, 15 Jan 2019 03:58:49 +0000
Message-ID: <F7FC466FA1E455449AD0F9063BBE758E0BC3A4F0@SHSMSX101.ccr.corp.intel.com>
References: <1547468699-17633-1-git-send-email-like.xu@linux.intel.com>
	<1547468699-17633-3-git-send-email-like.xu@linux.intel.com>
	<20190114205134.GB16013@habkost.net>
In-Reply-To: <20190114205134.GB16013@habkost.net>
Content-Language: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH v1 2/5] vl.c: add -smp,
 dies=* command line support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Like Xu <like.xu@linux.intel.com>, "igor.v.kovalenko@gmail.com" <igor.v.kovalenko@gmail.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "imammedo@redhat.com" <imammedo@redhat.com>, "drjones@redhat.com" <drjones@redhat.com>, "Michael
	S. Tsirkin" <mst@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Richard Henderson <rth@twiddle.net>

> -----Original Message-----
> From: Eduardo Habkost [mailto:ehabkost@redhat.com]
> Sent: Tuesday, January 15, 2019 4:52 AM
> To: Like Xu <like.xu@linux.intel.com>
> Cc: qemu-devel@nongnu.org; Xu, Like <like.xu@intel.com>;
> imammedo@redhat.com; drjones@redhat.com; Michael S. Tsirkin
> <mst@redhat.com>; Marcelo Tosatti <mtosatti@redhat.com>; Marcel
> Apfelbaum <marcel.apfelbaum@gmail.com>; Paolo Bonzini
> <pbonzini@redhat.com>; Peter Crosthwaite
> <crosthwaite.peter@gmail.com>; Richard Henderson <rth@twiddle.net>
> Subject: Re: [Qemu-devel] [PATCH v1 2/5] vl.c: add -smp,dies=3D* command
> line support
>=20
> On Mon, Jan 14, 2019 at 08:24:56PM +0800, Like Xu wrote:
> > This patch updates the check rules on legeacy -smp parse from user
> > command and it's designed to obey the same restrictions as
> socket/core/thread model.
> >
> > Signed-off-by: Like Xu <like.xu@linux.intel.com>
>=20
> This would require the documentation for -smp to be updated.
> qemu-options.hx still says that "cores=3D" is the number of cores per soc=
ket.
[Xu, Like] I'll add more docs in next version and thanks.
>=20
> Also, I'm not completely sure we should change the meaning of "cores=3D"
> and smp_cores to be per-die instead of per-socket.  Most machines won't
> have any code for tracking dies, so we probably shouldn't make the extra
> complexity affect all machines.[1]
[Xu, Like] I'd prefer to apply die level in a general way without extra aff=
ect.
>=20
> What would be the disadvantages of a simple -machine "dies-per-socket"
> option, specific for PC?
[Xu, Like] It may not be a good choice to cut up cpu topo parser logic and
die level is so generic that any machine provided by qemu as far as I know
could benefit from potential socket/die/core/thread model.
>=20
> Keeping core-id and smp_cores per-socket instead of per-die also seems
> necessary to keep backwards compatibility on the interface for identifyin=
g
> CPU hotplug slots.  Igor, what do you think?
[Xu, Like] The compatibility issue on hotplug from MCP challenge is still b=
eing=20
evaluated and Igor, what do you think :D ?=20
>=20
>=20
> [1] I would even argue that the rest of the -smp options belong
>     to the machine object, and topology rules should be
>     machine-specific, but cleaning this up will require
>     additional work.
[Xu, Like] I agree and Intel may have another
two cpu topo levels named module and tile from SDM spec for packaging
and that should be machine-specific as proposal if any. However
the die level I believe is much more generic just like core or thread.
>=20
> > ---
> >  hmp.c             |  3 +++
> >  hw/core/machine.c | 12 ++++++++++++
> >  vl.c              | 33 ++++++++++++++++++++-------------
> >  3 files changed, 35 insertions(+), 13 deletions(-)
> >
> > diff --git a/hmp.c b/hmp.c
> > index 80aa5ab..05ac133 100644
> > --- a/hmp.c
> > +++ b/hmp.c
> > @@ -3013,6 +3013,9 @@ void hmp_hotpluggable_cpus(Monitor *mon,
> const QDict *qdict)
> >          if (c->has_socket_id) {
> >              monitor_printf(mon, "    socket-id: \"%" PRIu64 "\"\n", c-
> >socket_id);
> >          }
> > +        if (c->has_die_id) {
> > +            monitor_printf(mon, "    die-id: \"%" PRIu64 "\"\n", c->di=
e_id);
> > +        }
> >          if (c->has_core_id) {
> >              monitor_printf(mon, "    core-id: \"%" PRIu64 "\"\n", c->c=
ore_id);
> >          }
> > diff --git a/hw/core/machine.c b/hw/core/machine.c index
> > 95dc7c3..05bc545 100644
> > --- a/hw/core/machine.c
> > +++ b/hw/core/machine.c
> > @@ -601,6 +601,11 @@ void
> machine_set_cpu_numa_node(MachineState *machine,
> >              return;
> >          }
> >
> > +        if (props->has_die_id && !slot->props.has_die_id) {
> > +            error_setg(errp, "die-id is not supported");
> > +            return;
> > +        }
> > +
> >          if (props->has_socket_id && !slot->props.has_socket_id) {
> >              error_setg(errp, "socket-id is not supported");
> >              return;
> > @@ -615,6 +620,10 @@ void
> machine_set_cpu_numa_node(MachineState *machine,
> >                  continue;
> >          }
> >
> > +        if (props->has_die_id && props->die_id !=3D slot->props.die_id=
) {
> > +                continue;
> > +        }
> > +
> >          if (props->has_socket_id && props->socket_id !=3D slot-
> >props.socket_id) {
> >                  continue;
> >          }
> > @@ -849,6 +858,9 @@ static char *cpu_slot_to_string(const CPUArchId
> *cpu)
> >      if (cpu->props.has_socket_id) {
> >          g_string_append_printf(s, "socket-id: %"PRId64, cpu-
> >props.socket_id);
> >      }
> > +    if (cpu->props.has_die_id) {
> > +        g_string_append_printf(s, "die-id: %"PRId64, cpu->props.die_id=
);
> > +    }
> >      if (cpu->props.has_core_id) {
> >          if (s->len) {
> >              g_string_append_printf(s, ", "); diff --git a/vl.c b/vl.c
> > index 9b8ea3f..72be689 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -169,6 +169,7 @@ int win2k_install_hack =3D 0;  int singlestep =3D 0=
;
> > int smp_cpus;  unsigned int max_cpus;
> > +int smp_dies =3D 1;
> >  int smp_cores =3D 1;
> >  int smp_threads =3D 1;
> >  int acpi_enabled =3D 1;
> > @@ -1208,6 +1209,9 @@ static QemuOptsList qemu_smp_opts =3D {
> >              .name =3D "sockets",
> >              .type =3D QEMU_OPT_NUMBER,
> >          }, {
> > +             .name =3D "dies",
> > +            .type =3D QEMU_OPT_NUMBER,
> > +        }, {
> >              .name =3D "cores",
> >              .type =3D QEMU_OPT_NUMBER,
> >          }, {
> > @@ -1226,32 +1230,34 @@ static void smp_parse(QemuOpts *opts)
> >      if (opts) {
> >          unsigned cpus    =3D qemu_opt_get_number(opts, "cpus", 0);
> >          unsigned sockets =3D qemu_opt_get_number(opts, "sockets", 0);
> > +        unsigned dies =3D qemu_opt_get_number(opts, "dies", 0);
> >          unsigned cores   =3D qemu_opt_get_number(opts, "cores", 0);
> >          unsigned threads =3D qemu_opt_get_number(opts, "threads", 0);
> >
> >          /* compute missing values, prefer sockets over cores over
> > threads */
> > +        dies =3D dies > 0 ? dies : 1;
> >          if (cpus =3D=3D 0 || sockets =3D=3D 0) {
> >              cores =3D cores > 0 ? cores : 1;
> >              threads =3D threads > 0 ? threads : 1;
> >              if (cpus =3D=3D 0) {
> >                  sockets =3D sockets > 0 ? sockets : 1;
> > -                cpus =3D cores * threads * sockets;
> > +                cpus =3D cores * threads * dies * sockets;
> >              } else {
> >                  max_cpus =3D qemu_opt_get_number(opts, "maxcpus", cpus=
);
> > -                sockets =3D max_cpus / (cores * threads);
> > +                sockets =3D max_cpus / (cores * threads * dies);
> >              }
> >          } else if (cores =3D=3D 0) {
> >              threads =3D threads > 0 ? threads : 1;
> > -            cores =3D cpus / (sockets * threads);
> > +            cores =3D cpus / (sockets * dies * threads);
> >              cores =3D cores > 0 ? cores : 1;
> >          } else if (threads =3D=3D 0) {
> > -            threads =3D cpus / (cores * sockets);
> > +            threads =3D cpus / (cores * dies * sockets);
> >              threads =3D threads > 0 ? threads : 1;
> > -        } else if (sockets * cores * threads < cpus) {
> > +        } else if (sockets * dies * cores * threads < cpus) {
> >              error_report("cpu topology: "
> > -                         "sockets (%u) * cores (%u) * threads (%u) < "
> > +                         "sockets (%u) * dies (%u) * cores (%u) * thre=
ads (%u) < "
> >                           "smp_cpus (%u)",
> > -                         sockets, cores, threads, cpus);
> > +                         sockets, dies, cores, threads, cpus);
> >              exit(1);
> >          }
> >
> > @@ -1262,22 +1268,23 @@ static void smp_parse(QemuOpts *opts)
> >              exit(1);
> >          }
> >
> > -        if (sockets * cores * threads > max_cpus) {
> > +        if (sockets * dies * cores * threads > max_cpus) {
> >              error_report("cpu topology: "
> > -                         "sockets (%u) * cores (%u) * threads (%u) > "
> > +                         "sockets (%u) * dies (%u) * cores (%u) * thre=
ads (%u) > "
> >                           "maxcpus (%u)",
> > -                         sockets, cores, threads, max_cpus);
> > +                         sockets, dies, cores, threads, max_cpus);
> >              exit(1);
> >          }
> >
> > -        if (sockets * cores * threads !=3D max_cpus) {
> > +        if (sockets * dies * cores * threads !=3D max_cpus) {
> >              warn_report("Invalid CPU topology deprecated: "
> > -                        "sockets (%u) * cores (%u) * threads (%u) "
> > +                        "sockets (%u) * dies (%u) * cores (%u) * threa=
ds (%u) "
> >                          "!=3D maxcpus (%u)",
> > -                        sockets, cores, threads, max_cpus);
> > +                        sockets, dies, cores, threads, max_cpus);
> >          }
> >
> >          smp_cpus =3D cpus;
> > +        smp_dies =3D dies;
> >          smp_cores =3D cores;
> >          smp_threads =3D threads;
> >      }
> > --
> > 1.8.3.1
> >
>=20
> --
> Eduardo
