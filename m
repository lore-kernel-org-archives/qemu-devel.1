Received: from eggs.gnu.org ([2001:4830:134:3::10]:56554)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1e56o8-0006uw-Ru
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:08:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1e56o5-0004Xc-KS
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:08:04 -0400
Received: from mail1.hostfission.com ([139.99.139.48]:34354)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <geoff@hostfission.com>) id 1e56o5-0004W2-8J
	for qemu-devel@nongnu.org; Thu, 19 Oct 2017 05:08:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Thu, 19 Oct 2017 20:07:54 +1100
From: geoff@hostfission.com
In-Reply-To: <CABdb736Ja=PTUn_iPaNSG9HAFO-STJ5m8A3cKVt4Ff8T4jcXhQ@mail.gmail.com>
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
	<CABdb734KxNJ2uMo2e61sFOXNFRgax067ErkQNQ1U1iO7ROAvCw@mail.gmail.com>
	<4d790f860a3cf21bd7e33e7c3f53b58b@hostfission.com>
	<CABdb737FAM-k18=8wKohxrn21otnqiBUFoBNKqdEyu==B-s_kA@mail.gmail.com>
	<a92ac1c09d6d24656449bc2d65c623ea@hostfission.com>
	<CABdb736Ja=PTUn_iPaNSG9HAFO-STJ5m8A3cKVt4Ff8T4jcXhQ@mail.gmail.com>
Message-ID: <59a147491e11c4c692e9f762bcd9fb21@hostfission.com>
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

On 2017-10-19 20:01, Ladi Prosek wrote:
> On Thu, Oct 19, 2017 at 10:44 AM,  <geoff@hostfission.com> wrote:
>> On 2017-10-19 19:35, Ladi Prosek wrote:
>>> 
>>> On Wed, Oct 18, 2017 at 5:04 PM,  <geoff@hostfission.com> wrote:
>>>> 
>>>> Hi Ladi & Yan,
>>>> 
>>>> I am pleased to present the completed driver for review, please see:
>>>> 
>>>> https://github.com/gnif/kvm-guest-drivers-windows
>>> 
>>> 
>>> Awesome!
>>> 
>>> Feel free to open pull request, it should be easier to comment on.
>> 
>> 
>> Great, I will do so after I have addressed the below. Thanks again.
>> 
>>> 
>>> * WoW considerations: It would be nice if the driver could detect 
>>> that
>>> the map request is coming from a 32-bit process and expect a 
>>> different
>>> layout of struct IVSHMEM_MMAP.
>> 
>> 
>> I did think of this but I am unsure as to how to detect this.
> 
> I don't think I ever used it but IoIs32bitProcess() looks promising.
> 
>>> 
>>> * It would be cleaner to use READ_REGISTER_* and WRITE_REGISTER_*
>>> from/to IVSHMEMDeviceRegisters instead of plain memory accesses. Or 
>>> at
>>> the very least the accesses should be marked volatile.
>> 
>> 
>> I thought that mapping the IO space was enough for this since it is
>> mapped as non-cacheable. I can see the point of marking it volatile 
>> but
>> see no need to use the read/write register semantics. If this is what 
>> it
>> takes however I am happy to do so.
> 
> Code like this raises eyebrows:
> 
>   deviceContext->devRegisters->doorbell |= (UINT32)in->vector |
> (in->peerID << 16);
> 
> Many readers will probably be wondering what exactly the compiler is
> allowed to do with this statement. May it end up ORing the lower and
> upper word separately, for example?
> 
>   OR [word ptr addr], in->vector
>   OR [word ptr addr + 2], in->peerID
> 
> And, by the way, is OR really what we want here?
> 

After double checking this you are dead right, the register is 
documented
as write only. I will fix this.

>>> 
>>> * In ivshmem.inf: ManufacturerName="Red Hat, Inc." instead of 
>>> "RedHat"
>>> 
>> 
>> No worries.
>> 
>>> * Is any of the API used by the driver Win10-only? Just curious, it's
>>> fine to build the driver only for Win10 for now even if it isn't.
>> 
>> 
>> I have not tried to build it on anything older then win 10 build 10586
>> as I have nothing older, but AFAIK it should build on windows 8.1 or
>> later just fine. This is more due to my lack of familiarity with 
>> Visual
>> Studio, give me gcc and vim any day :).
> 
> Gotcha, no worries, other versions can be tested later.
