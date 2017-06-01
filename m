Received: from eggs.gnu.org ([2001:4830:134:3::10]:34995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1dGTcE-0000rF-Vj
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1dGTcE-00063J-15
	for qemu-devel@nongnu.org; Thu, 01 Jun 2017 13:10:30 -0400
Date: Thu, 1 Jun 2017 19:10:19 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <20170601171019.j7ist5qnuvllvfhi@kozik-lap>
References: <20170521152949.15338-1-krzk@kernel.org>
	<CAFEAcA8qYBAgHWPGdSTry7Rmt1Ai9gmKXdKs+f_x_jQU0+7c5Q@mail.gmail.com>
	<CAJKOXPebX4GFh06NmAfkt3Vt5D-xwbeJ3UPA-Z+vMc8BtQZcZw@mail.gmail.com>
	<CAFEAcA8Q8-U9aocQgbUTt2WP4S9Tj_K_iXZuP08x9Ck0LszS3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8Q8-U9aocQgbUTt2WP4S9Tj_K_iXZuP08x9Ck0LszS3Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3 00/11] hw: arm: exynos: Bring up
 secondary CPU, QOM-ify Soc, other improvements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Thu, Jun 01, 2017 at 05:31:41PM +0100, Peter Maydell wrote:
> On 31 May 2017 at 09:58, Krzysztof Kozlowski <krzk@kernel.org> wrote:
> > On Tue, May 30, 2017 at 2:04 PM, Peter Maydell <peter.maydell@linaro.org> wrote:
> >> So is this a regression compared to our current model? I was
> >> under the impression from the previous thread that it was,
> >> which is why I didn't apply that patchset.
> >
> > It depends how wide understanding of regression you have. :)
> > 1. Before this patch, second CPU could not boot. System was usable but
> > worked on only one CPU.
> > 2. Before this patch, kernel's IRQ work is broken. None of IRQ work
> > are executed which is mostly visible during poweroff - system hangs on
> > syncing IRQ works.
> > 3. With this patch, second CPU boots and IRQ works properly (so
> > poweroff is possible).
> > 4. However with this patch, Linux kernel with cpuidle enabled (which
> > is also included in many kernel defconfigs), the system is very
> > unresponsive.
> >
> > So overall... a lot of things were broken already. This patches fixes
> > them... but breaks different thing.
> 
> It sounds like it breaks a key thing, ie "boot a single cpu kernel
> built from a defconfig", though. That's a regression I'd rather
> not have.

I am not sure if I understand you correctly... the system previously
booted into one CPU mode because second CPU just could not boot. Now by
default, second CPU succeeds and this means that *default* settings are
indeed more broken than before.

On the other hand, after removing a line from hw/arm/exynos4210.c:
	qdev_prop_set_uint32(dev, "num-cpu", EXYNOS4210_NCPUS);
and running qemu with "-accel tcg -smp cpus=1,maxcpus=1,cores=1"
everything is okay. Booting of one CPU is unaffected.

> If there's a subset of these patches which don't break
> that I'm happy to take those. Otherwise we need to investigate
> and fix whatever the problem is that causes that unresponsiveness
> before we can apply them.

Yes, you can take everything except first patch
("hw/intc/exynos4210_gic: Fix GIC memory mappings for secondary CPU")
and it should be fine. Rest of patches are just independent.

Best regards,
Krzysztof
