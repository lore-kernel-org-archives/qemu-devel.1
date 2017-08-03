Received: from eggs.gnu.org ([2001:4830:134:3::10]:34111)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ddHgH-00040G-HJ
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:04:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ddHgG-0000vm-Er
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:04:57 -0400
Date: Thu, 3 Aug 2017 17:04:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170803170444.1009a26e@nial.brq.redhat.com>
In-Reply-To: <20170802212933.GG3108@localhost.localdomain>
References: <20170802103259.25940-1-lvivier@redhat.com>
	<CAAdtpL4fDx3JLm7+=TcJTZXwq_zuwup4=zkGH8QMLJ1ES=kqHw@mail.gmail.com>
	<de5b3384-086b-bf7f-944f-94d10e185a7d@redhat.com>
	<20170802212933.GG3108@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] cpu: don't allow negative core id
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "qemu-ppc@nongnu.org list:PowerPC" <qemu-ppc@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Wed, 2 Aug 2017 18:29:33 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Wed, Aug 02, 2017 at 03:50:36PM +0200, Laurent Vivier wrote:
> > On 02/08/2017 15:42, Philippe Mathieu-Daud=C3=A9 wrote: =20
> > > Hi Laurent,
> > >=20
> > > On Wed, Aug 2, 2017 at 7:32 AM, Laurent Vivier <lvivier@redhat.com> w=
rote: =20
> > >> With pseries machine type a negative core-id is not managed properly:
> > >> -1 gives an inaccurate error message ("core -1 already populated"),
> > >> -2 crashes QEMU (core dump)
> > >>
> > >> As it seems a negative value is invalid for any architecture,
> > >> instead of checking this in spapr_core_pre_plug() I think it's better
> > >> to check this in the generic part, core_prop_set_core_id() =20
> > >=20
> > > Why is this property signed? If there is not reason to use it negativ=
e,
> > > is it possible to use object_property_add(.."uint"..)? =20
> >=20
> > You should be right:
> >=20
> > { 'struct': 'NumaNodeOptions',
> >   'data': {
> >    '*nodeid': 'uint16',
> >    '*cpus':   ['uint16'],
> >    '*mem':    'size',
> >    '*memdev': 'str' }}
> >=20
> > but
> >=20
> > { 'struct': 'CpuInstanceProperties',
> >   'data': { '*node-id': 'int',
> >             '*socket-id': 'int',
> >             '*core-id': 'int',
> >             '*thread-id': 'int'
> >   }
> > }
> >=20
> > But I'm not sure it's a good idea to change the API now. =20
>=20
> Property parsing is not affected by the QAPI schema at all, so
> touching the schema wouldn't fix the bug.
>=20
> The same applies to the 'type' argument to object_property_add():
> it is ignored everywhere.
>=20
> However, the property setter can simply use a visitor for unsigned values=
, and
> it will reject negative values automatically, e.g.:
>=20
>   diff --git a/hw/cpu/core.c b/hw/cpu/core.c
>   index 2bf960d..b5af2bf 100644
>   --- a/hw/cpu/core.c
>   +++ b/hw/cpu/core.c
>   @@ -25,9 +25,9 @@ static void core_prop_set_core_id(Object *obj, Visito=
r *v, const char *name,
>    {
>        CPUCore *core =3D CPU_CORE(obj);
>        Error *local_err =3D NULL;
>   -    int64_t value;
>   +    uint32_t value;
>   =20
>   -    visit_type_int(v, name, &value, &local_err);
>   +    visit_type_uint32(v, name, &value, &local_err);
>        if (local_err) {
>            error_propagate(errp, local_err);
>            return;
>=20
>=20
>   $ ./ppc64-softmmu/qemu-system-ppc64 -device POWER8_v2.0-spapr-cpu-core,=
core-id=3D-2
>   qemu-system-ppc64: -device POWER8_v2.0-spapr-cpu-core,core-id=3D-2: Par=
ameter 'core-id' expects uint32_t
>=20
>=20
> I would suggest changing the CPUCore struct fields to uint32_t or
> uint64_t, but it would be more intrusive and we're past hard
> freeze.  Your patch looks good for 2.10.
there is one reason to use signed int here,
negative values might be used to mark not set property value,
I recall we do something like this in target-i386.


>=20
> Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>
>=20
> I'm queueing it on machine-next.
>=20
