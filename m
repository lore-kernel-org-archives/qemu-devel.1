Received: from eggs.gnu.org ([2001:4830:134:3::10]:37102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f48o8-000189-IU
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:36:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f48o3-0000TR-Qk
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 13:36:20 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180405172554.27401-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <aef5b809-2cac-1490-239f-47ef97496133@amsat.org>
Date: Thu, 5 Apr 2018 14:36:12 -0300
MIME-Version: 1.0
In-Reply-To: <20180405172554.27401-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-2.12] target/arm: Report
 unsupported MPU region sizes more clearly
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 04/05/2018 02:25 PM, Peter Maydell wrote:
> Currently our PMSAv7 and ARMv7M MPU implementation cannot handle
> MPU region sizes smaller than our TARGET_PAGE_SIZE. However we
> report that in a slightly confusing way:
> 
>  DRSR[3]: No support for MPU (sub)region alignment of 9 bits. Minimum is 10
> 
> The problem is not the alignment of the region, but its size;
> tweak the error message to say so:
>  DRSR[3]: No support for MPU (sub)region size of 512 bytes. Minimum is 1024.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
> This doesn't really need to go into 2.12, but as a cleanup to a warning
> message it's pretty harmless.
> 
>  target/arm/helper.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index dcb8476d9e..b14fdab140 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -9625,9 +9625,9 @@ static bool get_phys_addr_pmsav7(CPUARMState *env, uint32_t address,
>              }
>              if (rsize < TARGET_PAGE_BITS) {
>                  qemu_log_mask(LOG_UNIMP,
> -                              "DRSR[%d]: No support for MPU (sub)region "
> -                              "alignment of %" PRIu32 " bits. Minimum is %d\n",
> -                              n, rsize, TARGET_PAGE_BITS);
> +                              "DRSR[%d]: No support for MPU (sub)region size of"
> +                              " %" PRIu32 " bytes. Minimum is %d.\n",
> +                              n, (1 << rsize), TARGET_PAGE_SIZE);
>                  continue;
>              }
>              if (srdis) {
> 
