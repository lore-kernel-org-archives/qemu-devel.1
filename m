Received: from eggs.gnu.org ([2001:4830:134:3::10]:42910)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f3ziZ-0004ky-Mb
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 03:54:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f3ziU-0003Cn-Tx
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 03:53:59 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42618)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1f3ziU-0003Bm-LS
	for qemu-devel@nongnu.org; Thu, 05 Apr 2018 03:53:54 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w357nENf142445
	for <qemu-devel@nongnu.org>; Thu, 5 Apr 2018 03:53:52 -0400
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h5esp2mcu-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 05 Apr 2018 03:53:52 -0400
Received: from localhost
	by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 5 Apr 2018 08:53:50 +0100
References: <20180326092036.12780-1-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 5 Apr 2018 09:53:45 +0200
MIME-Version: 1.0
In-Reply-To: <20180326092036.12780-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Message-Id: <11ca3563-dd2c-f8b0-8336-323177477a00@de.ibm.com>
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
To: David Hildenbrand <david@redhat.com>, qemu-s390x@nongnu.org
Cc: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>



On 03/26/2018 11:20 AM, David Hildenbrand wrote:
> Manually having to use cpu_synchronize_state() is error prone. I don't
> think that the performance impact is that huge if we simply synchronize
> the state on every kvm_arch_handle_exit() call. This makes the code
> easier to maintain.
> 
> We now also call it (although not neded) for
> - KVM_EXIT_S390_RESET -> s390_reipl_request()
> - KVM_EXIT_DEBUG -> kvm_arch_handle_debug_exit()
> - unmanagable/unimplemented intercepts
> - ICPT_WAITPSW -> s390_handle_wait() -> cpu gets halted
> - ICPT_CPU_STOP -> do_stop_interrupt() -> cpu gets halted
> - Scenarios where we inject an operation exception
> - handle_sigp() on the source CPU
> - handle_stsi()
> 
> I don't think any of these are performance critical. Especially as we
> have all information directly contained in kvm_run, there are no
> additional IOCTLs to issue on modern kernels.

We had other issues in the past in other (common code) places. For example
see

commit 79ca7a1b898eb97c4192f3c78027a0f20485e7b4
Author:     Christian Borntraeger <borntraeger@de.ibm.com>
AuthorDate: Tue Mar 7 15:19:08 2017 +0100
Commit:     Paolo Bonzini <pbonzini@redhat.com>
CommitDate: Tue Mar 14 13:26:36 2017 +0100

    exec: add cpu_synchronize_state to cpu_memory_rw_debug

so we might consider going even further.....But this will be tricky.


FWIW, I think your patch even fixes a bug:

--- snip ----
static int handle_diag(S390CPU *cpu, struct kvm_run *run, uint32_t ipb)
{
    int r = 0;
    uint16_t func_code;

    /*
     * For any diagnose call we support, bits 48-63 of the resulting
     * address specify the function code; the remainder is ignored.
     */
    func_code = decode_basedisp_rs(&cpu->env, ipb, NULL) & DIAG_KVM_CODE_MASK;

---->
	static inline hwaddr decode_basedisp_s(CPUS390XState *env, uint32_t ipb,
	                                       uint8_t *ar)
	{
	    hwaddr addr = 0;
	    uint8_t reg;
	    
	    reg = ipb >> 28;
	    if (reg > 0) {
	        addr = env->regs[reg];

----> we do the sync_regs after this in the diag handler!
So currently we only handle the case with base reg == 0 correctly.
So
diag x,y,0x500(0) 
works


but things like
lghi 1,0x500
diag x,y,0(1)

not unless I miss something.


[...]
> @@ -1778,6 +1760,8 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
> 
>      qemu_mutex_lock_iothread();
> 
> +    cpu_synchronize_state(CPU(cpu));
> +
>      switch (run->exit_reason) {
>          case KVM_EXIT_S390_SIEIC:
>              ret = handle_intercept(cpu);
> 

Does it make sense to do this hunk NOW for 2.12 (cc stable)
and queue your full patch for 2.13?
