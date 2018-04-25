Received: from eggs.gnu.org ([2001:4830:134:3::10]:43686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBLzk-0006KY-Qf
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:06:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fBLzb-0005CM-6H
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:06:08 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42412 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1fBLzb-0005CA-2E
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 11:05:59 -0400
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-10-peter.maydell@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <2116cce5-6920-a42a-a4c0-880c102b30e6@redhat.com>
Date: Wed, 25 Apr 2018 17:05:51 +0200
MIME-Version: 1.0
In-Reply-To: <20180420145249.32435-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 09/13] hw/char/exynos4210_uart.c: Remove
 unneeded handling of NULL chardev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, patches@linaro.org

On 20.04.2018 16:52, Peter Maydell wrote:
> The handling of NULL chardevs in exynos4210_uart_create() is now
> all unnecessary: we don't need to create 'null' chardevs, and we
> don't need to enforce a bounds check on serial_hd().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/char/exynos4210_uart.c | 20 --------------------
>  1 file changed, 20 deletions(-)
> 
> diff --git a/hw/char/exynos4210_uart.c b/hw/char/exynos4210_uart.c
> index c2bba03362..a5a285655f 100644
> --- a/hw/char/exynos4210_uart.c
> +++ b/hw/char/exynos4210_uart.c
> @@ -589,28 +589,8 @@ DeviceState *exynos4210_uart_create(hwaddr addr,
>      DeviceState  *dev;
>      SysBusDevice *bus;
>  
> -    const char chr_name[] = "serial";
> -    char label[ARRAY_SIZE(chr_name) + 1];
> -
>      dev = qdev_create(NULL, TYPE_EXYNOS4210_UART);
>  
> -    if (!chr) {
> -        if (channel >= MAX_SERIAL_PORTS) {
> -            error_report("Only %d serial ports are supported by QEMU",
> -                         MAX_SERIAL_PORTS);
> -            exit(1);
> -        }

If I get the EXYNOS 4210 data sheet right, this chip has only 4 channels
indeed:

http://www.samsung.com/global/business/semiconductor/file/product/Exynos_4_Dual_45nm_User_Manaul_Public_REV1.00-0.pdf

So I think you should at least keep an "assert(channel < 4)" in here?

Apart from that, the patch looks sane to me, so when you add that assert():

Reviewed-by: Thomas Huth <thuth@redhat.com>
