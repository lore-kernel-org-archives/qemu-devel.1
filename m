Received: from eggs.gnu.org ([2001:4830:134:3::10]:55433)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f4OJz-0004uK-Hh
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:10:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1f4OJv-0006Ta-7G
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:10:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55902)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1f4OJu-0006Sz-V7
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:10:11 -0400
Received: from pps.filterd (m0098396.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
	w36A1EFs086002
	for <qemu-devel@nongnu.org>; Fri, 6 Apr 2018 06:10:09 -0400
Received: from e06smtp10.uk.ibm.com (e06smtp10.uk.ibm.com [195.75.94.106])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2h65uqb92h-1
	(version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 06 Apr 2018 06:10:09 -0400
Received: from localhost
	by e06smtp10.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Fri, 6 Apr 2018 11:10:06 +0100
References: <20180406093552.13016-1-david@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 6 Apr 2018 12:10:02 +0200
MIME-Version: 1.0
In-Reply-To: <20180406093552.13016-1-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <eea39d3b-84d7-4b27-bff4-ad4a5b73bc1a@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v1 for-2.12] s390x/kvm: call
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



On 04/06/2018 11:35 AM, David Hildenbrand wrote:
> Manually having to use cpu_synchronize_state() is error prone. And as
> Christian Borntraeger discovered, e.g. handle_diag() is currently
> missing a cpu_synchronize_state(), as decode_basedisp_s() uses a
> general purpose register value internally.
> 
> So let's do an overall cpu_synchronize_state(), which fixes at least the
> one mentioned BUG. We will clean up the superfluous cpu_synchronize_state()
> calls later.
> 
> We now also call it (although maybe not neded) for
> - KVM_EXIT_S390_RESET -> s390_reipl_request()
> - KVM_EXIT_DEBUG -> kvm_arch_handle_debug_exit()
> - unmanagable/unimplemented intercepts
> - ICPT_CPU_STOP -> do_stop_interrupt() -> cpu gets halted
> - Scenarios where we inject an operation exception
> - handle_stsi()
> 
> I don't think any of these are performance critical. Especially as we
> have all information directly contained in kvm_run, there are no
> additional IOCTLs to issue on modern kernels.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>

ok for 2.12.
> ---
>  target/s390x/kvm.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> index f570896dc1..fb59d92def 100644
> --- a/target/s390x/kvm.c
> +++ b/target/s390x/kvm.c
> @@ -1778,6 +1778,8 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
> 
>      qemu_mutex_lock_iothread();
> 
> +    cpu_synchronize_state(cs);
> +
>      switch (run->exit_reason) {
>          case KVM_EXIT_S390_SIEIC:
>              ret = handle_intercept(cpu);
> 
