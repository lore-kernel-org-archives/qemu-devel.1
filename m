Received: from eggs.gnu.org ([2001:4830:134:3::10]:40061)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYdHF-0004wG-9s
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:12:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fYdHC-0000qI-22
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:12:25 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54398 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1fYdHB-0000Sh-TS
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 16:12:21 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B3217A2CDC
	for <qemu-devel@nongnu.org>; Thu, 28 Jun 2018 20:12:15 +0000 (UTC)
References: <1530216310-52873-1-git-send-email-pbonzini@redhat.com>
	<1530216310-52873-30-git-send-email-pbonzini@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <84e14f63-7722-a791-d3a5-b6b9dd6098e5@redhat.com>
Date: Thu, 28 Jun 2018 22:12:14 +0200
MIME-Version: 1.0
In-Reply-To: <1530216310-52873-30-git-send-email-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PULL 29/60] numa: report all DIMM/NVDIMMs as
 plugged memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On 28.06.2018 22:04, Paolo Bonzini wrote:
> From: David Hildenbrand <david@redhat.com>
> 
> Right now, there is some inconsistency between hotplugged and
> coldplugged memory. DIMMs added via "-device" result in different stats
> than DIMMs added using "device_add".
> 
> E.g.
>     [...]
>     -numa node,nodeid=0,cpus=0-1 -numa node,nodeid=1,cpus=2-3 \
>     -m 4G,maxmem=20G,slots=2 \
>     -object memory-backend-ram,id=mem0,size=8G \
>     -device pc-dimm,id=dimm0,memdev=mem0 \
>     -object memory-backend-ram,id=mem1,size=8G \
>     -device nvdimm,id=dimm1,memdev=mem1,node=1
> 
> Results in NUMA info
>     (qemu) info numa
>     info numa
>     2 nodes
>     node 0 cpus: 0 1
>     node 0 size: 10240 MB
>     node 0 plugged: 0 MB
>     node 1 cpus: 2 3
>     node 1 size: 10240 MB
>     node 1 plugged: 0 MB
> 
> But in memory size summary:
>     (qemu) info memory_size_summary
>     info memory_size_summary
>     base memory: 4294967296
>     plugged memory: 17179869184
> 
> Make this consistent by reporting all hot and coldplugged
> memory a.k.a. DIMM and NVDIMM as "plugged".
> 
> Fixes: 31959e82fb0 ("hmp: extend "info numa" with hotplugged memory information")
> Signed-off-by: David Hildenbrand <david@redhat.com>
> Message-Id: <20180622144045.737-1-david@redhat.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  numa.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/numa.c b/numa.c
> index 94f758c..5f6367b 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -566,10 +566,8 @@ static void numa_stat_memory_devices(NumaNodeMem node_mem[])
>  
>              if (pcdimm_info) {
>                  node_mem[pcdimm_info->node].node_mem += pcdimm_info->size;
> -                if (pcdimm_info->hotpluggable && pcdimm_info->hotplugged) {
> -                    node_mem[pcdimm_info->node].node_plugged_mem +=
> -                        pcdimm_info->size;
> -                }
> +                node_mem[pcdimm_info->node].node_plugged_mem +=
> +                    pcdimm_info->size;
>              }
>          }
>      }
> 

There was a v2 with a tweaked description, but the content remained the
same.

-- 

Thanks,

David / dhildenb
