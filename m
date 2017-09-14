Received: from eggs.gnu.org ([2001:4830:134:3::10]:51252)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dsOuj-0005bW-8J
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:50:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1dsOui-0005tV-0t
	for qemu-devel@nongnu.org; Thu, 14 Sep 2017 03:50:21 -0400
Date: Thu, 14 Sep 2017 09:50:11 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170914095011.2fba8aab@nial.brq.redhat.com>
In-Reply-To: <af093dab-efb0-7fb7-b373-e9a547ca6da7@amsat.org>
References: <1505318697-77161-1-git-send-email-imammedo@redhat.com>
	<1505318697-77161-6-git-send-email-imammedo@redhat.com>
	<af093dab-efb0-7fb7-b373-e9a547ca6da7@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 5/5] arm: drop intermediate cpu_model ->
 cpu type parsing and use cpu type directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Alistair Francis <alistair23@gmail.com>

On Thu, 14 Sep 2017 00:47:20 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> Hi Igor,
>=20
> awesome clean refactor!
Thanks,

there is more patches on this topic for other targets to post
but it's waiting on 1-3/5 to land in master so it would be
easier for maintainers to verify/test them without fishing out
dependencies from mail list.

hopefully everything will land in 2.11 so we won't have to deal
with cpu_model anywhere except of one place vl.c.

> just 1 comment inlined.
>=20
> On 09/13/2017 01:04 PM, Igor Mammedov wrote:
> > there are 2 use cases to deal with:
> >    1: fixed CPU models per board/soc
> >    2: boards with user configurable cpu_model and fallback to
> >       default cpu_model if user hasn't specified one explicitly
> >=20
> > For the 1st
> >    drop intermediate cpu_model parsing and use const cpu type
> >    directly, which replaces:
> >       typename =3D object_class_get_name(
> >             cpu_class_by_name(TYPE_ARM_CPU, cpu_model))
> >       object_new(typename)
> >    with
> >       object_new(FOO_CPU_TYPE_NAME)
> >    or
> >       cpu_generic_init(BASE_CPU_TYPE, "my cpu model")
> >    with
> >       cpu_create(FOO_CPU_TYPE_NAME)
> >=20
> > as result 1st use case doesn't have to invoke not necessary
> > translation and not needed code is removed.
> >=20
> > For the 2nd
> >   1: set default cpu type with MachineClass::default_cpu_type and
> >   2: use generic cpu_model parsing that done before machine_init()
> >      is run and:
> >      2.1: drop custom cpu_model parsing where pattern is:
> >         typename =3D object_class_get_name(
> >             cpu_class_by_name(TYPE_ARM_CPU, cpu_model))
> >         [parse_features(typename, cpu_model, &err) ]
> >=20
> >      2.2: or replace cpu_generic_init() which does what
> >           2.1 does + create_cpu(typename) with just
> >           create_cpu(machine->cpu_type)
> > as result cpu_name -> cpu_type translation is done using
> > generic machine code one including parsing optional features
> > if supported/present (removes a bunch of duplicated cpu_model
> > parsing code) and default cpu type is defined in an uniform way
> > within machine_class_init callbacks instead of adhoc places
> > in boadr's machine_init code.
> >=20
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
> > ---
> > v2:
> >   - fix merge conflicts with ignore_memory_transaction_failures
> >   - fix couple merge conflicts where SoC type string where replaced by =
type macro
> >   - keep plain prefix string in: strncmp(cpu_type, "pxa27", 5)
> >   - s/"%s" ARM_CPU_TYPE_SUFFIX/ARM_CPU_TYPE_NAME("%s")/
> > ---
[...]

> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index fe96557..fe26e99 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -163,13 +163,13 @@ static const int a15irqmap[] =3D {
> >   };
> >  =20
> >   static const char *valid_cpus[] =3D {
> > -    "cortex-a15",
> > -    "cortex-a53",
> > -    "cortex-a57",
> > -    "host",
> > +    ARM_CPU_TYPE_NAME("cortex-a15"),
> > +    ARM_CPU_TYPE_NAME("cortex-a53"),
> > +    ARM_CPU_TYPE_NAME("cortex-a57"),
> > +    ARM_CPU_TYPE_NAME("host"),
> >   };
> >  =20
> > -static bool cpuname_valid(const char *cpu)
> > +static bool cpu_type_valid(const char *cpu)
> >   {
> >       int i; =20
>=20
> I'd just change this by:
>=20
> static bool cpuname_valid(const char *cpu)
> {
>      static const char *valid_cpus[] =3D {
>          ARM_CPU_TYPE_NAME("cortex-a15"),
>          ARM_CPU_TYPE_NAME("cortex-a53"),
>          ARM_CPU_TYPE_NAME("cortex-a57"),
>      };
>      int i;
>=20
>      for (i =3D 0; i < ARRAY_SIZE(valid_cpus); i++) {
>          if (strcmp(cpu, valid_cpus[i]) =3D=3D 0) {
>              return true;
>          }
>      }

>      return kvm_enabled() && !strcmp(cpu, ARM_CPU_TYPE_NAME("host");
here is one more case to consider for valid_cpus refactoring,
CCing Alistair.

> }
>=20
> Anyway this can be a later patch.
this check might be removed or superseded by generic valid_cpus work
that Alistair is working on, anyways it should be part of that work
as change is not directly related to this series.


[...]
