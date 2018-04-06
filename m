Received: from eggs.gnu.org ([2001:4830:134:3::10]:37150)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andr2000@gmail.com>) id 1f4PMq-0001yO-N0
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 07:17:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andr2000@gmail.com>) id 1f4PMm-0000Gr-OQ
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 07:17:16 -0400
Received: from mail-lf0-x22f.google.com ([2a00:1450:4010:c07::22f]:40700)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <andr2000@gmail.com>) id 1f4PMm-0000GR-FY
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 07:17:12 -0400
Received: by mail-lf0-x22f.google.com with SMTP id e5-v6so21560lfb.7
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 04:17:12 -0700 (PDT)
References: <20180313154826.20436-1-kraxel@redhat.com>
	<20180313161035.GL4788@phenom.ffwll.local>
	<20180314080301.366zycak3whqvvqx@sirius.home.kraxel.org>
	<CAKMK7uGG6Z6XLc6GuKv7-3grCNg+EK2Lh6XWpavjsbZWF_L5Wg@mail.gmail.com>
	<20180406001117.GD31612@mdroper-desk.amr.corp.intel.com>
	<2411d2c1-33c0-2ba5-67ea-3bb9af5d5ec9@epam.com>
	<20180406090747.gwiegu22z4noj23i@sirius.home.kraxel.org>
From: Oleksandr Andrushchenko <andr2000@gmail.com>
Message-ID: <9a085854-3758-1500-9971-806c611cb54f@gmail.com>
Date: Fri, 6 Apr 2018 14:17:04 +0300
MIME-Version: 1.0
In-Reply-To: <20180406090747.gwiegu22z4noj23i@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
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
> I'm not sure we can create something which works on both kvm and xen.
> The memory management model is quite different ...
>
>
> On xen the hypervisor manages all memory.  Guests can allow other guests
> to access specific pages (using grant tables).  In theory any guest <=>
> guest communication is possible.  In practice is mostly guest <=> dom0
> because guests access their virtual hardware that way.  dom0 is the
> priviledged guest which owns any hardware not managed by xen itself.
>
> Xen guests can ask the hypervisor to update the mapping of guest
> physical pages.  They can ballon down (unmap and free pages).  They can
> ballon up (ask the hypervisor to map fresh pages).  They can map pages
> exported by other guests using grant tables.  xen-zcopy makes heavy use
> of this.  It balloons down, to make room in the guest physical address
> space, then goes map the exported pages there, finally composes a
> dma-buf.
>
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
Does the above mean you can assume that xen-zcopy and udmabuf
can co-exist as two different solutions?
And what about hyper-dmabuf?

Thank you,
Oleksandr
