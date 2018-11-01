Received: from eggs.gnu.org ([2001:4830:134:3::10]:51144)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIHPM-0007c6-LH
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:09:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIHPL-0004C3-Mp
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:09:28 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:39520)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIHPK-0004AX-UW
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 14:09:27 -0400
Received: by mail-oi1-x242.google.com with SMTP id e3-v6so17378647oiy.6
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 11:09:25 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA9EFYCaO2XMdYq+Uy72VbTow7oJSHm18TSzG+tUP8NsBg@mail.gmail.com>
References: <20181024113709.16599-1-richard.henderson@linaro.org>
	<87sh0k6757.fsf@linaro.org>
	<CAFEAcA9EFYCaO2XMdYq+Uy72VbTow7oJSHm18TSzG+tUP8NsBg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Nov 2018 18:09:03 +0000
Message-ID: <CAFEAcA8dE2ZRqB826UE1KpgM-wGCTe510c2zYebosZXNF1feKA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 0/5] target/arm: KVM vs ARMISARegisters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 1 November 2018 at 17:30, Peter Maydell <peter.maydell@linaro.org> wrote=
:
> On 1 November 2018 at 17:26, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>> I think the problem is the we trip over the assert because:
>>
>>     /* Some features automatically imply others: */
>>     if (arm_feature(env, ARM_FEATURE_V8)) {
>>         if (arm_feature(env, ARM_FEATURE_M)) {
>>             set_feature(env, ARM_FEATURE_V7);
>>         } else {
>>             set_feature(env, ARM_FEATURE_V7VE);
>>         }
>>     }
>>
>> Allows:
>>
>>     if (arm_feature(env, ARM_FEATURE_V7VE)) {
>>         assert(cpu_isar_feature(arm_div, cpu));
>>
>> Which isn't strictly true on kvm guests.
>
> KVM guests should definitely all be v7VE and all have
> the arm divide instruction, if they implement AArch32 at all.
> I think what we're hitting here is the case where the host
> CPU has no AArch32 support. In that case the ID_ISAR0_EL1
> sysreg (which we read from KVM and use to populate the
> cpu->isar struct) has an UNKNOWN value.

So I think the assert should probably be
"assert that if this cpu has any EL that can execute at
AArch32 then it has the arm_div ISAR feature". You can
determine the former by looking at ID_AA64PFR0_EL1 field
EL0 (bits [3:0]), which will be >=3D 0b0010 if AArch32 is
supported at any EL.

thanks
-- PMM
