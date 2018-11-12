Received: from eggs.gnu.org ([2001:4830:134:3::10]:39068)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMDIe-00058q-Au
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:34:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMDIc-0005RQ-Pr
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:34:47 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:43611)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMDIa-0005QP-Rp
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 09:34:46 -0500
Received: by mail-oi1-x243.google.com with SMTP id j202-v6so7293675oih.10
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 06:34:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6ace0700-23b9-d004-a5d9-6ab1bdb90835@linaro.org>
References: <20181108175246.13416-1-richard.henderson@linaro.org>
	<20181108175246.13416-3-richard.henderson@linaro.org>
	<CAFEAcA_WJMAsHWx+OTO+j0eTsHodpXkyxLv6cAdXxgjsCmTYhw@mail.gmail.com>
	<6ace0700-23b9-d004-a5d9-6ab1bdb90835@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 14:34:18 +0000
Message-ID: <CAFEAcA-3yT-Tw_Q6fiioyxTF8oEJ0r+ZTKdYCg4inYgtdwcxRA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 2/5] target/arm: Fill in ARMISARegisters
 for kvm64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>

On 12 November 2018 at 14:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 11/12/18 12:37 PM, Peter Maydell wrote:
>> On 8 November 2018 at 17:52, Richard Henderson
>> <richard.henderson@linaro.org> wrote:
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>
>>>      /* Old kernels may not know about the PREFERRED_TARGET ioctl: however
>>>       * we know these will only support creating one kind of guest CPU,
>>>       * which is its preferred CPU type. Fortunately these old kernels
>>> @@ -474,8 +497,71 @@ bool kvm_arm_get_host_cpu_features(ARMHostCPUFeatures *ahcf)
>>>      ahcf->target = init.target;
>>>      ahcf->dtb_compatible = "arm,arm-v8";
>>>
>>> +    err = read_sys_reg64(fdarray[2], &ahcf->isar.id_aa64pfr0,
>>> +                         ARM64_SYS_REG(3, 0, 0, 4, 0));
>>> +    if (unlikely(err < 0)) {
>>> +        /*
>>> +         * Before v4.15, the kernel only exposed a limited number of system
>>> +         * registers, not including any of the interesting AArch64 ID regs.
>>> +         * For the most part we could leave these fields as zero with minimal
>>> +         * effect, since this does not affect the values seen by the guest.
>>
>> These older kernels do implement reading of id_isar0 through
>> id_isar5, though -- we could read and use those values rather than
>> leaving them zero.
>
> But without id_aa64pfr0, we don't know if id_isar0 et al have UNKNOWN values
> due to aa32 mode not being present.  E.g. run a 4.8 kernel on a thunderx1 cpu.

Good point, which makes things kind of awkward.

>>> +        ahcf->isar.id_aa64pfr0 = 0x00000011; /* EL1&0, AArch64 only */
>>> +        err = 0;
>>
>> Doesn't this code path leave everything except id_aa64pfr0 as
>> zero, thus leaving us with the "could cause problems down the
>> line" situation ?
>
> The other id_aa64* register fields are all extensions to v8.0, so they should
> be zero.  I am of course assuming that AdvSIMD is present, otherwise qemu
> itself probably have failed before now.

You don't set the id_isar* to say "AdvSIMD present" (or "VFP present"), though.
So if we in a later commit change target/arm/machine.c:vfp_needed() to
check an id_isar* field instead of ARM_FEATURE_VFP then we'll break
migration for these old kernel versions. That was the kind of thing I was
hoping we could avoid having to remember for the future...

thanks
-- PMM
