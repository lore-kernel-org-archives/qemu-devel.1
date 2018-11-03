Received: from eggs.gnu.org ([2001:4830:134:3::10]:34399)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gIscz-0002GW-Sc
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 05:54:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gIscx-0000Ss-MM
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 05:54:01 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40864)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gIscr-0000Fx-PF
	for qemu-devel@nongnu.org; Sat, 03 Nov 2018 05:53:55 -0400
Received: by mail-wr1-x443.google.com with SMTP id i17-v6so4322125wre.7
	for <qemu-devel@nongnu.org>; Sat, 03 Nov 2018 02:53:48 -0700 (PDT)
References: <20181102145433.4553-1-richard.henderson@linaro.org>
	<CAFEAcA_tcR_33Q+2ZFHdzo4_9khXggum=gRfZ8+L49KmP3hHiw@mail.gmail.com>
	<20181102193529.GB12057@e113682-lin.lund.arm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <effa3839-f0ab-e6ab-e034-a1a6d1d06923@linaro.org>
Date: Sat, 3 Nov 2018 09:53:44 +0000
MIME-Version: 1.0
In-Reply-To: <20181102193529.GB12057@e113682-lin.lund.arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/5] target/arm: KVM vs ARMISARegisters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Christoffer Dall <christoffer.dall@arm.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, qemu-arm <qemu-arm@nongnu.org>, Marc Zyngier <marc.zyngier@arm.com>, Dave Martin <Dave.Martin@arm.com>

On 11/2/18 7:35 PM, Christoffer Dall wrote:
>> It looks like the kernel can handle reads of ID_ISAR0_EL1
>> through ID_ISAR5_EL1, but not ID_ISAR6_EL1, any of the
>> MVFR*_EL1 or ID_AA64_ISAR* or ID_AA64PFR*.
>>
>> This is probably because the kernel is way too old to be
>> interestingly supportable for KVM, but we did previously
>> manage to boot on this setup.
> 
> I'm a little confused. v4.8 used to work (although it was perhaps not
> the most stable at that time).  What changed?

We are changing QEMU to depend on ID registers to define the set of features
that are supported, instead of re-defining those same features with the
ARM_FEATURE_* enumeration.

For KVM, there are only a few of those that are important in the end: those
that affect migration.  However, it seemed to me to be most future-proof if I
just read in all of the relevant ID registers so that should a code path shared
between TCG and KVM test a field, we get the right value.

Which appeared to work, since I was using a 4.15 kernel.  But I hadn't imagined
that such support had only just appeared.

> 93390c0a1b20 (arm64: KVM: Hide unsupported AArch64 CPU features from guests, 2017-10-31)
> 
> Which Dave (cc'ed) wrote and which was introduced in v4.15.
> 
> As per my question above, I'm not exactly sure what (if anything) we
> need to fix on the kernel side?

It doesn't sound like there's anything in the kernel that needs fixing.  But it
does sound like we need a workaround in userspace to deal with old kernels.

Peter, what about filling in some defaults via MIDR and friends, using the
values we have from the TCG side.  Then overwriting that default with the
registers that we can read from the kernel.  Ignore ENOENT failures and just
leave the default.

There are currently only two features that affect migration, and so must not be
approximated: T2EE and SVE.  The former is in ID_ISAR3, which is in the set
that is supported by 4.8.  The latter you were never going to run on a kernel
that old anyway.

Although, while I have you, Christopher, is there a way to extract the Limited
Ordering Region registers without modifying guest state?  Those are multiplexed
with LORN_EL1.


r~
