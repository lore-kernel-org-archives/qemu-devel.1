Received: from eggs.gnu.org ([2001:4830:134:3::10]:42245)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1eC88A-0006FZ-0B
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:57:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1eC889-0005cw-5B
	for qemu-devel@nongnu.org; Tue, 07 Nov 2017 12:57:46 -0500
Date: Tue, 7 Nov 2017 09:57:38 -0800 (PST)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <CAFEAcA9txp80bxgV5dYCPx7xoxqgutpbLyZ7PDkkL_OfVjSxYA@mail.gmail.com>
Message-ID: <alpine.DEB.2.10.1711070957150.30448@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1711061412330.30448@sstabellini-ThinkPad-X260>
	<CAFEAcA9txp80bxgV5dYCPx7xoxqgutpbLyZ7PDkkL_OfVjSxYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [PATCH v2] aarch64: advertise the GIC system
 register interface
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, QEMU Developers <qemu-devel@nongnu.org>, "xen-devel@lists.xen.org" <xen-devel@lists.xen.org>, qemu-arm <qemu-arm@nongnu.org>, julien.grall@arm.com

On Tue, 7 Nov 2017, Peter Maydell wrote:
> On 6 November 2017 at 22:16, Stefano Stabellini <sstabellini@kernel.org> wrote:
> > When QEMU emulates a GICv3, it needs to advertise the presence of the
> > system register interface, which is done via id_aa64pfr0.
> >
> > To do that, and at the same time to avoid advertising the presence of
> > the system register interface when it is actually not available, set a
> > boolean property in machvirt_init. Check on the boolean property from
> > register_cp_regs_for_features and set id_aa64pfr0 accordingly.
> >
> > Signed-off-by: Stefano Stabellini <sstabellini@kernel.org>
> >
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 9e18b41..369d36b 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -1401,6 +1401,9 @@ static void machvirt_init(MachineState *machine)
> >              object_property_set_link(cpuobj, OBJECT(secure_sysmem),
> >                                       "secure-memory", &error_abort);
> >          }
> > +        if (vms->gic_version == 3) {
> > +            object_property_set_bool(cpuobj, true, "gicv3-sysregs", NULL);
> > +        }
> >
> >          object_property_set_bool(cpuobj, true, "realized", NULL);
> >          object_unref(cpuobj);
> 
> I thought about this on the cycle into work this morning, and I
> think that rather than require every board that uses gicv3
> to set a property on the CPU, we should change the definition
> of the id_aa64pfr0 register so that rather than being ARM_CP_CONST
> it has a readfn, and then at runtime we can get that readfn to
> add in the right bit if env->gicv3state is non-null.
> 
> I'll put together a patch this afternoon.

Great, please CC me when you do, I'll help you test the patch.
