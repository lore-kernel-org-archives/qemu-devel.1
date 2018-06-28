Received: from eggs.gnu.org ([2001:4830:134:3::10]:51149)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYTJP-0004FZ-Ri
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 05:34:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fYTJM-0007HR-OG
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 05:33:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35976 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fYTJM-0007G6-HZ
	for qemu-devel@nongnu.org; Thu, 28 Jun 2018 05:33:56 -0400
Date: Thu, 28 Jun 2018 11:33:53 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180628113353.6c65459a@redhat.com>
In-Reply-To: <20180628090011.14879-1-david@redhat.com>
References: <20180628090011.14879-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] numa: report all DIMM/NVDIMMs as
 plugged in "info numa"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Eugene Crosser <evgenii.cherkashin@profitbricks.com>, Vadim Galitsyn <vadim.galitsyn@profitbricks.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 28 Jun 2018 11:00:11 +0200
David Hildenbrand <david@redhat.com> wrote:

> Right now, there is some inconsistency between hotplugged and
> coldplugged memory. DIMMs added via "-device" result in different stats
> than DIMMs added using "device_add".
> 
> E.g. with the following QEMU cmdline:
>     [...]
>     -numa node,nodeid=0,cpus=0-1 -numa node,nodeid=1,cpus=2-3 \
>     -m 4G,maxmem=20G,slots=2 \
>     -object memory-backend-ram,id=mem0,size=8G \
>     -device pc-dimm,id=dimm0,memdev=mem0 \
>     -object memory-backend-ram,id=mem1,size=8G \
>     -device nvdimm,id=dimm1,memdev=mem1,node=1
> 
> "info memory_size_summary" will correctly report:
>     (qemu) info memory_size_summary
>     info memory_size_summary
>     base memory: 4294967296
>     plugged memory: 17179869184
> 
> While "info numa" will not report DIMM/NVDIMMs as (cold)plugged memory.
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
> Make this consistent by reporting all hot and coldplugged memory a.k.a.
> DIMM and NVDIMM as "plugged".
> 
> With this change, the output of "info numa" is now:
>     (qemu) info numa
>     info numa
>     2 nodes
>     node 0 cpus: 0 1
>     node 0 size: 10240 MB
>     node 0 plugged: 8192 MB
>     node 1 cpus: 2 3
>     node 1 size: 10240 MB
>     node 1 plugged: 8192 MB
> 
> Fixes: 31959e82fb0 ("hmp: extend "info numa" with hotplugged memory information")
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
> 
> v1 -> v2:
> - Tweaked patch description/sibject as requested by Igor.
> 
>  numa.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/numa.c b/numa.c
> index 94f758c757..5f6367b989 100644
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
