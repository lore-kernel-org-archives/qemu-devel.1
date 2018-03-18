Received: from eggs.gnu.org ([2001:4830:134:3::10]:44372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1exhVl-0005Qa-8P
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 19:14:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1exhVi-000079-2q
	for qemu-devel@nongnu.org; Sun, 18 Mar 2018 19:14:45 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1521232280-13089-1-git-send-email-alindsay@codeaurora.org>
	<1521232280-13089-15-git-send-email-alindsay@codeaurora.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9af89876-bf5d-4696-a430-664fcd5a02fa@amsat.org>
Date: Mon, 19 Mar 2018 00:14:38 +0100
MIME-Version: 1.0
In-Reply-To: <1521232280-13089-15-git-send-email-alindsay@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v3 14/22] target/arm: Make PMOVSCLR 64 bits
 wide
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Aaron Lindsay <alindsay@codeaurora.org>, qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Alistair Francis <alistair.francis@xilinx.com>, Wei Huang <wei@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: Michael Spradling <mspradli@codeaurora.org>, qemu-devel@nongnu.org, Digant Desai <digantd@codeaurora.org>

Hi Aaron,

On 03/16/2018 09:31 PM, Aaron Lindsay wrote:
> This is a bug fix to ensure 64-bit reads of this register don't read
> adjacent data.
> 
> Signed-off-by: Aaron Lindsay <alindsay@codeaurora.org>
> ---
>  target/arm/cpu.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/cpu.h b/target/arm/cpu.h
> index 9c3b5ef..fb2f983 100644
> --- a/target/arm/cpu.h
> +++ b/target/arm/cpu.h
> @@ -367,7 +367,7 @@ typedef struct CPUARMState {
>          uint32_t c9_data;
>          uint64_t c9_pmcr; /* performance monitor control register */
>          uint64_t c9_pmcnten; /* perf monitor counter enables */
> -        uint32_t c9_pmovsr; /* perf monitor overflow status */
> +        uint64_t c9_pmovsr; /* perf monitor overflow status */

This doesn't look correct, since this reg is 32b.

I *think* the correct fix is in ARMCPRegInfo v7_cp_reginfo[]:

    { .name = "PMOVSR", ...
-     ..., .fieldoffset = offsetof(CPUARMState, cp15.c9_pmovsr),
+     ..., .fieldoffset = offsetoflow32(CPUARMState, cp15.c9_pmovsr),
      .accessfn = pmreg_access,
      .writefn = pmovsr_write,
      .raw_writefn = raw_write },

>          uint32_t c9_pmuserenr; /* perf monitor user enable */
>          uint64_t c9_pmselr; /* perf monitor counter selection register */
>          uint64_t c9_pminten; /* perf monitor interrupt enables */
> 

Regards,

Phil.
