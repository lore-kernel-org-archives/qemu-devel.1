Received: from eggs.gnu.org ([209.51.188.92]:35968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw96K-0005qk-7c
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:22:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gw96I-0002Xd-Eb
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:22:36 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:37181)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gw96I-0002St-40
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 12:22:34 -0500
Received: by mail-wm1-f66.google.com with SMTP id x10so3596840wmg.2
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 09:22:26 -0800 (PST)
References: <20190219153727.62279-1-stephen.checkoway@oberlin.edu>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <94a5fb9b-0e86-fe7b-9a29-f62838300420@redhat.com>
Date: Tue, 19 Feb 2019 18:22:24 +0100
MIME-Version: 1.0
In-Reply-To: <20190219153727.62279-1-stephen.checkoway@oberlin.edu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] block/pflash_cfi02: Fix memory leak and
 potential use-after-free
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stephen Checkoway <stephen.checkoway@oberlin.edu>, qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, Kevin Wolf <kwolf@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>, Markus Armbruster <armbru@redhat.com>

On 2/19/19 4:37 PM, Stephen Checkoway wrote:
> Don't dynamically allocate the pflash's timer. But do use timer_del in
> an unrealize function to make sure that the timer can't fire after the
> pflash_t has been freed.
> 
> Signed-off-by: Stephen Checkoway <stephen.checkoway@oberlin.edu>
> ---
>  hw/block/pflash_cfi02.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 0f8b7b8c7b..1588aeff5a 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -84,7 +84,7 @@ struct pflash_t {
>      uint16_t unlock_addr0;
>      uint16_t unlock_addr1;
>      uint8_t cfi_table[0x52];
> -    QEMUTimer *timer;
> +    QEMUTimer timer;
>      /* The device replicates the flash memory across its memory space.  Emulate
>       * that by having a container (.mem) filled with an array of aliases
>       * (.mem_mappings) pointing to the flash memory (.orig_mem).
> @@ -429,7 +429,7 @@ static void pflash_write (pflash_t *pfl, hwaddr offset,
>              }
>              pfl->status = 0x00;
>              /* Let's wait 5 seconds before chip erase is done */
> -            timer_mod(pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +            timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
>                        (NANOSECONDS_PER_SECOND * 5));
>              break;
>          case 0x30:
> @@ -444,7 +444,7 @@ static void pflash_write (pflash_t *pfl, hwaddr offset,
>              }
>              pfl->status = 0x00;
>              /* Let's wait 1/2 second before sector erase is done */
> -            timer_mod(pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
> +            timer_mod(&pfl->timer, qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) +
>                        (NANOSECONDS_PER_SECOND / 2));
>              break;
>          default:
> @@ -596,7 +596,7 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
>      pfl->rom_mode = 1;
>      sysbus_init_mmio(SYS_BUS_DEVICE(dev), &pfl->mem);
>  
> -    pfl->timer = timer_new_ns(QEMU_CLOCK_VIRTUAL, pflash_timer, pfl);
> +    timer_init_ns(&pfl->timer, QEMU_CLOCK_VIRTUAL, pflash_timer, pfl);

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

>      pfl->wcycle = 0;
>      pfl->cmd = 0;
>      pfl->status = 0;
> @@ -695,11 +695,18 @@ static Property pflash_cfi02_properties[] = {
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> +static void pflash_cfi02_unrealize(DeviceState *dev, Error **errp)
> +{
> +    pflash_t *pfl = CFI_PFLASH02(dev);
> +    timer_del(&pfl->timer);
> +}
> +
>  static void pflash_cfi02_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
>      dc->realize = pflash_cfi02_realize;
> +    dc->unrealize = pflash_cfi02_unrealize;
>      dc->props = pflash_cfi02_properties;
>      set_bit(DEVICE_CATEGORY_STORAGE, dc->categories);
>  }
> 
