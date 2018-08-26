Received: from eggs.gnu.org ([2001:4830:134:3::10]:55119)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1ftjdE-0003c1-4V
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 21:14:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <joel.stan@gmail.com>) id 1ftjdC-0000JO-VR
	for qemu-devel@nongnu.org; Sat, 25 Aug 2018 21:14:20 -0400
MIME-Version: 1.0
References: <20180803052137.10602-1-joel@jms.id.au>
	<20180803052137.10602-4-joel@jms.id.au>
	<CAFEAcA9o8JE-ZE3SLBTFrrNCgtJ85L6T7opPZnd0pJaZVkRdVA@mail.gmail.com>
In-Reply-To: <CAFEAcA9o8JE-ZE3SLBTFrrNCgtJ85L6T7opPZnd0pJaZVkRdVA@mail.gmail.com>
From: Joel Stanley <joel@jms.id.au>
Date: Sat, 25 Aug 2018 18:14:06 -0700
Message-ID: <CACPK8XdaT4tHDqFe92hfKjKWaTtnXxA1MW-=noLVkTM+G1EZYA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v4 3/3] arm: Add BBC micro:bit machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Jim Mussared <jim.mussared@gmail.com>, Stefan Hajnoczi <stefanha@gmail.com>, =?UTF-8?Q?Steffen_G=C3=B6rtz?= <contrib@steffen-goertz.de>, Julia Suvorova <jusual@mail.ru>

On Thu, 16 Aug 2018 at 07:12, Peter Maydell <peter.maydell@linaro.org> wrote:

> > +static void microbit_machine_init(MachineClass *mc)
> > +{
> > +    mc->desc = "BBC micro:bit";
> > +    mc->init = microbit_init;
> > +    mc->max_cpus = 1;
> > +}
> > +DEFINE_MACHINE("microbit", microbit_machine_init);
>
> Your subclass of TYPE_MACHINE has extra state, so it can't
> use DEFINE_MACHINE (which creates a subclass whose instance_size
> is the same as the parent TYPE_MACHINE). You need to do this
> longhand:
>
> static void machine_class_init(ObjectClass *oc, void *data)
> {
>     MachineClass *mc = MACHINE_CLASS(oc);
>
>     mc->desc = "BBC micro:bit";
>     mc->init = microbit_init;
>     mc->max_cpus = 1;
> }
>
> static const TypeInfo microbit_info = {
>     .name = TYPE_MICROBIT_MACHINE,
>     .parent = TYPE_MACHINE,
>     .instance_size = sizeof(MICROBITMachineState),
>     .class_init = microbit_class_init,
> };
>
> static void microbit_machine_init(void)
> {
>     type_register_static(&microbit_info);
> }
>
> type_init(microbit_machine_init);
>
>
> (code untested but should be correct; compare against other boards.)

Thanks for spelling it out. I spent a decent chunk of time looking at
other boards, and this aspect of Qemu still baffles me.
