Received: from eggs.gnu.org ([209.51.188.92]:35518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h3I9X-0005rF-Cn
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h3I82-0007DK-SO
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:25:55 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37669)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1h3I82-0007Cu-LQ
	for qemu-devel@nongnu.org; Mon, 11 Mar 2019 06:25:54 -0400
Received: by mail-wm1-f67.google.com with SMTP id x10so3663042wmg.2
	for <qemu-devel@nongnu.org>; Mon, 11 Mar 2019 03:25:54 -0700 (PDT)
References: <20190311074752.GA17747@ls3530.dellerweb.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <9b974705-d8b3-3068-9925-23e678491d98@redhat.com>
Date: Mon, 11 Mar 2019 11:11:26 +0100
MIME-Version: 1.0
In-Reply-To: <20190311074752.GA17747@ls3530.dellerweb.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] pcnet: Avoid warning when switching back
 to 16bit mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org, Jason Wang <jasowang@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>

On 3/11/19 8:47 AM, Helge Deller wrote:
> When Linux is shutting down, the pcnet32 driver switches the pcnet card
> back to 16bit mode to "avoid problems with dumb DOS packet driver after
> a warm reboot".
> This triggers the following warning in the qemu pcnet32 emulation:
> Bad SWSTYLE=0x04

This was bugging us for years, thanks!

> 
> Avoid this qemu warning by allowing the switch-back to 16bit mode.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> 
> diff --git a/hw/net/pcnet.c b/hw/net/pcnet.c
> index d9ba04bdfc..14eb2fa1b0 100644
> --- a/hw/net/pcnet.c
> +++ b/hw/net/pcnet.c
> @@ -1496,8 +1496,9 @@ static void pcnet_bcr_writew(PCNetState *s, uint32_t rap, uint32_t val)
>          case 1:
>              val |= 0x0100;
>              break;
> -        case 2:
> +        case 2: /* 32bit mode */
>          case 3:
> +        case 4: /* 16bit mode */
>              val |= 0x0300;
>              break;
>          default:
> 
