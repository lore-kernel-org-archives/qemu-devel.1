Received: from eggs.gnu.org ([2001:4830:134:3::10]:59162)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWidA-0006Dl-8L
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:03:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gWid5-0004um-C7
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:03:24 -0500
Date: Tue, 11 Dec 2018 12:02:47 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20181211140247.GA20015@habkost.net>
References: <20181204142023.15982-1-marcandre.lureau@redhat.com>
	<20181204142023.15982-9-marcandre.lureau@redhat.com>
	<20181210173118.GF4669@habkost.net>
	<CAJ+F1CKcNhLsu=b5ZJbA_6Kyb3_EUt3nzsZ0q+OWpvZS6JyytA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <CAJ+F1CKcNhLsu=b5ZJbA_6Kyb3_EUt3nzsZ0q+OWpvZS6JyytA@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-3.2 v5 08/19] hw: apply machine compat
 properties without touching globals
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@gmail.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, QEMU <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Qemu-s390x list <qemu-s390x@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

On Tue, Dec 11, 2018 at 04:07:19PM +0400, Marc-Andr=E9 Lureau wrote:
> Hi
>=20
> On Mon, Dec 10, 2018 at 9:31 PM Eduardo Habkost <ehabkost@redhat.com> w=
rote:
> >
> > On Tue, Dec 04, 2018 at 06:20:12PM +0400, Marc-Andr=E9 Lureau wrote:
> > > Similarly to accel properties, move compat properties out of global=
s
> > > registration, and apply the machine compat properties during
> > > device_post_init().
> > >
> > > As suggested during review, populating the arrays can be done direc=
tly
> > > without resorting to using macros.
> > >
> > > Signed-off-by: Marc-Andr=E9 Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  include/hw/boards.h        |   3 +-
> > >  hw/arm/virt.c              |  48 ++-
> > >  hw/core/machine.c          |  19 +-
> > >  hw/core/qdev.c             |   2 +
> > >  hw/i386/pc_piix.c          | 588 +++++++++++++++++++++------------=
----
> > >  hw/i386/pc_q35.c           |  70 ++++-
> > >  hw/ppc/spapr.c             | 209 +++++++------
> > >  hw/s390x/s390-virtio-ccw.c | 220 +++++++-------
> > >  vl.c                       |   1 -
> > >  9 files changed, 673 insertions(+), 487 deletions(-)
> > >
> > > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > > index f82f28468b..28c2b0af41 100644
> > > --- a/include/hw/boards.h
> > > +++ b/include/hw/boards.h
> > > @@ -69,7 +69,6 @@ int machine_kvm_shadow_mem(MachineState *machine)=
;
> > >  int machine_phandle_start(MachineState *machine);
> > >  bool machine_dump_guest_core(MachineState *machine);
> > >  bool machine_mem_merge(MachineState *machine);
> > > -void machine_register_compat_props(MachineState *machine);
> > >  HotpluggableCPUList *machine_query_hotpluggable_cpus(MachineState =
*machine);
> > >  void machine_set_cpu_numa_node(MachineState *machine,
> > >                                 const CpuInstanceProperties *props,
> > > @@ -191,7 +190,7 @@ struct MachineClass {
> > >      const char *default_machine_opts;
> > >      const char *default_boot_order;
> > >      const char *default_display;
> > > -    GArray *compat_props;
> > > +    GPtrArray *compat_props;
> > >      const char *hw_version;
> > >      ram_addr_t default_ram_size;
> > >      const char *default_cpu_type;
> > > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > > index f69e7eb399..530c8ca89d 100644
> > > --- a/hw/arm/virt.c
> > > +++ b/hw/arm/virt.c
> > > @@ -1872,8 +1872,9 @@ static void virt_machine_3_1_options(MachineC=
lass *mc)
> > >  }
> > >  DEFINE_VIRT_MACHINE_AS_LATEST(3, 1)
> > >
> > > -#define VIRT_COMPAT_3_0 \
> > > +static GlobalProperty virt_compat_3_0[] =3D {
> > >      HW_COMPAT_3_0
> > > +};
> > [...]
> >
> > All the changes to compat macros are independent from the change
> > you describe in the patch subject, and makes review more
> > difficult.  What about doing that in a separate patch?
> >
> > We can replace all the virt.c, pc_piix.c, pc_q35.c, and spapr.c
> > hunks in this patch with the following:
> >
> > diff --git a/include/hw/boards.h b/include/hw/boards.h
> > index f82f28468b..622bbaf939 100644
> > --- a/include/hw/boards.h
> > +++ b/include/hw/boards.h
> > @@ -290,18 +289,10 @@ struct MachineState {
> >
> >  #define SET_MACHINE_COMPAT(m, COMPAT) \
> >      do {                              \
> > -        int i;                        \
> >          static GlobalProperty props[] =3D {       \
> >              COMPAT                              \
> > -            { /* end of list */ }               \
> >          };                                      \
> > -        if (!m->compat_props) { \
> > -            m->compat_props =3D g_array_new(false, false, sizeof(voi=
d *)); \
> > -        } \
> > -        for (i =3D 0; props[i].driver !=3D NULL; i++) {    \
> > -            GlobalProperty *prop =3D &props[i];          \
> > -            g_array_append_val(m->compat_props, prop); \
> > -        }                                              \
> > +        compat_props_add(m->compat_props, props, G_N_ELEMENTS(props)=
); \
> >      } while (0)
> >
> >  #endif
> >
>=20
> Didn't you ask in a previous iteration to remove the macros?
> "I like us to be able to
> register compat properties without macro magic.  The existence of
> SET_MACHINE_COMPAT is a bug and not a feature.

I did ask you to not introduce a new macro in accel.c, and
removing the existing macros is really welcome.  I just don't
think we should do everything in a single patch.

--=20
Eduardo
