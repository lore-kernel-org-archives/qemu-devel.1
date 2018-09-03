Received: from eggs.gnu.org ([2001:4830:134:3::10]:49306)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fwovR-0006Zt-6I
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 09:29:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1fwovN-0003kC-WA
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 09:29:53 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46810 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1fwovN-0003jo-QO
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 09:29:49 -0400
Date: Mon, 3 Sep 2018 15:29:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180903152941.185efb26@redhat.com>
In-Reply-To: <20180829153624.12299-2-david@redhat.com>
References: <20180829153624.12299-1-david@redhat.com>
	<20180829153624.12299-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 01/20] memory-device: fix error message
 when hinted address is too small
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>

On Wed, 29 Aug 2018 17:36:05 +0200
David Hildenbrand <david@redhat.com> wrote:

> The "at" should actually be a "before".
>     if (new_addr < address_space_start)
>      -> "can't add memory ... before... $address_space_start"  
> 
> So it looks similar to the other check
>     } else if ((new_addr + size) > address_space_end)
>      -> "can't add memory ... beyond..."  
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/mem/memory-device.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/mem/memory-device.c b/hw/mem/memory-device.c
> index 6de4f70bb4..efacbc2a7d 100644
> --- a/hw/mem/memory-device.c
> +++ b/hw/mem/memory-device.c
> @@ -146,7 +146,8 @@ uint64_t memory_device_get_free_addr(MachineState *ms, const uint64_t *hint,
>          new_addr = *hint;
>          if (new_addr < address_space_start) {
>              error_setg(errp, "can't add memory [0x%" PRIx64 ":0x%" PRIx64
> -                       "] at 0x%" PRIx64, new_addr, size, address_space_start);
> +                       "] before 0x%" PRIx64, new_addr, size,
> +                       address_space_start);
>              return 0;
>          } else if ((new_addr + size) > address_space_end) {
>              error_setg(errp, "can't add memory [0x%" PRIx64 ":0x%" PRIx64
