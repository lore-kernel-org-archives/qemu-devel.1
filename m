Received: from eggs.gnu.org ([2001:4830:134:3::10]:36259)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1eTnYB-0003M0-7t
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 06:37:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <a175818323@gmail.com>) id 1eTnY9-0000Hp-PQ
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 06:37:39 -0500
Received: from mail-io0-x22f.google.com ([2607:f8b0:4001:c06::22f]:37029)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <a175818323@gmail.com>)
	id 1eTnY9-0000HU-IC
	for qemu-devel@nongnu.org; Tue, 26 Dec 2017 06:37:37 -0500
Received: by mail-io0-x22f.google.com with SMTP id n14so9106541iob.4
	for <qemu-devel@nongnu.org>; Tue, 26 Dec 2017 03:37:37 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <A2975661238FB949B60364EF0F2C257439B2BAD8@SHSMSX104.ccr.corp.intel.com>
References: <CAMxP3BRqxD8tC1-M3+Pr8q8JZ1G_fGPbcvNQehwdPGFykdEk0g@mail.gmail.com>
	<A2975661238FB949B60364EF0F2C257439B2BAD8@SHSMSX104.ccr.corp.intel.com>
From: Bob Chen <a175818323@gmail.com>
Date: Tue, 26 Dec 2017 19:37:36 +0800
Message-ID: <CAMxP3BQ8zt3oOh7UoUxJYD00Lv=L54iJiC4JJS8XLaFf1NRKzg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [GPU and VFIO] qemu hang at startup,
 VFIO_IOMMU_MAP_DMA is extremely slow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>

2017-12-26 18:51 GMT+08:00 Liu, Yi L <yi.l.liu@intel.com>:

> > -----Original Message-----
> > From: Qemu-devel [mailto:qemu-devel-bounces+yi.l.liu=
> intel.com@nongnu.org]
> > On Behalf Of Bob Chen
> > Sent: Tuesday, December 26, 2017 6:30 PM
> > To: qemu-devel@nongnu.org
> > Subject: [Qemu-devel] [GPU and VFIO] qemu hang at startup,
> > VFIO_IOMMU_MAP_DMA is extremely slow
> >
> > Hi,
> >
> > I have a host server with multiple GPU cards, and was assigning them to
> qemu
> > with VFIO.
> >
> > I found that when setting up the last free GPU, the qemu process would
> hang
>
> Are all the GPUs in the same iommu group?
>

Each of them is in a single group.


>
> > there and took almost 10 minutes before finishing startup. I made some
> dig by
> > gdb, and found the slowest part occurred at the
> > hw/vfio/common.c:vfio_dma_map function call.
>
> This is to setup mapping and it takes time. This function would be called
> multiple
> times and it will take some time. The slowest part, do you mean it takes
> a long time for a single vfio_dma_map() calling or the whole passthru
> spends a lot
> of time on creating mapping. If a single calling takes a lot of time, then
> it may be
> a problem.
>

Each vfio_dma_map() takes 3 to 10 mins accordingly.


>
> You may paste your Qemu command which might help. And the dmesg in host
> would also help.
>

cmd line:
After adding -device vfio-pci,host=09:00.0,multifunction=on,addr=0x15, qemu
would hang.
Otherwise, could start immediately without this option.

dmesg:
[Tue Dec 26 18:39:50 2017] vfio-pci 0000:09:00.0: enabling device (0400 ->
0402)
[Tue Dec 26 18:39:51 2017] vfio_ecap_init: 0000:09:00.0 hiding ecap
0x1e@0x258
[Tue Dec 26 18:39:51 2017] vfio_ecap_init: 0000:09:00.0 hiding ecap
0x19@0x900
[Tue Dec 26 18:39:55 2017] kvm: zapping shadow pages for mmio generation
wraparound
[Tue Dec 26 18:39:55 2017] kvm: zapping shadow pages for mmio generation
wraparound
[Tue Dec 26 18:40:03 2017] kvm [74663]: vcpu0 ignored rdmsr: 0x345

Kernel:
3.10.0-514.16.1  CentOS 7.3


>
> >
> >
> > static int vfio_dma_map(VFIOContainer *container, hwaddr iova, ram_addr_t
> > size, void *vaddr, bool readonly) { ...
> >     if (ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0 ||
> >         (errno == EBUSY && vfio_dma_unmap(container, iova, size) == 0 &&
> >          ioctl(container->fd, VFIO_IOMMU_MAP_DMA, &map) == 0)) {
> >         return 0;
> >     }
> > ...
> > }
> >
> >
> > The hang was enable to reproduce on one of my hosts, I was setting up a
> 4GB
> > memory VM, while the host still had 16GB free. GPU physical mem is 8G.
>
> Does it happen when you only assign a single GPU?
>

Not sure. Didn't try multiple GPUs.


>
> > Also, this phenomenon was observed on other hosts occasionally, and the
> > similarity is that they always happened on the last free GPU.
> >
> >
> > Full stack trace file is attached. Looking forward for you help, thanks
> >
> >
> > - Bob
>
> Regards,
> Yi L
>
