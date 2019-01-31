Received: from eggs.gnu.org ([209.51.188.92]:59013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpGw6-0001DD-Au
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:19:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gpGw5-00075r-Gg
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 13:19:38 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190123195527.29575-1-david@redhat.com>
	<20190123195527.29575-5-david@redhat.com>
Date: Thu, 31 Jan 2019 19:19:28 +0100
In-Reply-To: <20190123195527.29575-5-david@redhat.com> (David Hildenbrand's
	message of "Wed, 23 Jan 2019 20:55:22 +0100")
Message-ID: <87imy4vgen.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH RFCv2 4/9] virtio-pmem: Prototype
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, Pankaj Gupta <pagupta@redhat.com>, Collin Walling <walling@linux.ibm.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Halil Pasic <pasic@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

David Hildenbrand <david@redhat.com> writes:

> From: Pankaj Gupta <pagupta@redhat.com>
>
> This is the current protoype of virtio-pmem. Support will require
> machine changes for the architectures that will support it, so it will
> not yet be compiled.
>
> TODO:
> - Use separate struct for tracking requests internally
> - Move request/response structs to linux headers
> - Factor out linux header sync
> - Drop debug printfs
>
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> [ MemoryDevice/MemoryRegion changes, cleanups, addr property "memaddr",
>   split up patches, unplug handler ]
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
[...]
> diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
> index 6d5c3b2d4f..346389565a 100644
> --- a/include/standard-headers/linux/virtio_ids.h
> +++ b/include/standard-headers/linux/virtio_ids.h
> @@ -43,5 +43,6 @@
>  #define VIRTIO_ID_INPUT        18 /* virtio input */
>  #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
>  #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
> +#define VIRTIO_ID_PMEM         25 /* virtio pmem */
>  
>  #endif /* _LINUX_VIRTIO_IDS_H */
> diff --git a/qapi/misc.json b/qapi/misc.json
> index 24d20a880a..b71eca2666 100644
> --- a/qapi/misc.json
> +++ b/qapi/misc.json
> @@ -2949,16 +2949,42 @@
>            }
>  }
>  
> +##
> +# @VirtioPMEMDeviceInfo:
> +#
> +# VirtioPMEM state information
> +#
> +# @id: device's ID
> +#
> +# @memaddr: physical address in memory, where device is mapped
> +#
> +# @size: size of memory that the device provides
> +#
> +# @memdev: memory backend linked with device
> +#
> +# Since: 4.0
> +##

This is like PCDIMMDeviceInfo less @slot, @node, @hotplugged,
@hotpluggable, and with @addr renamed to @memaddr.

Any particular reason for the rename?

> +{ 'struct': 'VirtioPMEMDeviceInfo',
> +  'data': { '*id': 'str',
> +            'memaddr': 'size',
> +            'size': 'size',
> +            'memdev': 'str'
> +          }
> +}
> +
>  ##
>  # @MemoryDeviceInfo:
>  #
>  # Union containing information about a memory device
>  #
> +# nvdimm is included since 2.12. virtio-pmem is included since 4.0.
> +#

Let's stick to the way we document similar things elsewhere:

   # @nvdimm: since 2.12
   #
   # @virtio-pmem: since 4.0
   #

>  # Since: 2.1
>  ##
>  { 'union': 'MemoryDeviceInfo',
>    'data': { 'dimm': 'PCDIMMDeviceInfo',
> -            'nvdimm': 'PCDIMMDeviceInfo'
> +            'nvdimm': 'PCDIMMDeviceInfo',
> +            'virtio-pmem': 'VirtioPMEMDeviceInfo'
>            }
>  }
