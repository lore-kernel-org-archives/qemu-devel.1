Received: from eggs.gnu.org ([209.51.188.92]:49545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmcvP-0006Ef-IE
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:12:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gmcvO-0001og-LU
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:11:59 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:45788)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gmcvO-0001mF-Es
	for qemu-devel@nongnu.org; Thu, 24 Jan 2019 06:11:58 -0500
Received: by mail-wr1-f65.google.com with SMTP id t6so5960917wrr.12
	for <qemu-devel@nongnu.org>; Thu, 24 Jan 2019 03:11:58 -0800 (PST)
References: <20190123212234.32068-1-stefanha@redhat.com>
	<20190123212234.32068-3-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <f58f9085-c895-1fa5-9fae-afe4ac8de39a@redhat.com>
Date: Thu, 24 Jan 2019 12:11:55 +0100
MIME-Version: 1.0
In-Reply-To: <20190123212234.32068-3-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/5] pflash: flush rom device memory
 region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <lvivier@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>, jim@groklearning.com, Max Reitz <mreitz@redhat.com>, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, jusual@mail.ru, Richard Henderson <rth@twiddle.net>

Hi Stefan,

On 1/23/19 10:22 PM, Stefan Hajnoczi wrote:
> pflash devices should mark the memory region dirty and invalidate TBs
> after directly writing to the RAM backing the ROM device.
> 
> Note that pflash_cfi01_get_memory() is used by several machine types to
> populate ROM contents directly.  Callers are untouched by this patch
> because they only modify memory before the guest is started.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/block/pflash_cfi01.c | 5 +++++
>  hw/block/pflash_cfi02.c | 8 ++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index bffb4c40e7..5301c11c18 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -446,6 +446,7 @@ static inline void pflash_data_write(pflash_t *pfl, hwaddr offset,
>          break;
>      }
>  
> +    memory_region_flush_rom_device(&pfl->mem, offset, width);
>  }
>  
>  static void pflash_write(pflash_t *pfl, hwaddr offset,
> @@ -482,6 +483,8 @@ static void pflash_write(pflash_t *pfl, hwaddr offset,
>              if (!pfl->ro) {
>                  memset(p + offset, 0xff, pfl->sector_len);
>                  pflash_update(pfl, offset, pfl->sector_len);
> +                memory_region_flush_rom_device(&pfl->mem, offset,
> +                                               pfl->sector_len);
>              } else {
>                  pfl->status |= 0x20; /* Block erase error */
>              }
> @@ -763,6 +766,8 @@ static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
>              error_setg(errp, "failed to read the initial flash content");
>              return;
>          }
> +
> +        memory_region_flush_rom_device(&pfl->mem, 0, total_len);

The device realize() is also executed before the guest is started, is
this call really necessary?

>      }
>  
>      /* Default to devices being used at their maximum device width. This was
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 0f8b7b8c7b..d04572eca4 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -378,6 +378,8 @@ static void pflash_write (pflash_t *pfl, hwaddr offset,
>                      pflash_update(pfl, offset, 4);
>                      break;
>                  }
> +
> +                memory_region_flush_rom_device(&pfl->orig_mem, offset, width);
>              }
>              pfl->status = 0x00 | ~(value & 0x80);
>              /* Let's pretend write is immediate */
> @@ -426,6 +428,8 @@ static void pflash_write (pflash_t *pfl, hwaddr offset,
>              if (!pfl->ro) {
>                  memset(pfl->storage, 0xFF, pfl->chip_len);
>                  pflash_update(pfl, 0, pfl->chip_len);
> +                memory_region_flush_rom_device(&pfl->orig_mem, 0,
> +                                               pfl->chip_len);
>              }
>              pfl->status = 0x00;
>              /* Let's wait 5 seconds before chip erase is done */
> @@ -441,6 +445,8 @@ static void pflash_write (pflash_t *pfl, hwaddr offset,
>              if (!pfl->ro) {
>                  memset(p + offset, 0xFF, pfl->sector_len);
>                  pflash_update(pfl, offset, pfl->sector_len);
> +                memory_region_flush_rom_device(&pfl->orig_mem, offset,
> +                                               pfl->sector_len);
>              }
>              pfl->status = 0x00;
>              /* Let's wait 1/2 second before sector erase is done */
> @@ -590,6 +596,8 @@ static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
>              error_setg(errp, "failed to read the initial flash content");
>              return;
>          }
> +
> +        memory_region_flush_rom_device(&pfl->orig_mem, 0, chip_len);

Ditto.

>      }
>  
>      pflash_setup_mappings(pfl);
> 
