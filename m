Received: from eggs.gnu.org ([2001:4830:134:3::10]:57415)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dHSpw-0002wL-L4
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 06:32:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1dHSpr-0006kk-Pv
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 06:32:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:46528)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1dHSpr-0006hQ-Ha
	for qemu-devel@nongnu.org; Sun, 04 Jun 2017 06:32:39 -0400
Message-ID: <5933E245.3030903@intel.com>
Date: Sun, 04 Jun 2017 18:34:45 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <7ff05785-6bca-a886-0eb0-aeeb0f8d8e1a@redhat.com>
	<5923CCF2.2000001@intel.com>
	<3d9e8375-fbaa-c011-8242-b37cd971069b@redhat.com>
	<5924136A.4090004@intel.com>
	<7636d3d0-a0de-f9a6-47f8-2d09a448b978@redhat.com>
	<592544D9.5010100@intel.com>
	<23dac05e-ba3d-df6d-4831-feab9be1c6d2@redhat.com>
	<5926C7AC.4080603@intel.com>
	<6a6ecbcd-e9ae-1cf0-ccd9-14294cd0cf86@redhat.com>
	<5367a1b2-b3cc-8df2-c9ec-99fb60a57666@redhat.com>
	<20170525204018-mutt-send-email-mst@kernel.org>
In-Reply-To: <20170525204018-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [virtio-dev] Re: [virtio-dev] Re:
 [PATCH v2 00/16] Vhost-pci for inter-VM communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "marcandre.lureau@gmail.com" <marcandre.lureau@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>

On 05/26/2017 01:57 AM, Michael S. Tsirkin wrote:
>
> I think that's a very valid point. Linux isn't currently optimized to
> handle packets in device BAR.
>
> There are several issues here and you do need to address them in the
> kernel, no way around that:
>
> 1. lots of drivers set protection to
>          vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
>
Sorry for my late reply.

In the implementation tests, I didn't find an issue when letting the
guest directly access the bar MMIO returned by ioremap_cache().
If that's conventionally improper, we can probably make a new
function similar to ioremap_cache, as the 2nd comment suggests
below.

So, in any case, the vhost-pci driver uses ioremap_cache() or a similar
function, which sets the memory type to WB.



>     vfio certainly does, and so I think does pci sysfs.
>     You won't get good performance with this, you want to use
>     a cacheable mapping.
>     This needs to be addressed for pmd to work well.

In case it's useful for the discussion here, introduce a little background
about how the bar MMIO is used in vhost-pci:
The device in QEMU sets up the MemoryRegion of the bar as  "ram" type,
which will finally have translation mappings created in EPT. So, the memory
setup of the bar is the same as adding a regular RAM. It's like we are
passing through a bar memory to the guest which allows the guest to
directly access to the bar memory.

Back to the comments, why it is not cacheable memory when the
vhost-pci driver explicitly uses ioremap_cache()?

>
> 2. linux mostly assumes PCI BAR isn't memory, ioremap_cache returns __iomem
>     pointers which aren't supposed to be dereferenced directly.
>     You want a new API that does direct remap or copy if not possible.
>     Alternatively remap or fail, kind of like pci_remap_iospace.
>     Maybe there's already something like that - I'm not sure.
>

For the vhost-pci case, the bar is known to be a portion physical memory.
So, in this case, would it be an issue if the driver directly accesses 
to it?
(as mentioned above, the implementation functions correctly)

Best,
Wei
