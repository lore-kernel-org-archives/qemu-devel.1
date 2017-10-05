Received: from eggs.gnu.org ([2001:4830:134:3::10]:52779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzxqO-0006dN-TM
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 00:33:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dzxqL-0005j5-QH
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 00:33:08 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1506092407-26985-1-git-send-email-peter.maydell@linaro.org>
	<1506092407-26985-21-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e03aefd1-81bb-10b0-f325-fdce7e60c7a6@amsat.org>
Date: Thu, 5 Oct 2017 01:33:01 -0300
MIME-Version: 1.0
In-Reply-To: <1506092407-26985-21-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 20/20] nvic: Add missing code
 for writing SHCSR.HARDFAULTPENDED bit
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

On 09/22/2017 12:00 PM, Peter Maydell wrote:
> When we added support for the new SHCSR bits in v8M in commit
> 437d59c17e9 the code to support writing to the new HARDFAULTPENDED
> bit was accidentally only added for non-secure writes; the
> secure banked version of the bit should also be writable.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/armv7m_nvic.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index bd1d5d3..22d5e6e 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -1230,6 +1230,7 @@ static void nvic_writel(NVICState *s, uint32_t offset, uint32_t value,

        if (attrs.secure) {

if banked then arch is v8M,

>              s->sec_vectors[ARMV7M_EXCP_BUS].enabled = (value & (1 << 17)) != 0;
>              s->sec_vectors[ARMV7M_EXCP_USAGE].enabled =
>                  (value & (1 << 18)) != 0;
> +            s->sec_vectors[ARMV7M_EXCP_HARD].pending = (value & (1 << 21)) != 0;

therefore this bit is present.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>              /* SecureFault not banked, but RAZ/WI to NS */
>              s->vectors[ARMV7M_EXCP_SECURE].active = (value & (1 << 4)) != 0;
>              s->vectors[ARMV7M_EXCP_SECURE].enabled = (value & (1 << 19)) != 0;
> 
