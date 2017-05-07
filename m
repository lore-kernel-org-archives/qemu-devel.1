Received: from eggs.gnu.org ([2001:4830:134:3::10]:49989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1d7Jr9-0007vE-RL
	for qemu-devel@nongnu.org; Sun, 07 May 2017 06:56:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1d7Jr8-0003u8-TN
	for qemu-devel@nongnu.org; Sun, 07 May 2017 06:56:03 -0400
Date: Sun, 7 May 2017 12:55:53 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <20170507105553.4xoq7obdc2bjx26x@kozik-lap>
References: <20170313180432.7067-1-krzk@kernel.org>
	<20170313180432.7067-2-krzk@kernel.org>
	<cf23c2b4-c4c1-bb46-626e-a54851b25cbb@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <cf23c2b4-c4c1-bb46-626e-a54851b25cbb@amsat.org>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v2 1/5] hw/intc/exynos4210_gic:
 Fix GIC memory mappings for secondary CPU
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Igor Mitsyanko <i.mitsyanko@gmail.com>

On Mon, Mar 13, 2017 at 04:32:40PM -0300, Philippe Mathieu-Daud=C3=A9 wrote:
> On 03/13/2017 03:04 PM, Krzysztof Kozlowski wrote:
> > Recent Linux kernel (tested next-20170224) was complaining about missing
> > GIC mask and was unable to bring up secondary CPU:
> >=20
> >     [    0.000000] NR_IRQS:16 nr_irqs:16 16
> >     [    0.000000] GIC CPU mask not found - kernel will fail to boot.
> >     ...
> >     [    0.400492] smp: Bringing up secondary CPUs ...
> >     [    1.413184] CPU1: failed to boot: -110
> >     [    1.423981] smp: Brought up 1 node, 1 CPU
> >=20
> > In its instance_init() call, the Exynos GIC driver was setting GIC
> > memory mappings for each CPU, from 1 up to "num-cpu" property.  The
> > Exynos4210 machine init call on the other hand, first created Exynos GIC
> > device and then set the "num-cpu" property which was too late.  The init
> > already happened with default "num-cpu" value of 1 thus GIC mappings
> > were created only for the first CPU.
> >=20
> > Split the Exynos GIC init code into realize function so the code will
> > see updated "num-cpu" property.  This fixes the warning and brings
> > second CPU:
> >     [    0.435780] CPU1: thread -1, cpu 1, socket 9, mpidr 80000901
> >     [    0.451838] smp: Brought up 1 node, 2 CPUs
> >=20
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
>=20
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

Beside bringing secondary CPU, this patch fixes also Software Generated
Interrupts. Without it, none of the SGIs are coming (except CPU wakeup):
  IPI0: =C2=A0 =C2=A0 =C2=A0 6281 =C2=A0CPU wakeup interrupts
  IPI1: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0Timer broadcast interrupts
  IPI2: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0Rescheduling interrupts
  IPI3: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0Function call interrupts
  IPI4: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0CPU stop interrupts
  IPI5: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0IRQ work interrupts
  IPI6: =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00 =C2=A0completion interrupts

This is pretty annoying because lack of SGIs means lack of IPIs thus for
example IRQ work cannot be executed. Without IRQ work, the kernel hangs
on power down on cpufreq shutdown because in cpufreq_dbs_governor_stop()
there is irq_work_sync() but none of irq_work interrupts were handled.

I still did not solve the issue with cpuidle (AFTR). I am trying to
implement CPU power off (needed for AFTR) but it is one-way so far (no
wakeup). Anyway the workaround is to just disable cpuidle.

Overall, what is the status of this patch? Should I resend? I can also
extend the commit description with paragraph about SGI/IPI.

Best regards,
Krzysztof
