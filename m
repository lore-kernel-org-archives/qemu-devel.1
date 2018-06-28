Received: from eggs.gnu.org ([2001:4830:134:3::10]:47659)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYWaP-0007dY-N4
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:03:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1fYWaL-0002Hu-JW
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:03:45 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:46405)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <laurent@vivier.eu>) id 1fYWaL-0002HH-8t
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 09:03:41 -0400
References: <20180626165658.31394-1-peter.maydell@linaro.org>
	<20180626165658.31394-24-peter.maydell@linaro.org>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <50e46f22-1e3d-10ce-5b5b-a10af49a95f1@vivier.eu>
Date: Thu, 28 Jun 2018 15:03:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180626165658.31394-24-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PULL 23/32] tcg: Support MMU protection regions
 smaller than TARGET_PAGE_SIZE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org

Le 26/06/2018 à 18:56, Peter Maydell a écrit :
> Add support for MMU protection regions that are smaller than
> TARGET_PAGE_SIZE. We do this by marking the TLB entry for those
> pages with a flag TLB_RECHECK. This flag causes us to always
> take the slow-path for accesses. In the slow path we can then
> special case them to always call tlb_fill() again, so we have
> the correct information for the exact address being accessed.
> 
> This change allows us to handle reading and writing from small
> regions; we cannot deal with execution from the small region.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Message-id: 20180620130619.11362-2-peter.maydell@linaro.org
> ---
>  accel/tcg/softmmu_template.h |  24 ++++---
>  include/exec/cpu-all.h       |   5 +-
>  accel/tcg/cputlb.c           | 131 +++++++++++++++++++++++++++++------
>  3 files changed, 130 insertions(+), 30 deletions(-)

This patch breaks Quadra 800 emulation, any idea why?

ABCFGHIJK
qemu: fatal: Unable to handle guest executing from RAM within a small
MPU region at 0x0014cb5a
D0 = 0000006a   A0 = 002d8a19   F0 = 7fff ffffffffffffffff  (         nan)
D1 = 00000010   A1 = 002d8a19   F1 = 7fff ffffffffffffffff  (         nan)
D2 = 000003e0   A2 = 00332310   F2 = 7fff ffffffffffffffff  (         nan)
D3 = 00000000   A3 = 00331f98   F3 = 7fff ffffffffffffffff  (         nan)
D4 = 0036da87   A4 = 0036daa3   F4 = 7fff ffffffffffffffff  (         nan)
D5 = 000003e0   A5 = 0036de67   F5 = 7fff ffffffffffffffff  (         nan)
D6 = 002d8a18   A6 = 002d8a1a   F6 = 7fff ffffffffffffffff  (         nan)
D7 = 0014ac46   A7 = 00331ed8   F7 = 7fff ffffffffffffffff  (         nan)
PC = 0014cb5a   SR = 2700 T:0 I:7 SI -----
FPSR = 00000000 ---- -------- -----  FPCR = 0000 X RN --------
  A7(MSP) = 00000000   A7(USP) = 00000000 ->A7(ISP) = 00331f38
VBR = 0x00364528
SFC = 0 DFC 0
SSW 00000000 TCR 00008000 URP 00000000 SRP 00001000
DTTR0/1: 00000000/f807a040 ITTR0/1: 00000000/f807a040
MMUSR 00000000, fault at 00000000
Aborted (core dumped)

Laurent
