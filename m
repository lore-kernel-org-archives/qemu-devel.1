Received: from eggs.gnu.org ([209.51.188.92]:59155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1h1SVC-0001Le-Fx
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:06:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1h1SVB-0007Fn-93
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:06:14 -0500
Received: from greensocs.com ([193.104.36.180]:44009)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <damien.hedde@greensocs.com>) id 1h1SVA-000708-2p
	for qemu-devel@nongnu.org; Wed, 06 Mar 2019 04:06:13 -0500
From: Damien Hedde <damien.hedde@greensocs.com>
References: <a6548846-c64d-a815-45a5-953ccc4b7ea0@greensocs.com>
	<CAFEAcA8dM_DN9Mrep8O7XVPPis0v2XcSU3fWSHTbz2MJDqjEsg@mail.gmail.com>
	<fe389f85-a52d-e469-96de-f34663a3c5a5@greensocs.com>
	<CAFEAcA_OrJ-1SzE5UpT4eHbzi-KS_GqX13KZdHzEzovXnsnsUg@mail.gmail.com>
	<63b980a2-6b28-d5e2-891c-6245ddb1e851@redhat.com>
	<CAFEAcA8L1qKaNwpr8sMZC8jQXbaLtCctaV8ecTFxXTVy0sWjVw@mail.gmail.com>
	<20190304102912.GC6010@toto>
Message-ID: <4c1c9c2c-73e9-bacf-b4c4-3fa425480e3f@greensocs.com>
Date: Wed, 6 Mar 2019 10:05:50 +0100
MIME-Version: 1.0
In-Reply-To: <20190304102912.GC6010@toto>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US-large
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC] multi phase reset
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Mark Burton <mark.burton@greensocs.com>, QEMU Developers <qemu-devel@nongnu.org>

Hi Edgar,

On 3/4/19 11:29 AM, Edgar E. Iglesias wrote:
> Hi Damien and others,
> 
> A few questions from my side.
> 
> We sometimes see that wires from generic GPIO blocks get connected to reset inputs.
> This happens both to off-chip perihperals but we also see it on-chip.
> 
> To avoid having GPIO modules know that some of their outputs are being used as
> reset signals it would be nice to have a reset proxy that allows any qemu_irq to
> drive resets for a given device. Perhaps even with built-in options for both interpreting
> "active-low" and "active-high". I think it would even be useful to have this
> in qdev but that may be pushing it too far. Any thoughts on that?
Do you mean for Device or other objects as well ? I planned to add a
function so that a Device could declare one of its gpio/irq input as
reset. It is straightforward since we just need to set the proper
handler to the irq. The device controlling the irq (output) would have
no knowledge of that.

> 
> Have you thought about what happens if someone does an MMIO access to a device while
> its reset is active? Were you planning to have some "default" SysBus level handling to
> block MMIO while in reset or anything like that? Or would that be handled individually
> by each device model?Right know it would be handled individually by each model. With
In my first power/clock gating implementation (last year), I tried to do
a kind of default deactivation of mmio memory region in SysbusDevice
object and it appears to me it is complicated for 2 reasons:
+ A device has to handle its memory region flag/properties during
migration (if we automatically disable things, should we automatically
migrate this ?)
+ Some memory regions may already be disabled, so we cannot simply
disabled the mmio array and re-enabled it later.

Right know for the cadence_uart, I check this in the Device itself.

I'm no expert of memory regions, so there is maybe a simple solution I
don't see.
> 
> Another question is regarding reset of CPUs. It would be nice to be able to expose
> similar interfaces and have some defined behaviour for CPUs that are in reset. E.g,
> if reset is active the CPU does not execute etc.
> 
> Cheers,
> Edgar
> 
