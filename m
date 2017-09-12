Received: from eggs.gnu.org ([2001:4830:134:3::10]:47527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drixy-0004TR-7B
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 07:02:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1drixt-0001dA-9O
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 07:02:54 -0400
Date: Tue, 12 Sep 2017 13:02:35 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170912130235.2353dec3@nial.brq.redhat.com>
In-Reply-To: <CAKmqyKPWDmVYJceYao7NkD5svWqN_fYbDoUJ4uLNFdAhv+kFwg@mail.gmail.com>
References: <1504533662-198084-1-git-send-email-imammedo@redhat.com>
	<1504533662-198084-7-git-send-email-imammedo@redhat.com>
	<20170905213152.GG17184@localhost.localdomain>
	<CAKmqyKPWDmVYJceYao7NkD5svWqN_fYbDoUJ4uLNFdAhv+kFwg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 6/6] arm: drop intermadiate cpu_model ->
 cpu type parsing and use cpu type directly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Rob Herring <robh@kernel.org>, Andrew Jones <drjones@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org
	Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>

On Tue, 5 Sep 2017 14:47:52 -0700
Alistair Francis <alistair23@gmail.com> wrote:

> On Tue, Sep 5, 2017 at 2:31 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
> > On Mon, Sep 04, 2017 at 04:01:02PM +0200, Igor Mammedov wrote:  
> >> there are 2 use cases to deal with:
> >>   1: fixed CPU models per board/soc
> >>   2: boards with user configurable cpu_model and fallback to
> >>      default cpu_model if user hasn't specified one explicitly
> >>
> >> For the 1st
> >>   drop intermediate cpu_model parsing and use const cpu type
> >>   directly, which replaces:
> >>      typename = object_class_get_name(
> >>            cpu_class_by_name(TYPE_ARM_CPU, cpu_model))
> >>      object_new(typename)
> >>   with
> >>      object_new(FOO_CPU_TYPE_NAME)
> >>   or
> >>      cpu_generic_init(BASE_CPU_TYPE, "my cpu model")
> >>   with
> >>      cpu_create(FOO_CPU_TYPE_NAME)
> >>
> >> as result 1st use case doesn't have to invoke not necessary
> >> translation and not needed code is removed.
> >>
> >> For the 2nd
> >>  1: set default cpu type with MachineClass::default_cpu_type and
> >>  2: use generic cpu_model parsing that done before machine_init()
> >>     is run and:
> >>     2.1: drop custom cpu_model parsing where pattern is:
> >>        typename = object_class_get_name(
> >>            cpu_class_by_name(TYPE_ARM_CPU, cpu_model))
> >>        [parse_features(typename, cpu_model, &err) ]
> >>
> >>     2.2: or replace cpu_generic_init() which does what
> >>          2.1 does + create_cpu(typename) with just
> >>          create_cpu(machine->cpu_type)
> >> as result cpu_name -> cpu_type translation is done using
> >> generic machine code one including parsing optional features
> >> if supported/present (removes a bunch of duplicated cpu_model
> >> parsing code) and default cpu type is defined in an uniform way
> >> within machine_class_init callbacks instead of adhoc places
> >> in boadr's machine_init code.
> >>
> >> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >> ---
> >> CC: Peter Maydell <peter.maydell@linaro.org>
> >> CC: Igor Mitsyanko <i.mitsyanko@gmail.com>
> >> CC: Rob Herring <robh@kernel.org>
> >> CC: Andrzej Zaborowski <balrogg@gmail.com>
> >> CC: Jan Kiszka <jan.kiszka@web.de>
> >> CC: Alistair Francis <alistair@alistair23.me>
> >> CC: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
> >> CC: qemu-arm@nongnu.org
> >> ---

[...]

> >>
> >>  static const TypeInfo lm3s6965evb_type = {
> >> diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
> >> index f61e735..1cd6374 100644
> >> --- a/hw/arm/stm32f205_soc.c
> >> +++ b/hw/arm/stm32f205_soc.c
> >> @@ -112,7 +112,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
> >>
> >>      armv7m = DEVICE(&s->armv7m);
> >>      qdev_prop_set_uint32(armv7m, "num-irq", 96);
> >> -    qdev_prop_set_string(armv7m, "cpu-model", s->cpu_model);
> >> +    qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
> >>      object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),
> >>                                       "memory", &error_abort);
> >>      object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err);
> >> @@ -200,7 +200,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
> >>  }
> >>
> >>  static Property stm32f205_soc_properties[] = {
> >> -    DEFINE_PROP_STRING("cpu-model", STM32F205State, cpu_model),
> >> +    DEFINE_PROP_STRING("cpu-type", STM32F205State, cpu_type),  
> >
> > Same as armv7m: are we 100% sure users are not setting this
> > manually?  
> 
> In an embedded board like this it really doesn't make sense to let the
> user overwrite the CPU. The SoC will take it as an option, but the
> board (which creates the SoC) just blindly always uses the same CPU.
> That feature is more for QOMificatoion then any real reason though.
If SoC has fixed cpu type then I'd drop property.
I'd leave it upto board maintainers to cleanup not really needed
properties and make soc with fixed cpu type where it makes sense.

> In saying that I think a warning if the user tries to set the CPU
> would make sense. I know that this issues comes up in other ARM boards
> (Zynq-7000 has the same issue as well) so maybe a machine property
> saying that the board doesn't accept custom CPUs would be a good idea.
> 
> Overall I think this patch is moving in the right direction though and
> this CPU option being ignored existed before this series.
right, this series just removes cpu_generic_init()/cpu_model in boards
everything else should be done as separate series.

> 
> Thanks,
> Alistair
> 
> 
> >
> >  
> 
