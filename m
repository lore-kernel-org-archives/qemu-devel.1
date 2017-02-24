Received: from eggs.gnu.org ([2001:4830:134:3::10]:46500)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1chIey-0008Ga-Al
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:23:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1chIev-0002KB-3k
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:23:56 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45840)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1chIeu-0002Jt-Ti
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 11:23:53 -0500
References: <20170222183919.11928-1-ehabkost@redhat.com>
	<CAFEAcA8_SsbdXWFbAt+qKXF-XGBjAt=ZbDgzSaeXYFzYPL1KTQ@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6c2f2984-336b-8f03-8be2-4152e683b69a@redhat.com>
Date: Fri, 24 Feb 2017 17:23:48 +0100
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8_SsbdXWFbAt+qKXF-XGBjAt=ZbDgzSaeXYFzYPL1KTQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/3] i386: Add "max" CPU model to TCG
 and KVM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, Eduardo Habkost <ehabkost@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Richard W.M. Jones" <rjones@redhat.com>, Cornelia Huck <cornelia.huck@de.ibm.com>, "Daniel P. Berrange" <berrange@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Jiri Denemark <jdenemar@redhat.com>, Richard Henderson <rth@twiddle.net>, Christian Borntraeger <borntraeger@de.ibm.com>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>

Am 24.02.2017 um 14:48 schrieb Peter Maydell:
> On 22 February 2017 at 18:39, Eduardo Habkost <ehabkost@redhat.com> wrote:
>> Changes v1 -> v2:
>> * Fix build without CONFIG_KVM at lmce_supported()
>> * Rebased on top of my x86-next branch:
>>   https://github.com/ehabkost/qemu x86-next
>>
>> Git branch for testing:
>>   https://github.com/ehabkost/qemu-hacks work/x86-cpu-max-tcg
>>
>> libvirt code to use the new feature already exist, and were
>> submitted to libvir-list, at:
>>   https://www.mail-archive.com/libvir-list@redhat.com/msg142168.html
>>
>> ---
>>
>> This is a replacement for the previous series that enabled the
>> "host" CPU model on TCG. Now a new "max" CPU is being added,
>> while keeping "host" KVM-specific.
>>
>> In addition to simply adding "max" as a copy of the existing
>> "host" CPU model, additional patches change it to not use any
>> host CPUID information when in TCG mode.
> 
> 
> I had a look at implementing this for ARM, and ran into problems
> because of how we've done '-cpu host'. For us the "host" CPU
> type is registered dynamically when kvm_init() is called,
> because (a) it only exists if -enable-kvm and (b) it probes
> the kernel to find out what's available. So I could easily
> add 'max' in the same place; but then where should I add the
> type definition of 'max' for the non-KVM case?
> 
> Any suggestions?

Maybe switch to some late initialization?

On s390x, we register the host model right away, but fill it with life
in the initfn. If KVM is disabled, the host model will be available, but
we will deny to use it (via kvm_required).

For max, it would be the same thing. The initfn will simply inititalize
the model differently, depending on the selected accelerator.

When the models are inititalized, kvm is already up and running, so it
the kernel can be properly probed.

Not sure if that helps :)

-- 
Thanks,

David
