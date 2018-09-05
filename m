Received: from eggs.gnu.org ([2001:4830:134:3::10]:37944)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fxWWZ-0000qV-9p
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:03:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1fxWWT-0007XT-5q
	for qemu-devel@nongnu.org; Wed, 05 Sep 2018 08:03:07 -0400
Date: Wed, 5 Sep 2018 14:02:48 +0200
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20180905120248.unyh6q4msvyx4f43@kamzik.brq.redhat.com>
References: <1532496652-26364-2-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA9hivJzqksiSZbco4+EysYj=_y0t3k_L7TobxNPS8T2dQ@mail.gmail.com>
	<CAHmQWvC4Kp1CAeCe8ZTGtSeG7fnT=Xen4GFKfnhTBWUCJdQV+g@mail.gmail.com>
	<20180829134219.cmyqipnvukk6k2rp@kamzik.brq.redhat.com>
	<CAHmQWvA5t7zbbDDM0UvuKSL_Z8ey+x+vOGZumYjwsq0FC5AHGA@mail.gmail.com>
	<20180830083117.iekobw7l3arkt24m@bivouac.eciton.net>
	<CAFEAcA_s+9-4PYHyx_aAnxwt4e=VH77uBG7rC4JA++nOyjAaPw@mail.gmail.com>
	<20180830100233.nr6fm3npy57zl4xx@bivouac.eciton.net>
	<CAKv+Gu9r+1OBOSUBW_KpDEEoKyc=iwW4zVEe04-_JUnJtSGupQ@mail.gmail.com>
	<CAHmQWvBDjMeBpe9Puv+oRii3JrVULW_+AYJL9WV1tXT7F7ALfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmQWvBDjMeBpe9Puv+oRii3JrVULW_+AYJL9WV1tXT7F7ALfg@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] hw/arm: Add Arm Enterprise machine
 type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Leif Lindholm <leif.lindholm@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>

On Wed, Sep 05, 2018 at 06:08:57PM +0800, Hongbo Zhang wrote:
> On 30 August 2018 at 21:29, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > On 30 August 2018 at 12:02, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> >> On Thu, Aug 30, 2018 at 09:39:33AM +0100, Peter Maydell wrote:
> >>> On 30 August 2018 at 09:31, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> >>> > On Thu, Aug 30, 2018 at 03:07:29PM +0800, Hongbo Zhang wrote:
> >>> >> @Ard, @Leif, is there any possibility to remove all the DT nodes?
> >>> >> On real hardware, how does UEFI find the memory size and CPU number?
> >>> >
> >>> > Usually by asking some form of SCP/PMU.
> >>> > So until we have rock-solid multi-cpu-instance (making terms up here,
> >>> > there may be a proper name already?) support upstream, we need to take
> >>> > shortcuts.
> >>>
> >>> I would expect that you'd want a "faked-on-the-QEMU end" SCP
> >>> communications endpoint to start with anyway. We have one of
> >>> those for vexpress, for instance.
> >>
> >> Ah, I wasn't aware we did!
> >>
> >> In that case - sure, that is probably the more sensible solution.
> >> Does it emulate SCMI?
> >>
> >
> > The purpose of the SBSA/SBBR qemu machine is prototyping the
> > interactions between rich firmware and the OS for things like RAS,
> > secure variable storage for UEFI or capsule update.
> >
> > How exactly the firmware figures out how many CPUs and how much memory
> > we are running with is out of scope for this, and so I don't think
> > there is a need to build something from scratch here: DT will do just
> > fine, given that both EDK2 and ARM-TF have working DT code for these
> > things.
> 
> Ard, we need to clarify which DT nodes should be kept in SBSA-ref QEMU.
> I've researched and tested, there are 3 kinds of DT nodes in the
> current 'virt' machine:
> 
> a) CPU DT node, because it is dynamic according to input parameters,
> and we don't want to get it by other way, so we agreed to keep it.

I have a patch series on the list[*] (which I need to refresh) that
would also add a generated cpu-map node. I think the SBSA-ref machine
may be interested in testing more complex cpu topologies, but that won't
be easy to do with ACPI boot guests unless the topology is hard coded.
How will sbsa-ref know when it should use a hard coded cpu topology vs.
a dynamic number of cpus in a flat topology?

[*] http://lists.nongnu.org/archive/html/qemu-devel/2018-07/msg01170.html

> b) GIC, UART, Timer (and RTC?) nodes, these nodes are now used by
> UEFI, if removed, UEFI needs a rework to not rely on them any longer.

Will sbsa-ref support GICv2? If so, then timer and pmu DT nodes will
need to have their irqflags fields modified depending on the number of
configured CPUs.

> c) All the other devices nodes, such as GPIO, PCIE etc, currently the
> UEFI doesn't need them, so UEFI can boot with them removed.
> 
> How about b) and c)?
> my idea is to keep a) only, remove b) and thus a UEFI modification
> accordingly is to be done, c) can be removed freely.

So UEFI would learn to augment static DTBs with QEMU generated
DT nodes and/or other auxiliary info from QEMU passed to it
through the "guest DT" (which is now looking more like a guest
firmware configuration description)? Is it worth it? Why not
just require the entire DTB to be provided by the user on the
QEMU command line and completely ignore QEMU parameters like
'-smp'?

Thanks,
drew
