Received: from eggs.gnu.org ([209.51.188.92]:54919)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goVID-0008RZ-7J
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:27:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1goVHu-0006yz-2Q
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:27:04 -0500
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:35912)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1goVHs-0006uP-If
	for qemu-devel@nongnu.org; Tue, 29 Jan 2019 10:26:57 -0500
Received: by mail-ot1-x341.google.com with SMTP id k98so18200648otk.3
	for <qemu-devel@nongnu.org>; Tue, 29 Jan 2019 07:26:48 -0800 (PST)
MIME-Version: 1.0
References: <1544173675-14217-1-git-send-email-hongbo.zhang@linaro.org>
	<1544173675-14217-3-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA9mF+WiPLW4yyv1aEMLTg2QK2krZvxyjCSsMziJtzx3Ug@mail.gmail.com>
	<CAHmQWvCw5ndod93WqLXDgGxDERtRM3ee_qiLA+S34Y9X2JFvVQ@mail.gmail.com>
In-Reply-To: <CAHmQWvCw5ndod93WqLXDgGxDERtRM3ee_qiLA+S34Y9X2JFvVQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 29 Jan 2019 15:26:29 +0000
Message-ID: <CAFEAcA_+UhU56D7Yx5K8+=DbtUiiV8V7sX2UgxFKSkScUypxFg@mail.gmail.com>
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
To: Hongbo Zhang <hongbo.zhang@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Ard Biesheuvel <ard.biesheuvel@linaro.org>, Leif Lindholm <leif.lindholm@linaro.org>, Radoslaw Biernacki <radoslaw.biernacki@linaro.org>

On Mon, 28 Jan 2019 at 09:46, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>
> On Tue, 22 Jan 2019 at 19:49, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Fri, 7 Dec 2018 at 09:08, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
> > > +static void sbsa_ref_machine_done(Notifier *notifier, void *data)
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
> > I still don't understand why we need this -- it doesn't seem
> > to be doing anything different from the default behaviour that
> > boot.c implements if skip_dtb_autoload is false.
> >
>
> According to the process of arm_load_kernel() in boot.c, If only
> kernel loaded via -kernel but without any firmware, it works fine.
> While in this case, we have have firmware loaded but no kernel (eg
> firmware loads kernel from storage, firmware never come back to qemu
> again), so the arm_load_kernel() returns in the middle before calling
> arm_load_dtb(),  because arm_load_dtb() is the final step in
> arm_load_kernel(), so there is no chance for the arm_load_dtb() to be
> called, then we get error message and qemu quits.

Oh, I see now. I think this is a bug in boot.c and we should
fix it by making the "this is a firmware boot" code path also
do the arm_load_dtb() call. I'll send a patch.

thanks
-- PMM
