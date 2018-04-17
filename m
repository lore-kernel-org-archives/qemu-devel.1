Received: from eggs.gnu.org ([2001:4830:134:3::10]:45987)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f8OuD-00039N-Cm
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 07:36:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1f8OuC-00059H-Bi
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 07:36:13 -0400
Date: Tue, 17 Apr 2018 13:35:44 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20180417133544.0102ef0b@redhat.com>
In-Reply-To: <CAFEAcA_nM4VanwwPKB3bpL6=wvk=u-bh1b+O3ahNFMpRnchcsg@mail.gmail.com>
References: <1523551221-11612-1-git-send-email-imammedo@redhat.com>
	<1523551221-11612-4-git-send-email-imammedo@redhat.com>
	<CAFEAcA-AVuHMao5kQUrfEYWpGL0y-CwbuqCA_8ZSZrVbqz9nCg@mail.gmail.com>
	<CAFEAcA_nM4VanwwPKB3bpL6=wvk=u-bh1b+O3ahNFMpRnchcsg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-2.13 3/4] arm: always start
 from first_cpu when registering loader cpu reset callback
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Eric Auger <eric.auger@redhat.com>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>

On Mon, 16 Apr 2018 18:17:51 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 12 April 2018 at 19:29, Peter Maydell <peter.maydell@linaro.org> wrote:
> > On 12 April 2018 at 17:40, Igor Mammedov <imammedo@redhat.com> wrote:  
> >> if arm_load_kernel() were passed non first_cpu, QEMU would end up
> >> with partially set do_cpu_reset() callback leaving some CPUs without it.
> >>
> >> Make sure that do_cpu_reset() is registered for all CPUs by enumerating
> >> CPUs from first_cpu.
> >>
> >> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> >> ---
> >>  hw/arm/boot.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/hw/arm/boot.c b/hw/arm/boot.c
> >> index 2f464ca..2591fee 100644
> >> --- a/hw/arm/boot.c
> >> +++ b/hw/arm/boot.c
> >> @@ -1188,7 +1188,7 @@ void arm_load_kernel(ARMCPU *cpu, struct arm_boot_info *info)
> >>       * actually loading a kernel, the handler is also responsible for
> >>       * arranging that we start it correctly.
> >>       */
> >> -    for (cs = CPU(cpu); cs; cs = CPU_NEXT(cs)) {
> >> +    for (cs = first_cpu; cs; cs = CPU_NEXT(cs)) {
> >>          qemu_register_reset(do_cpu_reset, ARM_CPU(cs));
> >>      }
> >>  }  
> >
> > Definitely a bug fix, so:
> > Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> >
> > I think though that in at least some cases we'll still mishandle
> > being passed anything other than first_cpu as the CPU pointer,
> > because in do_cpu_reset() we do some checks for "do this if
> > cs == first_cpu", on the assumption that first_cpu is the
> > primary CPU that we're booting. We should instead I suppose
> > be checking against the CPU pointer we're given as the
> > arm_load_kernel() argument (which I think do_cpu_reset() can
> > get at via info->load_kernel_notifier.cpu).
> >
> > We should probably analyse which boards actually pass anything
> > other than first_cpu -- I suspect it will end up just being
> > the xilinx board which has both A and R profile cores...  
> 
> I did the check, and in fact all of our boards always pass the
> first CPU as the boot CPU. Xilinx comes the closest, in that
> the SoC object has a boot-cpu property to pick a boot CPU, but
> since none of our boards set that it defaults to the first CPU.
> 
> Since this patch isn't very related to the rest of the series
> I've just applied it to target-arm.next ready for 2.13 (with
> a note in the commit message that in practice it isn't a behaviour
> change). Let me know if that's awkward for you and you'd prefer
> to keep it in this series, in which case I'll drop it.
That's fine, I'll just rebase v2 on top of it.

> 
> thanks
> -- PMM
