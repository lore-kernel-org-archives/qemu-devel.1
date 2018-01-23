Received: from eggs.gnu.org ([2001:4830:134:3::10]:54901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bztemail@gmail.com>) id 1edx4g-0001J0-NE
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:49:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bztemail@gmail.com>) id 1edx4e-000064-IE
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:49:10 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA--i8RVKaBw5yXn4xRXBy5S+Yk=WDNKbuqzfDxn6jjtOA@mail.gmail.com>
References: <CADYoBw2dogvU6-3vChG4js0BNdyTPG8eDvMSRoU50eTX_9DdEQ@mail.gmail.com>
	<MWHPR21MB01590CD596A992C93E01B5079E460@MWHPR21MB0159.namprd21.prod.outlook.com>
	<CADYoBw1ksGDo26-PC4eMnyqxZQoZkXNLDeGoWfcRHs-SfTCJkw@mail.gmail.com>
	<MWHPR21MB01591543E188B048145985709E470@MWHPR21MB0159.namprd21.prod.outlook.com>
	<CADYoBw0RjiW2as9jGtPg92E8XK3KR+gM9C5vjC7HHsBauFn4ug@mail.gmail.com>
	<CADYoBw19GifmUR=Rztkzzc-v3-zWR6frjiNb_wjzsevreAqPDQ@mail.gmail.com>
	<CAFEAcA9_+wZJa7Ht6EHCCZYm+hrfdbjd9gUmVJPGgZ0yvbZOPA@mail.gmail.com>
	<MWHPR21MB0480DE1F826056BC8377EE289E250@MWHPR21MB0480.namprd21.prod.outlook.com>
	<CADYoBw31C0Z2vp0S0ZFBOC6A3146wxtZWvzJabACkGh44ZwC0w@mail.gmail.com>
	<MWHPR21MB0480A1F01D2CEF51E7CE21B09E3A0@MWHPR21MB0480.namprd21.prod.outlook.com>
	<CADYoBw1Ro5gxROvhCVXGv0=-Y8zXmGbKR3D6xOqhkb0zp__LkA@mail.gmail.com>
	<CADYoBw27wU3CsYPeP7ONFWt4aj+6tvzwU5roDSOKz8qq1n8GSg@mail.gmail.com>
	<CAFEAcA--i8RVKaBw5yXn4xRXBy5S+Yk=WDNKbuqzfDxn6jjtOA@mail.gmail.com>
From: bzt bzt <bztemail@gmail.com>
Date: Tue, 23 Jan 2018 12:49:06 +0100
Message-ID: <CADYoBw36gPOyiK36WaS0v_2R=iuWYL-sQAtffrZZJU2DpMv5Bw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] BCM2837 and machine raspi3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Andrew Baumann <Andrew.Baumann@microsoft.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>

Hi,

On Mon, Jan 22, 2018 at 1:12 PM, Peter Maydell <peter.maydell@linaro.org>
wrote:

> On 18 January 2018 at 21:39, bzt bzt <bztemail@gmail.com> wrote:
> > Dear All,
> >
> > Since you still haven't merged Alistair's patch, I decided to include it
> in
> > my own.
> > I've shrinked the number of modified files to two, that's the bare
> minimum
> > to support "-M raspi3" switch. Bcm2836.c modified minimally, the rest is
> in
> > raspi.c. I've renamed raspi2_init() to raspi_init() 'cos now it
> initializes
> > raspi3 as well, no additional function.
> >
>
> Can you send this as a proper patch email, not as a reply to
> an existing email thread, please? (This makes our automated tooling
> much happier.)
>

Only if you're not demanding any further nonsense modifications.


>
> In particular we can't apply patches if they don't come with
> the right Signed-off-by: lines from everybody who contributed
> code to them.
>
> I've made some code review comments below.
>
> > diff --git a/hw/arm/bcm2836.c b/hw/arm/bcm2836.c
> > index 8c43291112..5119e00051 100644
> > --- a/hw/arm/bcm2836.c
> > +++ b/hw/arm/bcm2836.c
> > @@ -15,6 +15,7 @@
> >  #include "hw/arm/bcm2836.h"
> >  #include "hw/arm/raspi_platform.h"
> >  #include "hw/sysbus.h"
> > +#include "hw/boards.h"
> >  #include "exec/address-spaces.h"
> >
> >  /* Peripheral base address seen by the CPU */
> > @@ -30,7 +31,7 @@ static void bcm2836_init(Object *obj)
> >
> >      for (n = 0; n < BCM2836_NCPUS; n++) {
> >          object_initialize(&s->cpus[n], sizeof(s->cpus[n]),
> > -                          "cortex-a15-" TYPE_ARM_CPU);
> > +                          current_machine->cpu_type);
>
> This SoC code shouldn't be looking at the current_machine settings.
> It should have a QOM property that specifies the cpu type, and

the raspi.c code should set that property. (Call the property
>
'cpu-type' -- if you grep in hw/arm for that string you'll find
> some examples of existing devices/boards that do this.)
>

I'll give you some time to think about why it is nonsense that you asking
for.
Hint: you cannot add properties to an uninitialized object, you can't add
the CPUs in the realize phase (will cause segfaults, I've tried) and SoC
initialization will do call bcm2836_init().

  [...]

> There should be more spaces in this : "version == 3 ? ...".
> If you run your patch through scripts/checkpatch.pl it should
> help with this kind of style nit (though it doesn't always find
> everything and sometimes it gets confused, so it's not always right).
>

Sure thing.


> [...]
> This will get confused if the user passes a -cpu argument. Instead
> we should just have the machine type directly determine the version.
> There are several ways to do this, but the simplest way is to have
> raspi2_machine_init() set mc->init to raspi2_init() and
> raspi3_machine_init()
> set mc->niit to raspi3_init(), and thenthose function calls
> raspi_init(machine, 2) or raspi_init(machine, 3).
>

Auch. Originally there were two raspi_init() functions (with two different
version values), I've reduced the number to one because you asked for it.
I've also tried to access the MachineClass object from raspi_init(), but
it's impossible, MACHINE_CLASS() drops and assert, find_machine_class()
segfaults. Nice model interface you have there.


>
> (The other approach would be to make the board set up a subclass
> of MachineState and then have raspi2 and raspi3 be subclasses of
> that, which gives you a place to define raspi-specific data fields
> like "version". You can see that approach in hw/arm/vexpress.c. But
> that seems like a lot of effort to go to given where we've started,
> so I don't really recommend it.)
>

Again, that is EXACTLY what I originally had, and you (the maintainers)
said there shouldn't be a new BCM2837 class, so I've removed it.
Look, if you can't understand how my patch works, just say so, no shame in
that.


> [...]
>
> I don't want to add new machine types which set the
> ignore_memory_transaction_failures flag to true -- this is
> only for existing board models where we don't know what
> guest code that used to run would break when the flag was
> flipped. For new boards we know that no code runs on them
> so can leave the flag at its correct default.
>

Just copy'n'pasted raspi2, only modified the CPU model in which they differ.


>
> This may mean that you need to add some extra dummy
> devices to the the SoC model using
> create_unimplemented_device() so that your guest image
> doesn't crash trying to probe those devices.
>

This may mean your users will be very upset because mainline qemu won't
emulate raspi3 in the foreseeable future, because it's sure like hell I
won't fix something that's not broken.


>
> I appreciate that this is a bit annoying for a case like this
> where it's adding a new variant of an existing SoC, but
> this is one of the situations where the only practical
> opportunity to get the implementation right without breaking
> existing QEMU users is at the point where we add the new
> board model.
>

It is not annoying at all, it's simply silly. Are you really thought I
would do *your* job?
"Only two things are infinite, the universe and the human stupidity, and
I'm not sure about the former!". Actually I'm very entertained :-D :-D :-D

But seriously, I've showed you a way how to add raspi3, the rest is up to
you. I won't do anything more about it, I'm not a paid qemu maintainer
whatsoever!
Again, my patch is working for me, it does not broke any existing raspi2
machines, and I'm very happy about using it for more than half a year now!
These are the facts, everything else is just talking.

Cheers
bzt


> thanks
> -- PMM
>
