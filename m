Received: from eggs.gnu.org ([2001:4830:134:3::10]:55342)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f4P58-0003VS-Vt
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f4P54-0006pN-2r
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 06:58:59 -0400
Date: Fri, 6 Apr 2018 12:58:50 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180406125850.64f2ff58.cohuck@redhat.com>
In-Reply-To: <20180406093552.13016-1-david@redhat.com>
References: <20180406093552.13016-1-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
To: David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Huth <thuth@redhat.com>

On Fri,  6 Apr 2018 11:35:52 +0200
David Hildenbrand <david@redhat.com> wrote:

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

Thanks, queued to s390-fixes.
