Received: from eggs.gnu.org ([2001:4830:134:3::10]:45363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0PFb-0001K8-Kt
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 06:53:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1g0PFY-0005ml-Es
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 06:53:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33724)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1g0PFV-0005lV-Vd
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 06:53:28 -0400
References: <20180912160118.21158-1-liq3ea@163.com>
	<20180912160118.21158-9-liq3ea@163.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <815540d4-443a-7d8a-cbb5-0155a2a5346f@redhat.com>
Date: Thu, 13 Sep 2018 12:53:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180912160118.21158-9-liq3ea@163.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 8/8] exec: add read callback for notdirty
 memory region
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Li Qiang <liq3ea@163.com>, lersek@redhat.com, marcandre.lureau@gmail.com, ehabkost@redhat.com, mst@redhat.com, peter.maydell@linaro.org, ppandit@redhat.com
Cc: qemu-devel@nongnu.org, Li Qiang <liq3ea@gmail.com>

On 12/09/2018 18:01, Li Qiang wrote:
> From: Li Qiang <liq3ea@gmail.com>
> 
> Signed-off-by: Li Qiang <liq3ea@gmail.com>

This cannot happen, since TLB_NOTDIRTY is only added to the addr_write
member (see accel/tcg/cputlb.c).

Paolo

> ---
>  exec.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/exec.c b/exec.c
> index 6826c8337d..3cd5ad2cae 100644
> --- a/exec.c
> +++ b/exec.c
> @@ -2681,6 +2681,11 @@ void memory_notdirty_write_complete(NotDirtyInfo *ndi)
>      }
>  }
>  
> +static uint64_t notdirty_mem_read(void *opaque, hwaddr addr, unsigned size)
> +{
> +    return 0;
> +}
> +
>  /* Called within RCU critical section.  */
>  static void notdirty_mem_write(void *opaque, hwaddr ram_addr,
>                                 uint64_t val, unsigned size)
> @@ -2702,6 +2707,7 @@ static bool notdirty_mem_accepts(void *opaque, hwaddr addr,
>  }
>  
>  static const MemoryRegionOps notdirty_mem_ops = {
> +    .read = notdirty_mem_read,
>      .write = notdirty_mem_write,
>      .valid.accepts = notdirty_mem_accepts,
>      .endianness = DEVICE_NATIVE_ENDIAN,
> @@ -2965,6 +2971,7 @@ static uint16_t dummy_section(PhysPageMap *map, FlatView *fv, MemoryRegion *mr)
>      return phys_section_add(map, &section);
>  }
>  
> +
>  static void readonly_mem_write(void *opaque, hwaddr addr,
>                                 uint64_t val, unsigned size)
>  {
> 
