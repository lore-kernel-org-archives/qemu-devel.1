Received: from eggs.gnu.org ([2001:4830:134:3::10]:41745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dV21E-0000zE-Im
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:44:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dV215-0006nI-Ad
	for qemu-devel@nongnu.org; Tue, 11 Jul 2017 16:44:24 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1499771839-32518-1-git-send-email-peter.maydell@linaro.org>
	<1499771839-32518-3-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <6cee176b-a624-4f1d-aba6-e1c9fa011209@amsat.org>
Date: Tue, 11 Jul 2017 17:42:59 -0300
MIME-Version: 1.0
In-Reply-To: <1499771839-32518-3-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 2/7] hw/char/cmsdk-apb-uart.c: Implement
 CMSDK APB UART
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

Hi Peter,

There is probably no need yet, but we could model a generic APB slave 
with this code, as an overlapping subregion (device top 0x30 bytes).

For now only PID0 differs, but since all ID are 8bit the device could 
even instantiate the subregion with some u64 PID, 32 CID args.

(thinking about watchdog and dualtimers).

Regards,

Phil.

On 07/11/2017 08:17 AM, Peter Maydell wrote:
> +REG32(PID4, 0xFD0)
> +REG32(PID5, 0xFD4)
> +REG32(PID6, 0xFD8)
> +REG32(PID7, 0xFDC)
> +REG32(PID0, 0xFE0)
> +REG32(PID1, 0xFE4)
> +REG32(PID2, 0xFE8)
> +REG32(PID3, 0xFEC)
> +REG32(CID0, 0xFF0)
> +REG32(CID1, 0xFF4)
> +REG32(CID2, 0xFF8)
> +REG32(CID3, 0xFFC)
> +
> +/* PID/CID values */
> +static const int uart_id[] = {
> +    0x04, 0x00, 0x00, 0x00, /* PID4..PID7 */
> +    0x21, 0xb8, 0x1b, 0x00, /* PID0..PID3 */
> +    0x0d, 0xf0, 0x05, 0xb1, /* CID0..CID3 */
> +};
> +
[...]
> +static uint64_t uart_read(void *opaque, hwaddr offset, unsigned size)
> +{
> +    CMSDKAPBUART *s = CMSDK_APB_UART(opaque);
> +    uint64_t r;
> +
> +    switch (offset) {
[...]
> +    case A_PID4 ... A_CID3:
> +        r = uart_id[offset / 4 - A_PID4];
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "CMSDK APB UART read: bad offset %x\n", (int) offset);
> +        r = 0;
> +        break;
> +    }
> +    trace_cmsdk_apb_uart_read(offset, r, size);
> +    return r;
> +}
> +
[...]
> +static void uart_write(void *opaque, hwaddr offset, uint64_t value,
> +                       unsigned size)
> +{
> +    CMSDKAPBUART *s = CMSDK_APB_UART(opaque);
> +
> +    trace_cmsdk_apb_uart_write(offset, value, size);
> +
> +    switch (offset) {
[...]
> +    case A_PID4 ... A_CID3:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "CMSDK APB UART write: write to RO offset 0x%x\n",
> +                      (int)offset);
> +        break;
> +    default:
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "CMSDK APB UART write: bad offset 0x%x\n", (int) offset);
> +        break;
> +    }
> +}
