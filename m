Received: from eggs.gnu.org ([2001:4830:134:3::10]:40524)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gWj3t-0005G6-Is
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:31:07 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@gmail.com>) id 1gWj3q-0002ak-MB
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 09:31:00 -0500
MIME-Version: 1.0
References: <20181204142023.15982-1-marcandre.lureau@redhat.com>
	<20181204142023.15982-9-marcandre.lureau@redhat.com>
	<20181211142310.GB20015@habkost.net>
In-Reply-To: <20181211142310.GB20015@habkost.net>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Tue, 11 Dec 2018 18:30:32 +0400
Message-ID: <CAJ+F1CKF7_MEtZNY2FEot9dG-RZQwGeZZ7+3+q1QgD98koF2SA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, David Hildenbrand <david@redhat.com>, "open list:sPAPR pseries" <qemu-ppc@nongnu.org>, Cornelia Huck <cohuck@redhat.com>, QEMU <qemu-devel@nongnu.org>, Christian Borntraeger <borntraeger@de.ibm.com>, Qemu-s390x list <qemu-s390x@nongnu.org>, "open list:ARM" <qemu-arm@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, David Gibson <david@gibson.dropbear.id.au>

Hi

On Tue, Dec 11, 2018 at 6:24 PM Eduardo Habkost <ehabkost@redhat.com> wrote=
:
>
> I have specific questions about the approach we are using to
> eliminate the macros.
>
> My main goal when asking this to be moved to a separate patch is
> to not make this discussion block the register_global_properties() &
> device_post_init() changes (which look good to me).
>
>
> On Tue, Dec 04, 2018 at 06:20:12PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> [...]
> > -#define VIRT_COMPAT_3_0 \
> > +static GlobalProperty virt_compat_3_0[] =3D {
> >      HW_COMPAT_3_0
> > +};
>
> What about moving the array inside virt_machine_3_0_options()?

Sure

>
> >
> >  static void virt_3_0_instance_init(Object *obj)
> >  {
> > @@ -1883,12 +1884,14 @@ static void virt_3_0_instance_init(Object *obj)
> >  static void virt_machine_3_0_options(MachineClass *mc)
> >  {
> >      virt_machine_3_1_options(mc);
> > -    SET_MACHINE_COMPAT(mc, VIRT_COMPAT_3_0);
> > +    compat_props_add(mc->compat_props,
> > +                     virt_compat_3_0, G_N_ELEMENTS(virt_compat_3_0));
> >  }
> >  DEFINE_VIRT_MACHINE(3, 0)
>
> This is nice, because it's basically the same amount of
> boilerplate code, but I would find a NULL-terminated array much
> easier to use than having to use G_N_ELEMENTS().

But easier to get wrong too. I prefer the explicit N arguments. (it
also gives some flexibility, since you can point to inner pointer +
size, although we don't care at this point)

>
> This would be nice in cases like virt, because we wouldn't even
> need to declare a separate array.  We could do something like:
>
>     compat_props_add(mc->compat_props, hw_compat_3_0);
>
> and that's all.  No need for HW_COMPAT_* macros, no need for
> extra arrays to be declared.
>
>
> [...]
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index 7092d6d13f..575566e466 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -438,74 +438,112 @@ static void pc_i440fx_3_1_machine_options(Machin=
eClass *m)
> >  DEFINE_I440FX_MACHINE(v3_1, "pc-i440fx-3.1", NULL,
> >                        pc_i440fx_3_1_machine_options);
> >
> > +static GlobalProperty pc_compat_3_0[] =3D {
> > +    PC_COMPAT_3_0
> > +};
> > +
> >  static void pc_i440fx_3_0_machine_options(MachineClass *m)
> >  {
> >      pc_i440fx_3_1_machine_options(m);
> >      m->is_default =3D 0;
> >      m->alias =3D NULL;
> > -    SET_MACHINE_COMPAT(m, PC_COMPAT_3_0);
> > +
> > +    compat_props_add(m->compat_props,
> > +                     pc_compat_3_0, G_N_ELEMENTS(pc_compat_3_0));
> >  }
> >
> >  DEFINE_I440FX_MACHINE(v3_0, "pc-i440fx-3.0", NULL,
> >                        pc_i440fx_3_0_machine_options);
>
> Now, this is requiring _more_ boilerplate code than before.  I'd
> like us to find a way to eliminate the macro without increasing
> the amount of boilerplate code.

I am open to ideas

>
>
> [...]
> > diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> > index 7afd1a175b..d801ba71eb 100644
> > --- a/hw/ppc/spapr.c
> > +++ b/hw/ppc/spapr.c
> > @@ -3973,8 +3973,9 @@ DEFINE_SPAPR_MACHINE(3_1, "3.1", true);
> >  /*
> >   * pseries-3.0
> >   */
> > -#define SPAPR_COMPAT_3_0                                              =
\
> > +static GlobalProperty spapr_compat_3_0[] =3D {
> >      HW_COMPAT_3_0
> > +};
> >
> >  static void spapr_machine_3_0_instance_options(MachineState *machine)
> >  {
> > @@ -3986,7 +3987,8 @@ static void spapr_machine_3_0_class_options(Machi=
neClass *mc)
> >      sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> >
> >      spapr_machine_3_1_class_options(mc);
> > -    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_3_0);
> > +    compat_props_add(mc->compat_props,
> > +                     spapr_compat_3_0, G_N_ELEMENTS(spapr_compat_3_0))=
;
> >
> >      smc->legacy_irq_allocation =3D true;
> >      smc->irq =3D &spapr_irq_xics_legacy;
> > @@ -3997,18 +3999,19 @@ DEFINE_SPAPR_MACHINE(3_0, "3.0", false);
> >  /*
> >   * pseries-2.12
> >   */
> > -#define SPAPR_COMPAT_2_12                                             =
 \
> > -    HW_COMPAT_2_12                                                    =
 \
> > -    {                                                                 =
 \
> > -        .driver =3D TYPE_POWERPC_CPU,                                 =
   \
> > -        .property =3D "pre-3.0-migration",                            =
   \
> > -        .value    =3D "on",                                           =
   \
> > -    },                                                                =
 \
> > -    {                                                                 =
 \
> > -        .driver =3D TYPE_SPAPR_CPU_CORE,                              =
   \
> > -        .property =3D "pre-3.0-migration",                            =
   \
> > -        .value    =3D "on",                                           =
   \
> > +static GlobalProperty spapr_compat_2_12[] =3D {
> > +    HW_COMPAT_2_12
> > +    {
> > +        .driver =3D TYPE_POWERPC_CPU,
> > +        .property =3D "pre-3.0-migration",
> > +        .value    =3D "on",
> > +    },
> > +    {
> > +        .driver =3D TYPE_SPAPR_CPU_CORE,
> > +        .property =3D "pre-3.0-migration",
> > +        .value    =3D "on",
> >      },
> > +};
> >
> >  static void spapr_machine_2_12_instance_options(MachineState *machine)
> >  {
> > @@ -4020,7 +4023,8 @@ static void spapr_machine_2_12_class_options(Mach=
ineClass *mc)
> >      sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> >
> >      spapr_machine_3_0_class_options(mc);
> > -    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_12);
> > +    compat_props_add(mc->compat_props,
> > +                     spapr_compat_2_12, G_N_ELEMENTS(spapr_compat_2_12=
));
>
> It would be nice to be able to write this as:
>
>     static GlobalProperty spapr_compat_2_12[] =3D {
>         {
>             .driver =3D TYPE_POWERPC_CPU,
>             .property =3D "pre-3.0-migration",
>             .value    =3D "on",
>         },
>         {
>             .driver =3D TYPE_SPAPR_CPU_CORE,
>             .property =3D "pre-3.0-migration",
>             .value    =3D "on",
>         },
>         { /* end of list */ },
>     };
>
>     compat_props_add(mc->compat_props, hw_compat_3_0);
>     compat_props_add(mc->compat_props, spapr_compat_2_12);
>
> This way we won't need the HW_COMPAT_* macros anymore.

That could be done on top, I imagine. I can give it a try.

>
> Other than that, it's also basically the same amount of
> boilerplate as before, so that's good.
>
>
> >
> >      /* We depend on kvm_enabled() to choose a default value for the
> >       * hpt-max-page-size capability. Of course we can't do it here
> [...]
> > diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> > index a0615a8b35..275cbe5da4 100644
> > --- a/hw/s390x/s390-virtio-ccw.c
> > +++ b/hw/s390x/s390-virtio-ccw.c
> > @@ -651,96 +651,106 @@ bool css_migration_enabled(void)
> >      }                                                                 =
        \
> >      type_init(ccw_machine_register_##suffix)
> >
> > -#define CCW_COMPAT_3_0 \
> > -        HW_COMPAT_3_0
> > -
> > -#define CCW_COMPAT_2_12 \
> > -        HW_COMPAT_2_12
> > -
> > -#define CCW_COMPAT_2_11 \
> > -        HW_COMPAT_2_11 \
> > -        {\
> > -            .driver   =3D TYPE_SCLP_EVENT_FACILITY,\
> > -            .property =3D "allow_all_mask_sizes",\
> > -            .value    =3D "off",\
> > -        },
> [...]
> > +static GlobalProperty ccw_compat_3_0[] =3D {
> > +    HW_COMPAT_3_0
> > +};
> > +
> > +static GlobalProperty ccw_compat_2_12[] =3D {
> > +    HW_COMPAT_2_12
> > +};
> > +
> > +static GlobalProperty ccw_compat_2_11[] =3D {
> > +    HW_COMPAT_2_11
> > +    {
> > +        .driver   =3D TYPE_SCLP_EVENT_FACILITY,
> > +        .property =3D "allow_all_mask_sizes",
> > +        .value    =3D "off",
> > +    },
> > +};
> [...]
> >
> >  static void ccw_machine_3_1_instance_options(MachineState *machine)
> >  {
> > @@ -762,7 +772,8 @@ static void ccw_machine_3_0_class_options(MachineCl=
ass *mc)
> >
> >      s390mc->hpage_1m_allowed =3D false;
> >      ccw_machine_3_1_class_options(mc);
> > -    SET_MACHINE_COMPAT(mc, CCW_COMPAT_3_0);
> > +    compat_props_add(mc->compat_props,
> > +                     ccw_compat_3_0, G_N_ELEMENTS(ccw_compat_3_0));
>
> Same comments from spapr apply here: getting rid of the
> HW_COMPAT_* macros would be nice, but this version is good enough
> because it has the same amount of boilerplate code.
>
>

thanks

> >  }
> >  DEFINE_CCW_MACHINE(3_0, "3.0", false);
> [...]
>
> --
> Eduardo
>


--=20
Marc-Andr=C3=A9 Lureau
