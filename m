Received: from eggs.gnu.org ([2001:4830:134:3::10]:52196)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gJgjJ-0007RW-D4
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:23:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1gJgjH-0004ET-1l
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 10:23:53 -0500
Date: Mon, 5 Nov 2018 16:23:00 +0100
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20181105152300.GA1148@toto>
References: <20181016093703.10637-1-peter.maydell@linaro.org>
	<20181016093703.10637-2-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181016093703.10637-2-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/2] target/arm: Set S and PTW
 in 64-bit PAR format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org

On Tue, Oct 16, 2018 at 10:37:02AM +0100, Peter Maydell wrote:
> In do_ats_write() we construct a PAR value based on the result
> of the translation.  A comment says "S2WLK and FSTAGE are always
> zero, because we don't implement virtualization".
> Since we do in fact now implement virtualization, add the missing
> code that sets these bits based on the reported ARMMMUFaultInfo.
> 
> (These bits are named PTW and S in ARMv8, so we follow that
> convention in the new comments in this patch.)
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  target/arm/helper.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index 43afdd082e1..dc849b09893 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2344,10 +2344,12 @@ static uint64_t do_ats_write(CPUARMState *env, uint64_t value,
>  
>              par64 |= 1; /* F */
>              par64 |= (fsr & 0x3f) << 1; /* FS */
> -            /* Note that S2WLK and FSTAGE are always zero, because we don't
> -             * implement virtualization and therefore there can't be a stage 2
> -             * fault.
> -             */
> +            if (fi.stage2) {
> +                par64 |= (1 << 9); /* S */
> +            }
> +            if (fi.s1ptw) {
> +                par64 |= (1 << 8); /* PTW */
> +            }
>          }
>      } else {
>          /* fsr is a DFSR/IFSR value for the short descriptor
> -- 
> 2.19.0
> 
> 
