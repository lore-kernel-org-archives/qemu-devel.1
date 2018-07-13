Received: from eggs.gnu.org ([2001:4830:134:3::10]:50695)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdyKy-0004CX-A7
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:42:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fdyKx-0001Rl-Cg
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:42:20 -0400
Received: from mail-oi0-x241.google.com ([2607:f8b0:4003:c06::241]:41213)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fdyKx-0001R7-7i
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:42:19 -0400
Received: by mail-oi0-x241.google.com with SMTP id k12-v6so62242271oiw.8
	for <qemu-devel@nongnu.org>; Fri, 13 Jul 2018 06:42:19 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <f32095a2-72b7-662d-ee58-670c2b322218@greensocs.com>
References: <20180629132954.24269-1-luc.michel@greensocs.com>
	<20180629132954.24269-17-luc.michel@greensocs.com>
	<CAFEAcA_fFsqwr316OLcZVwBs72ESLob1AKDZN24JfFo78zQ=AQ@mail.gmail.com>
	<f32095a2-72b7-662d-ee58-670c2b322218@greensocs.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jul 2018 14:41:57 +0100
Message-ID: <CAFEAcA-UGEW7GkfeRDfxv6PzAE8dkiqHEpYc+Z3OMW0yZ7ynSA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 16/20] intc/arm_gic: Implement
 gic_update_virt() function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc Michel <luc.michel@greensocs.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Sai Pavan Boddu <saipava@xilinx.com>, Edgar Iglesias <edgari@xilinx.com>, Mark Burton <mark.burton@greensocs.com>, Jan Kiszka <jan.kiszka@web.de>

On 13 July 2018 at 14:33, Luc Michel <luc.michel@greensocs.com> wrote:
>
>
> On 07/12/2018 03:56 PM, Peter Maydell wrote:
>> On 29 June 2018 at 14:29, Luc Michel <luc.michel@greensocs.com> wrote:
>>> Add the gic_update_virt() function to update the vCPU interface states
>>> and raise vIRQ and vFIQ as needed. This commit renames gic_update() to
>>> gic_update_internal() and generalizes it to handle both cases, with a
>>> `virt' parameter to track whether we are updating the CPU or vCPU
>>> interfaces.
>>>
>>> The main difference between CPU and vCPU is the way we select the best
>>> IRQ. This part has been split into the gic_get_best_(v)irq functions.
>>> For the virt case, the LRs are iterated to find the best candidate.
>>>
>>> Signed-off-by: Luc Michel <luc.michel@greensocs.com>
>>> ---
>>>  hw/intc/arm_gic.c | 170 +++++++++++++++++++++++++++++++++++-----------
>>>  1 file changed, 130 insertions(+), 40 deletions(-)
>>
>>
>>> +
>>> +/* Return true if IRQ signaling is enabled:
>>> + *   - !virt -> from the distributor to the CPU interfaces,
>>> + *              for the given group mask,
>>> + *   -  virt -> from the given virtual interface to the CPU virtual interface.
>>> + */
>>> +static inline bool gic_irq_signaling_enabled(GICState *s, int cpu, bool virt,
>>> +                                    int group_mask)
>>> +{
>>> +    return (virt && (s->h_hcr[cpu] & R_GICH_HCR_EN_MASK))
>>> +        || (!virt && (s->ctlr & group_mask));
>>> +}
>>
>> For a real CPU interface we test the GICC_CTLR EnableGrp0/1 bits here.
>> For a virt CPU interface shouldn't we test the GICV_CTLR bits ?
> This test is still done in gic_update_internal() (we test
> s->cpu_ctlr[cpu_iface], with cpu_iface being the index of a vcpu when
> virt is true). I can move it in this function if you think it's clearer?

Oh, I see, you put it in the outer condition:

+        if (!gic_irq_signaling_enabled(s, cpu, virt,
+                                       GICD_CTLR_EN_GRP0 | GICD_CTLR_EN_GRP1)
+            || !(s->cpu_ctlr[cpu_iface] &
+                 (GICC_CTLR_EN_GRP0 | GICC_CTLR_EN_GRP1))) {

Yes, I think if we're going to abstract the check into a function
we should put it all in the function, not have half of it
in the function and half not.

(The purpose of the function is "identify configurations of the
GIC where it cannot possibly generate either an IRQ or a FIQ
regardless of the individual interrupt or list register state,
so that we can early-exit without doing a complete scan of
all interrupts/list registers".)

thanks
-- PMM
