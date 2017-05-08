Received: from eggs.gnu.org ([2001:4830:134:3::10]:37185)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1d7nIn-0008Am-C6
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:22:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <k.kozlowski.k@gmail.com>) id 1d7nIm-0001Od-B4
	for qemu-devel@nongnu.org; Mon, 08 May 2017 14:22:33 -0400
Date: Mon, 8 May 2017 20:22:24 +0200
From: Krzysztof Kozlowski <krzk@kernel.org>
Message-ID: <20170508182224.dfbvmfb4fxfbe3ys@kozik-lap>
References: <20170507113540.8687-1-krzk@kernel.org>
	<20170507113540.8687-4-krzk@kernel.org>
	<f8b021fa-e3f8-50d7-8013-d67e66e25ce6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f8b021fa-e3f8-50d7-8013-d67e66e25ce6@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/3] hw/arm/exynos: Add support for system
 poweroff
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: Igor Mitsyanko <i.mitsyanko@gmail.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

On Mon, May 08, 2017 at 09:21:40AM -0500, Eric Blake wrote:
> On 05/07/2017 06:35 AM, Krzysztof Kozlowski wrote:
> > On all Exynos-based boards, the system powers down itself by driving
> > PS_HOLD signal low.  Handle writing to respective PMU register to fix
> > power off failure:
> > 
> >     reboot: Power down
> >     Unable to poweroff system
> >     shutdown: 31 output lines suppressed due to ratelimiting
> >     Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000000
> > 
> >     CPU: 0 PID: 1 Comm: shutdown Not tainted 4.11.0-rc8 #846
> >     Hardware name: SAMSUNG EXYNOS (Flattened Device Tree)
> >     [<c031050c>] (unwind_backtrace) from [<c030ba6c>] (show_stack+0x10/0x14)
> >     [<c030ba6c>] (show_stack) from [<c05b2800>] (dump_stack+0x88/0x9c)
> >     [<c05b2800>] (dump_stack) from [<c03d3140>] (panic+0xdc/0x268)
> >     [<c03d3140>] (panic) from [<c0343614>] (do_exit+0xa90/0xab4)
> >     [<c0343614>] (do_exit) from [<c035f2dc>] (SyS_reboot+0x164/0x1d0)
> >     [<c035f2dc>] (SyS_reboot) from [<c0307c80>] (ret_fast_syscall+0x0/0x3c)
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> > ---
> >  hw/misc/exynos4210_pmu.c | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> 
> > @@ -397,6 +398,12 @@ typedef struct Exynos4210PmuState {
> >      uint32_t reg[PMU_NUM_OF_REGISTERS];
> >  } Exynos4210PmuState;
> >  
> > +static void exynos4210_pmu_poweroff(void)
> > +{
> > +    PRINT_DEBUG("QEMU PMU: PS_HOLD bit down, powering off\n");
> > +    qemu_system_shutdown_request();
> 
> Depending on whether your patch lands before or after mine, we'll have
> to update this. It sounds like it is a guest-triggered reset, so my
> patch would have this use SHUTDOWN_CAUSE_GUEST_SHUTDOWN.
> 
> https://lists.gnu.org/archive/html/qemu-devel/2017-05/msg01380.html

Sure, I can rebase and fix the difference once your patchset gets in.

Best regards,
Krzysztof
