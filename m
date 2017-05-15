Received: from eggs.gnu.org ([2001:4830:134:3::10]:43458)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAG75-0006VK-Dn
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:32:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAG72-0003jX-9M
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:32:39 -0400
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dAG72-0003im-6B
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:32:36 -0400
Received: by mail-qt0-x241.google.com with SMTP id r58so15519133qtb.2
	for <qemu-devel@nongnu.org>; Mon, 15 May 2017 06:32:36 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170515104543.32044-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <b8046b2f-976f-01b9-c9ea-c9fded14f35d@amsat.org>
Date: Mon, 15 May 2017 10:32:32 -0300
MIME-Version: 1.0
In-Reply-To: <20170515104543.32044-1-kraxel@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] ehci: fix overflow in frame timer code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: 8610_28@163.com

Hi Gerd, 李林,

On 05/15/2017 07:45 AM, Gerd Hoffmann wrote:
> In case the frame timer doesn't run for a while due to the host being
> busy skipped_uframes can become big enough that UFRAME_TIMER_NS *
> skipped_uframes overflows.  Which in turn throws off all subsequent
> ehci frame timer calculations.
>
> Reported-by: 李林 <8610_28@163.com>

李林: You may want to add your Signed-off-by here along with Gerd's.

> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/usb/hcd-ehci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/usb/hcd-ehci.c b/hw/usb/hcd-ehci.c
> index 3703a8dddc..17c572c55f 100644
> --- a/hw/usb/hcd-ehci.c
> +++ b/hw/usb/hcd-ehci.c
> @@ -2238,7 +2238,7 @@ static void ehci_work_bh(void *opaque)
>      int need_timer = 0;
>      int64_t expire_time, t_now;
>      uint64_t ns_elapsed;
> -    int uframes, skipped_uframes;
> +    uint64_t uframes, skipped_uframes;
>      int i;
>
>      t_now = qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
>
