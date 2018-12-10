Received: from eggs.gnu.org ([2001:4830:134:3::10]:54324)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gWL3J-0005lm-OS
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 07:52:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <farosas@linux.ibm.com>) id 1gWL3G-0005Tt-J0
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 07:52:49 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:38914)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <farosas@linux.ibm.com>)
	id 1gWL3F-0005T0-Rz
	for qemu-devel@nongnu.org; Mon, 10 Dec 2018 07:52:46 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	wBACo3M1084966
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 07:52:43 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2p9q4x45xg-1
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 10 Dec 2018 07:52:43 -0500
Received: from localhost
	by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <farosas@linux.ibm.com>;
	Mon, 10 Dec 2018 12:52:42 -0000
From: Fabiano Rosas <farosas@linux.ibm.com>
In-Reply-To: <20181202091317.GM30479@umbus.fritz.box>
References: <20181121181347.24035-1-farosas@linux.ibm.com>
	<20181121181347.24035-4-farosas@linux.ibm.com>
	<20181126074100.GJ2251@umbus.fritz.box>
	<87h8fymgyq.fsf@linux.ibm.com>
	<20181202091317.GM30479@umbus.fritz.box>
Date: Mon, 10 Dec 2018 10:52:18 -0200
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87d0q9mtml.fsf@linux.ibm.com>
Subject: Re: [Qemu-devel] [RFC PATCH v2 3/3] target/ppc: support single
 stepping with KVM HV
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: Peter Maydell <peter.maydell@linaro.org>, Cornelia Huck <cohuck@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, James Hogan <jhogan@kernel.org>, Marcelo Tosatti <mtosatti@redhat.com>, David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org, Christian Borntraeger <borntraeger@de.ibm.com>, Aleksandar Markovic <amarkovic@wavecomp.com>, Paolo Bonzini <pbonzini@redhat.com>, philmd@redhat.com, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

David Gibson <david@gibson.dropbear.id.au> writes:

>> >> +    if (arch_info->address == trace_handler_addr) {
>> >> +        cpu_synchronize_state(cs);
>> >> +        kvm_remove_breakpoint(cs, trace_handler_addr, 4, GDB_BREAKPOINT_SW);
>> >> +
>> >> +        cpu_memory_rw_debug(cs, env->spr[SPR_SRR0] - 4, (uint8_t *)&insn,
>> >> +                            sizeof(insn), 0);
>> >> +
>> >> +        /* If the last instruction was a mfmsr, make sure that the
>> >> +         * MSR_SE bit is not set to avoid the guest kernel knowing
>> >> +         * that it is being single-stepped */
>> >> +        if (extract32(insn, 26, 6) == 31 && extract32(insn, 1, 10) == 83) {
>> >> +            reg = extract32(insn, 21, 5);
>> >> +            env->gpr[reg] &= ~(1ULL << MSR_SE);
>> >> +        }
>> >
>> > Hm.  What happens if both qemu and the guest itself attempt to single
>> > step at the same time?  How do you distinguish between the cases?
>> 
>> There is currently no distinction being made.
>
> This seems incorrect to me.  Basically you're restoring !MSR_SE
> unconditionaly when you finish the hypervisor side step, which might
> not be correct if the guest is also attempting to single step itself.
> AFAICT it should be possible to track what the guest thinks is the
> value of MSR_SE and restore that.

I was skeptical of being able to do both single steps at the same time
but I found a way to reproduce it by stepping over an rfid when
SRR1_SE is already 1.

>  If both hypervisor and guest
> attempt to single step, I'd expect to have the hypervisor trap first,
> then return to the guest's single step vector.

With the fix you suggest above, QEMU will be able to single step the
interrupt handler during the guest's single step. That means I'll have
to restore the SRRs as well so that the handler returns to the correct
place.

>> I could do the latter, if you prefer.
>
> I think that's better - I don't think it's safe to assume that you're
> *not* synchronized with KVM.

Ok, that's better indeed.

Thanks for the comments, I'll prepare another version with the
appropriate corrections.
