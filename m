Received: from eggs.gnu.org ([2001:4830:134:3::10]:60867)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eihZz-0002YH-Cu
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:17:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eihZw-0007qn-5y
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:17:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:28830)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1eihZv-0007qM-VZ
	for qemu-devel@nongnu.org; Mon, 05 Feb 2018 09:17:04 -0500
References: <20180203103727.26457-1-mark.cave-ayland@ilande.co.uk>
	<20180203103727.26457-2-mark.cave-ayland@ilande.co.uk>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <1f833824-3bb4-3ac7-71c4-4d2db47b82f5@redhat.com>
Date: Mon, 5 Feb 2018 15:17:00 +0100
MIME-Version: 1.0
In-Reply-To: <20180203103727.26457-2-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 01/10] cuda: do not use old_mmio accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org

On 03/02/2018 11:37, Mark Cave-Ayland wrote:
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/misc/macio/cuda.c | 40 ++++++++--------------------------------
>  1 file changed, 8 insertions(+), 32 deletions(-)
> 
> diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
> index 008d8bd4d5..23b7e0f5b0 100644
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
> -    },
> +    .read = cuda_read,
> +    .write = cuda_write,
>      .endianness = DEVICE_NATIVE_ENDIAN,

As CUDA Macintoshes are all big-endian, I think you should use
DEVICE_BIG_ENDIAN here, except if you are aware of a little-endian
machine using it in little-endian mode.

Thanks,
Laurent
