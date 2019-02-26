Received: from eggs.gnu.org ([209.51.188.92]:38507)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gymb4-0002XW-CR
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 18:57:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gymb2-00081k-PX
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 18:57:13 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:53497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gymb2-0007zV-FG
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 18:57:12 -0500
Received: by mail-wm1-f65.google.com with SMTP id e74so4063799wmg.3
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 15:57:09 -0800 (PST)
References: <20190226193408.23862-1-armbru@redhat.com>
	<20190226193408.23862-4-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <b11c1d28-8d84-aa7b-9fed-4ebcdc6f17a8@redhat.com>
Date: Wed, 27 Feb 2019 00:57:06 +0100
MIME-Version: 1.0
In-Reply-To: <20190226193408.23862-4-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 03/11] pflash_cfi01: Log use of flawed
 "write to buffer"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, alex.bennee@linaro.org, mreitz@redhat.com, qemu-ppc@nongnu.org, lersek@redhat.com

On 2/26/19 8:34 PM, Markus Armbruster wrote:
> Our implementation of "write to buffer" (command 0xE8) is flawed.
> LOG_UNIMP its use, and add some FIXME comments.
> 
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/block/pflash_cfi01.c | 13 +++++++++++++
>  1 file changed, 13 insertions(+)
> 
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index e6d933a06d..d381f14e3c 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -502,6 +502,10 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
>              break;
>          case 0xe8: /* Write to buffer */
>              DPRINTF("%s: Write to buffer\n", __func__);
> +            /* FIXME should save @offset, @width for case 1+ */
> +            qemu_log_mask(LOG_UNIMP,
> +                          "%s: Write to buffer emulation is flawed\n",
> +                          __func__);
>              pfl->status |= 0x80; /* Ready! */
>              break;
>          case 0xf0: /* Probe for AMD flash */
> @@ -545,6 +549,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
>              /* Mask writeblock size based on device width, or bank width if
>               * device width not specified.
>               */
> +            /* FIXME check @offset, @width */
>              if (pfl->device_width) {
>                  value = extract32(value, 0, pfl->device_width * 8);
>              } else {
> @@ -582,7 +587,13 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
>      case 2:
>          switch (pfl->cmd) {
>          case 0xe8: /* Block write */
> +            /* FIXME check @offset, @width */
>              if (!pfl->ro) {
> +                /*
> +                 * FIXME writing straight to memory is *wrong*.  We
> +                 * should write to a buffer, and flush it to memory
> +                 * only on confirm command (see below).
> +                 */
>                  pflash_data_write(pfl, offset, value, width, be);
>              } else {
>                  pfl->status |= 0x10; /* Programming error */
> @@ -598,6 +609,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
>                  pfl->wcycle++;
>                  if (!pfl->ro) {
>                      /* Flush the entire write buffer onto backing storage.  */
> +                    /* FIXME premature! */
>                      pflash_update(pfl, offset & mask, pfl->writeblock_size);
>                  } else {
>                      pfl->status |= 0x10; /* Programming error */
> @@ -614,6 +626,7 @@ static void pflash_write(PFlashCFI01 *pfl, hwaddr offset,
>          switch (pfl->cmd) {
>          case 0xe8: /* Block write */
>              if (cmd == 0xd0) {
> +                /* FIXME this is where we should write out the buffer */

Thanks for all those comments.

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

BTW I'm OK to fix that during next dev window.

Regards,

Phil.

>                  pfl->wcycle = 0;
>                  pfl->status |= 0x80;
>              } else {
> 
