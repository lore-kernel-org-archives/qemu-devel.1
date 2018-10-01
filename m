Received: from eggs.gnu.org ([2001:4830:134:3::10]:50993)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1g73O4-00016A-H8
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 14:57:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1g73O1-0001u1-BT
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 14:57:44 -0400
Date: Mon, 1 Oct 2018 19:57:27 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20181001185726.GD24231@work-vm>
References: <20180926094219.20322-1-david@redhat.com>
	<20180926094219.20322-22-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180926094219.20322-22-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 21/24] hmp: handle virtio-pmem when
 printing memory device infos
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
> Print the memory device info just like for PCDIMM/NVDIMM.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

> ---
>  hmp.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index 3a9f797677..159f82e155 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -2532,6 +2532,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>      Error *err = NULL;
>      MemoryDeviceInfoList *info_list = qmp_query_memory_devices(&err);
>      MemoryDeviceInfoList *info;
> +    VirtioPMemDeviceInfo *vpi;
>      MemoryDeviceInfo *value;
>      PCDIMMDeviceInfo *di;
>  
> @@ -2541,19 +2542,9 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>          if (value) {
>              switch (value->type) {
>              case MEMORY_DEVICE_INFO_KIND_DIMM:
> -                di = value->u.dimm.data;
> -                break;
> -
>              case MEMORY_DEVICE_INFO_KIND_NVDIMM:
> -                di = value->u.nvdimm.data;
> -                break;
> -
> -            default:
> -                di = NULL;
> -                break;
> -            }
> -
> -            if (di) {
> +                di = (value->type == MEMORY_DEVICE_INFO_KIND_DIMM) ?
> +                     value->u.dimm.data : value->u.nvdimm.data;
>                  monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
>                                 MemoryDeviceInfoKind_str(value->type),
>                                 di->id ? di->id : "");
> @@ -2566,6 +2557,18 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>                                 di->hotplugged ? "true" : "false");
>                  monitor_printf(mon, "  hotpluggable: %s\n",
>                                 di->hotpluggable ? "true" : "false");
> +                break;
> +            case MEMORY_DEVICE_INFO_KIND_VIRTIO_PMEM:
> +                vpi = value->u.virtio_pmem.data;
> +                monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
> +                               MemoryDeviceInfoKind_str(value->type),
> +                               vpi->id ? vpi->id : "");
> +                monitor_printf(mon, "  memaddr: 0x%" PRIx64 "\n", vpi->memaddr);
> +                monitor_printf(mon, "  size: %" PRIu64 "\n", vpi->size);
> +                monitor_printf(mon, "  memdev: %s\n", vpi->memdev);
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
