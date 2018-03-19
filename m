Received: from eggs.gnu.org ([2001:4830:134:3::10]:48026)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1exvy6-0002yU-Ow
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 10:41:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1exvy2-000820-NW
	for qemu-devel@nongnu.org; Mon, 19 Mar 2018 10:40:58 -0400
Date: Mon, 19 Mar 2018 15:40:20 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180319154020.6d668399@igors-macbook-pro.local>
In-Reply-To: <CAFEAcA_9YQ4bSzHgM8yLAPtPZ2C70u13kTCLf4rHGPCBUgNiZA@mail.gmail.com>
References: <20180313153458.26822-1-peter.maydell@linaro.org>
	<20180313153458.26822-9-peter.maydell@linaro.org>
	<MWHPR21MB018983B74A652443B70680F19ED20@MWHPR21MB0189.namprd21.prod.outlook.com>
	<CAFEAcA_9YQ4bSzHgM8yLAPtPZ2C70u13kTCLf4rHGPCBUgNiZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 8/9] hw/arm/bcm2836: Hardcode correct CPU
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>, Andrew Baumann <Andrew.Baumann@microsoft.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Philippe =?UTF-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Pekka Enberg <penberg@iki.fi>, "patches@linaro.org" <patches@linaro.org>

On Thu, 15 Mar 2018 17:13:03 +0000
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 13 March 2018 at 16:55, Andrew Baumann <Andrew.Baumann@microsoft.com> wrote:
> >> From: Qemu-devel <qemu-devel-
> >> bounces+andrew.baumann=microsoft.com@nongnu.org> On Behalf Of Peter
> >> Maydell
> >> Sent: Tuesday, 13 March 2018 08:35
> >>
> >> Now we have separate types for BCM2386 and BCM2387, we might as well
> >> just hard-code the CPU type they use rather than having it passed
> >> through as an object property. This then lets us put the initialization
> >> of the CPU object in init rather than realize.
> 
> > What about the default_cpu_type field of MachineClass set in
> > raspi[23]_machine_init? That seems irrelevant now...
> 
> Igor, can you help with this question? For a board that always
> has one CPU type (because the real hardware only ever has
> one SoC, and that SoC QOM object hard codes the CPU type)
> does it still need to set the mc->default_cpu_type field in
> its MachineClass, or does that become pointless ?

Since board ignores whatever were specified on '-cpu' and 
there aren't any checks in board code for current_machine->cpu_type,
removing mc->default_cpu_type won't really affect anything.

With current code in vl.c and with default_cpu_type set, user will
get error if he specified non existing cpu_model with -cpu.
If default_cpu_type were NULL, -cpu is completely ignored.

But once http://patchwork.ozlabs.org/patch/870297/ is applied
it will error out the same way as if default_cpu_type were
set since vl.c won't rely on it anymore for parsing cpu_model.

So in short it's ok to remove mc->default_cpu_type here.

> 
> thanks
> -- PMM
