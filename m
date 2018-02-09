Received: from eggs.gnu.org ([2001:4830:134:3::10]:59247)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ekEvQ-0002yb-VI
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:05:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ekEvP-0003G6-NQ
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 15:05:36 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180209185142.17151-1-mark.cave-ayland@ilande.co.uk>
	<20180209185142.17151-2-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <bb007cd9-8733-f8ee-2529-438a27c5b973@amsat.org>
Date: Fri, 9 Feb 2018 17:05:23 -0300
MIME-Version: 1.0
In-Reply-To: <20180209185142.17151-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv2 01/12] cuda: do not use old_mmio accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au, lvivier@redhat.com

Hi Mark,

On 02/09/2018 03:51 PM, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/misc/macio/cuda.c | 40 ++++++++--------------------------------
>  1 file changed, 8 insertions(+), 32 deletions(-)
> 
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index 008d8bd4d5..6631017ca2 100644
> --- a/hw/misc/macio/cuda.c
> +++ b/hw/misc/macio/cuda.c
> @@ -275,7 +275,7 @@ static void cuda_delay_set_sr_int(CUDAState *s)
>      timer_mod(s->sr_delay_timer, expire);
>  }
>  
> -static uint32_t cuda_readb(void *opaque, hwaddr addr)
> +static uint64_t cuda_read(void *opaque, hwaddr addr, unsigned size)
>  {
>      CUDAState *s = opaque;
>      uint32_t val;
> @@ -350,7 +350,7 @@ static uint32_t cuda_readb(void *opaque, hwaddr addr)
>      return val;
>  }
>  
> -static void cuda_writeb(void *opaque, hwaddr addr, uint32_t val)
> +static void cuda_write(void *opaque, hwaddr addr, uint64_t val, unsigned size)
>  {
>      CUDAState *s = opaque;
>  
> @@ -780,38 +780,14 @@ static void cuda_receive_packet_from_host(CUDAState *s,
>      }
>  }
>  
> -static void cuda_writew (void *opaque, hwaddr addr, uint32_t value)
> -{
> -}
> -
> -static void cuda_writel (void *opaque, hwaddr addr, uint32_t value)
> -{
> -}
> -
> -static uint32_t cuda_readw (void *opaque, hwaddr addr)
> -{
> -    return 0;
> -}
> -
> -static uint32_t cuda_readl (void *opaque, hwaddr addr)
> -{
> -    return 0;
> -}
> -
>  static const MemoryRegionOps cuda_ops = {
> -    .old_mmio = {
> -        .write = {
> -            cuda_writeb,
> -            cuda_writew,
> -            cuda_writel,
> -        },
> -        .read = {
> -            cuda_readb,
> -            cuda_readw,
> -            cuda_readl,
> -        },
> +    .read = cuda_read,
> +    .write = cuda_write,
> +    .endianness = DEVICE_BIG_ENDIAN,
> +    .valid = {

This change the device behavior, previously 16/32bit access were
ignored, now they are illegal.

Using ".impl" instead also change the behavior, since 16/32bits access
would be processed (as 2x or 4x 8bit access).

A comment "this change is safe because ..." would reassure me ;)

> +        .min_access_size = 1,
> +        .max_access_size = 1,
>      },
> -    .endianness = DEVICE_NATIVE_ENDIAN,
>  };
>  
>  static bool cuda_timer_exist(void *opaque, int version_id)
> 
