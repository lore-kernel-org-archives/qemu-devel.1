Received: from eggs.gnu.org ([2001:4830:134:3::10]:35668)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fW27n-0001pI-UJ
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:07:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1fW27i-0003ML-VM
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 12:07:55 -0400
References: <20180424101859.10239-1-david@redhat.com>
	<7c046e3c-8752-87c5-f4ff-06ef56ef0128@de.ibm.com>
	<20180621180443.1f0dc588.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9b9aaca9-5d32-73a0-049f-ee4c08b0b388@redhat.com>
Date: Thu, 21 Jun 2018 18:07:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180621180443.1f0dc588.cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v1] s390x: refactor reset/reipl handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 21.06.2018 18:04, Cornelia Huck wrote:
> On Thu, 21 Jun 2018 17:49:56 +0200
> Christian Borntraeger <borntraeger@de.ibm.com> wrote:
> 
>> On 04/24/2018 12:18 PM, David Hildenbrand wrote:
>>> Calling pause_all_vcpus()/resume_all_vcpus() from a VCPU thread might
>>> not be the best idea. As pause_all_vcpus() temporarily drops the qemu
>>> mutex, two parallel calls to pause_all_vcpus() can be active at a time,
>>> resulting in a deadlock. (either by two VCPUs or by the main thread and a
>>> VCPU)
>>>
>>> Let's handle it via the main loop instead, as suggested by Paolo. If we
>>> would have two parallel reset requests by two different VCPUs at the
>>> same time, the last one would win.
>>>
>>> We use the existing ipl device to handle it. The nice side effect is
>>> that we can get rid of reipl_requested.
>>>
>>> This change implies that all reset handling now goes via the common
>>> path, so "no-reboot" handling is now active for all kinds of reboots.  
>>
>> Ok, this breaks the s390 IPL process when -no-reboot  is specified.
>> The bios does a diagnose 308 subcode 1 to jump to the final image while
>> at the same time resetting all devices. This is now blocked with -no-reboot
>> (although it is actually the boot)
>>
>>
>> I have noticed that with virt-install on iso images since virt-install
>> specifies -no-reboot.
>>
>> Something like this seems to help but it is not a nice solution.
> 
> It's a bit ugly, but allows us to accommodate the different semantics
> for the different diag subcodes... the -no-reboot parameter is only
> supposed to suppress normal guest reboot requests, right?

The question is if -no-reboot should also be considered for kexec. There
are (at least on x86, not sure about s390x) "fast reboot techniques
using kexec". So it feels like -no-reboot should also apply for kexec.
But definitely not for the BIOS :)


-- 

Thanks,

David / dhildenb
