Received: from eggs.gnu.org ([2001:4830:134:3::10]:52881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <benh@au1.ibm.com>) id 1dWCz8-0006EK-0S
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 22:39:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <benh@au1.ibm.com>) id 1dWCz4-0001JO-TT
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 22:39:10 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:47641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <benh@au1.ibm.com>) id 1dWCz4-0001I9-J0
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 22:39:06 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v6F2d4tk061629
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 22:39:04 -0400
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2bpsv9ce10-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 14 Jul 2017 22:39:03 -0400
Received: from localhost
	by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <benh@au1.ibm.com>;
	Sat, 15 Jul 2017 12:38:55 +1000
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
Reply-To: benh@au1.ibm.com
Date: Sat, 15 Jul 2017 12:38:53 +1000
In-Reply-To: <20170714040437.22034-1-nikunj@linux.vnet.ibm.com>
References: <20170714040437.22034-1-nikunj@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Message-Id: <1500086333.2865.102.camel@au1.ibm.com>
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
To: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Cc: bharata@linux.vnet.ibm.com, qemu-devel@nongnu.org, clg@kaod.org

On Fri, 2017-07-14 at 09:34 +0530, Nikunj A Dadhania wrote:
> Rebooting a SMP TCG guest is broken for both single/multi threaded TCG.
> 
> When reset happens, all the CPUs are in halted state. First CPU is brought out
> of reset and secondary CPUs would be initialized by the guest kernel using a
> rtas call start-cpu.
> 
> However, in case of TCG, decrementer interrupts keep on coming and waking the
> secondary CPUs up.
> 
> These secondary CPUs would see the decrementer interrupt pending, which makes
> cpu::has_work() to bring them out of wait loop and start executing
> tcg_exec_cpu().
> 
> The problem with this is all the CPUs wake up and start booting SLOF image,
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

I think the right fix is for reset to clear the LPCR PECE bits.

 Cheers
Ben.
 
> >          if ((env->pending_interrupts & (1u << PPC_INTERRUPT_MCK)) &&
>              (env->spr[SPR_LPCR] & LPCR_P7_PECE2)) {
> @@ -8693,7 +8694,8 @@ static bool cpu_has_work_POWER8(CPUState *cs)
>          }
>          if ((env->pending_interrupts & (1u << PPC_INTERRUPT_DECR)) &&
>              (env->spr[SPR_LPCR] & LPCR_P8_PECE3)) {
> -            return true;
> +            /* Return true only when MSR_EE is enabled */
> +            return msr_ee;
>          }
>          if ((env->pending_interrupts & (1u << PPC_INTERRUPT_MCK)) &&
>              (env->spr[SPR_LPCR] & LPCR_P8_PECE4)) {
> @@ -8876,7 +8878,8 @@ static bool cpu_has_work_POWER9(CPUState *cs)
>          /* Decrementer Exception */
>          if ((env->pending_interrupts & (1u << PPC_INTERRUPT_DECR)) &&
>              (env->spr[SPR_LPCR] & LPCR_DEE)) {
> -            return true;
> +            /* Return true only when MSR_EE is enabled */
> +            return msr_ee;
>          }
>          /* Machine Check or Hypervisor Maintenance Exception */
>          if ((env->pending_interrupts & (1u << PPC_INTERRUPT_MCK |
