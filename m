Received: from eggs.gnu.org ([2001:4830:134:3::10]:45866)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dMqDe-0005B1-Rf
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 02:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dMqDb-0003SW-OK
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 02:31:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53520)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dMqDb-0003S1-Ea
	for qemu-devel@nongnu.org; Mon, 19 Jun 2017 02:31:23 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CDE71C04B936
	for <qemu-devel@nongnu.org>; Mon, 19 Jun 2017 06:31:20 +0000 (UTC)
Date: Mon, 19 Jun 2017 14:31:10 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170619063110.GA16787@pxdev.xzpeter.org>
References: <1496980142-8986-1-git-send-email-peterx@redhat.com>
	<1496980142-8986-4-git-send-email-peterx@redhat.com>
	<20170609134010.GK22043@thinpad.lan.raisama.net>
	<20170612081356.GD12928@pxdev.xzpeter.org>
	<20170613034102.GA11751@pxdev.xzpeter.org>
	<20170613111635.GU5016@thinpad.lan.raisama.net>
	<20170616075820.GE30118@pxdev.xzpeter.org>
	<20170616143432.GO5016@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170616143432.GO5016@thinpad.lan.raisama.net>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] migration: move
 global_state.optional out
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Markus Armbruster <armbru@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>

On Fri, Jun 16, 2017 at 11:34:32AM -0300, Eduardo Habkost wrote:
> On Fri, Jun 16, 2017 at 03:58:20PM +0800, Peter Xu wrote:
> > On Tue, Jun 13, 2017 at 08:16:35AM -0300, Eduardo Habkost wrote:

[...]

> > Hi, Eduardo,
> > 
> > I'm working on providing a AccelState.global_props, then let KVM/TCG
> > to use it to handle X86_CPU properties there.  However, I stuck at a
> > point where TCG/KVM cannot know what is the macro "TYPE_X86_CPU"
> > (since it's only there on X86).  The change is something like this (it
> > cannot be applied directly to master since it's only one patch among
> > my series, it is used to show what I am doing and the problem):
> 
> Unfortunately TYPE_X86_CPU macro is arch-specific because it may
> be expanded to "x86_64-cpu" or "i386-cpu" depending on the QEMU
> target.  So it actually represents two different classes, because
> the target/i386/cpu.c code is compiled twice (once for i386 and
> once for x86_64).
> 
> In this case, you will need two entries on the tcg default
> property list:
> 
>   x86_64-cpu.vme=off
>   i386-cpu.vme=off
> 
> Now, we could hardcode the class names, or provide TYPE_I386_CPU
> and TYPE_X86_64_CPU macros from a header available to generic
> code[1].  I don't know what's the best solution.
> 
> [1] i.e. not cpu.h. I was going to suggest including
>     "target/i386/cpu-qom.h", but I'm not sure if
>     it can be safely included by generic code.

Thanks. I'll choose to hard code it for now (with some comments).

> 
> > 
> > --8<--
> > diff --git a/accel.c b/accel.c
> > index 82b318c..db503b6 100644
> > --- a/accel.c
> > +++ b/accel.c
> > @@ -34,13 +34,34 @@
> >  #include "sysemu/qtest.h"
> >  #include "hw/xen/xen.h"
> >  #include "qom/object.h"
> > +#if TARGET_I386
> > +#include "target/i386/cpu-qom.h"
> > +#endif
> > 
> >  int tcg_tb_size;
> >  static bool tcg_allowed = true;
> > 
> > +static AccelPropValue x86_tcg_default_props[] = {
> > +    { "vme", "off" },
> > +    { NULL, NULL },
> 
> You need a "driver" (type) field too.  I suggest using struct
> GlobalProperty like we do on MachineClass.

Yeah, I did it ...

> 
> > +};
> > +
> > +static void tcg_register_accel_props(AccelState *accel)
> > +{
> > +#if TARGET_I386
> > +    AccelPropValue *entry;
> > +
> > +    for (entry = x86_tcg_default_props; entry->prop; entry++) {
> > +        global_property_list_register(accel->global_props, TYPE_X86_CPU,
> > +                                      entry->prop, entry->value, false);

... here, since the driver field is the same (we'll just apply this
property list to both "i386-cpu" and "x86_64-cpu").

> > +    }
> > +#endif
> > +}
> > +

[...]

> > What above patch did is something like "moving x86_cpu properties from
> > x86 CPU codes into tcg" (I am using tcg as example, kvm is more
> > complex but has similar issue).
> > 
> > Here the general problem is that, there are some properties to be
> > applied when both conditions match:
> > 
> > - target is X86 (so using X86 cpus)
> > - accel is tcg
> > 
> > In the old code, it works since in x86 cpu.c codes we can use this:
> > 
> >   if (tcg_enabled()) {
> >       x86_cpu_apply_props(cpu, tcg_default_props);
> >   }
> > 
> > to know "whether accel is TCG". However I cannot do similar thing in
> > TCG code to know "whether target is x86". (I was trying to use
> > TARGET_I386 but it was poisoned, of course...)
> > 
> > Any thoughts? (Markus/Paolo/others?)
> 
> You don't need to make the property conditional on the target, if
> you just use the right class name on the "driver' field.

Yeah, as long as I can use the hard coded "i386-cpu"/"x86_64-cpu" in
accelerator codes, then I'll be fine.  Thanks again!

-- 
Peter Xu
