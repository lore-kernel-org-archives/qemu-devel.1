Received: from eggs.gnu.org ([2001:4830:134:3::10]:35503)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tglx@linutronix.de>) id 1eWgQ4-0000Di-2B
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:37:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tglx@linutronix.de>) id 1eWgPz-0005qJ-4u
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:37:12 -0500
Received: from galois.linutronix.de ([2a01:7a0:2:106d:700::1]:45537)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <tglx@linutronix.de>) id 1eWgPy-0005oR-VC
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 05:37:07 -0500
Date: Wed, 3 Jan 2018 11:36:49 +0100 (CET)
From: Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <ec0baa05-eeb7-7baa-7bc6-062d7f52e6ec@collabora.com>
Message-ID: <alpine.DEB.2.20.1801031132540.1957@nanos>
References: <5a4c49c8.50b91c0a.2b051.322e@mx.google.com>
	<de09d482-9cf1-e695-ee57-f91e2277c8de@collabora.com>
	<alpine.DEB.2.20.1801031046270.1957@nanos>
	<ec0baa05-eeb7-7baa-7bc6-062d7f52e6ec@collabora.com>
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
To: Guillaume Tucker <guillaume.tucker@collabora.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Ingo Molnar <mingo@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, kernel-build-reports@lists.linaro.org, Matt Hart <matthew.hart@linaro.org>, stable@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org

On Wed, 3 Jan 2018, Guillaume Tucker wrote:
> On 03/01/18 09:48, Thomas Gleixner wrote:
> > > Well, it turns out this is not exactly a conflict as there's a
> > > subtle difference between the qemu devices in lab-mhart and in
> > > lab-collabora.  The ones in lab-collabora are configured to use
> > > KVM, and it looks like the ones in lab-mhart aren't.
> > > 
> > > So this job with KVM enabled passes in lab-collabora:
> > > 
> > >    https://lava.collabora.co.uk/scheduler/job/1032358
> > > 
> > > but it fails if I tell LAVA (qemu) to disable KVM:
> > > 
> > >    https://lava.collabora.co.uk/scheduler/job/1032359
> > > 
> > > with the same panic as in lab-mhart.  It seems like it's failing
> > > to return from an interrupt:
> > > 
> > >    http://lava.streamtester.net/scheduler/job/87308
> > > 
> > >    [    2.678828]  ? native_iret+0x7/0x7
> > >    [    2.679208] WARNING: can't dereference iret registers at
> > > 00000000ffc66068
> > > for ip page_fault+0x11/0x60
> > > 
> > > This triggered an automated bisection on kernelci.org, please see
> > > the results below.
> > > 
> > > I may run another bisection with this config enabled earlier in
> > > the history to track down the actual change in the code that
> > > introduced the issue, let me know if it's worth doing.
> > 
> > No, because before that commit not all pieces are in place.
> > 
> > Can you please try the failing kernel with pti=off on the command line?
> 
> It does boot with pti=off (and KVM disabled):
> 
>   https://lava.collabora.co.uk/scheduler/job/1032387

So it's a qemu issue. Added qemu folks on Cc.

> > I'll start a test instance here as well.
 
Thanks,

	tglx
