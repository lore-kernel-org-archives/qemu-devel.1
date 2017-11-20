Received: from eggs.gnu.org ([2001:4830:134:3::10]:59776)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1eGjZg-00059k-F5
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 05:45:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1eGjZf-0005TH-6w
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 05:45:12 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:46451)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a175818323@gmail.com>)
	id 1eGjZe-0005Sz-Vg
	for qemu-devel@nongnu.org; Mon, 20 Nov 2017 05:45:11 -0500
Received: by mail-ot0-x241.google.com with SMTP id j29so7252166oth.13
	for <qemu-devel@nongnu.org>; Mon, 20 Nov 2017 02:45:10 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAMxP3BRze3uBxUoKwPNUO-SPBGWHQBLc+5qF08HBn7vnyhwEWw@mail.gmail.com>
References: <20170829214929.31136.21144.stgit@gimli.home>
	<CAMxP3BRze3uBxUoKwPNUO-SPBGWHQBLc+5qF08HBn7vnyhwEWw@mail.gmail.com>
From: Bob Chen <a175818323@gmail.com>
Date: Mon, 20 Nov 2017 18:45:09 +0800
Message-ID: <CAMxP3BTBe9+36EmbaWGDQ4O2jqDjQJqosGzXeDD-niUxMLJ8Mw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 0/3] vfio/pci: Add NVIDIA GPUDirect P2P
 clique support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org

It's a mistake, please ignore. This patch is able to work.

2017-10-26 18:45 GMT+08:00 Bob Chen <a175818323@gmail.com>:

> There seem to be some bugs in these patches, causing my VM failed to boot.
>
> Test case:
>
> 0. Merge these 3 patches in to release 2.10.1
>
> 1. qemu-system-x86_64_2.10.1  ... \
> -device vfio-pci,host=04:00.0 \
> -device vfio-pci,host=05:00.0 \
> -device vfio-pci,host=08:00.0 \
> -device vfio-pci,host=09:00.0 \
> -device vfio-pci,host=85:00.0 \
> -device vfio-pci,host=86:00.0 \
> -device vfio-pci,host=89:00.0 \
> -device vfio-pci,host=8a:00.0 ...
>
> The guest was able to boot up.
>
> 2. qemu-system-x86_64_2.10.1  ... \
> -device vfio-pci,host=04:00.0,x-nv-gpudirect-clique=0 \
> -device vfio-pci,host=05:00.0,x-nv-gpudirect-clique=0 \
> -device vfio-pci,host=08:00.0,x-nv-gpudirect-clique=0 \
> -device vfio-pci,host=09:00.0,x-nv-gpudirect-clique=0 \
> -device vfio-pci,host=85:00.0,x-nv-gpudirect-clique=8 \
> -device vfio-pci,host=86:00.0,x-nv-gpudirect-clique=8 \
> -device vfio-pci,host=89:00.0,x-nv-gpudirect-clique=8 \
> -device vfio-pci,host=8a:00.0,x-nv-gpudirect-clique=8 \
>
> Hang. VNC couldn't connect.
>
>
> My personal patch used to work, although it was done by straightforward
> hacking and not that friendly to read.
>
> --- a/hw/vfio/pci.c
> +++ b/hw/vfio/pci.c
>
>  @@static int vfio_initfn(PCIDevice *pdev)
>
>     vfio_add_emulated_long(vdev, 0xc8, 0x50080009, ~0);
>     if (count < 4)
>     {
>         vfio_add_emulated_long(vdev, 0xcc, 0x00005032, ~0);
>     }
>     else
>     {
>         vfio_add_emulated_long(vdev, 0xcc, 0x00085032, ~0);
>     }
>     vfio_add_emulated_word(vdev, 0x78, 0xc810, ~0);
>
> 2017-08-30 6:05 GMT+08:00 Alex Williamson <alex.williamson@redhat.com>:
>
>> NVIDIA has a specification for exposing a virtual vendor capability
>> which provides a hint to guest drivers as to which sets of GPUs can
>> support direct peer-to-peer DMA.  Devices with the same clique ID are
>> expected to support this.  The user can specify a clique ID for an
>> NVIDIA graphics device using the new vfio-pci x-nv-gpudirect-clique=
>> option, where valid clique IDs are a 4-bit integer.  It's entirely the
>> user's responsibility to specify sets of devices for which P2P works
>> correctly and provides some benefit.  This is only useful for DMA
>> between NVIDIA GPUs, therefore it's only useful to specify cliques
>> comprised of more than one GPU.  Furthermore, this does not enable DMA
>> between VMs, there is no change to VM DMA mapping, this only exposes
>> hints about existing DMA paths to the guest driver.  Thanks,
>>
>> Alex
>>
>> ---
>>
>> Alex Williamson (3):
>>       vfio/pci: Do not unwind on error
>>       vfio/pci: Add virtual capabilities quirk infrastructure
>>       vfio/pci: Add NVIDIA GPUDirect Cliques support
>>
>>
>>  hw/vfio/pci-quirks.c |  114 ++++++++++++++++++++++++++++++
>> ++++++++++++++++++++
>>  hw/vfio/pci.c        |   17 +++++++
>>  hw/vfio/pci.h        |    4 ++
>>  3 files changed, 133 insertions(+), 2 deletions(-)
>>
>
>
