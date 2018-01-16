Received: from eggs.gnu.org ([2001:4830:134:3::10]:60977)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar@xilinx.com>) id 1ebSZ1-0004Gq-BP
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:50:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar@xilinx.com>) id 1ebSYv-0004rg-EC
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:50:11 -0500
Received: from mail-sn1nam02on0050.outbound.protection.outlook.com
	([104.47.36.50]:50880
	helo=NAM02-SN1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <edgar@xilinx.com>) id 1ebSYv-0004qy-2X
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:50:05 -0500
Date: Tue, 16 Jan 2018 21:49:57 +0700
From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
Message-ID: <20180116144957.GA5516@toto>
References: <1516103467-7983-1-git-send-email-edgar.iglesias@gmail.com>
	<CAFEAcA8v1pmDLD6xz_5yysqyV+aG3EiSF1j9ahYC9f2XatF80Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAFEAcA8v1pmDLD6xz_5yysqyV+aG3EiSF1j9ahYC9f2XatF80Q@mail.gmail.com>
Subject: Re: [Qemu-devel] [PULL v1 0/8] Xilinx queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistai@xilinx.com>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>

On Tue, Jan 16, 2018 at 02:17:04PM +0000, Peter Maydell wrote:
> On 16 January 2018 at 11:50, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> > From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
> >
> > The following changes since commit f521eeee3bd060b460c99e605472b7e03967db43:
> >
> >   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20180115' into staging (2018-01-15 13:17:47 +0000)
> >
> > are available in the git repository at:
> >
> >   git@github.com:edgarigl/qemu.git tags/edgar/xilinx-next-2018-01.for-upstream
> >
> > for you to fetch changes up to e451272ac191cd3ac408bc89ea63a401e84d4224:
> >
> >   xlnx-zynqmp: Connect the IPI device to the ZynqMP SoC (2018-01-16 11:44:49 +0100)
> >
> > ----------------------------------------------------------------
> > Xilinx queue
> >
> > ----------------------------------------------------------------
> > Alistair Francis (8):
> >       xlnx-zynqmp-pmu: Initial commit of the ZynqMP PMU
> >       xlnx-zynqmp-pmu: Add the CPU and memory
> >       aarch64-softmmu.mak: Use an ARM specific config
> >       xlnx-pmu-iomod-intc: Add the PMU Interrupt controller
> >       xlnx-zynqmp-pmu: Connect the PMU interrupt controller
> >       xlnx-zynqmp-ipi: Initial version of the Xilinx IPI device
> >       xlnx-zynqmp-pmu: Connect the IPI device to the PMU
> >       xlnx-zynqmp: Connect the IPI device to the ZynqMP SoC
> >
> 
> Hi -- this trips some new runtime sanitizer warnings:


Hi Peter,

This didn't show up on my clang testing, do you mind sharing configure line and clang version you use?

@Alistair, it does seem like the call to microblaze_load_kernel is passing wrong arguments.
Can you have a look?

Cheers,
Edgar



> 
>   GTESTER check-qtest-microblaze
> /home/petmay01/linaro/qemu-for-merges/vl.c:2279:16: runtime error:
> null pointer passed as argument 1, which is declared to never be null
> /usr/include/unistd.h:290:60: note: nonnull attribute specified here
> /home/petmay01/linaro/qemu-for-merges/vl.c:2279:16: runtime error:
> null pointer passed as argument 1, which is declared to never be null
> /usr/include/unistd.h:290:60: note: nonnull attribute specified here
> make: Leaving directory '/home/petmay01/linaro/qemu-for-merges/build/clang'
> make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/clang'
>   GTESTER check-qtest-microblazeel
> /home/petmay01/linaro/qemu-for-merges/vl.c:2279:16: runtime error:
> null pointer passed as argument 1, which is declared to never be null
> /usr/include/unistd.h:290:60: note: nonnull attribute specified here
> /home/petmay01/linaro/qemu-for-merges/vl.c:2279:16: runtime error:
> null pointer passed as argument 1, which is declared to never be null
> /usr/include/unistd.h:290:60: note: nonnull attribute specified here
> 
> This is because you've called qemu_find_file() with a NULL pointer
> (which it then passes to access(), which it isn't valid to call with
> a NULL pathname argument). Backtrace:
> 
> #0  0x0000555555e446c1 in qemu_find_file (type=0, name=0x0)
>     at /home/petmay01/linaro/qemu-for-merges/vl.c:2279
> #1  0x0000555555dfd693 in microblaze_load_kernel (cpu=0x55555824da28,
> ddr_base=<optimised out>, ramsize=0, initrd_filename=<optimised out>,
> dtb_filename=0x0, machine_cpu_reset=0x0)
>     at /home/petmay01/linaro/qemu-for-merges/hw/microblaze/boot.c:128
> #2  0x0000555555dfd519 in xlnx_zynqmp_pmu_init (machine=<optimised out>)
>     at /home/petmay01/linaro/qemu-for-merges/hw/microblaze/xlnx-zynqmp-pmu.c:190
> #3  0x0000555555f2fd5d in machine_run_board_init (machine=<optimised out>)
>     at /home/petmay01/linaro/qemu-for-merges/hw/core/machine.c:792
> #4  0x0000555555e4a357 in main (argc=<optimised out>, argv=<optimised
> out>, envp=<optimised out>)
>     at /home/petmay01/linaro/qemu-for-merges/vl.c:4622
> 
> thanks
> -- PMM
