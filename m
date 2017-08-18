Received: from eggs.gnu.org ([2001:4830:134:3::10]:42660)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dikqu-0001KD-Tk
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:14:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dikqu-0006Jm-0w
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:14:32 -0400
Received: from mail-wm0-x235.google.com ([2a00:1450:400c:c09::235]:37697)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dikqt-0006Ii-QJ
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:14:31 -0400
Received: by mail-wm0-x235.google.com with SMTP id i66so4682860wmg.0
	for <qemu-devel@nongnu.org>; Fri, 18 Aug 2017 10:14:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1503076096-14220-1-git-send-email-thuth@redhat.com>
References: <1503076096-14220-1-git-send-email-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 18 Aug 2017 18:14:08 +0100
Message-ID: <CAFEAcA_F1iFu8cbKCyxnjZP+hVY9DkrJZXHqZ65G10BqzcapQw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/allwinner: Fix crash with
 -nodefaults -M cubieboard
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Beniamino Galvani <b.galvani@gmail.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Li Guang <lig.fnst@cn.fujitsu.com>

On 18 August 2017 at 18:08, Thomas Huth <thuth@redhat.com> wrote:
> The allwinner-a10 device uses serial_hds[0] without checking whether
> it is available or not. So using the cubieboard with -nodefaults
> currently results in a segmentation fault. Fix it by adding a
> proper check here.
> And while we're at it, mark the device as "user_creatable = false"
> since this apparently can not directly be used by the users but has
> to be wired up in code instead.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  hw/arm/allwinner-a10.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/hw/arm/allwinner-a10.c b/hw/arm/allwinner-a10.c
> index f62a9a3..e152566 100644
> --- a/hw/arm/allwinner-a10.c
> +++ b/hw/arm/allwinner-a10.c
> @@ -109,8 +109,10 @@ static void aw_a10_realize(DeviceState *dev, Error **errp)
>      sysbus_connect_irq(SYS_BUS_DEVICE(&s->sata), 0, s->irq[56]);
>
>      /* FIXME use a qdev chardev prop instead of serial_hds[] */
> -    serial_mm_init(get_system_memory(), AW_A10_UART0_REG_BASE, 2, s->irq[1],
> -                   115200, serial_hds[0], DEVICE_NATIVE_ENDIAN);
> +    if (serial_hds[0]) {
> +        serial_mm_init(get_system_memory(), AW_A10_UART0_REG_BASE, 2, s->irq[1],
> +                       115200, serial_hds[0], DEVICE_NATIVE_ENDIAN);
> +    }

This doesn't look like the right fix, because it means that
there won't be a UART device at that point in system memory
at all. What you want is for there to be a UART device there
but not connected to anything, ie serial_mm_init() should cope
with being passed a NULL Chardev*.

thanks
-- PMM
