Received: from eggs.gnu.org ([2001:4830:134:3::10]:60299)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gFh5g-0004D4-0P
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:58:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1gFgsz-0006gN-E8
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:45:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1gFgsx-0006et-4l
	for qemu-devel@nongnu.org; Thu, 25 Oct 2018 10:45:20 -0400
Date: Thu, 25 Oct 2018 15:45:04 +0100
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181025154509.219e21bb@Igors-MacBook-Pro.local>
In-Reply-To: <20181023152306.3123-7-david@redhat.com>
References: <20181023152306.3123-1-david@redhat.com>
	<20181023152306.3123-7-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 6/7] memory-device: avoid overflows on
 very huge devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Eduardo Habkost <ehabkost@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Tue, 23 Oct 2018 17:23:05 +0200
David Hildenbrand <david@redhat.com> wrote:

> Should not be a problem right now, but it could theoretically happen
> in the future.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/mem/memory-device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> index 996ad1490f..8be63c8032 100644
> --- a/hw/mem/memory-device.c
> +++ b/hw/mem/memory-device.c
> @@ -85,7 +85,8 @@ static void memory_device_check_addable(MachineState *ms, uint64_t size,
>  
>      /* will we exceed the total amount of memory specified */
>      memory_device_used_region_size(OBJECT(ms), &used_region_size);
> -    if (used_region_size + size > ms->maxram_size - ms->ram_size) {
> +    if (used_region_size + size < used_region_size ||
> +        used_region_size + size > ms->maxram_size - ms->ram_size) {
>          error_setg(errp, "not enough space, currently 0x%" PRIx64
>                     " in use of total space for memory devices 0x" RAM_ADDR_FMT,
>                     used_region_size, ms->maxram_size - ms->ram_size);
