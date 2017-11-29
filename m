Received: from eggs.gnu.org ([2001:4830:134:3::10]:41558)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eJyMk-0005ld-RA
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 04:09:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1eJyMg-0004nf-Qs
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 04:09:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1eJyMg-0004mf-Id
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 04:09:10 -0500
Date: Wed, 29 Nov 2017 10:09:02 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20171129100902.2d6408cf@redhat.com>
In-Reply-To: <CAKmqyKONB9phsgZbXkzQ7=i6RiWiDqAa6fuqexKJNbmkL0di6A@mail.gmail.com>
References: <cover.1508279421.git.alistair.francis@xilinx.com>
	<7d590a446dfe29a1815c3cad2a93f7d6b0d8a214.1508279421.git.alistair.francis@xilinx.com>
	<ff2f55ec-ef33-6512-3a5d-3ade1eaaf92e@amsat.org>
	<CAKmqyKONB9phsgZbXkzQ7=i6RiWiDqAa6fuqexKJNbmkL0di6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 4/5] xlnx-zcu102: Specify the valid CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>

On Thu, 26 Oct 2017 11:59:16 +0200
Alistair Francis <alistair.francis@xilinx.com> wrote:

> On Mon, Oct 23, 2017 at 1:14 PM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org> wrote:
> > On 10/17/2017 07:31 PM, Alistair Francis wrote: =20
> >> List all possible valid CPU options.
> >>
> >> Signed-off-by: Alistair Francis <alistair.francis@xilinx.com>
> >> ---
> >>
> >> An implementation for single CPU machines is still being discussed. A
> >> solution proposed by Eduardo is this:
> >>
> >> 1) Change the default on TYPE_MACHINE to:
> >>      mc->valid_cpu_types =3D { TYPE_CPU, NULL };
> >>
> >>    This will keep the existing behavior for all boards.
> >>
> >> 2) mc->valid_cpu_types=3DNULL be interpreted as "no CPU model
> >>    except the default is accepted" or "-cpu is not accepted" in
> >>    machine_run_board_init() (I prefer the former, but both
> >>    options would be correct)
> >>
> >> 3) Boards like xlnx_zynqmp could then just do this:
> >>
> >>    static void xxx_class_init(...) {
> >>        mc->default_cpu_type =3D MY_CPU_TYPE;
> >>        /* Reason: XXX_init() is hardcoded to MY_CPU_TYPE */
> >>        mc->valid_cpu_types =3D NULL;
> >>    }
> >>
> >> V3:
> >>  - Make variable static
> >> V2:
> >>  - Don't use the users -cpu
> >>  - Fixup allignment
> >>
> >>  hw/arm/xlnx-zcu102.c | 17 +++++++++++++++++
> >>  1 file changed, 17 insertions(+)
> >>
> >> diff --git a/hw/arm/xlnx-zcu102.c b/hw/arm/xlnx-zcu102.c
> >> index 519a16ed98..d5a5425356 100644
> >> --- a/hw/arm/xlnx-zcu102.c
> >> +++ b/hw/arm/xlnx-zcu102.c
> >> @@ -160,6 +160,11 @@ static void xlnx_zynqmp_init(XlnxZCU102 *s, Machi=
neState *machine)
> >>      arm_load_kernel(s->soc.boot_cpu_ptr, &xlnx_zcu102_binfo);
> >>  }
> >>
> >> +static const char *xlnx_zynqmp_valid_cpus[] =3D {
> >> +                                            ARM_CPU_TYPE_NAME("cortex=
-a53"),
> >> +                                            NULL
> >> +                                              }; =20
> >
> > Why so many spaces? :) Maybe Peter can clean it when applying.
> >
> > static const char *xlnx_zynqmp_valid_cpus[] =3D {
> >     ARM_CPU_TYPE_NAME("cortex-a53"),
> >     NULL
> > };
+1 to what Philippe is suggesting, this is common pattern in QEMU code.

> The spaces are there to keep the elements under the array (while being
> less then 80 characters).
it's not aligned on 4SP from the beginning or 4SP after {}
so it's not exactly matching codding style and catches eye.
Also in case one would need to add an extra cpu there with
longer name beyond 80chr, one would need to move the rest
elements to new alignment.

the same applies for 4-5/5,
I'd would repost fixed up series.

>=20
> Alistair
>=20
> >
> > Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> > =20
> >> +
> >>  static void xlnx_ep108_init(MachineState *machine)
> >>  {
> >>      XlnxZCU102 *s =3D EP108_MACHINE(machine);
> >> @@ -185,6 +190,12 @@ static void xlnx_ep108_machine_class_init(ObjectC=
lass *oc, void *data)
> >>      mc->block_default_type =3D IF_IDE;
> >>      mc->units_per_default_bus =3D 1;
> >>      mc->ignore_memory_transaction_failures =3D true;
> >> +    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a53");
> >> +    /* The ZynqMP SoC is always a Cortex-A53. We add this here to give
> >> +     * users a sane error if they specify a different CPU, but we nev=
er
> >> +     * use their CPU choice.
> >> +     */
> >> +    mc->valid_cpu_types =3D xlnx_zynqmp_valid_cpus;
> >>  }
> >>
> >>  static const TypeInfo xlnx_ep108_machine_init_typeinfo =3D {
> >> @@ -240,6 +251,12 @@ static void xlnx_zcu102_machine_class_init(Object=
Class *oc, void *data)
> >>      mc->block_default_type =3D IF_IDE;
> >>      mc->units_per_default_bus =3D 1;
> >>      mc->ignore_memory_transaction_failures =3D true;
> >> +    mc->default_cpu_type =3D ARM_CPU_TYPE_NAME("cortex-a53");
> >> +    /* The ZynqMP SoC is always a Cortex-A53. We add this here to give
> >> +     * users a sane error if they specify a different CPU, but we nev=
er
> >> +     * use their CPU choice.
> >> +     */
> >> +    mc->valid_cpu_types =3D xlnx_zynqmp_valid_cpus;
> >>  }
> >>
> >>  static const TypeInfo xlnx_zcu102_machine_init_typeinfo =3D {
> >> =20
