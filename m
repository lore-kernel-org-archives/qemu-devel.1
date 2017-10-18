Received: from eggs.gnu.org ([2001:4830:134:3::10]:58745)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1e4nYB-0005hB-TB
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:34:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1e4nY6-0004Bx-Ml
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:34:19 -0400
Received: from mail-ua0-f196.google.com ([209.85.217.196]:54737)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1e4nY6-0004Bi-Hg
	for qemu-devel@nongnu.org; Wed, 18 Oct 2017 08:34:14 -0400
Received: by mail-ua0-f196.google.com with SMTP id n38so3399061uai.11
	for <qemu-devel@nongnu.org>; Wed, 18 Oct 2017 05:34:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <d5b66cd9f96b0dafedf4369ff02a7121@hostfission.com>
References: <5548e41a5668ec0cba9543139327e035@hostfission.com>
	<3A7697A0-1AF3-46E8-8BCC-45A8127A2638@redhat.com>
	<286ea2bbfb5ec77d962300c9996c8688@hostfission.com>
	<92FEAF6E-3002-4F0F-B845-4EC3D29381A4@redhat.com>
	<c0c5158aeb4e553ac55639e66d81c007@hostfission.com>
	<34b4df5da848d69b213f538e5751c0d3@hostfission.com>
	<CABdb734e-Fmfjk8auh-FzKnhmxjs0Bh9WpXWDmRBjYUWsZfe3A@mail.gmail.com>
	<0f911b72c94a0d0f1bedf1c6385b045e@hostfission.com>
	<CABdb735gdt_N=GDTb2G_sPENjpxS98dFxoPQBLqtMmp8EKCRFw@mail.gmail.com>
	<d5b66cd9f96b0dafedf4369ff02a7121@hostfission.com>
From: Ladi Prosek <lprosek@redhat.com>
Date: Wed, 18 Oct 2017 14:34:13 +0200
Message-ID: <CABdb734KxNJ2uMo2e61sFOXNFRgax067ErkQNQ1U1iO7ROAvCw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Wed, Oct 18, 2017 at 8:56 AM,  <geoff@hostfission.com> wrote:
> On 2017-10-18 17:50, Ladi Prosek wrote:
>>
>> On Wed, Oct 18, 2017 at 7:50 AM,  <geoff@hostfission.com> wrote:
>>>
>>> On 2017-10-18 16:31, Ladi Prosek wrote:
>>>>
>>>>
>>>> Hi Geoff,
>>>>
>>>> On Mon, Oct 16, 2017 at 8:31 PM,  <geoff@hostfission.com> wrote:
>>>>>
>>>>>
>>>>> Hi Yan & Ladi.
>>>>>
>>>>> I have written an initial implementation that supports just the share=
d
>>>>> memory
>>>>> mapping at this time. I plan to add events also but before I go furth=
er
>>>>> I
>>>>> would
>>>>> like some feedback if possible on what I have implemented thus far.
>>>>>
>>>>> Please see:
>>>>>
>>>>>
>>>>>
>>>>> https://github.com/gnif/kvm-guest-drivers-windows/commit/8655cf12fbdd=
77b991f96d97bc20f967b5907c12
>>>>
>>>>
>>>>
>>>> Thank you, looks good overall.
>>>>
>>>> * Please don't use the 'vio' prefix for this driver. ivshmem is not a
>>>> VirtIO device (i.e. not using the VirtIO protocol). Also the test
>>>> program should live in a subdirectory, so maybe something like
>>>> /ivshmem and /ivshmem/test.
>>>
>>>
>>>
>>> Noted, I will remove the prefix throughout and move the test applicatio=
n.
>>>
>>>>
>>>> * In VIOIVSHMEMEvtDevicePrepareHardware: I don't think that Windows
>>>> guarantees that resources are enumerated in BAR order. In VirtIO
>>>> drivers we read the PCI config space to identify the BAR index:
>>>>
>>>>
>>>> https://github.com/virtio-win/kvm-guest-drivers-windows/blob/master/Vi=
rtIO/VirtIOPCICommon.c#L353
>>>
>>>
>>>
>>> The windows 'toaster' sample relies on the resource order, but as a
>>> belt and braces approach I will update the code to use the same
>>> approach.
>>
>>
>> Interesting, thanks! If that's really the case then we can remove the
>> code from VirtioLib. I have cloned the latest Windows-driver-samples
>> but can't find this under general/toaster. Namely
>> ToasterEvtDevicePrepareHardware just prints some info about all
>> resources but does not do anything order-related. Can you point me to
>> the right code?
>>
>
> Sorry, my mistake, it wasn't the toaster code but the kmdf driver, it
> assumes the BAR ordering to determine which is which.
>
> https://github.com/Microsoft/Windows-driver-samples/blob/aa6e0b36eb932099=
fa4eb950a6f5e289a23b6d6e/general/pcidrv/kmdf/HW/nic_init.c#L649

Got it. And MSDN says:

"A driver for a PCI bus device receives resources that are listed in
the order in which they appear in the device=E2=80=99s Base Address Registe=
rs
(BARs)."
https://docs.microsoft.com/en-us/windows-hardware/drivers/wdf/raw-and-trans=
lated-resources

So please disregard my comment.

We'll probably leave VirtioLib alone for now to stay robust, though.
Counting resources works only if the BAR layout is known. VirtIO 1.0
depends on knowing the exact BAR index and can't assume that the
second mem/IO resource is BAR #1, for example. Thanks!

>
>>>>
>>>> * IOCTL codes on Windows have a structure to them:
>>>>
>>>>
>>>> https://docs.microsoft.com/en-us/windows-hardware/drivers/kernel/defin=
ing-i-o-control-codes
>>>
>>>
>>>
>>> Thanks, I will fix this.
>>>
>>>>
>>>> * In VIOIVSHMEMEvtIoDeviceControl: The "only one mapping at a time is
>>>> allowed" test has a race. I think that simply making the IO queue
>>>> WdfIoQueueDispatchSequential instead of WdfIoQueueDispatchParallel
>>>> will fix it.
>>>
>>>
>>>
>>> Good point, I will change this.
>>>
>>>>
>>>> * According to MSDN, MmMapLockedPagesSpecifyCache(UserMode) should be
>>>> wrapped in try/except. Also, what happens if the file handle is
>>>> inherited by a child process? Can it unmap the mapping in parent's
>>>> address space? What if the parent exits? A possible solution is
>>>> discussed in this article:
>>>> http://www.osronline.com/article.cfm?article=3D39
>>>
>>>
>>>
>>> Noted re try/except. As for a child inheriting it, the owner is tracked
>>> by the WDFFILEOBJECT, which the child I believe will inherit also, whic=
h
>>> would mean that the child would gain the ability to issue IOCTLs to the
>>> mapping.
>>>
>>>>
>>>> Thanks!
>>>> Ladi
>>>
>>>
>>>
>>>
>>> No, thank you! I am grateful someone is willing to provide some feedbac=
k
>>> on this.
>>>
>>> I have been working on adding MSI interrupt support to the driver
>>> also which is close to ready, just trying to figure out why the driver
>>> fails to start with STATUS_DEVICE_POWER_FAILURE when I try to setup the
>>> IRQs with WdfInterruptCreate.
>>>
>>> Thanks again,
>>> Geoff
>
>
