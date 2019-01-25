Received: from eggs.gnu.org ([209.51.188.92]:53175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gn4T3-0001kS-3j
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 11:36:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gn4T0-0001q5-IV
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 11:36:32 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:39363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gn4Sw-0001oc-Bv
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 11:36:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id t27so10965859wra.6
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 08:36:26 -0800 (PST)
References: <20190125155711.2351-1-stefanha@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <837964ff-1cab-b5c0-9d27-56c317af58e0@redhat.com>
Date: Fri, 25 Jan 2019 17:36:23 +0100
MIME-Version: 1.0
In-Reply-To: <20190125155711.2351-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] pflash: flush rom device memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

On 1/25/19 4:57 PM, Stefan Hajnoczi wrote:
> pflash devices should mark the memory region dirty and invalidate TBs
> after directly writing to the RAM backing the ROM device.
> 
> Note that pflash_cfi01_get_memory() is used by several machine types to
> populate ROM contents directly.  Callers are untouched by this patch
> because they only modify memory before the guest is started.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
> Based-on: <20190123212234.32068-1-stefanha@redhat.com>
> 
> Split from the original patch series.  Philippe asked me to drop the
> flush calls in ->realize() since they are unnecessary.
> 
> Peter: Your ARM tree has the memory_region_flush_rom_device() patch that
> this depends on, so it may be easiest for this to go via your tree.
> 
>  hw/block/pflash_cfi01.c | 3 +++
>  hw/block/pflash_cfi02.c | 6 ++++++
>  2 files changed, 9 insertions(+)
> 
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index bffb4c40e7..2f0b9c4c02 100644
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
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 0f8b7b8c7b..47edce8dcf 100644
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
> 
