Received: from eggs.gnu.org ([2001:4830:134:3::10]:34727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andr2000@gmail.com>) id 1f4Nlk-0001Ik-72
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:34:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andr2000@gmail.com>) id 1f4Nlh-000465-1b
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:34:52 -0400
Received: from mail-wm0-x244.google.com ([2a00:1450:400c:c09::244]:38866)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andr2000@gmail.com>) id 1f4Nlg-00045n-MM
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:34:48 -0400
Received: by mail-wm0-x244.google.com with SMTP id i3so1975800wmf.3
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 02:34:48 -0700 (PDT)
References: <20180313154826.20436-1-kraxel@redhat.com>
	<20180313161035.GL4788@phenom.ffwll.local>
	<20180314080301.366zycak3whqvvqx@sirius.home.kraxel.org>
	<CAKMK7uGG6Z6XLc6GuKv7-3grCNg+EK2Lh6XWpavjsbZWF_L5Wg@mail.gmail.com>
	<20180406001117.GD31612@mdroper-desk.amr.corp.intel.com>
	<2411d2c1-33c0-2ba5-67ea-3bb9af5d5ec9@epam.com>
	<20180406090747.gwiegu22z4noj23i@sirius.home.kraxel.org>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <0351cf53-3e27-d0b4-a77b-8392c2b0a951@gmail.com>
Date: Fri, 6 Apr 2018 12:34:45 +0300
MIME-Version: 1.0
In-Reply-To: <20180406090747.gwiegu22z4noj23i@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [RfC PATCH] Add udmabuf misc device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>, Oleksandr Andrushchenko <Oleksandr_Andrushchenko@epam.com>
Cc: Dongwon Kim <dongwon.kim@intel.com>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, David Airlie <airlied@linux.ie>, open list <linux-kernel@vger.kernel.org>, dri-devel <dri-devel@lists.freedesktop.org>, qemu-devel@nongnu.org, "moderated list:DMA BUFFER SHARING FRAMEWORK" <linaro-mm-sig@lists.linaro.org>, "open list:DMA BUFFER SHARING FRAMEWORK" <linux-media@vger.kernel.org>

On 04/06/2018 12:07 PM, Gerd Hoffmann wrote:
>    Hi,
>
>>>    * The general interface should be able to express sharing from any
>>>      guest:guest, not just guest:host.  Arbitrary G:G sharing might be
>>>      something some hypervisors simply aren't able to support, but the
>>>      userspace API itself shouldn't make assumptions or restrict that.  I
>>>      think ideally the sharing API would include some kind of
>>>      query_targets interface that would return a list of VM's that your
>>>      current OS is allowed to share with; that list would be depend on the
>>>      policy established by the system integrator, but obviously wouldn't
>>>      include targets that the hypervisor itself wouldn't be capable of
>>>      handling.
>> Can you give a use-case for this? I mean that the system integrator
>> is the one who defines which guests/hosts talk to each other,
>> but querying means that it is possible that VMs have some sort
>> of discovery mechanism, so they can decide on their own whom
>> to connect to.
> Note that vsock (created by vmware, these days also has a virtio
> transport for kvm) started with support for both guest <=> host and
> guest <=> guest support.  But later on guest <=> guest was dropped.
> As far I know the reasons where (a) lack of use cases and (b) security.
>
> So, I likewise would know more details on the use cases you have in mind
> here.  Unless we have a compelling use case here I'd suggest to drop the
> guest <=> guest requirement as it makes the whole thing alot more
> complex.
This is exactly the use-case we have: in our setup Dom0 doesn't
own any HW at all and all the HW is passed into a dedicated
driver domain (DomD) which is still a guest domain.
Then, buffers are shared between two guests, for example,
DomD and DomA (Android guest)
>>>    * The sharing API could be used to share multiple kinds of content in a
>>>      single system.  The sharing sink driver running in the content
>>>      producer's VM should accept some additional metadata that will be
>>>      passed over to the target VM as well.
> Not sure this should be part of hyper-dmabuf.  A dma-buf is nothing but
> a block of data, period.  Therefore protocols with dma-buf support
> (wayland for example) typically already send over metadata describing
> the content, so duplicating that in hyper-dmabuf looks pointless.
>
>> 1. We are targeting ARM and one of the major requirements for the buffer
>> sharing is the ability to allocate physically contiguous buffers, which gets
>> even more complicated for systems not backed with an IOMMU. So, for some
>> use-cases it is enough to make the buffers contiguous in terms of IPA and
>> sometimes those need to be contiguous in terms of PA.
> Which pretty much implies the host must to the allocation.
>
>> 2. For Xen we would love to see UAPI to create a dma-buf from grant
>> references provided, so we can use this generic solution to implement
>> zero-copying without breaking the existing Xen protocols. This can
>> probably be extended to other hypervizors as well.
> I'm not sure we can create something which works on both kvm and xen.
> The memory management model is quite different ...
>
>
> On xen the hypervisor manages all memory.  Guests can allow other guests
> to access specific pages (using grant tables).  In theory any guest <=>
> guest communication is possible.  In practice is mostly guest <=> dom0
> because guests access their virtual hardware that way.  dom0 is the
> priviledged guest which owns any hardware not managed by xen itself.
Please see above for our setup with DomD and Dom0 being
a generic ARMv8 domain, no HW
> Xen guests can ask the hypervisor to update the mapping of guest
> physical pages.  They can ballon down (unmap and free pages).  They can
> ballon up (ask the hypervisor to map fresh pages).  They can map pages
> exported by other guests using grant tables.  xen-zcopy makes heavy use
> of this.  It balloons down, to make room in the guest physical address
> space, then goes map the exported pages there, finally composes a
> dma-buf.
This is what it does
>
> On kvm qemu manages all guest memory.  qemu also has all guest memory
> mapped, so a grant-table like mechanism isn't needed to implement
> virtual devices.  qemu can decide how it backs memory for the guest.
> qemu propagates the guest memory map to the kvm driver in the linux
> kernel.  kvm guests have some control over the guest memory map, for
> example they can map pci bars wherever they want in their guest physical
> address space by programming the base registers accordingly, but unlike
> xen guests they can't ask the host to remap individual pages.
>
> Due to qemu having all guest memory mapped virtual devices are typically
> designed to have the guest allocate resources, then notify the host
> where they are located.  This is where the udmabuf idea comes from:
> Guest tells the host (qemu) where the gem object is, and qemu then can
> create a dmabuf backed by those pages to pass it on to other processes
> such as the wayland display server.  Possibly even without the guest
> explicitly asking for it, i.e. export the framebuffer placed by the
> guest in the (virtual) vga pci memory bar as dma-buf.  And I can imagine
> that this is useful outsize virtualization too.
>
>
> I fail to see any common ground for xen-zcopy and udmabuf ...
>
> Beside that there is the problem that the udmabuf idea has its own share
> of issues, for example the fork() issue pointed out by Christian
> König[1].  So I still need to find something which can work for kvm ...
>
> cheers,
>    Gerd
>
> [1] https://www.spinics.net/lists/dri-devel/msg169442.html
> _______________________________________________
> dri-devel mailing list
> dri-devel@lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
