Received: from eggs.gnu.org ([2001:4830:134:3::10]:57431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kirkseraph@gmail.com>) id 1cPVcI-000753-4f
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 09:35:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kirkseraph@gmail.com>) id 1cPVcD-000607-Fj
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 09:35:38 -0500
Date: Fri, 6 Jan 2017 15:35:27 +0100
From: Seraphime Kirkovski <kirkseraph@gmail.com>
Message-ID: <20170106143527.sdto622nm6hflp5b@roojbos.sk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: Re: [Qemu-devel] [RESEND PATCH] target-arm/abi32: check for
 segfault in do_kernel_trap
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Riku Voipio <riku.voipio@iki.fi>, qemu-arm <qemu-arm@nongnu.org>

<riku.voipio@iki.fi>,qemu-arm <qemu-arm@nongnu.org>
Bcc:
Subject: Re: [Qemu-devel] [RESEND PATCH] target-arm/abi32: check for 
segfault in do_kernel_trap
Reply-To: In-Reply-To: 
<CAFEAcA-9aYRHcn1dAD0xuR9H8sJ__HOK9ayWmsK7H-Cr2rj4SQ@mail.gmail.com>

Hi Peter,
thanks for the feedback.

On Thu, Jan 05, 2017 at 02:42:38PM +0000, Peter Maydell wrote:
> If you compare what happens with this segv code with
> what happens for the segvs detected inside
> arm_kernel_cmpxchg64_helper(), there's a difference.
> With this code we will queue the signal and then return,
> skipping the code which updates env->regs[15] and env->thumb.
> The existing codepath for cmpxchg64 doesn't skip that code.
> The effect is that for cmpxchg64 the SEGV signal handler
> will see a PC pointing at the call into the kernel commpage,
> whereas for this code it will see the PC actually in the
> kernel commpage.
> 
> I'm not sure which of these options is the best choice,
> but I do think we should be consistent.

I think it would be safer to keep the current behaviour.

In terms of implementation, I find it would be better to extract the 
__kernel_cmpxchg code in a separate function. On the one hand, this 
would avoid code duplication or strange gotos and make do_kernel_trap
more readable. On the other hand, this would clutter a bit git history.
If it is acceptable, I will send a patch with those changes. If not, 
will try to find a cleaner solution without creating new functions.

Cheers,
Seraphime Kirkovski
