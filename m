Received: from eggs.gnu.org ([2001:4830:134:3::10]:37537)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6ZGD-0001bl-OW
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 06:15:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f6ZG8-000182-Iq
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 06:15:21 -0400
Received: from mail-oi0-x231.google.com ([2607:f8b0:4003:c06::231]:40476)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f6ZG8-00017f-8z
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 06:15:16 -0400
Received: by mail-oi0-x231.google.com with SMTP id x9-v6so4614378oig.7
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 03:15:16 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <7a39d3f5-af2b-e21d-fa10-798b67fe4f63@lauterbach.com>
References: <1521034084-17344-1-git-send-email-abdallah.bouassida@lauterbach.com>
	<1521034084-17344-4-git-send-email-abdallah.bouassida@lauterbach.com>
	<87h8orcg3a.fsf@linaro.org>
	<7a39d3f5-af2b-e21d-fa10-798b67fe4f63@lauterbach.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Apr 2018 11:14:54 +0100
Message-ID: <CAFEAcA-2uZ_=POrmuHiXirTchUoxoD92ZfctrcMVj2s31XQXdw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 3/3] target/arm: Add the XML
 dynamic generation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Khaled Jmal <khaled.jmal@lauterbach.com>, qemu-arm <qemu-arm@nongnu.org>

On 6 April 2018 at 18:28, Abdallah Bouassida
<abdallah.bouassida@lauterbach.com> wrote:
> Alex wrote:
>> There is something odd going on here because if I run a simple little
>> features binary
>> (https://github.com/stsquad/testcases/blob/master/aarch64/features.c) I
>> get:
>>
>>   ID_AA64ISAR0_EL1    : 0x0000000000011120
>>   ID_AA64ISAR1_EL1    : 0x0000000000000000
>>   ID_AA64MMFR0_EL1    : 0x00000000ff000000
>>   ID_AA64MMFR1_EL1    : 0x0000000000000000
>>   ID_AA64PFR0_EL1     : 0x0000000000000011
>>   ID_AA64PFR1_EL1     : 0x0000000000000000
>>   ID_AA64DFR0_EL1     : 0x0000000000000006
>>   ID_AA64DFR1_EL1     : 0x0000000000000000
>>   MIDR_EL1            : 0x00000000411fd070
>>   MPIDR_EL1           : 0x0000000080000000
>>   REVIDR_EL1          : 0x0000000000000000
>>
>> However in the gdb output we see:
>>
>>   ID_AA64ISAR0_EL1           0x11120  69920
>>   ID_AA64ISAR1_EL1           0x0      0
>>   ID_AA64MMFR0_EL1           0x1124   4388  <-?
>>   ID_AA64MMFR1_EL1           0x0      0
>>   ID_PFR0                    0x131    305   <-name and value?
>>   ID_AA64PFR1_EL1            0x0      0
>>   ID_AA64DFR0_EL1            0x10305106       271601926 <-?
>>   ID_AA64DFR1_EL1            0x0      0
>>   REVIDR_EL1                 0x0      0
>>
>> So why the discrepancies?
>
>>  ID_AA64MMFR0_EL1           0x1124    4388  <-?
>>  ID_AA64DFR0_EL1            0x10305106        271601926 <-?
> I get the same value in x1 (= 0x1124) and x2 (= 0x10305106) when I execute
> the following instructions on the guest:
>   MRS x1, ID_AA64MMFR0_EL1
>   MRS x2, ID_AA64DFR0_EL1

Alex's test program looks like a Linux userspace one -- in
which case it will be reading whatever faked-up values the
guest kernel is providing, rather than directly accessing
the registers (since they're not EL0-readable in hardware).
That may be the cause of the discrepancies.

(As an aside, we probably need to add support for userspace
accessing of ID regs to our linux-user code at some point.)

>>  ID_PFR0                    0x131     305   <-name and value?
> This is not ID_AA64PFR0_EL1 - the ID_AA64PFR0_EL1 is not registered in our
> dynamic XML as it has "ARM_CP_NO_RAW" type.
> So should we add some modifications to handle this special case?

Hmm, this is an interesting case. I'm not entirely sure
this register absolutely needs to be NO_RAW. Deciding
whether we could drop the NO_RAW requires more thought than
I have time for right now, though.

In any case, it's quite plausible we may have registers
which we want to be not migrated (so NO_RAW) but which we
do want to allow the gdb stub to read (and perhaps write).
I think that handling those special cases with a .gdbreadfn
and .gdbwritefn as and when we need to would be the best
approach.

For the moment, this patchset is intended to be a "reasonable
effort" reflection of the system registers into the gdbstub,
so I don't think we need to do that now. If users have
genuine need to read particular registers we can add the
special casing code then.

thanks
-- PMM
