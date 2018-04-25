Received: from eggs.gnu.org ([2001:4830:134:3::10]:41391)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBLt8-0001si-DM
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:59:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBLt7-0002EL-PK
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:59:18 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:38487)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fBLt7-0002ED-LT
	for qemu-devel@nongnu.org; Wed, 25 Apr 2018 10:59:17 -0400
Received: by mail-qt0-x242.google.com with SMTP id z23-v6so27188497qti.5
	for <qemu-devel@nongnu.org>; Wed, 25 Apr 2018 07:59:17 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180420145249.32435-1-peter.maydell@linaro.org>
	<20180420145249.32435-10-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <340ae18b-3a45-6148-5ff2-57e64340dadb@amsat.org>
Date: Wed, 25 Apr 2018 11:59:13 -0300
MIME-Version: 1.0
In-Reply-To: <20180420145249.32435-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
Cc: patches@linaro.org, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>

On 04/20/2018 11:52 AM, Peter Maydell wrote:
> The handling of NULL chardevs in exynos4210_uart_create() is now
> all unnecessary: we don't need to create 'null' chardevs, and we
> don't need to enforce a bounds check on serial_hd().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

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
> -        chr = serial_hd(channel);
> -        if (!chr) {
> -            snprintf(label, ARRAY_SIZE(label), "%s%d", chr_name, channel);
> -            chr = qemu_chr_new(label, "null");
> -            if (!(chr)) {
> -                error_report("Can't assign serial port to UART%d", channel);
> -                exit(1);
> -            }
> -        }
> -    }
> -
>      qdev_prop_set_chr(dev, "chardev", chr);
>      qdev_prop_set_uint32(dev, "channel", channel);
>      qdev_prop_set_uint32(dev, "rx-size", fifo_size);
> 
