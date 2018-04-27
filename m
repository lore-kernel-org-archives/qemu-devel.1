Received: from eggs.gnu.org ([2001:4830:134:3::10]:46047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1fC2cH-0005P1-TZ
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:36:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1fC2cD-0008Nj-1t
	for qemu-devel@nongnu.org; Fri, 27 Apr 2018 08:36:45 -0400
References: <20180427120515.24067-1-david@redhat.com>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <a0539fcb-3d7b-9101-59be-a87c2f7afef8@redhat.com>
Date: Fri, 27 Apr 2018 15:36:25 +0300
MIME-Version: 1.0
In-Reply-To: <20180427120515.24067-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] pc-dimm: fix error messages if no slots
 were defined
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Markus Armbruster <armbru@redhat.com>, qemu-ppc@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Alexander Graf <agraf@suse.de>

On 27/04/2018 15:05, David Hildenbrand wrote:
> If no slots were defined we try to allocate an empty bitmap, which
> fails.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
> 
> v1 -> v2: more detailed error message
> 
>  hw/mem/pc-dimm.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/mem/pc-dimm.c b/hw/mem/pc-dimm.c
> index 0119c68e01..12da89d562 100644
> --- a/hw/mem/pc-dimm.c
> +++ b/hw/mem/pc-dimm.c
> @@ -118,9 +118,16 @@ static int pc_dimm_slot2bitmap(Object *obj, void *opaque)
>  
>  int pc_dimm_get_free_slot(const int *hint, int max_slots, Error **errp)
>  {
> -    unsigned long *bitmap = bitmap_new(max_slots);
> +    unsigned long *bitmap;
>      int slot = 0;
>  
> +    if (max_slots <= 0) {
> +        error_setg(errp, "no slots where allocated, please specify "
> +                   "the 'slots' option");
> +        return slot;
> +    }
> +
> +    bitmap = bitmap_new(max_slots);
>      object_child_foreach(qdev_get_machine(), pc_dimm_slot2bitmap, bitmap);
>  
>      /* check if requested slot is not occupied */
> 

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
