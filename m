Received: from eggs.gnu.org ([209.51.188.92]:38244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1go3V7-0004zo-31
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1go3V0-0002fd-1v
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:41 -0500
Received: from mail-lf1-x142.google.com ([2a00:1450:4864:20::142]:45330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1go3Ur-0002bi-Rz
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 04:46:32 -0500
Received: by mail-lf1-x142.google.com with SMTP id b20so11312145lfa.12
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 01:46:27 -0800 (PST)
MIME-Version: 1.0
References: <1544173675-14217-1-git-send-email-hongbo.zhang@linaro.org>
	<1544173675-14217-3-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA9mF+WiPLW4yyv1aEMLTg2QK2krZvxyjCSsMziJtzx3Ug@mail.gmail.com>
In-Reply-To: <CAFEAcA9mF+WiPLW4yyv1aEMLTg2QK2krZvxyjCSsMziJtzx3Ug@mail.gmail.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Mon, 28 Jan 2019 17:46:14 +0800
Message-ID: <CAHmQWvCw5ndod93WqLXDgGxDERtRM3ee_qiLA+S34Y9X2JFvVQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v5 2/2] hw/arm: add Arm SBSA reference
 machine, devices part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>

On Tue, 22 Jan 2019 at 19:49, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 7 Dec 2018 at 09:08, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> >
> > Following the previous patch, this patch adds peripheral devices to the
> > newly introduced SBSA-ref machine.
> >
> > Signed-off-by: Hongbo Zhang <hongbo.zhang@linaro.org>
> > ---
> >  hw/arm/sbsa-ref.c | 421 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 421 insertions(+)
>
> Most of this code looks good, thanks.
>

Thanks.
By the way, this patch https://patchwork.kernel.org/patch/10744759/
has been merged, now we have a generic EHCI controller, I will add
this in my next iteration.

> > +
> > +static void sbsa_ref_machine_done(Notifier *notifier, void *data)
> > +{
> > +    VirtMachineState *vms = container_of(notifier, VirtMachineState,
> > +                                         machine_done);
> > +    ARMCPU *cpu = ARM_CPU(first_cpu);
> > +    struct arm_boot_info *info = &vms->bootinfo;
> > +    AddressSpace *as = arm_boot_address_space(cpu, info);
> > +
> > +    if (arm_load_dtb(info->dtb_start, info, info->dtb_limit, as) < 0) {
> > +        exit(1);
> > +    }
> > +}
>
> I still don't understand why we need this -- it doesn't seem
> to be doing anything different from the default behaviour that
> boot.c implements if skip_dtb_autoload is false.
>

According to the process of arm_load_kernel() in boot.c, If only
kernel loaded via -kernel but without any firmware, it works fine.
While in this case, we have have firmware loaded but no kernel (eg
firmware loads kernel from storage, firmware never come back to qemu
again), so the arm_load_kernel() returns in the middle before calling
arm_load_dtb(),  because arm_load_dtb() is the final step in
arm_load_kernel(), so there is no chance for the arm_load_dtb() to be
called, then we get error message and qemu quits.

> thanks
> -- PMM
