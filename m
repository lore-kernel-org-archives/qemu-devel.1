Received: from eggs.gnu.org ([2001:4830:134:3::10]:41651)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cGQ32-0007U7-3I
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 07:49:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cGQ2y-0007ce-1D
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 07:49:40 -0500
Received: from mail-vk0-f46.google.com ([209.85.213.46]:33335)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cGQ2x-0007cV-Sq
	for qemu-devel@nongnu.org; Mon, 12 Dec 2016 07:49:35 -0500
Received: by mail-vk0-f46.google.com with SMTP id 137so39598104vkl.0
	for <qemu-devel@nongnu.org>; Mon, 12 Dec 2016 04:49:35 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161102135933.h6clwz4ahsgchwgv@hawk.localdomain>
References: <CAFEAcA9_E=uPX5GqryrF4kyrXNYbH-8Oiv1mgbJM6VshnQe-kw@mail.gmail.com>
	<20161102135933.h6clwz4ahsgchwgv@hawk.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Dec 2016 12:48:14 +0000
Message-ID: <CAFEAcA9hb1M25AYnBDY0OYTMGvGe5VVR0SLg=T5MR_k1U_S=fw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] when we add EL2 to QEMU TCG ARM emulation and the
 virt board, should it default on or off?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Andrew Jones <drjones@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On 2 November 2016 at 13:59, Andrew Jones <drjones@redhat.com> wrote:
> On Tue, Nov 01, 2016 at 05:16:59PM +0000, Peter Maydell wrote:
>>  (2) directly user-set cpu property, or board property ?
>
> So this is why I was rambling above about the two precedents.
> IMO, we should choose a cpu property when it's a purely cpu
> feature, like the PMU, and board (without a user-settable cpu
> property) otherwise. Does this feature require board changes?
> I'm aware of switching the psci method from hvc to smc, but
> I'd shrug that one off. Is there anything else? If not, then
> I vote cpu property only.

So the things that the board needs to support EL2:
 * PSCI method change
 * need to wire up some interrupt lines (GICv3 maintenance
   interrupt, and VIRQ and VFIQ)
 * for GICv2 you would need also to set a property on
   the GIC to tell it to implement the virt extensions
   (for GICv3 this isn't necessary as the virt extensions
   only affect the CPU interface, which is strictly part
   of the CPU and which in my patches is configured via
   a back-door connection between the CPU proper and the
   GIC cpuif code)

You can do all the interrupt wiring unconditionally,
because if the CPU doesn't have EL2 then the extra
irq lines are just unused. And of course you can drive
the board changes off a CPU property value if you want...

The other reason I made EL3 have both a CPU property and a
board property is that it allowed us to have the board
property default to false (for back-compat) but the
CPU property default to true (so that any future boards
would get EL3 support by default, like the h/w -- you
can't get a real Cortex-A57 without EL2 and EL3).

thanks
-- PMM
