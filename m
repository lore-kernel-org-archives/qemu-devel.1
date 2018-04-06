Received: from eggs.gnu.org ([2001:4830:134:3::10]:43602)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f4NzQ-0003fl-QN
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1f4NzL-0004MI-RV
	for qemu-devel@nongnu.org; Fri, 06 Apr 2018 05:49:00 -0400
Date: Fri, 6 Apr 2018 11:48:51 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180406114851.4522c072.cohuck@redhat.com>
In-Reply-To: <0bef659c-1f6f-9f81-ba3b-1f0d8577cee8@redhat.com>
References: <20180406093552.13016-1-david@redhat.com>
	<02023ca6-bdab-5cf0-a882-b4c1e8c9e95b@redhat.com>
	<0bef659c-1f6f-9f81-ba3b-1f0d8577cee8@redhat.com>
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
Cc: Thomas Huth <thuth@redhat.com>, qemu-s390x@nongnu.org, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Alexander Graf <agraf@suse.de>, Christian Borntraeger <borntraeger@de.ibm.com>

On Fri, 6 Apr 2018 11:46:22 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 06.04.2018 11:40, Thomas Huth wrote:
> > On 06.04.2018 11:35, David Hildenbrand wrote:  
> >> Manually having to use cpu_synchronize_state() is error prone. And as
> >> Christian Borntraeger discovered, e.g. handle_diag() is currently
> >> missing a cpu_synchronize_state(), as decode_basedisp_s() uses a
> >> general purpose register value internally.
> >>
> >> So let's do an overall cpu_synchronize_state(), which fixes at least the
> >> one mentioned BUG. We will clean up the superfluous cpu_synchronize_state()
> >> calls later.
> >>
> >> We now also call it (although maybe not neded) for
> >> - KVM_EXIT_S390_RESET -> s390_reipl_request()
> >> - KVM_EXIT_DEBUG -> kvm_arch_handle_debug_exit()
> >> - unmanagable/unimplemented intercepts
> >> - ICPT_CPU_STOP -> do_stop_interrupt() -> cpu gets halted
> >> - Scenarios where we inject an operation exception
> >> - handle_stsi()
> >>
> >> I don't think any of these are performance critical. Especially as we
> >> have all information directly contained in kvm_run, there are no
> >> additional IOCTLs to issue on modern kernels.
> >>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  target/s390x/kvm.c | 2 ++
> >>  1 file changed, 2 insertions(+)
> >>
> >> diff --git a/target/s390x/kvm.c b/target/s390x/kvm.c
> >> index f570896dc1..fb59d92def 100644
> >> --- a/target/s390x/kvm.c
> >> +++ b/target/s390x/kvm.c
> >> @@ -1778,6 +1778,8 @@ int kvm_arch_handle_exit(CPUState *cs, struct kvm_run *run)
> >>  
> >>      qemu_mutex_lock_iothread();
> >>  
> >> +    cpu_synchronize_state(cs);  
> > 
> > Since we're in kvm.c here, maybe rather call kvm_cpu_synchronize_state()
> > directly to avoid the wrapper function?
> > 
> >  Thomas
> >   
> 
> No strong opinion. I can see that kvm_cpu_synchronize_state()
> - is not used in target/s390x/kvm.c yet
> - is very rarely used in kvm code in general
> 

Let's just go with this one for 2.12? If we want to switch to the kvm_*
variant, we can still do it for 2.13.
