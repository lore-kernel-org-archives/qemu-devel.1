Received: from eggs.gnu.org ([2001:4830:134:3::10]:44617)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cdt0z-0001hA-72
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 01:24:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <liq3ea@gmail.com>) id 1cdt0y-0002j3-0J
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 01:24:33 -0500
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:36460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <liq3ea@gmail.com>) id 1cdt0x-0002hy-RI
	for qemu-devel@nongnu.org; Wed, 15 Feb 2017 01:24:31 -0500
Received: by mail-io0-x242.google.com with SMTP id q20so11368502ioi.3
	for <qemu-devel@nongnu.org>; Tue, 14 Feb 2017 22:24:30 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <5899a02e.45ca240a.6c373.93c1@mx.google.com>
References: <5899a02e.45ca240a.6c373.93c1@mx.google.com>
From: Li Qiang <liq3ea@gmail.com>
Date: Wed, 15 Feb 2017 14:24:29 +0800
Message-ID: <CAKXe6SLoQskt4SGxDRUg46sM0SZnNCXtizrt7TaLLWpGk8b6zg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH] usb: ohci: limit the number of link eds
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Qemu Developers <qemu-devel@nongnu.org>
Cc: Li Qiang <liqiang6-s@360.cn>

Hello Gerd,

Ping...

2017-02-07 18:23 GMT+08:00 Li Qiang <liq3ea@gmail.com>:

> From: Li Qiang <liqiang6-s@360.cn>
>
> The guest may builds an infinite loop with link eds. This patch
> limit the number of linked ed to avoid this.
>
> Signed-off-by: Li Qiang <liqiang6-s@360.cn>
> ---
>  hw/usb/hcd-ohci.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
>
> diff --git a/hw/usb/hcd-ohci.c b/hw/usb/hcd-ohci.c
> index c82a92f..4a63f3b 100644
> --- a/hw/usb/hcd-ohci.c
> +++ b/hw/usb/hcd-ohci.c
> @@ -42,6 +42,8 @@
>
>  #define OHCI_MAX_PORTS 15
>
> +#define ED_LINK_LIMIT 4
> +
>  static int64_t usb_frame_time;
>  static int64_t usb_bit_time;
>
> @@ -1184,7 +1186,7 @@ static int ohci_service_ed_list(OHCIState *ohci,
> uint32_t head, int completion)
>      uint32_t next_ed;
>      uint32_t cur;
>      int active;
> -
> +    uint32_t link_cnt = 0;
>      active = 0;
>
>      if (head == 0)
> @@ -1199,6 +1201,11 @@ static int ohci_service_ed_list(OHCIState *ohci,
> uint32_t head, int completion)
>
>          next_ed = ed.next & OHCI_DPTR_MASK;
>
> +        if (++link_cnt > ED_LINK_LIMIT) {
> +            ohci_die(ohci);
> +            return 0;
> +        }
> +
>          if ((ed.head & OHCI_ED_H) || (ed.flags & OHCI_ED_K)) {
>              uint32_t addr;
>              /* Cancel pending packets for ED that have been paused.  */
> --
> 1.8.3.1
>
>
