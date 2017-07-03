Received: from eggs.gnu.org ([2001:4830:134:3::10]:48808)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dRzbC-00073I-L2
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:33:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dRzbB-0008Cx-TI
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:33:02 -0400
Received: from mail-wm0-x236.google.com ([2a00:1450:400c:c09::236]:38746)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dRzbB-0008Bw-Lq
	for qemu-devel@nongnu.org; Mon, 03 Jul 2017 07:33:01 -0400
Received: by mail-wm0-x236.google.com with SMTP id f67so51658923wmh.1
	for <qemu-devel@nongnu.org>; Mon, 03 Jul 2017 04:33:01 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170703111549.10924-1-kraxel@redhat.com>
References: <20170703111549.10924-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 3 Jul 2017 12:32:39 +0100
Message-ID: <CAFEAcA_u9_jdyDRDb089n3swLsboaV8QfdojLaN5aZLZ69zDPw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] ehci: add sanity check for maxframes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 3 July 2017 at 12:15, Gerd Hoffmann <kraxel@redhat.com> wrote:
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  hw/usb/hcd-ehci.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 73090e01ad..604912cb3e 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -2483,6 +2483,11 @@ void usb_ehci_realize(EHCIState *s, DeviceState *dev, Error **errp)
>                     NB_PORTS);
>          return;
>      }
> +    if (s->maxframes < 8 || s->maxframes > 512)  {
> +        error_setg(errp, "maxframes %d out if range (8 .. 512)",
> +                   s->maxframes);

Typo: should be "of".

> +        return;
> +    }
>
>      usb_bus_new(&s->bus, sizeof(s->bus), s->companion_enable ?
>                  &ehci_bus_ops_companion : &ehci_bus_ops_standalone, dev);
> --
> 2.9.3

Otherwise
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Do we want something similar for hcd-uhci just for consistency?

thanks
-- PMM
