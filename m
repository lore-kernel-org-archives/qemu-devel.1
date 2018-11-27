Received: from eggs.gnu.org ([2001:4830:134:3::10]:53000)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gRfPj-0004FR-G3
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 10:36:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sameo@linux.intel.com>) id 1gRfPi-0003Ms-2y
	for qemu-devel@nongnu.org; Tue, 27 Nov 2018 10:36:39 -0500
Date: Tue, 27 Nov 2018 16:35:51 +0100
From: Samuel Ortiz <sameo@linux.intel.com>
Message-ID: <20181127153551.GC4393@caravaggio>
References: <20181113165247.4806-1-sameo@linux.intel.com>
	<20181113165247.4806-5-sameo@linux.intel.com>
	<CAFEAcA9wvrnshOTYz-jZ0n6m7SfusYY+bnB-iPnQuVNqqdg5Ww@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA9wvrnshOTYz-jZ0n6m7SfusYY+bnB-iPnQuVNqqdg5Ww@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH 04/13] target: arm: Move all interrupt and
 exception handlers into their own file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>

On Tue, Nov 20, 2018 at 01:45:03PM +0000, Peter Maydell wrote:
> On 13 November 2018 at 16:52, Samuel Ortiz <sameo@linux.intel.com> wrote:
> > Most of them are TCG dependent so we want to be able to not build them
> > in order to support TCG disablement with ARM.
> >
> > Signed-off-by: Samuel Ortiz <sameo@linux.intel.com>
> > Tested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> > Reviewed-by: Robert Bradford <robert.bradford@intel.com>
> > ---
> >  target/arm/excp_helper.c | 550 +++++++++++++++++++++++++++++++++++++++
> >  target/arm/helper.c      | 531 -------------------------------------
> >  target/arm/Makefile.objs |   2 +-
> >  3 files changed, 551 insertions(+), 532 deletions(-)
> >  create mode 100644 target/arm/excp_helper.c
> 
> You'll find that you need to rebase as there is a recent change
> that your moved copies are missing: commit e24ad484909e7.
> (I have just discovered git diff's --color-moved option which
> is great for checking this sort of code-movement patch.)
> 
> What is your plan for dealing with the way that the KVM code
> for injecting a breakpoint exception into the guest works
> by calling the do_interrupt code ?
> (see target/arm/kvm64.c:kvm_arm_handle_debug(),
> which calls cc->do_interrupt(cs).) This patch moves those
> functions to a file which won't be compiled and a later one
> in the series seems to stop cc->do_interrupt being set at all
> if CONFIG_TCG is not defined. That will result in QEMU crashing
> when it tries to inject an exception, won't it?
Yes, indeed.
So it seems we need to inject an exception back into the guest when
doing hardware assisted debugging and when we have not set any
breakpoint from QEMU. So it's essentially handling the debugging from
the guest case.
Would returning an error when that happens be an acceptable solution? So
when building qemu for arm64 with TCG disabled, one would basically no
longer be able to debug from the guest. Something along those lines:


diff --git a/target/arm/kvm64.c b/target/arm/kvm64.c
index 0a502091e7..3e8a871272 100644
--- a/target/arm/kvm64.c
+++ b/target/arm/kvm64.c
@@ -1079,6 +1079,11 @@ bool kvm_arm_handle_debug(CPUState *cs, struct kvm_debug_exit_arch *debug_exit)
                      __func__, debug_exit->hsr, env->pc);
     }
 
+    if (!tcg_enabled()) {
+        error_report("guest debugging not supported");
+        return false;
+    }
+
     /* If we are not handling the debug exception it must belong to
      * the guest. Let's re-use the existing TCG interrupt code to set
      * everything up properly.
