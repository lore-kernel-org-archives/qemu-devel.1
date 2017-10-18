Received: from eggs.gnu.org ([2001:4830:134:3::10]:40367)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1e4gxM-0007mv-4z
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 01:31:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1e4gxJ-0003Md-1N
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 01:31:52 -0400
Received: from mail-ua0-f176.google.com ([209.85.217.176]:46144)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1e4gxI-0003ML-Sn
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 01:31:48 -0400
Received: by mail-ua0-f176.google.com with SMTP id w45so2751362uac.3
	for <qemu-devel@nongnu.org>; Tue, 17 Oct 2017 22:31:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <34b4df5da848d69b213f538e5751c0d3@hostfission.com>
References: <5548e41a5668ec0cba9543139327e035@hostfission.com>
	<3A7697A0-1AF3-46E8-8BCC-45A8127A2638@redhat.com>
	<286ea2bbfb5ec77d962300c9996c8688@hostfission.com>
	<92FEAF6E-3002-4F0F-B845-4EC3D29381A4@redhat.com>
	<c0c5158aeb4e553ac55639e66d81c007@hostfission.com>
	<34b4df5da848d69b213f538e5751c0d3@hostfission.com>
From: Ladi Prosek <lprosek@redhat.com>
Date: Wed, 18 Oct 2017 07:31:46 +0200
Message-ID: <CABdb734e-Fmfjk8auh-FzKnhmxjs0Bh9WpXWDmRBjYUWsZfe3A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] ivshmem Windows Driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: geoff@hostfission.com
Cc: Yan Vugenfirer <yvugenfi@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

Hi Geoff,

On Mon, Oct 16, 2017 at 8:31 PM,  <geoff@hostfission.com> wrote:
> Hi Yan & Ladi.
>
> I have written an initial implementation that supports just the shared
> memory
> mapping at this time. I plan to add events also but before I go further I
> would
> like some feedback if possible on what I have implemented thus far.
>
> Please see:
>
> https://github.com/gnif/kvm-guest-drivers-windows/commit/8655cf12fbdd77b991f96d97bc20f967b5907c12

Thank you, looks good overall.

* Please don't use the 'vio' prefix for this driver. ivshmem is not a
VirtIO device (i.e. not using the VirtIO protocol). Also the test
program should live in a subdirectory, so maybe something like
/ivshmem and /ivshmem/test.

* In VIOIVSHMEMEvtDevicePrepareHardware: I don't think that Windows
guarantees that resources are enumerated in BAR order. In VirtIO
drivers we read the PCI config space to identify the BAR index:
https://github.com/virtio-win/kvm-guest-drivers-windows/blob/master/VirtIO/VirtIOPCICommon.c#L353

* IOCTL codes on Windows have a structure to them:
https://docs.microsoft.com/en-us/windows-hardware/drivers/kernel/defining-i-o-control-codes

* In VIOIVSHMEMEvtIoDeviceControl: The "only one mapping at a time is
allowed" test has a race. I think that simply making the IO queue
WdfIoQueueDispatchSequential instead of WdfIoQueueDispatchParallel
will fix it.

* According to MSDN, MmMapLockedPagesSpecifyCache(UserMode) should be
wrapped in try/except. Also, what happens if the file handle is
inherited by a child process? Can it unmap the mapping in parent's
address space? What if the parent exits? A possible solution is
discussed in this article:
http://www.osronline.com/article.cfm?article=39

Thanks!
Ladi
