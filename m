Received: from eggs.gnu.org ([2001:4830:134:3::10]:49911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebS3L-0002K7-JG
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:17:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1ebS3K-0004Jh-E5
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:17:27 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:35932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1ebS3K-0004JZ-8W
	for qemu-devel@nongnu.org; Tue, 16 Jan 2018 09:17:26 -0500
Received: by mail-ot0-x243.google.com with SMTP id f100so1141027otf.3
	for <qemu-devel@nongnu.org>; Tue, 16 Jan 2018 06:17:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1516103467-7983-1-git-send-email-edgar.iglesias@gmail.com>
References: <1516103467-7983-1-git-send-email-edgar.iglesias@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 16 Jan 2018 14:17:04 +0000
Message-ID: <CAFEAcA8v1pmDLD6xz_5yysqyV+aG3EiSF1j9ahYC9f2XatF80Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v1 0/8] Xilinx queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Alistair Francis <alistai@xilinx.com>, Sai Pavan Boddu <sai.pavan.boddu@xilinx.com>, Edgar Iglesias <edgar.iglesias@xilinx.com>

On 16 January 2018 at 11:50, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>
> The following changes since commit f521eeee3bd060b460c99e605472b7e03967db43:
>
>   Merge remote-tracking branch 'remotes/juanquintela/tags/migration/20180115' into staging (2018-01-15 13:17:47 +0000)
>
> are available in the git repository at:
>
>   git@github.com:edgarigl/qemu.git tags/edgar/xilinx-next-2018-01.for-upstream
>
> for you to fetch changes up to e451272ac191cd3ac408bc89ea63a401e84d4224:
>
>   xlnx-zynqmp: Connect the IPI device to the ZynqMP SoC (2018-01-16 11:44:49 +0100)
>
> ----------------------------------------------------------------
> Xilinx queue
>
> ----------------------------------------------------------------
> Alistair Francis (8):
>       xlnx-zynqmp-pmu: Initial commit of the ZynqMP PMU
>       xlnx-zynqmp-pmu: Add the CPU and memory
>       aarch64-softmmu.mak: Use an ARM specific config
>       xlnx-pmu-iomod-intc: Add the PMU Interrupt controller
>       xlnx-zynqmp-pmu: Connect the PMU interrupt controller
>       xlnx-zynqmp-ipi: Initial version of the Xilinx IPI device
>       xlnx-zynqmp-pmu: Connect the IPI device to the PMU
>       xlnx-zynqmp: Connect the IPI device to the ZynqMP SoC
>

Hi -- this trips some new runtime sanitizer warnings:

  GTESTER check-qtest-microblaze
/home/petmay01/linaro/qemu-for-merges/vl.c:2279:16: runtime error:
null pointer passed as argument 1, which is declared to never be null
/usr/include/unistd.h:290:60: note: nonnull attribute specified here
/home/petmay01/linaro/qemu-for-merges/vl.c:2279:16: runtime error:
null pointer passed as argument 1, which is declared to never be null
/usr/include/unistd.h:290:60: note: nonnull attribute specified here
make: Leaving directory '/home/petmay01/linaro/qemu-for-merges/build/clang'
make: Entering directory '/home/petmay01/linaro/qemu-for-merges/build/clang'
  GTESTER check-qtest-microblazeel
/home/petmay01/linaro/qemu-for-merges/vl.c:2279:16: runtime error:
null pointer passed as argument 1, which is declared to never be null
/usr/include/unistd.h:290:60: note: nonnull attribute specified here
/home/petmay01/linaro/qemu-for-merges/vl.c:2279:16: runtime error:
null pointer passed as argument 1, which is declared to never be null
/usr/include/unistd.h:290:60: note: nonnull attribute specified here

This is because you've called qemu_find_file() with a NULL pointer
(which it then passes to access(), which it isn't valid to call with
a NULL pathname argument). Backtrace:

#0  0x0000555555e446c1 in qemu_find_file (type=0, name=0x0)
    at /home/petmay01/linaro/qemu-for-merges/vl.c:2279
#1  0x0000555555dfd693 in microblaze_load_kernel (cpu=0x55555824da28,
ddr_base=<optimised out>, ramsize=0, initrd_filename=<optimised out>,
dtb_filename=0x0, machine_cpu_reset=0x0)
    at /home/petmay01/linaro/qemu-for-merges/hw/microblaze/boot.c:128
#2  0x0000555555dfd519 in xlnx_zynqmp_pmu_init (machine=<optimised out>)
    at /home/petmay01/linaro/qemu-for-merges/hw/microblaze/xlnx-zynqmp-pmu.c:190
#3  0x0000555555f2fd5d in machine_run_board_init (machine=<optimised out>)
    at /home/petmay01/linaro/qemu-for-merges/hw/core/machine.c:792
#4  0x0000555555e4a357 in main (argc=<optimised out>, argv=<optimised
out>, envp=<optimised out>)
    at /home/petmay01/linaro/qemu-for-merges/vl.c:4622

thanks
-- PMM
