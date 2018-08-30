Received: from eggs.gnu.org ([2001:4830:134:3::10]:49418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fvIhi-0003LW-TZ
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 04:53:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fvIhd-0003Cx-N7
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 04:53:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33152 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fvIhc-0003CK-Uo
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 04:53:21 -0400
Date: Thu, 30 Aug 2018 09:53:11 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180830085311.GB2380@work-vm>
References: <20180829153624.12299-1-david@redhat.com>
	<20180829153624.12299-2-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180829153624.12299-2-david@redhat.com>
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
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>

* David Hildenbrand (david@redhat.com) wrote:
> The "at" should actually be a "before".
>     if (new_addr < address_space_start)
>      -> "can't add memory ... before... $address_space_start"
> 
> So it looks similar to the other check
>     } else if ((new_addr + size) > address_space_end)
>      -> "can't add memory ... beyond..."
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
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

OK, so


Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

>              return 0;
>          } else if ((new_addr + size) > address_space_end) {

That comparison (that's already there) doesn't look wrap-safe?

Dave
>              error_setg(errp, "can't add memory [0x%" PRIx64 ":0x%" PRIx64

> -- 
> 2.17.1
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
