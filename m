Received: from eggs.gnu.org ([2001:4830:134:3::10]:51561)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euINl-0000y1-18
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:48:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mjc@sifive.com>) id 1euINi-0005HK-Sk
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:48:25 -0500
Received: from mail-oi0-x230.google.com ([2607:f8b0:4003:c06::230]:37039)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <mjc@sifive.com>) id 1euINi-0005HA-Ls
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 08:48:22 -0500
Received: by mail-oi0-x230.google.com with SMTP id f186so6989717oig.4
	for <qemu-devel@nongnu.org>; Fri, 09 Mar 2018 05:48:22 -0800 (PST)
MIME-Version: 1.0
References: <1519998711-73430-1-git-send-email-mjc@sifive.com>
	<1519998711-73430-14-git-send-email-mjc@sifive.com>
	<95de07a9-5605-d5b8-606d-5d4cd624d5e5@amsat.org>
In-Reply-To: <95de07a9-5605-d5b8-606d-5d4cd624d5e5@amsat.org>
From: Michael Clark <mjc@sifive.com>
Date: Fri, 09 Mar 2018 13:48:11 +0000
Message-ID: <CAHNT7NsQpYTsiF9=qo40OvXd5DUh8FabwnYYv8n5acDA5mEFnw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 13/23] RISC-V HART Array
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>, Palmer Dabbelt <palmer@sifive.com>, RISC-V Patches <patches@groups.riscv.org>, Sagar Karandikar <sagark@eecs.berkeley.edu>, qemu-devel@nongnu.org

Got it. I can add to the post merge cleanup patch series. BTW the code
currently creates a homogeneous array or cores but the intent is that it
supports a heterogeneous array, in the future. It might evolve into an SOC
base class. We need a method to give it an array or cpu_models. For example
the U54-MC has an e51 monitor core and 4 u54 application cores, but they
are part of a heterogeneous core complex. This code is essentially
=E2=80=9Cscaffolding=E2=80=9D. All of the boards currently have a CLINT, so=
 we could move
that in here too, and perhaps rename it.

Evolution... it works as it is at present. Heterogenous signals the future
intent.

On Sat, 10 Mar 2018 at 1:52 AM, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> On 03/02/2018 02:51 PM, Michael Clark wrote:
> > Holds the state of a heterogenous array of RISC-V hardware threads.
>
> heterogeneous
>
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Signed-off-by: Sagar Karandikar <sagark@eecs.berkeley.edu>
> > Signed-off-by: Michael Clark <mjc@sifive.com>
> > ---
> >  hw/riscv/riscv_hart.c         | 89
> +++++++++++++++++++++++++++++++++++++++++++
> >  include/hw/riscv/riscv_hart.h | 39 +++++++++++++++++++
> >  2 files changed, 128 insertions(+)
> >  create mode 100644 hw/riscv/riscv_hart.c
> >  create mode 100644 include/hw/riscv/riscv_hart.h
> >
> > diff --git a/hw/riscv/riscv_hart.c b/hw/riscv/riscv_hart.c
> > new file mode 100644
> > index 0000000..14e3c18
> > --- /dev/null
> > +++ b/hw/riscv/riscv_hart.c
> > @@ -0,0 +1,89 @@
> > +/*
> > + * QEMU RISCV Hart Array
> > + *
> > + * Copyright (c) 2017 SiFive, Inc.
> > + *
> > + * Holds the state of a heterogenous array of RISC-V harts
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2 or later, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but
> WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> License for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> along with
> > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#include "qemu/osdep.h"
> > +#include "qapi/error.h"
> > +#include "hw/sysbus.h"
> > +#include "target/riscv/cpu.h"
> > +#include "hw/riscv/riscv_hart.h"
> > +
> > +static Property riscv_harts_props[] =3D {
> > +    DEFINE_PROP_UINT32("num-harts", RISCVHartArrayState, num_harts, 1)=
,
> > +    DEFINE_PROP_STRING("cpu-type", RISCVHartArrayState, cpu_type),
> > +    DEFINE_PROP_END_OF_LIST(),
> > +};
> > +
> > +static void riscv_harts_cpu_reset(void *opaque)
> > +{
> > +    RISCVCPU *cpu =3D opaque;
> > +    cpu_reset(CPU(cpu));
> > +}
> > +
> > +static void riscv_harts_realize(DeviceState *dev, Error **errp)
> > +{
> > +    RISCVHartArrayState *s =3D RISCV_HART_ARRAY(dev);
> > +    Error *err =3D NULL;
> > +    int n;
> > +
> > +    s->harts =3D g_new0(RISCVCPU, s->num_harts);
> > +
> > +    for (n =3D 0; n < s->num_harts; n++) {
> > +
> > +        object_initialize(&s->harts[n], sizeof(RISCVCPU), s->cpu_type)=
;
> > +        s->harts[n].env.mhartid =3D n;
> > +        object_property_add_child(OBJECT(s), "harts[*]",
> OBJECT(&s->harts[n]),
> > +                                  &error_abort);
> > +        qemu_register_reset(riscv_harts_cpu_reset, &s->harts[n]);
> > +        object_property_set_bool(OBJECT(&s->harts[n]), true,
> > +                                 "realized", &err);
> > +        if (err) {
> > +            error_propagate(errp, err);
> > +            return;
> > +        }
> > +    }
> > +}
> > +
> > +static void riscv_harts_class_init(ObjectClass *klass, void *data)
> > +{
> > +    DeviceClass *dc =3D DEVICE_CLASS(klass);
> > +
> > +    dc->props =3D riscv_harts_props;
> > +    dc->realize =3D riscv_harts_realize;
> > +}
> > +
> > +static void riscv_harts_init(Object *obj)
> > +{
> > +    /* RISCVHartArrayState *s =3D SIFIVE_COREPLEX(obj); */
>
> This seems an old comment, now this would be RISCV_HART_ARRAY(obj).
>
> Maybe better remove this riscv_harts_init(), ...
>
> > +}
> > +
> > +static const TypeInfo riscv_harts_info =3D {
> > +    .name          =3D TYPE_RISCV_HART_ARRAY,
> > +    .parent        =3D TYPE_SYS_BUS_DEVICE,
> > +    .instance_size =3D sizeof(RISCVHartArrayState),
> > +    .instance_init =3D riscv_harts_init,
>
> ... and drop this line?
>
> > +    .class_init    =3D riscv_harts_class_init,
> > +};
> > +
> > +static void riscv_harts_register_types(void)
> > +{
> > +    type_register_static(&riscv_harts_info);
> > +}
> > +
> > +type_init(riscv_harts_register_types)
> > diff --git a/include/hw/riscv/riscv_hart.h
> b/include/hw/riscv/riscv_hart.h
> > new file mode 100644
> > index 0000000..0671d88
> > --- /dev/null
> > +++ b/include/hw/riscv/riscv_hart.h
> > @@ -0,0 +1,39 @@
> > +/*
> > + * QEMU RISC-V Hart Array interface
> > + *
> > + * Copyright (c) 2017 SiFive, Inc.
> > + *
> > + * Holds the state of a heterogenous array of RISC-V harts
> > + *
> > + * This program is free software; you can redistribute it and/or modif=
y
> it
> > + * under the terms and conditions of the GNU General Public License,
> > + * version 2 or later, as published by the Free Software Foundation.
> > + *
> > + * This program is distributed in the hope it will be useful, but
> WITHOUT
> > + * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY =
or
> > + * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public
> License for
> > + * more details.
> > + *
> > + * You should have received a copy of the GNU General Public License
> along with
> > + * this program.  If not, see <http://www.gnu.org/licenses/>.
> > + */
> > +
> > +#ifndef HW_RISCV_HART_H
> > +#define HW_RISCV_HART_H
> > +
> > +#define TYPE_RISCV_HART_ARRAY "riscv.hart_array"
> > +
> > +#define RISCV_HART_ARRAY(obj) \
> > +    OBJECT_CHECK(RISCVHartArrayState, (obj), TYPE_RISCV_HART_ARRAY)
> > +
> > +typedef struct RISCVHartArrayState {
> > +    /*< private >*/
> > +    SysBusDevice parent_obj;
> > +
> > +    /*< public >*/
> > +    uint32_t num_harts;
> > +    char *cpu_type;
> > +    RISCVCPU *harts;
> > +} RISCVHartArrayState;
> > +
> > +#endif
> >
>
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
>
