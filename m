Received: from eggs.gnu.org ([2001:4830:134:3::10]:48796)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eD4Y6-0004By-WF
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 03:20:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eD4Y1-0008Bv-TL
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 03:20:26 -0500
Received: from mail.ispras.ru ([83.149.199.45]:45866)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dovgaluk@ispras.ru>) id 1eD4Y1-00088a-Ed
	for qemu-devel@nongnu.org; Fri, 10 Nov 2017 03:20:21 -0500
From: "Pavel Dovgalyuk" <dovgaluk@ispras.ru>
References: <20171031112457.10516.8971.stgit@pasha-VirtualBox>
	<20171031112644.10516.1734.stgit@pasha-VirtualBox>
	<a8979594-78e4-13dc-2958-f7b4444a1bb0@redhat.com>
	<001501d353cd$29099010$7b1cb030$@ru>
	<18ddcf7c-0198-a0ce-c2cc-992131512897@redhat.com>
	<fbda6d5e-aee1-ec74-faf4-e2dde0003588@redhat.com>
	<001201d3547d$929156c0$b7b40440$@ru>
	<954d2fb6-ce56-3000-f395-404c238eb040@redhat.com>
In-Reply-To: <954d2fb6-ce56-3000-f395-404c238eb040@redhat.com>
Date: Fri, 10 Nov 2017 11:20:23 +0300
Message-ID: <000301d359fc$c168fc30$443af490$@ru>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Content-Transfer-Encoding: 7bit
Content-Language: ru
Subject: Re: [Qemu-devel] [RFC PATCH 19/26] cpu-exec: reset exit flag before
 calling cpu_exec_nocache
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: 'Paolo Bonzini' <pbonzini@redhat.com>, 'Pavel Dovgalyuk' <Pavel.Dovgaluk@ispras.ru>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, mst@redhat.com, jasowang@redhat.com, quintela@redhat.com, zuban32s@gmail.com, maria.klimushenkova@ispras.ru, kraxel@redhat.com, boost.lists@gmail.com, alex.bennee@linaro.org

> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> On 03/11/2017 09:27, Pavel Dovgalyuk wrote:
> >> From: Paolo Bonzini [mailto:pbonzini@redhat.com]
> >> On 02/11/2017 12:33, Paolo Bonzini wrote:
> >>> On 02/11/2017 12:24, Pavel Dovgalyuk wrote:
> >>>>> I am not sure about this.  I think if instead you should return false
> >>>>> from here and EXCP_INTERRUPT from cpu_exec.
> >>>> The problem is inside the TB. It checks cpu->icount_decr.u16.high which is -1.
> >>>> And we have to enter the TB to cause an exception (because it exists in replay log).
> >>>> That is why we reset this flag and try to execute the TB.
> >>>
> >>> But if u16.high is -1, shouldn't you return EXCP_INTERRUPT first (via
> >>> "Finally, check if we need to exit to the main loop" in
> >>> cpu_handle_interrupt)?  Then only cause the exception when that one is
> >>> processed.
> >>
> >> ... indeed, you probably need something like:
> >>
> >>     /* Clear the interrupt flag now since we're processing
> >>      * cpu->interrupt_request and cpu->exit_request.
> >>      */
> >>     insns_left = atomic_read(&cpu->icount_decr.u32);
> >>     atomic_set(&cpu->icount_decr.u16.high, 0);
> >>     if (unlikely(insns_left < 0) {
> >>         /* Ensure the zeroing of icount_decr comes before the next read
> >>          * of cpu->exit_request or cpu->interrupt_request.
> >>          */
> >>         smb_mb();
> >>     }
> >>
> >> at the top of cpu_handle_interrupt.  Then you can remove the same
> >> atomic_set+smp_mb in cpu_loop_exec_tb, like
> >>
> >>     *last_tb = NULL;
> >>     insns_left = atomic_read(&cpu->icount_decr.u32);
> >>     if (insns_left < 0) {
> >>         /* Something asked us to stop executing chained TBs; just
> >>          * continue round the main loop. Whatever requested the exit
> >>          * will also have set something else (eg exit_request or
> >>          * interrupt_request) which will be handled by
> >>          * cpu_handle_interrupt.  cpu_handle_interrupt will also
> >>          * clear cpu->icount_decr.u16.high.
> >>          */
> >>         return;
> >>     }
> >
> > I tried this approach and it didn't work.
> > I think iothread sets u16.high flag after resetting it in cpu_handle_interrupt.
> 
> But why is this a problem?  The TB would exit immediately and go again
> to cpu_handle_interrupt.  cpu_handle_interrupt returns true and
> cpu_handle_exception causes the exception via cpu_exec_nocache.

I've tested your variant more thoroughly.
It seems, that iothread calls cpu_exec between atomic_set(&cpu->icount_decr.u16.high, 0); 
in cpu_handle_interrupt and cpu_exec_nocache in cpu_handle_exception.
I see no other reason, because this happens not for the every time.
And cpu_handle_interrupt is not called again, because cpu_handle_exception returns true.
Therefore we have an infinite loop, because no other code here resets cpu->icount_decr.u16.high.

Pavel Dovgalyuk
