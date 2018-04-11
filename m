Received: from eggs.gnu.org ([2001:4830:134:3::10]:43940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f6I53-0003SW-3J
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:54:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f6I52-0002l8-2i
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 11:54:41 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180410134203.17552-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <c996f23e-b8cf-7c6d-5557-cb7b03df6bfc@amsat.org>
Date: Wed, 11 Apr 2018 12:54:30 -0300
MIME-Version: 1.0
In-Reply-To: <20180410134203.17552-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-2.12]
 hw/char/cmsdk-apb-uart.c: Correctly clear INTSTATUS bits on writes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, patches@linaro.org

On 04/10/2018 10:42 AM, Peter Maydell wrote:
> The CMSDK APB UART INTSTATUS register bits are all write-one-to-clear.
> We were getting this correct for the TXO and RXO bits (which need
> special casing because their state lives in the STATE register),
> but had forgotten to handle the normal bits for RX and TX which
> we do store in our s->intstatus field.
> 
> Perform the W1C operation on the bits in s->intstatus too.
> 
> Fixes: https://bugs.launchpad.net/qemu/+bug/1760262
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> Not a disaster if this doesn't get into 2.12, I guess. I think
> it's missed the rc3 boat, so if we need an rc4 for some other
> reason we can put it in.
> 
>  hw/char/cmsdk-apb-uart.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/char/cmsdk-apb-uart.c b/hw/char/cmsdk-apb-uart.c
> index 1ad1e14295..9c0929d8a2 100644
> --- a/hw/char/cmsdk-apb-uart.c
> +++ b/hw/char/cmsdk-apb-uart.c
> @@ -274,6 +274,7 @@ static void uart_write(void *opaque, hwaddr offset, uint64_t value,
>           * is then reflected into the intstatus value by the update function).

The comment was correct :)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

>           */
>          s->state &= ~(value & (R_INTSTATUS_TXO_MASK | R_INTSTATUS_RXO_MASK));
> +        s->intstatus &= ~value;
>          cmsdk_apb_uart_update(s);
>          break;
>      case A_BAUDDIV:
> 
