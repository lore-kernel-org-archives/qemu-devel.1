Received: from eggs.gnu.org ([2001:4830:134:3::10]:47370)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fI6a4-0006dK-7e
	for qemu-devel@nongnu.org; Mon, 14 May 2018 02:03:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1fI2EX-0004Wx-JL
	for qemu-devel@nongnu.org; Sun, 13 May 2018 21:25:04 -0400
Date: Mon, 14 May 2018 04:24:52 +0300
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180514042436-mutt-send-email-mst@kernel.org>
References: <20180511131953.12905-1-david@redhat.com>
	<20180511131953.12905-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180511131953.12905-2-david@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 01/17] memory-device: drop assert
 related to align and start of address space
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Luiz Capitulino <lcapitulino@redhat.com>

On Fri, May 11, 2018 at 03:19:37PM +0200, David Hildenbrand wrote:
> The start of the address space does not have to be aligned for the
> search. Handly this case explicitly when starting the search for a new
> address.

Handly -> Handle?

> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  hw/mem/memory-device.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> index 3e04f3954e..361d38bfc5 100644
> --- a/hw/mem/memory-device.c
> +++ b/hw/mem/memory-device.c
> @@ -116,7 +116,6 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
>      address_space_start = ms->device_memory->base;
>      address_space_end = address_space_start +
>                          memory_region_size(&ms->device_memory->mr);
> -    g_assert(QEMU_ALIGN_UP(address_space_start, align) == address_space_start);
>      g_assert(address_space_end >= address_space_start);
>  
>      memory_device_check_addable(ms, size, errp);
> @@ -149,7 +148,7 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
>              return 0;
>          }
>      } else {
> -        new_addr = address_space_start;
> +        new_addr = QEMU_ALIGN_UP(address_space_start, align);
>      }
>  
>      /* find address range that will fit new memory device */
> -- 
> 2.14.3
