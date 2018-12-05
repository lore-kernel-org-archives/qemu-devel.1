Received: from eggs.gnu.org ([2001:4830:134:3::10]:40332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <leif.lindholm@linaro.org>) id 1gUUXq-0007ah-O7
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 05:36:43 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <leif.lindholm@linaro.org>) id 1gUUXo-0006mQ-Sa
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 05:36:42 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:34518)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <leif.lindholm@linaro.org>)
	id 1gUUXn-0006jD-Jn
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 05:36:40 -0500
Received: by mail-wm1-x343.google.com with SMTP id y185so11452044wmd.1
	for <qemu-devel@nongnu.org>; Wed, 05 Dec 2018 02:36:38 -0800 (PST)
Date: Wed, 5 Dec 2018 10:36:34 +0000
From: Leif Lindholm <leif.lindholm@linaro.org>
Message-ID: <20181205103634.cvogkgjdzq7e3feh@bivouac.eciton.net>
References: <1539939312-19713-1-git-send-email-hongbo.zhang@linaro.org>
	<1539939312-19713-2-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA-vF5orNpfGFe2sGWh=TxWL054PmCM-Yu4faJne+4CkbA@mail.gmail.com>
	<CAHmQWvCN00LkSvmAY8nCtoGYrRDsALYRkg0x_yz6HaRgQkQn3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHmQWvCN00LkSvmAY8nCtoGYrRDsALYRkg0x_yz6HaRgQkQn3w@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v4] hw/arm: Add arm SBSA reference machine
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>

On Wed, Dec 05, 2018 at 05:50:23PM +0800, Hongbo Zhang wrote:
> > > +static
> > > +void sbsa_ref_machine_done(Notifier *notifier, void *data)
> > > +{
> > > +    VirtMachineState *vms = container_of(notifier, VirtMachineState,
> > > +                                         machine_done);
> > > +    ARMCPU *cpu = ARM_CPU(first_cpu);
> > > +    struct arm_boot_info *info = &vms->bootinfo;
> > > +    AddressSpace *as = arm_boot_address_space(cpu, info);
> > > +
> > > +    if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as) < 0) {
> > > +        exit(1);
> > > +    }
> > > +}
> >
> > The virt board needs a machine-done notifier because it has
> > to add extra things to the DTB here. You don't, so you don't
> > need one. Don't set bootinfo.skip_dtb_autoload to true, and
> > then the boot.c code will do the arm_load_dtb() call for you.
> >
> After test and check, I think we still need this machine_done callback
> to call arm_load_dtb().
> If only kernel loaded via -kernel but without any firmware, it should
> work to let arm_load_kernel() call the arm_load_dtb(), while in our
> case, we have have firmware loaded but no kernel, so the
> arm_load_kernel() returns before calling arm_load_dtb(),  that is,
> firmware runs and there is no chance to call arm_load_dtb(), then we
> get error message and qemu quits.
> Moving arm_load_dtb() to earlier place in arm_load_kernel() cannot fix
> this issue either.

I don't see the value in using -kernel on the SBSA machine.
If it causes complexity, can we drop the functionality?

Regards,

Leif
