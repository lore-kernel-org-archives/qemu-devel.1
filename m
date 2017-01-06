Received: from eggs.gnu.org ([2001:4830:134:3::10]:37332)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPWB1-0000sA-4E
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:11:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cPWB0-0008A1-2D
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:11:31 -0500
Received: from mail-ua0-x229.google.com ([2607:f8b0:400c:c08::229]:33461)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cPWAz-00088u-Je
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:11:29 -0500
Received: by mail-ua0-x229.google.com with SMTP id i68so304140735uad.0
	for <qemu-devel@nongnu.org>; Fri, 06 Jan 2017 07:11:29 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170102211110.4801-1-jcd@tribudubois.net>
References: <20170102211110.4801-1-jcd@tribudubois.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jan 2017 15:11:08 +0000
Message-ID: <CAFEAcA_qPjjZijzL5L29tw6JQ+82od3wB959oPK-r=US65Bb9w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH v2] [i.MX] Remove MSGDATA register support.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jean-Christophe Dubois <jcd@tribudubois.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Marcin_Krzemi=C5=84ski?= <mar.krzeminski@gmail.com>

On 2 January 2017 at 21:11, Jean-Christophe Dubois <jcd@tribudubois.net> wrote:
> From the documentation it is not clear what this SPI register is about.
>
> Moreover, neither linux driver nor xvisor driver are using this SPI register.
>
> For now we just remove it and issue a log on register write access.
>
> Signed-off-by: Jean-Christophe Dubois <jcd@tribudubois.net>
> ---
>
> Changes since v1:
> * Fix coding style issue.
>
>  hw/ssi/imx_spi.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>
> diff --git a/hw/ssi/imx_spi.c b/hw/ssi/imx_spi.c
> index c2d293c..3a0400e 100644
> --- a/hw/ssi/imx_spi.c
> +++ b/hw/ssi/imx_spi.c
> @@ -338,9 +338,6 @@ static void imx_spi_write(void *opaque, hwaddr offset, uint64_t value,
>                        TYPE_IMX_SPI, __func__);
>          break;
>      case ECSPI_TXDATA:
> -    case ECSPI_MSGDATA:
> -        /* Is there any difference between TXDATA and MSGDATA ? */
> -        /* I'll have to look in the linux driver */
>          if (!imx_spi_is_enabled(s)) {
>              /* Ignore writes if device is disabled */
>              break;
> @@ -391,6 +388,14 @@ static void imx_spi_write(void *opaque, hwaddr offset, uint64_t value,
>          }
>
>          break;
> +    case ECSPI_MSGDATA:
> +        /* it is not clear from the spec what MSGDATA is for */
> +        /* Anyway it is not used by Linux driver */
> +        /* So for now we just ignore it */
> +        qemu_log_mask(LOG_GUEST_ERROR,
> +                      "[%s]%s: Trying to write to MSGDATA, ignoring\n",
> +                      TYPE_IMX_SPI, __func__);
> +        break;

This should be LOG_UNIMP, not LOG_GUEST_ERROR.

thanks
-- PMM
