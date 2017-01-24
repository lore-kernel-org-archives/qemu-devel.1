Received: from eggs.gnu.org ([2001:4830:134:3::10]:40638)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cW4iJ-0006Ki-LD
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:17:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1cW4iE-0006e0-Mk
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:16:59 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33314)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lvivier@redhat.com>) id 1cW4iE-0006dq-Gk
	for qemu-devel@nongnu.org; Tue, 24 Jan 2017 12:16:54 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 930077FE8D
	for <qemu-devel@nongnu.org>; Tue, 24 Jan 2017 17:16:54 +0000 (UTC)
References: <1485277734-16871-1-git-send-email-mst@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Message-ID: <12951919-67c3-50b6-22ae-1bb63b3062e4@redhat.com>
Date: Tue, 24 Jan 2017 18:16:46 +0100
MIME-Version: 1.0
In-Reply-To: <1485277734-16871-1-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vhost: skip ROM sections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org

On 24/01/2017 18:11, Michael S. Tsirkin wrote:
> vhost does not support RO protections on memory at the moment - adding
> ROMs would mean that e.g. a buggy guest might change them in-memory - a
> condition from which guest reset does not recover. Not nice.
> 
> We also definitely don't want to try logging writes into ROMs - in
> particular guests set very high addresses for ROM BARs so logging these
> writes would waste a lot of memory.  With phys address in the 32T range
> we would need 1Gbyte sized log - scanning it would take ages, and
> allocating such huge amount of log memory was also reported to fail on
> powerpc.
> 
> Maybe ROMs could be supported with the iotlb variant -
> not sure, but there seems to be no good reason for virtio
> to try to do DMA from ROM. So let's just skip ROM memory.
> 
> Suggested-by: Laurent Vivier <lvivier@redhat.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Laurent Vivier <lvivier@redhat.com>
Tested-by: Laurent Vivier <lvivier@redhat.com>

> ---
>  hw/virtio/vhost.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/virtio/vhost.c b/hw/virtio/vhost.c
> index 9cacf55..94b8c4a 100644
> --- a/hw/virtio/vhost.c
> +++ b/hw/virtio/vhost.c
> @@ -612,7 +612,8 @@ static void vhost_set_memory(MemoryListener *listener,
>  
>  static bool vhost_section(MemoryRegionSection *section)
>  {
> -    return memory_region_is_ram(section->mr);
> +    return memory_region_is_ram(section->mr) &&
> +        !memory_region_is_rom(section->mr);
>  }
>  
>  static void vhost_begin(MemoryListener *listener)
> 
