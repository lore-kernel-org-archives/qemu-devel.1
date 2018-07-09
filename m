Received: from eggs.gnu.org ([2001:4830:134:3::10]:42989)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fcZwN-00073m-3f
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:27:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1fcZwM-0000sH-2w
	for qemu-devel@nongnu.org; Mon, 09 Jul 2018 13:27:11 -0400
References: <1529500053-21704-1-git-send-email-eric.auger@redhat.com>
	<1529500053-21704-6-git-send-email-eric.auger@redhat.com>
	<20180703115507.nqmyo7c5q5lrevgt@kamzik.brq.redhat.com>
	<31c24e33-8fe8-a3c0-0430-d2f503f10932@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ef0b3c7a-4727-e76a-754b-fd5a5cf5ffdc@redhat.com>
Date: Mon, 9 Jul 2018 19:26:52 +0200
MIME-Version: 1.0
In-Reply-To: <31c24e33-8fe8-a3c0-0430-d2f503f10932@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 5/6] hw/arm/virt: support kvm_type property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>, Andrew Jones <drjones@redhat.com>
Cc: wei@redhat.com, peter.maydell@linaro.org, suzuki.poulose@arm.com, qemu-devel@nongnu.org, dgilbert@redhat.com, agraf@suse.de, qemu-arm@nongnu.org, david@gibson.dropbear.id.au, eric.auger.pro@gmail.com, qemu-ppc@nongnu.org

On 03.07.2018 14:31, Auger Eric wrote:
> Hi Drew,
> 
> On 07/03/2018 01:55 PM, Andrew Jones wrote:
>> On Wed, Jun 20, 2018 at 03:07:32PM +0200, Eric Auger wrote:
>>> The kvm-type property currently is used to pass
>>> a user parameter to KVM_CREATE_VM. This matches
>>> the way KVM/ARM expects to pass the max_vm_phys_shift
>>> parameter.
>>>
>>> This patch adds the support or the kvm-type property in
>>> machvirt and also implements the machine class kvm_type()
>>> callback so that it either returns the kvm-type value
>>> provided by the user or returns the max_vm_phys_shift
>>> exposed by KVM.
>>>
>>> for instance, the usespace can use the following option to
>>> instantiate a 42b IPA guest: -machine kvm-type=42
>>
>> 'kvm-type' is a very generic name. It looks like you're creating a KVM
>> VM of type 42 (which I assume is the ultimate KVM VM that answers the
>> meaning to Life, the Universe, and Everything), but it's not obvious
>> how it relates to physical address bits. Why not call this property
>> something like 'min_vm_phys_shift'? Notice the 'min' in the name,
>> because this is where the user is stating what the minimum number of
>> physical address bits required for the VM is. IIUC, if KVM supports
>> more, then it shouldn't be a problem.
> 
> Well I agree with you that using kvm-type=42 is not very nice.
> 
> On the other hand the current kernel API to pass the VM GPA address size
> is though the KVM_CREATE_VM kvm_type argument.
> 
> in accel/kvm/kvm-all.c there is all the infrastructure to fetch the
> generic machine kvm-type machine option and decode it into type, which
> is passed to KVM_CREATE_VM.
> 
> "
>     kvm_type = qemu_opt_get(qemu_get_machine_opts(), "kvm-type");
>     if (mc->kvm_type) {
>         type = mc->kvm_type(ms, kvm_type);
>     } else if (kvm_type) {
>         ret = -EINVAL;
>         fprintf(stderr, "Invalid argument kvm-type=%s\n", kvm_type);
>         goto err;
>     }
> 
>     do {
>         ret = kvm_ioctl(s, KVM_CREATE_VM, type);
>     } while (ret == -EINTR);
> "
> 
> This infrastructure already is used in hw/ppc/spapr.c

FWIW: The ppc code uses "kvm-type" to select the KVM implementation in
the kernel, since there are two implementations: kvm-pr (which is a
trap-and-emulate implementation) and kvm-hv (which is a
hardware-accelerated implementation). If you now introduce kvm-type for
ARM, too, but with a completely different meaning, I think that could
rather be confusing for the users...?

 Thomas
