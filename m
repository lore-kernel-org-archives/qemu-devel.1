Received: from eggs.gnu.org ([2001:4830:134:3::10]:39116)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAavv-00050C-Rp
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:51:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fAavq-0003GT-52
	for qemu-devel@nongnu.org; Mon, 23 Apr 2018 08:51:03 -0400
References: <20180420123456.22196-1-david@redhat.com>
	<20180423143147.6b4df2ac@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a3255802-f6fb-1cc3-9734-baaa03cffd28@redhat.com>
Date: Mon, 23 Apr 2018 14:50:43 +0200
MIME-Version: 1.0
In-Reply-To: <20180423143147.6b4df2ac@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 0/3] pc-dimm: factor out MemoryDevice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Pankaj Gupta <pagupta@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Richard Henderson <rth@twiddle.net>

On 23.04.2018 14:31, Igor Mammedov wrote:
> On Fri, 20 Apr 2018 14:34:53 +0200
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> Right now we can only map PCDIMM/NVDIMM into guest address space. In t=
he
>> future, we might want to do the same for virtio devices - e.g.
>> virtio-pmem or virtio-mem. Especially, they should be able to live sid=
e
>> by side to each other.
>>
>> E.g. the virto based memory devices regions will not be exposed via AC=
PI
>> and friends. They will be detected just like other virtio devices and
>> indicate the applicable memory region. This makes it possible to also =
use
>> them on architectures without memory device detection support (e.g. s3=
90x).
>>
>> Let's factor out the memory device code into a MemoryDevice interface.
> A couple of high level questions as relevant code is not here:

Important remark first: We also have s390x with virtio-ccw.

This essentially will also allow s390x guests to have
- memory hotplug via virtio-mem
- fake dax devices via virtio-pmem

>=20
>   1. what would hotplug/unplug call chain look like in case of virtio-p=
mem device
>      (reason I'm asking is that pmem being PCI device would trigger
>       PCI bus hotplug controller and then it somehow should piggyback
>       to Machine provided hotplug handlers, so I wonder what kind of
>       havoc it would cause on hotplug infrastructure)
>=20
>   2. why not use PCI bar mapping mechanism to do mapping since pmem is =
PCI device? =20

pmem might be a PCI device, but virtio-pmem is a virtio device (however
it will be exposed via a proxy)

>=20

I think both questions are best answered by Pankaj (already on CC).

--=20

Thanks,

David / dhildenb
