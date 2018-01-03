Received: from eggs.gnu.org ([2001:4830:134:3::10]:53273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tglx@linutronix.de>) id 1eWp8G-00058h-3P
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 14:55:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tglx@linutronix.de>) id 1eWp8A-00077L-Tq
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 14:55:23 -0500
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1]:47062)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tglx@linutronix.de>) id 1eWp8A-00074q-NO
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 14:55:18 -0500
Date: Wed, 3 Jan 2018 20:55:06 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <e2ca38ba-41c5-5f3a-849a-340a3ac76b6d@redhat.com>
Message-ID: <alpine.DEB.2.20.1801032053040.1957@nanos>
References: <5a4c49c8.50b91c0a.2b051.322e@mx.google.com>
	<de09d482-9cf1-e695-ee57-f91e2277c8de@collabora.com>
	<alpine.DEB.2.20.1801031046270.1957@nanos>
	<ec0baa05-eeb7-7baa-7bc6-062d7f52e6ec@collabora.com>
	<alpine.DEB.2.20.1801031132540.1957@nanos>
	<e2ca38ba-41c5-5f3a-849a-340a3ac76b6d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Subject: Re: [Qemu-devel] stable/linux-4.14.y boot: 108 boots: 0 failed,
 107 passed with 1 conflict (v4.14.11)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Guillaume Tucker <guillaume.tucker@collabora.com>, Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-build-reports@lists.linaro.org, Matt Hart <matthew.hart@linaro.org>, stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, qemu-devel@nongnu.org

On Wed, 3 Jan 2018, Paolo Bonzini wrote:
> On 03/01/2018 11:36, Thomas Gleixner wrote:
> > On Wed, 3 Jan 2018, Guillaume Tucker wrote:
> >> On 03/01/18 09:48, Thomas Gleixner wrote:
> >>>> Well, it turns out this is not exactly a conflict as there's a
> >>>> subtle difference between the qemu devices in lab-mhart and in
> >>>> lab-collabora.  The ones in lab-collabora are configured to use
> >>>> KVM, and it looks like the ones in lab-mhart aren't.
> >>>>
> >>>> So this job with KVM enabled passes in lab-collabora:
> >>>>
> >>>>    https://lava.collabora.co.uk/scheduler/job/1032358
> >>>>
> >>>> but it fails if I tell LAVA (qemu) to disable KVM:
> >>>>
> >>>>    https://lava.collabora.co.uk/scheduler/job/1032359
> >>>>
> >>>> with the same panic as in lab-mhart.  It seems like it's failing
> >>>> to return from an interrupt:
> >>>>
> >>>>    http://lava.streamtester.net/scheduler/job/87308
> >>>>
> >>>>    [    2.678828]  ? native_iret+0x7/0x7
> >>>>    [    2.679208] WARNING: can't dereference iret registers at
> >>>> 00000000ffc66068
> >>>> for ip page_fault+0x11/0x60
> >>>>
> >>>> This triggered an automated bisection on kernelci.org, please see
> >>>> the results below.
> >>>>
> >>>> I may run another bisection with this config enabled earlier in
> >>>> the history to track down the actual change in the code that
> >>>> introduced the issue, let me know if it's worth doing.
> >>>
> >>> No, because before that commit not all pieces are in place.
> >>>
> >>> Can you please try the failing kernel with pti=off on the command line?
> >>
> >> It does boot with pti=off (and KVM disabled):
> >>
> >>   https://lava.collabora.co.uk/scheduler/job/1032387
> > 
> > So it's a qemu issue. Added qemu folks on Cc.
> 
> Reproduced, thanks.  I will look into it.

I just noticed that the qemu instance emulates an AMD CPU.

We discovered an AMD related issue which fits in the problem you are seing
today.

Can you try the patch below please?

Thanks,

	tglx

8<------------------

--- a/arch/x86/entry/entry_64_compat.S
+++ b/arch/x86/entry/entry_64_compat.S
@@ -190,8 +190,13 @@ ENTRY(entry_SYSCALL_compat)
 	/* Interrupts are off on entry. */
 	swapgs
 
-	/* Stash user ESP and switch to the kernel stack. */
+	/* Stash user ESP */
 	movl	%esp, %r8d
+
+	/* Use %rsp as scratch reg. User ESP is stashed in r8 */
+	SWITCH_TO_KERNEL_CR3 scratch_reg=%rsp
+	
+	/* Switch to the kernel stack */
 	movq	PER_CPU_VAR(cpu_current_top_of_stack), %rsp
 
 	/* Construct struct pt_regs on stack */
@@ -220,12 +225,6 @@ GLOBAL(entry_SYSCALL_compat_after_hwfram
 	pushq   $0			/* pt_regs->r15 = 0 */
 
 	/*
-	 * We just saved %rdi so it is safe to clobber.  It is not
-	 * preserved during the C calls inside TRACE_IRQS_OFF anyway.
-	 */
-	SWITCH_TO_KERNEL_CR3 scratch_reg=%rdi
-
-	/*
 	 * User mode is traced as though IRQs are on, and SYSENTER
 	 * turned them off.
 	 */
