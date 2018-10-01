Received: from eggs.gnu.org ([2001:4830:134:3::10]:51237)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1g73Pm-0001nL-9W
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 14:59:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1g73Pj-000329-3F
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 14:59:30 -0400
Date: Mon, 1 Oct 2018 19:59:08 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181001185907.GE24231@work-vm>
References: <20180926094219.20322-1-david@redhat.com>
	<20180926094219.20322-23-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926094219.20322-23-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 22/24] numa: handle virtio-pmem in NUMA
 stats
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

* David Hildenbrand (david@redhat.com) wrote:
> Account the memory to node 0 for now. Once (if ever) virtio-pmem
> supports NUMA, we can account it to the right node.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  numa.c | 24 ++++++++++++------------
>  1 file changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/numa.c b/numa.c
> index 81542d4ebb..1ff1418c1e 100644
> --- a/numa.c
> +++ b/numa.c
> @@ -545,6 +545,7 @@ static void numa_stat_memory_devices(NumaNodeMem node_mem[])
>      MemoryDeviceInfoList *info_list = qmp_memory_device_list();
>      MemoryDeviceInfoList *info;
>      PCDIMMDeviceInfo     *pcdimm_info;
> +    VirtioPMemDeviceInfo *vpi;
>  
>      for (info = info_list; info; info = info->next) {
>          MemoryDeviceInfo *value = info->value;
> @@ -552,22 +553,21 @@ static void numa_stat_memory_devices(NumaNodeMem node_mem[])
>          if (value) {
>              switch (value->type) {
>              case MEMORY_DEVICE_INFO_KIND_DIMM:
> -                pcdimm_info = value->u.dimm.data;
> -                break;
> -
>              case MEMORY_DEVICE_INFO_KIND_NVDIMM:
> -                pcdimm_info = value->u.nvdimm.data;
> -                break;
> -
> -            default:
> -                pcdimm_info = NULL;
> -                break;
> -            }
> -
> -            if (pcdimm_info) {
> +                pcdimm_info = (value->type == MEMORY_DEVICE_INFO_KIND_DIMM) ?
> +                              value->u.dimm.data : value->u.nvdimm.data;
>                  node_mem[pcdimm_info->node].node_mem += pcdimm_info->size;
>                  node_mem[pcdimm_info->node].node_plugged_mem +=
>                      pcdimm_info->size;
> +                break;
> +            case MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM:
> +                vpi = value->u.virtio_pmem.data;
> +                /* TODO: once we support numa, assign to right node */
> +                node_mem[0].node_mem += vpi->size;
> +                node_mem[0].node_plugged_mem += vpi->size;
> +                break;
> +            default:
> +                g_assert_not_reached();
>              }
>          }
>      }
> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
