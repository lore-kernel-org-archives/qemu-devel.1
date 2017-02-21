Received: from eggs.gnu.org ([2001:4830:134:3::10]:38031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cgDC8-0002jm-QI
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:21:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1cgDC7-0008Q1-Tl
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:21:40 -0500
Received: from mx1.redhat.com ([209.132.183.28]:42938)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <alex.williamson@redhat.com>)
	id 1cgDC7-0008Pq-Kw
	for qemu-devel@nongnu.org; Tue, 21 Feb 2017 11:21:39 -0500
Date: Tue, 21 Feb 2017 09:21:37 -0700
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20170221092137.5b6cecbb@t450s.home>
In-Reply-To: <1487659615-15820-1-git-send-email-xyjxie@linux.vnet.ibm.com>
References: <1487659615-15820-1-git-send-email-xyjxie@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] memory: make ram device read/write endian
 sensitive
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yongji Xie <xyjxie@linux.vnet.ibm.com>
Cc: pbonzini@redhat.com, qemu-devel@nongnu.org, aik@ozlabs.ru, zhong@linux.vnet.ibm.com

On Tue, 21 Feb 2017 14:46:55 +0800
Yongji Xie <xyjxie@linux.vnet.ibm.com> wrote:

> At the moment ram device's memory regions are NATIVE_ENDIAN. This does
> not work on PPC64 because VFIO PCI device is little endian but PPC64
> always defines static macro TARGET_WORDS_BIGENDIAN.
> 
> This fixes endianness for ram device the same way as it is done
> for VFIO region in commit 6758008e2c4e79fb6bd04fe8e7a41665fa583965.

The referenced commit was to vfio code where the endianness is fixed,
here you're modifying shared generic code to assume the same
endianness as vfio.  That seems wrong.  Should
memory_region_init_ram_device_ptr() instead take an endian option and
ram_device_mem_ops should take the backing endianness into account?
Thanks,

Alex
 
> Signed-off-by: Yongji Xie <xyjxie@linux.vnet.ibm.com>
> ---
>  memory.c |   14 +++++++-------
>  1 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/memory.c b/memory.c
> index 6c58373..1ccb99f 100644
> --- a/memory.c
> +++ b/memory.c
> @@ -1139,13 +1139,13 @@ static uint64_t memory_region_ram_device_read(void *opaque,
>          data = *(uint8_t *)(mr->ram_block->host + addr);
>          break;
>      case 2:
> -        data = *(uint16_t *)(mr->ram_block->host + addr);
> +        data = le16_to_cpu(*(uint16_t *)(mr->ram_block->host + addr));
>          break;
>      case 4:
> -        data = *(uint32_t *)(mr->ram_block->host + addr);
> +        data = le32_to_cpu(*(uint32_t *)(mr->ram_block->host + addr));
>          break;
>      case 8:
> -        data = *(uint64_t *)(mr->ram_block->host + addr);
> +        data = le64_to_cpu(*(uint64_t *)(mr->ram_block->host + addr));
>          break;
>      }
>  
> @@ -1166,13 +1166,13 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
>          *(uint8_t *)(mr->ram_block->host + addr) = (uint8_t)data;
>          break;
>      case 2:
> -        *(uint16_t *)(mr->ram_block->host + addr) = (uint16_t)data;
> +        *(uint16_t *)(mr->ram_block->host + addr) = cpu_to_le16((uint16_t)data);
>          break;
>      case 4:
> -        *(uint32_t *)(mr->ram_block->host + addr) = (uint32_t)data;
> +        *(uint32_t *)(mr->ram_block->host + addr) = cpu_to_le32((uint32_t)data);
>          break;
>      case 8:
> -        *(uint64_t *)(mr->ram_block->host + addr) = data;
> +        *(uint64_t *)(mr->ram_block->host + addr) = cpu_to_le64(data);
>          break;
>      }
>  }
> @@ -1180,7 +1180,7 @@ static void memory_region_ram_device_write(void *opaque, hwaddr addr,
>  static const MemoryRegionOps ram_device_mem_ops = {
>      .read = memory_region_ram_device_read,
>      .write = memory_region_ram_device_write,
> -    .endianness = DEVICE_NATIVE_ENDIAN,
> +    .endianness = DEVICE_LITTLE_ENDIAN,
>      .valid = {
>          .min_access_size = 1,
>          .max_access_size = 8,
