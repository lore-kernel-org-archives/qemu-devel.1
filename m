Received: from eggs.gnu.org ([2001:4830:134:3::10]:36929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfOxa-0001no-Nw
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 07:15:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dfOxW-0003r3-Br
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 07:15:34 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50674)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dfOxW-0003qi-3q
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 07:15:30 -0400
References: <743158bc-15e4-46fe-38cb-161397b5b240@linaro.org>
	<3685aed3-735f-ae62-73a9-8f4a5c7cd459@redhat.com>
	<9be585e2-4641-329e-f442-69ae05faadba@redhat.com>
	<ea6acc7c-09a6-70ed-9ff0-865bd45a47f3@redhat.com>
	<24fa9f25-912e-8903-920e-b28feba492d2@redhat.com>
	<0f748b72-69de-1122-767d-b36dadad46fc@redhat.com>
	<c03faf70-9bad-aea7-00ed-8825e8770d03@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a8a4eb72-ef1f-1a30-25c5-4f617c7b90a8@redhat.com>
Date: Wed, 9 Aug 2017 13:15:23 +0200
MIME-Version: 1.0
In-Reply-To: <c03faf70-9bad-aea7-00ed-8825e8770d03@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] Qemu and 32 PCIe devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laszlo Ersek <lersek@redhat.com>, qemu-devel@nongnu.org
Cc: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, Marcel Apfelbaum <marcel@redhat.com>, Drew Jones <drjones@redhat.com>, Christoffer Dall <cdall@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Gema Gomez-Solano <gema.gomez-solano@linaro.org>, Marc Zygnier <marc.zyngier@arm.com>

On 09/08/2017 12:56, Laszlo Ersek wrote:
> Allow me one last question -- why (and since when) does each device hav=
e
> its own separate address space? Is that related to the virtual IOMMU?

No (though it helps there too).  It's because a device that has
bus-master DMA disabled in the command register cannot see RAM.

So each device has an address space that is just a huge alias for RAM.
The alias is enabled when bus-master DMA is disabled, and disabled when
bus-master DMA is enabled.

> Now that I look at the "info mtree" monitor output of a random VM, I se=
e
> the following "address-space"s:
> - memory
> - I/O
> - cpu-memory
> - bunch of nameless ones, with top level regions called

here they are :)

>   "bus master container"
> - several named "virtio-pci-cfg-as"
> - KVM-SMRAM
>=20
> I (sort of) understand MemoryRegions and aliases, but:
> - I don't know why "memory" and "cpu-memory" exist separately, for exam=
ple,

cpu-memory is also mostly a huge alias to memory.  But some
architectures may see some areas slightly differently when accessed from
devices vs. CPUs.

For example, the 0xFEE00000 area on x86 accesses the APIC when written
from CPUs and triggers MSIs when written from devices.  Not the best
example because we don't use memory vs. cpu-memory to model it, but it's
an example.

Another example was SMM on TCG; when entering SMM, SMRAM used to be
shown/hidden in cpu-memory (and not in memory).  Nowadays TCG uses a
completely separate address space, like KVM-SMRAM in your example above,
but you can see that cpu-memory can come in handy. :)

> - I seem to remember that the "bunch of nameless ones" has not always
> been there? (I could be totally wrong, of course.)

It's always been there IIRC, it comes from 817dcc536898.

Paolo

> ... There is one address_space_init() call in "hw/pci/pci.c", and it
> comes (most recently) from commit 3716d5902d74 ("pci: introduce a bus
> master container", 2017-03-13). The earliest commit that added it seems
> to be 817dcc536898 ("pci: give each device its own address space",
> 2012-10-03). The commit messages do mention IOMMUs.
>=20
> Thanks!
> Laszlo
>=20
