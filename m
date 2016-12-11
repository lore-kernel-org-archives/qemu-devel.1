Received: from eggs.gnu.org ([2001:4830:134:3::10]:52063)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cGD0V-0005Ve-Vi
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 17:54:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cGD0R-00048e-Ok
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 17:54:12 -0500
Received: from mail-ua0-f177.google.com ([209.85.217.177]:33719)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cGD0R-0003wl-KQ
	for qemu-devel@nongnu.org; Sun, 11 Dec 2016 17:54:07 -0500
Received: by mail-ua0-f177.google.com with SMTP id 20so66793068uak.0
	for <qemu-devel@nongnu.org>; Sun, 11 Dec 2016 14:53:46 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20161211163502.GB6352@cbox>
References: <1481301020-21777-1-git-send-email-peter.maydell@linaro.org>
	<1481301020-21777-5-git-send-email-peter.maydell@linaro.org>
	<20161211163502.GB6352@cbox>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 11 Dec 2016 22:52:25 +0000
Message-ID: <CAFEAcA_zvNvJ7K5GgPyeJ5EWRxO1XL2=rc6dv_nT6_h3qF=m6A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 4/4] hw/arm/virt: Don't incorrectly claim
 architectural timer to be edge-triggered
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christoffer Dall <christoffer.dall@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrew Jones <drjones@redhat.com>, Marc Zyngier <marc.zyngier@arm.com>

On 11 December 2016 at 16:35, Christoffer Dall
<christoffer.dall@linaro.org> wrote:
> On Fri, Dec 09, 2016 at 04:30:20PM +0000, Peter Maydell wrote:
>> +     * For backwards-compatibility, virt-2.8 and earlier will continue
>> +     * to say these are edge-triggered, but later machines will report
>> +     * the correct information.
>>       */
>
> Is this really necessary?

It's being conservative -- from the guest's point of view
(any guest, not necessarily just Linux) "virt-2.8" should behave
like the "virt" machine in the 2.8 QEMU release, including bugs,
not providing newer devices, and so on.

Andrew would be the expert on whether this is being unnecessarily
conservative in this specific case.

>>  static void virt_machine_2_8_options(MachineClass *mc)
>>  {
>> +    VirtMachineClass *vmc = VIRT_MACHINE_CLASS(OBJECT_CLASS(mc));
>> +
>>      virt_machine_2_9_options(mc);
>>      SET_MACHINE_COMPAT(mc, VIRT_COMPAT_2_8);
>> +    /* For 2.8 and earlier we falsely claimed in the DT that
>> +     * our timers were edge-triggered, not level-triggered.
>> +     */
>> +    vmc->claim_edge_triggered_timers = true;
>>  }
>>  DEFINE_VIRT_MACHINE(2, 8)
>>
> I don't understand this virt machine class version stuff.  In which case
> is the claim_edge_triggered_timers set to true?  (ok, appears to be when
> a 2.8 machine is created, but does that happen automatically or does the
> user specifically have to ask for it?)

If you say "-M virt-2.8" (or -2.7 or earlier, etc), it's set
to true. If you say "-M virt" or "-M virt-2.9" (or "-M virt-2.10"
or whatever we call the next release) it stays at the default
false.

thanks
-- PMM
