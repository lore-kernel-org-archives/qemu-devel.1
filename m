Received: from eggs.gnu.org ([2001:4830:134:3::10]:43924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dro4c-0006b1-2R
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:30:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1dro4a-0002Bx-So
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 12:30:06 -0400
MIME-Version: 1.0
In-Reply-To: <20170912125307.5681ec0e@nial.brq.redhat.com>
References: <1504533662-198084-1-git-send-email-imammedo@redhat.com>
	<1504533662-198084-7-git-send-email-imammedo@redhat.com>
	<20170905213152.GG17184@localhost.localdomain>
	<CAKmqyKPWDmVYJceYao7NkD5svWqN_fYbDoUJ4uLNFdAhv+kFwg@mail.gmail.com>
	<20170905221226.GZ7570@localhost.localdomain>
	<20170912125307.5681ec0e@nial.brq.redhat.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 12 Sep 2017 09:29:32 -0700
Message-ID: <CAKmqyKM6_EYdZNB-VSj6_piAxLKHiQS3WoFkX_83HQxDmjTtEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: Igor Mammedov <imammedo@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Rob Herring <robh@kernel.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>

On Tue, Sep 12, 2017 at 3:53 AM, Igor Mammedov <imammedo@redhat.com> wrote:
> On Tue, 5 Sep 2017 19:12:26 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
>
>> On Tue, Sep 05, 2017 at 02:47:52PM -0700, Alistair Francis wrote:
>> > On Tue, Sep 5, 2017 at 2:31 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> [...]
>> > >> diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
>> > >> index f61e735..1cd6374 100644
>> > >> --- a/hw/arm/stm32f205_soc.c
>> > >> +++ b/hw/arm/stm32f205_soc.c
>> > >> @@ -112,7 +112,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
>> > >>
>> > >>      armv7m = DEVICE(&s->armv7m);
>> > >>      qdev_prop_set_uint32(armv7m, "num-irq", 96);
>> > >> -    qdev_prop_set_string(armv7m, "cpu-model", s->cpu_model);
>> > >> +    qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
>> > >>      object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),
>> > >>                                       "memory", &error_abort);
>> > >>      object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err);
>> > >> @@ -200,7 +200,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
>> > >>  }
>> > >>
>> > >>  static Property stm32f205_soc_properties[] = {
>> > >> -    DEFINE_PROP_STRING("cpu-model", STM32F205State, cpu_model),
>> > >> +    DEFINE_PROP_STRING("cpu-type", STM32F205State, cpu_type),
>> > >
>> > > Same as armv7m: are we 100% sure users are not setting this
>> > > manually?
>> >
>> > In an embedded board like this it really doesn't make sense to let the
>> > user overwrite the CPU. The SoC will take it as an option, but the
>> > board (which creates the SoC) just blindly always uses the same CPU.
>> > That feature is more for QOMificatoion then any real reason though.
>> >
>>
>> I'm not talking about -cpu (no user-visible change in the
>> handling of -cpu should result from this patch), but about
>> possible cases where the user set the "cpu-model" property using
>> another mechanism, like -global.  Probably it's impossible for an
>> user to override the property successfully, but I would like to
>> be sure.
>>
>>
>> > In saying that I think a warning if the user tries to set the CPU
>> > would make sense. I know that this issues comes up in other ARM boards
>> > (Zynq-7000 has the same issue as well) so maybe a machine property
>> > saying that the board doesn't accept custom CPUs would be a good idea.
> Agreed, it would be useful, however goal of the patch to drop
> cpu_generic_init() preferably without changing behavior
>
> so I'd leave extra stuff you mention upto board maintainers
> to fix up on top.
>
>
>> Yeah, there are multiple cases in this patch where boards are
>> validating the CPU model, but not all boards do that.  A generic
>> MachineClass::valid_cpu_types[] field would be useful.
> so far I've met 3 use cases for valid_cpu_types
>  * no check - just try to use whatever user provided
>  * check for concrete cpu models (leaf classes)
>  * check for super-class based in partial cpu_model match
>
> it is nice to have valid_cpu_types[] /I recall even trying out something similar/
> but then series turns into mess where one tries to fix several things
> and on top of it in all targets, hence I've decided first to get rid of
> all cpu_model handling in boards and only then think about valid_cpus using cpu types.
>
> I'd gladly give up 'valid cpus' to someone else more interested in it,
> there are other users beside of ARM boards for it.
> /seems Alistair is interested in it, at least in ARM part/

Yeah, I'm interested in getting a generic framework to make this
possible in. Still just an RFC, I need to get back to that this week
and tidy it up.

Thanks,
Alistair

>
>
>> > Overall I think this patch is moving in the right direction though and
>> > this CPU option being ignored existed before this series.
>>
>> I agree this is going on the right direction.  However, I don't
>> see any board that ignore the CPU option: all of them seem to use
>> cpu_model when creating the CPUs, already.
> in ARM case there are boards that use
>  * '-cpu' provided model
>  * '-cpu' provided model with valid cpu checks
>  * 'hardcoded' cpu model ignoring '-cpu'/-global
>
> I've thought commit message sufficiently described current situation and changes.
