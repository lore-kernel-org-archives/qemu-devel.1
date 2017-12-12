Received: from eggs.gnu.org ([2001:4830:134:3::10]:55014)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eOluR-0000Ow-KK
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:51:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <drjones@redhat.com>) id 1eOluQ-0002y1-NG
	for qemu-devel@nongnu.org; Tue, 12 Dec 2017 09:51:51 -0500
Date: Tue, 12 Dec 2017 15:51:38 +0100
From: Andrew Jones <drjones@redhat.com>
Message-ID: <20171212145138.dqw6op2orgynlykk@kamzik.brq.redhat.com>
References: <09e7b89f-27f2-1787-b371-7b0c0eff78b8@redhat.com>
	<CAFEAcA-357eVt3s_7ULWxssQttvAV0DkUv_tGkyk8umVgfH1QA@mail.gmail.com>
	<d776710c-2255-947b-22c6-336e9491bb81@redhat.com>
	<CAKv+Gu9e6qwJ4=t=UHHGsVs1XM26agh17Mgy0ckAvUsy+2xi2A@mail.gmail.com>
	<CAFEAcA9JzK8sNF5TmENfXZ-NBJwfp03b2La4YQ=N2i1ZCzrNBw@mail.gmail.com>
	<CAKv+Gu_mzynBKSBSdtUhKRgNd3KmuJTwiNZpmvPCfkRDo_QCgA@mail.gmail.com>
	<CAFEAcA9HAcZTi6bT-FbsG9LtqO=4s7rpcz0niZbimG834t4uHA@mail.gmail.com>
	<CAKv+Gu8gZ-Y4-zV2GRgbXPcignAg3vi8__XaFXqAhYOZOL7GcQ@mail.gmail.com>
	<CAFEAcA8OY3PFk_bermKxQBuF_th7SudHgaRk8wf76EAGYnoCGw@mail.gmail.com>
	<CAKv+Gu_939a=cui76H5FqCZwbWqDUYhegNe18T+tBpq7CW+TrA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKv+Gu_939a=cui76H5FqCZwbWqDUYhegNe18T+tBpq7CW+TrA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/arm/virt-acpi-build: Add second
 UART to ACPI tables
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, "Jason A . Donenfeld" <Jason@zx2c4.com>, QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Andrea Bolognani <abologna@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, Laszlo Ersek <lersek@redhat.com>

On Tue, Dec 12, 2017 at 02:31:05PM +0000, Ard Biesheuvel wrote:
> On 12 December 2017 at 14:17, Peter Maydell <peter.maydell@linaro.org> wrote:
> > On 12 December 2017 at 14:16, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >> On 12 December 2017 at 14:13, Peter Maydell <peter.maydell@linaro.org> wrote:
> >>> On 12 December 2017 at 14:12, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >>>> On 12 December 2017 at 14:10, Peter Maydell <peter.maydell@linaro.org> wrote:
> >>>>> That doesn't actually usefully separate debug output from the
> >>>>> console, though, because stdout-path is also going to point
> >>>>> to the UART with the lowest physical address...
> >>>>>
> >>>>
> >>>> By default, yes, just like is currently the case. But I would assume
> >>>> this new serial port could be appointed 'console' and put into
> >>>> stdout-path by QEMU, based on the command line options?
> >>>
> >>> We don't have any command line options for doing that, and I'm
> >>> generally reluctant to introduce new command line UI, especially
> >>> new command line UI that's specific to Arm and not also needed
> >>> for x86.
> >>>
> >>
> >> If stdout-path is always going to point to pl011@0x9000000, why would
> >> we need to parse it?
> >
> > If you had always parsed stdout-path, we wouldn't need to worry
> > about the order in which the UART nodes appear in the dtb...
> >
> 
> That's a fair point. But it still does not justify introducing added
> complexity in the firmware, if the conclusion is always going to be
> that the console will be on pl011@9000000.
> 
> To Drew's point re DEBUG builds, I don't think we should generally
> enable DEBUG and send the output to nowhereland if the user does not
> wire it up. That's a MMIO trap and two world switches for each
> character written, if I am not mistaken, and the DEBUG builds are very
> noisy.

100% agree, which is why I said "If a user wires up a second UART...",
but I guess my "Not wiring it up would lose the messages..." sentence
was ambiguous. I didn't mean they'd output to no where, I meant those
messages wouldn't be output. I.e. some sort of debug_printf() function
would be written that only actually does a write when there's a debug
UART on the other end to write to.

I just commented on patch 2/3 of this series asking if we shouldn't
just not allocate the second UART's MMIO region and IRQ, when the user
doesn't provide a '-serial' option for it. If we didn't, then AAVMF
would just not output debug messages when only one UART (the console)
is found in the DT.

Thanks,
drew
