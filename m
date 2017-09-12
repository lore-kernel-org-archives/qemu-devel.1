Received: from eggs.gnu.org ([2001:4830:134:3::10]:36314)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1drjtS-0003td-Sf
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:02:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1drjtM-0005Rm-Qx
	for qemu-devel@nongnu.org; Tue, 12 Sep 2017 08:02:18 -0400
Date: Tue, 12 Sep 2017 09:01:38 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170912120138.GU7570@localhost.localdomain>
References: <1504533662-198084-1-git-send-email-imammedo@redhat.com>
	<1504533662-198084-7-git-send-email-imammedo@redhat.com>
	<20170905213152.GG17184@localhost.localdomain>
	<CAKmqyKPWDmVYJceYao7NkD5svWqN_fYbDoUJ4uLNFdAhv+kFwg@mail.gmail.com>
	<20170905221226.GZ7570@localhost.localdomain>
	<CAKmqyKO4yRz3R0BJ+gz=UfLc0d_AoNtEAHn-SNFMzg3xo12D=Q@mail.gmail.com>
	<20170909203014.GG7570@localhost.localdomain>
	<20170912122214.29f0840e@nial.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170912122214.29f0840e@nial.brq.redhat.com>
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
Cc: Alistair Francis <alistair23@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, Rob Herring <robh@kernel.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, Alistair Francis <alistair@alistair23.me>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Jan Kiszka <jan.kiszka@web.de>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Richard Henderson <rth@twiddle.net>

On Tue, Sep 12, 2017 at 12:22:14PM +0200, Igor Mammedov wrote:
> On Sat, 9 Sep 2017 17:30:14 -0300
> Eduardo Habkost <ehabkost@redhat.com> wrote:
> 
> > On Tue, Sep 05, 2017 at 03:46:07PM -0700, Alistair Francis wrote:
> > > On Tue, Sep 5, 2017 at 3:12 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:  
> > > > On Tue, Sep 05, 2017 at 02:47:52PM -0700, Alistair Francis wrote:  
> > > >> On Tue, Sep 5, 2017 at 2:31 PM, Eduardo Habkost <ehabkost@redhat.com> wrote:  
> > > > [...]  
> > > >> >> diff --git a/hw/arm/stm32f205_soc.c b/hw/arm/stm32f205_soc.c
> > > >> >> index f61e735..1cd6374 100644
> > > >> >> --- a/hw/arm/stm32f205_soc.c
> > > >> >> +++ b/hw/arm/stm32f205_soc.c
> > > >> >> @@ -112,7 +112,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
> > > >> >>
> > > >> >>      armv7m = DEVICE(&s->armv7m);
> > > >> >>      qdev_prop_set_uint32(armv7m, "num-irq", 96);
> > > >> >> -    qdev_prop_set_string(armv7m, "cpu-model", s->cpu_model);
> > > >> >> +    qdev_prop_set_string(armv7m, "cpu-type", s->cpu_type);
> > > >> >>      object_property_set_link(OBJECT(&s->armv7m), OBJECT(get_system_memory()),
> > > >> >>                                       "memory", &error_abort);
> > > >> >>      object_property_set_bool(OBJECT(&s->armv7m), true, "realized", &err);
> > > >> >> @@ -200,7 +200,7 @@ static void stm32f205_soc_realize(DeviceState *dev_soc, Error **errp)
> > > >> >>  }
> > > >> >>
> > > >> >>  static Property stm32f205_soc_properties[] = {
> > > >> >> -    DEFINE_PROP_STRING("cpu-model", STM32F205State, cpu_model),
> > > >> >> +    DEFINE_PROP_STRING("cpu-type", STM32F205State, cpu_type),  
> > > >> >
> > > >> > Same as armv7m: are we 100% sure users are not setting this
> > > >> > manually?  
> > > >>
> > > >> In an embedded board like this it really doesn't make sense to let the
> > > >> user overwrite the CPU. The SoC will take it as an option, but the
> > > >> board (which creates the SoC) just blindly always uses the same CPU.
> > > >> That feature is more for QOMificatoion then any real reason though.
> > > >>  
> > > >
> > > > I'm not talking about -cpu (no user-visible change in the
> > > > handling of -cpu should result from this patch), but about
> > > > possible cases where the user set the "cpu-model" property using
> > > > another mechanism, like -global.  Probably it's impossible for an
> > > > user to override the property successfully, but I would like to
> > > > be sure.  
> > > 
> > > Ah, that is trickier.
> > > 
> > > I guess that is possible to do, but the object setting logic should
> > > handle the error gracefully and inform the user of the error.  
> > 
> > After looking at the code more closely, I think we can be 100%
> > sure the user doesn't rely on the property, because:
> > 
> > * TYPE_ARMV7M and TYPE_STM32F205_SOC are both sysbus devices
> >   with user_creatable=false, so the user can't instantiate them
> >   directly;
> > * The only places where those objects are realized inside the
> >   code are:
> >   * mps2_common_init()
> >   * netduino2_init()
> >   * stm32f205_soc_realize()
> >   * armv7m_init()
> >   Those functions always set the "cpu-model" property immediately
> >   before realize.
> > 
> > This means any value set by the user (e.g. using -global) would
> > be always overwritten before realize.
> > 
> > However, I have a suggestion for Igor: making a separate patch
> > that renames the existing property to "x-cpu-model", and using
> > "x-cpu-type" in this series.  This way we will explicitly
> > document the fact that the property is not a stable
> > user/management interface.
> There is no much point in renaming to "x-cpu-model" as it will be deleted
> right afterwards, I'd just delete "cpu-model" and use "x-cpu-type"
> in this patch. I'm not a fun of 'x-' prefix and would prefer a flag
> in property to mark it as internal. But it's out of scope of this series,
> so I don't care much about naming at the moment and will use "x-cpu-type"
> as you suggest.

Peter pointed out that this is the case with lots of properties
on non-user-creatable devices.  So we can keep "cpu-type" for
consistency by now.

-- 
Eduardo
