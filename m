Received: from eggs.gnu.org ([2001:4830:134:3::10]:60579)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g6yOI-0006FM-RD
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 09:37:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1g6yOE-0008RW-KI
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 09:37:38 -0400
Date: Mon, 1 Oct 2018 15:37:18 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20181001153718.4ed97bd3@redhat.com>
In-Reply-To: <20180926094219.20322-20-david@redhat.com>
References: <20180926094219.20322-1-david@redhat.com>
	<20180926094219.20322-20-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 19/24] virtio-pmem: prototype
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Pankaj Gupta <pagupta@redhat.com>, Luiz Capitulino <lcapitul@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>

On Wed, 26 Sep 2018 11:42:14 +0200
David Hildenbrand <david@redhat.com> wrote:

> From: Pankaj Gupta <pagupta@redhat.com>
> 
> This is the current protoype of virtio-pmem. Support will require
> machine changes for the architectures that will support it, so it will
> not yet be compiled.
> 
> Signed-off-by: Pankaj Gupta <pagupta@redhat.com>
> [ MemoryDevice/MemoryRegion changes, cleanups, addr property "memaddr",
>   split up patches ]
> Signed-off-by: David Hildenbrand <david@redhat.com>
not an actual review, but a small nit/no/ below

[...]
> +
> +static const char *virtio_pmem_md_get_device_id(const MemoryDeviceState *md)
> +{
> +    Object *obj = OBJECT(md);
> +
> +    /* always return the ID of the proxy device the user configured */
> +    if (obj->parent && object_dynamic_cast(obj->parent, TYPE_DEVICE)) {
> +        const DeviceState *parent_dev = DEVICE(obj->parent);
> +
> +        return parent_dev->id;
It's layer violation, child device shouldn't ever access it's parent fields,
in general it's not acceptable practice.
To workaround parent could set a property for a child with this id to use,
but I'm not sure if it would work in this case.

Anyways you might not need this callback at all if proxy would implement
memory-device interface as mentioned in another comment.


> +    }
> +    return NULL;
> +}
> +
[...]
