Received: from eggs.gnu.org ([2001:4830:134:3::10]:58559)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <nikunj.dadhania@gmail.com>) id 1dWDwl-0007A9-4E
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 23:40:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <nikunj.dadhania@gmail.com>) id 1dWDwk-00074d-2r
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 23:40:47 -0400
MIME-Version: 1.0
In-Reply-To: <1500086333.2865.102.camel@au1.ibm.com>
References: <20170714040437.22034-1-nikunj@linux.vnet.ibm.com>
	<1500086333.2865.102.camel@au1.ibm.com>
From: Nikunj Dadhania <nikunj.dadhania@gmail.com>
Date: Sat, 15 Jul 2017 09:10:42 +0530
Message-ID: <CALAZu3-3i-uvGDedB_MdUaLEqJyck5sU_cPVLOuBbBwMkMVkBw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2] spapr: ignore decr
 interrupts when MSR_EE is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: benh@au1.ibm.com
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, qemu-ppc@nongnu.org, Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, bharata@linux.vnet.ibm.com, clg@kaod.org

On 15-Jul-2017 8:10 AM, "Benjamin Herrenschmidt" <benh@au1.ibm.com> wrote:

On Fri, 2017-07-14 at 09:34 +0530, Nikunj A Dadhania wrote:
> Rebooting a SMP TCG guest is broken for both single/multi threaded TCG.
>
> When reset happens, all the CPUs are in halted state. First CPU is
brought out
> of reset and secondary CPUs would be initialized by the guest kernel
using a
> rtas call start-cpu.
>
> However, in case of TCG, decrementer interrupts keep on coming and waking
the
> secondary CPUs up.
>
> These secondary CPUs would see the decrementer interrupt pending, which
makes
> cpu::has_work() to bring them out of wait loop and start executing
> tcg_exec_cpu().
>
> The problem with this is all the CPUs wake up and start booting SLOF
image,
> causing the following exception(4 CPUs TCG VM):

This patch isn't right....

> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -8536,7 +8536,8 @@ static bool cpu_has_work_POWER7(CPUState *cs)
>          }
>          if ((env->pending_interrupts & (1u << PPC_INTERRUPT_DECR)) &&
>              (env->spr[SPR_LPCR] & LPCR_P7_PECE1)) {
> -            return true;
> +            /* Return true only when MSR_EE is enabled */
> +            return msr_ee;
>          }

No, the HW will not check MSR_EE, in fact, MSR_EE can purposefully be
left off and we might expect a wakeup still.


Here we had a decr timer callback which is started during machine init and
remains on even during reset.

In case of HW, does the decr stop on reset?


I think the right fix is for reset to clear the LPCR PECE bits.


Ok, let me try that out.

Regards
Nikunj
