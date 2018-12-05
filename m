Received: from eggs.gnu.org ([2001:4830:134:3::10]:60735)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maran.wilson@oracle.com>) id 1gUbXS-0004j7-Of
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 13:04:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maran.wilson@oracle.com>) id 1gUbXN-0003Ez-Nb
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 13:04:46 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:35268)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maran.wilson@oracle.com>)
	id 1gUbXN-0003E8-Av
	for qemu-devel@nongnu.org; Wed, 05 Dec 2018 13:04:41 -0500
References: <CAGxU2F7+NZUS-BQ1hCnKynVxfsVUYTHRCWQvJwBA12bYmg0ZJA@mail.gmail.com>
	<938a2f54426dc059428fcfe1882bbb3b2d5cbc99.camel@intel.com>
	<CAGxU2F50U=NH8fGDXygcYycjoveNpdbKnnG3H0soCvub_Ea5cw@mail.gmail.com>
	<CAGxU2F7SA-kc0gsLNaUzbiinytJ2DF_r5UpB1JzRy-Su1_WOLw@mail.gmail.com>
	<a1ca57134a970fb3282afb36c0e3b5647b104ff8.camel@intel.com>
	<CAGxU2F7Sg0JaxyPQw_FhSc6MzYu+YzZpv9=VHp8qvwfTWpf_MQ@mail.gmail.com>
	<59cc9e47-3c2a-2417-9e89-e7ade92fdf2d@oracle.com>
	<20181205132041.GB24623@stefanha-x1.localdomain>
From: Maran Wilson <maran.wilson@oracle.com>
Message-ID: <669ef62d-06e2-3e6d-9f27-9ae8934b5330@oracle.com>
Date: Wed, 5 Dec 2018 10:04:36 -0800
MIME-Version: 1.0
In-Reply-To: <20181205132041.GB24623@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] QEMU/NEMU boot time with several x86 firmwares
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Samuel Ortiz <sameo@linux.intel.com>, Rob Bradford <robert.bradford@intel.com>, Stefano Garzarella <sgarzare@redhat.com>, Maran Wilson <maran.wilson@oracle.com>, Liam Merwick <liam.merwick@oracle.com>

On 12/5/2018 5:20 AM, Stefan Hajnoczi wrote:
> On Tue, Dec 04, 2018 at 02:44:33PM -0800, Maran Wilson wrote:
>> On 12/3/2018 8:35 AM, Stefano Garzarella wrote:
>>> On Mon, Dec 3, 2018 at 4:44 PM Rob Bradford <robert.bradford@intel.com> wrote:
>>>> Hi Stefano, thanks for capturing all these numbers,
>>>>
>>>> On Mon, 2018-12-03 at 15:27 +0100, Stefano Garzarella wrote:
>>>>> Hi Rob,
>>>>> I continued to investigate the boot time, and as you suggested I
>>>>> looked also at qemu-lite 2.11.2
>>>>> (https://github.com/kata-containers/qemu) and NEMU "virt" machine. I
>>>>> did the following tests using the Kata kernel configuration
>>>>> (
>>>>> https://github.com/kata-containers/packaging/blob/master/kernel/configs/x86_64_kata_kvm_4.14.x
>>>>> )
>>>>>
>>>>> To compare the results with qemu-lite direct kernel load, I added
>>>>> another tracepoint:
>>>>> - linux_start_kernel: first entry of the Linux kernel
>>>>> (start_kernel())
>>>>>
>>>> Great, do you have a set of patches available that all these trace
>>>> points. It would be great for reproduction.
>>> For sure! I'm attaching a set of patches for qboot, seabios, ovmf,
>>> nemu/qemu/qemu-lite and linux 4.14 whit the tracepoints.
>>> I'm also sharing a python script that I'm using with perf to extract
>>> the numbers in this way:
>>>
>>> $ perf record -a -e kvm:kvm_entry -e kvm:kvm_pio -e
>>> sched:sched_process_exec -o /tmp/qemu_perf.data &
>>> $ # start qemu/nemu multiple times
>>> $ killall perf
>>> $ perf script -s qemu-perf-script.py -i /tmp/qemu_perf.data
>>>
>>>>> As you can see, NEMU is faster to jump to the kernel
>>>>> (linux_start_kernel) than qemu-lite when uses qboot or seabios with
>>>>> virt support, but the time to the user space is strangely high, maybe
>>>>> the kernel configuration that I used is not the best one.
>>>>> Do you suggest another kernel configuration?
>>>>>
>>>> This looks very bad. This isn't the kernel configuration we normally
>>>> test with in our automated test system but is definitely one we support
>>>> as part of our partnernship with the Kata team. It's a high priority
>>>> for me to try and investigate that. Have you saved the kernel messages
>>>> as they might be helpful?
>>> Yes, I'm attaching the dmesg output with nemu and qemu.
>>>
>>>>> Anyway, I obtained the best boot time with qemu-lite and direct
>>>>> kernel
>>>>> load (vmlinux ELF image). I think because the kernel was not
>>>>> compressed. Indeed, looking to the others test, the kernel
>>>>> decompression (bzImage) takes about 80 ms (linux_start_kernel -
>>>>> linux_start_boot). (I'll investigate better)
>>>>>
>>>> Yup being able to load an uncompressed kernel is one of the big
>>>> advantages of qemu-lite. I wonder if we could bring that feature into
>>>> qemu itself to supplement the existing firmware based kernel loading.
>>> I think so, I'll try to understand if we can merge the qemu-lite
>>> direct kernel loading in qemu.
>> An attempt was made a long time ago to push the qemu-lite stuff (from the
>> Intel Clear Containers project) upstream. As I understand it, the main
>> stumbling block that seemed to derail the effort was that it involved adding
>> Linux OS specific code to Qemu so that Qemu could do things like create and
>> populate the zero page that Linux expects when entering startup_64().
>>
>> That ends up being a lot of very low-level, operating specific knowledge
>> about Linux that ends up getting baked into Qemu code. And understandably, a
>> number of folks saw problems with going down a path like that.
>>
>> Since then, we have put together an alternative solution that would allow
>> Qemu to boot an uncompressed Linux binary via the x86/HVM direct boot ABI
>> (https://xenbits.xen.org/docs/unstable/misc/pvh.html). The solution involves
>> first making changes to both the ABI as well as Linux, and then updating
>> Qemu to take advantage of the updated ABI which is already supported by both
>> Linux and Free BSD for booting VMs. As such, Qemu can remain OS agnostic,
>> and just be programmed to the published ABI.
>>
>> The canonical definition for the HVM direct boot ABI is in the Xen tree and
>> we needed to make some minor changes to the ABI definition to allow KVM
>> guests to also use the same structure and entry point. Those changes were
>> accepted to the Xen tree already:
>> https://lists.xenproject.org/archives/html/xen-devel/2018-04/msg00057.html
>>
>> The corresponding Linux changes that would allow KVM guests to be booted via
>> this PVH entry point have already been posted and reviewed:
>> https://lkml.org/lkml/2018/4/16/1002
>>
>> The final part is the set of Qemu changes to take advantage of the above and
>> boot a KVM guest via an uncompressed kernel binary using the entry point
>> defined by the ABI. Liam Merwick will be posting some RFC patches very soon
>> to allow this.
> Cool, thanks for doing this work!
>
> How do the boot times compare to qemu-lite and Firecracker's
> (https://github.com/firecracker-microvm/firecracker/) direct vmlinux ELF
> boot?

Boot times compare very favorably to qemu-lite, since the end result is 
basically doing a very similar thing. For now, we are going with a QEMU 
+ qboot solution to introduce the PVH entry support in Qemu (meaning we 
will be posting Qemu and qboot patches and you will need both to boot an 
uncompressed kernel binary). As such we have numbers that Liam will 
include in the cover letter showing significant boot time improvement 
over existing QEMU + qboot approaches involving a compressed kernel 
binary. And as we all know, the existing qboot approach already gets 
boot times down pretty low.

Once the patches have been posted (soon) it would be great if some other 
folks could pick them up and run your own numbers on various test setups 
and comparisons you already have.

I haven't tried Firecracker, specifically. It would be good to see a 
comparison just so we know where we stand, but it's not terribly 
relevant to folks who want to continue using Qemu right? Meaning Qemu 
(and all solutions built on it like kata) still needs a solution for 
improving boot time regardless of what NEMU and Firecracker are doing.

And from what I've read so far, Firecracker only supports Linux guests. 
So one could arguably just bake in all sorts of Linux specific knowledge 
into it and have it lay things out like zero page right in the VMM code 
right?

I don't know off-hand, but is that how Firecracker boots an uncompressed 
Linux kernel? Anyone know?

Thanks,
-Maran

> I'm asking because there are several custom approaches to fast kernel
> boot and we should make sure that whatever Linux and QEMU end up
> natively supporting is likely to work for all projects (NEMU, qemu-lite,
> Firecracker) and operating systems (Linux distros, other OSes).
>
> Stefan
