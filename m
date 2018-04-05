Received: from eggs.gnu.org ([2001:4830:134:3::10]:47903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f407U-00060d-N9
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 04:19:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1f407P-0003xm-OV
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 04:19:44 -0400
References: <20180326092036.12780-1-david@redhat.com>
	<11ca3563-dd2c-f8b0-8336-323177477a00@de.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <01b7db2f-d3a7-f9b1-2e76-9f33107cff4c@redhat.com>
Date: Thu, 5 Apr 2018 10:19:24 +0200
MIME-Version: 1.0
In-Reply-To: <11ca3563-dd2c-f8b0-8336-323177477a00@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH RFC] s390x/kvm: call
 cpu_synchronize_state() on every kvm_arch_handle_exit()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christian Borntraeger <borntraeger@de.ibm.com>, David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>

On 05.04.2018 09:53, Christian Borntraeger wrote:
> 
> 
> On 03/26/2018 11:20 AM, David Hildenbrand wrote:
>> Manually having to use cpu_synchronize_state() is error prone. I don't
>> think that the performance impact is that huge if we simply synchronize
>> the state on every kvm_arch_handle_exit() call. This makes the code
>> easier to maintain.
>>
>> We now also call it (although not neded) for
>> - KVM_EXIT_S390_RESET -> s390_reipl_request()
>> - KVM_EXIT_DEBUG -> kvm_arch_handle_debug_exit()
>> - unmanagable/unimplemented intercepts
>> - ICPT_WAITPSW -> s390_handle_wait() -> cpu gets halted
>> - ICPT_CPU_STOP -> do_stop_interrupt() -> cpu gets halted
>> - Scenarios where we inject an operation exception
>> - handle_sigp() on the source CPU
>> - handle_stsi()
>>
>> I don't think any of these are performance critical. Especially as we
>> have all information directly contained in kvm_run, there are no
>> additional IOCTLs to issue on modern kernels.
> 
> We had other issues in the past in other (common code) places. For example
> see
> 
> commit 79ca7a1b898eb97c4192f3c78027a0f20485e7b4
> Author:     Christian Borntraeger <borntraeger@de.ibm.com>
> AuthorDate: Tue Mar 7 15:19:08 2017 +0100
> Commit:     Paolo Bonzini <pbonzini@redhat.com>
> CommitDate: Tue Mar 14 13:26:36 2017 +0100
> 
>     exec: add cpu_synchronize_state to cpu_memory_rw_debug
> 
> so we might consider going even further.....But this will be tricky.
> 
> 
> FWIW, I think your patch even fixes a bug:
> 
> --- snip ----
> static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
> {
>     int r = 0;
>     uint16_t func_code;
> 
>     /*
>      * For any diagnose call we support, bits 48-63 of the resulting
>      * address specify the function code; the remainder is ignored.
>      */
>     func_code = decode_basedisp_rs(&cpu->env, ipb, NULL) & DIAG_KVM_CODE_MASK;
> 
> ---->
> 	static inline hwaddr decode_basedisp_s(CPUS390XState *env, uint32_t ipb,
> 	                                       uint8_t *ar)
> 	{
> 	    hwaddr addr = 0;
> 	    uint8_t reg;
> 	    
> 	    reg = ipb >> 28;
> 	    if (reg > 0) {
> 	        addr = env->regs[reg];
> 
> ----> we do the sync_regs after this in the diag handler!
> So currently we only handle the case with base reg == 0 correctly.
> So
> diag x,y,0x500(0) 
> works
> 
> 
> but things like
> lghi 1,0x500
> diag x,y,0(1)
> 
> not unless I miss something.

FWIW: Sounds like a good idea for a new kvm-unit-test... any volunteers?

 Thomas
