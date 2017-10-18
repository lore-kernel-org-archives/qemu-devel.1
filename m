Received: from eggs.gnu.org ([2001:4830:134:3::10]:47750)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1e4hFQ-0003fV-Mj
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 01:50:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1e4hFN-0003Pp-J7
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 01:50:32 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:49632)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1e4hFN-0003Ny-7f
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 01:50:29 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Wed, 18 Oct 2017 16:50:21 +1100
From: geoff@hostfission.com
In-Reply-To: <CABdb734e-Fmfjk8auh-FzKnhmxjs0Bh9WpXWDmRBjYUWsZfe3A@mail.gmail.com>
References: <5548e41a5668ec0cba9543139327e035@hostfission.com>
	<3A7697A0-1AF3-46E8-8BCC-45A8127A2638@redhat.com>
	<286ea2bbfb5ec77d962300c9996c8688@hostfission.com>
	<92FEAF6E-3002-4F0F-B845-4EC3D29381A4@redhat.com>
	<c0c5158aeb4e553ac55639e66d81c007@hostfission.com>
	<34b4df5da848d69b213f538e5751c0d3@hostfission.com>
	<CABdb734e-Fmfjk8auh-FzKnhmxjs0Bh9WpXWDmRBjYUWsZfe3A@mail.gmail.com>
Message-ID: <0f911b72c94a0d0f1bedf1c6385b045e@hostfission.com>
Subject: Re: [Qemu-devel] ivshmem Windows Driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>
Cc: Yan Vugenfirer <yvugenfi@redhat.com>, qemu-devel <qemu-devel@nongnu.org>

On 2017-10-18 16:31, Ladi Prosek wrote:
> Hi Geoff,
> 
> On Mon, Oct 16, 2017 at 8:31 PM,  <geoff@hostfission.com> wrote:
>> Hi Yan & Ladi.
>> 
>> I have written an initial implementation that supports just the shared
>> memory
>> mapping at this time. I plan to add events also but before I go 
>> further I
>> would
>> like some feedback if possible on what I have implemented thus far.
>> 
>> Please see:
>> 
>> https://github.com/gnif/kvm-guest-drivers-windows/commit/8655cf12fbdd77b991f96d97bc20f967b5907c12
> 
> Thank you, looks good overall.
> 
> * Please don't use the 'vio' prefix for this driver. ivshmem is not a
> VirtIO device (i.e. not using the VirtIO protocol). Also the test
> program should live in a subdirectory, so maybe something like
> /ivshmem and /ivshmem/test.

Noted, I will remove the prefix throughout and move the test 
application.

> 
> * In VIOIVSHMEMEvtDevicePrepareHardware: I don't think that Windows
> guarantees that resources are enumerated in BAR order. In VirtIO
> drivers we read the PCI config space to identify the BAR index:
> https://github.com/virtio-win/kvm-guest-drivers-windows/blob/master/VirtIO/VirtIOPCICommon.c#L353

The windows 'toaster' sample relies on the resource order, but as a
belt and braces approach I will update the code to use the same
approach.

> 
> * IOCTL codes on Windows have a structure to them:
> https://docs.microsoft.com/en-us/windows-hardware/drivers/kernel/defining-i-o-control-codes

Thanks, I will fix this.

> 
> * In VIOIVSHMEMEvtIoDeviceControl: The "only one mapping at a time is
> allowed" test has a race. I think that simply making the IO queue
> WdfIoQueueDispatchSequential instead of WdfIoQueueDispatchParallel
> will fix it.

Good point, I will change this.

> 
> * According to MSDN, MmMapLockedPagesSpecifyCache(UserMode) should be
> wrapped in try/except. Also, what happens if the file handle is
> inherited by a child process? Can it unmap the mapping in parent's
> address space? What if the parent exits? A possible solution is
> discussed in this article:
> http://www.osronline.com/article.cfm?article=39

Noted re try/except. As for a child inheriting it, the owner is tracked
by the WDFFILEOBJECT, which the child I believe will inherit also, which
would mean that the child would gain the ability to issue IOCTLs to the
mapping.

> 
> Thanks!
> Ladi


No, thank you! I am grateful someone is willing to provide some feedback
on this.

I have been working on adding MSI interrupt support to the driver
also which is close to ready, just trying to figure out why the driver
fails to start with STATUS_DEVICE_POWER_FAILURE when I try to setup the
IRQs with WdfInterruptCreate.

Thanks again,
Geoff
