Received: from eggs.gnu.org ([209.51.188.92]:40312)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gn5kX-0006Fc-ET
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 12:58:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gn5kV-0008RJ-Dw
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 12:58:41 -0500
Date: Fri, 25 Jan 2019 17:58:19 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190125175818.GG2695@work-vm>
References: <20190123195527.29575-1-david@redhat.com>
	<20190123195527.29575-8-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190123195527.29575-8-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFCv2 7/9] hmp: Handle virtio-pmem when
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
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Cornelia Huck <cohuck@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Collin Walling <walling@linux.ibm.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-s390x@nongnu.org

* David Hildenbrand (david@redhat.com) wrote:
> Print the memory device info just like for PCDIMM/NVDIMM.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hmp.c | 27 +++++++++++++++------------
>  1 file changed, 15 insertions(+), 12 deletions(-)
> 
> diff --git a/hmp.c b/hmp.c
> index 8da5fd8760..25c32e0810 100644
> --- a/hmp.c
> +++ b/hmp.c
> @@ -2553,6 +2553,7 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
>      Error *err = NULL;
>      MemoryDeviceInfoList *info_list = qmp_query_memory_devices(&err);
>      MemoryDeviceInfoList *info;
> +    VirtioPMEMDeviceInfo *vpi;
>      MemoryDeviceInfo *value;
>      PCDIMMDeviceInfo *di;
>  
> @@ -2562,19 +2563,9 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
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
> +                di = value->type == MEMORY_DEVICE_INFO_KIND_DIMM ?
> +                     value->u.dimm.data : value->u.nvdimm.data;
>                  monitor_printf(mon, "Memory device [%s]: \"%s\"\n",
>                                 MemoryDeviceInfoKind_str(value->type),
>                                 di->id ? di->id : "");
> @@ -2587,6 +2578,18 @@ void hmp_info_memory_devices(Monitor *mon, const QDict *qdict)
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


Although I'd prefer if that assert was replaced by a print
saying it was an unknown type.

Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>              }
>          }
>      }
> -- 
> 2.17.2
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
