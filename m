Received: from eggs.gnu.org ([2001:4830:134:3::10]:39409)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIGny-00074X-PV
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:30:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gIGnx-00071Y-LJ
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:30:50 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:46514)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gIGnx-00071M-FF
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:30:49 -0400
Received: by mail-oi1-x242.google.com with SMTP id k64-v6so17250743oia.13
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 10:30:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87sh0k6757.fsf@linaro.org>
References: <20181024113709.16599-1-richard.henderson@linaro.org>
	<87sh0k6757.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 1 Nov 2018 17:30:28 +0000
Message-ID: <CAFEAcA9EFYCaO2XMdYq+Uy72VbTow7oJSHm18TSzG+tUP8NsBg@mail.gmail.com>
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

On 1 November 2018 at 17:26, Alex Benn=C3=A9e <alex.bennee@linaro.org> wrot=
e:
>
> Richard Henderson <richard.henderson@linaro.org> writes:
>
>> My previous patch set for replacing feature bits with id registers
>> failed to consider that these id registers are beginning to control
>> migration, and thus we must fill them in for KVM as well.
>>
>> Thus, we want to initialize these values within CPU from the host.
>>
>> Finally, re-send the T32EE conversion patch, fixing the build
>> failure on an arm32 host in kvm32.c.
>>
>> Tested on arm64; cross-build tested for arm32.
>
> I'm still seeing the following assert on qemu-test:
>
>   qemu-system-aarch64: /home/alex/lsrc/qemu.git/target/arm/cpu.c:832: arm=
_cpu_realizefn: Assertion `cpu_isar_feature(arm_div, cpu)' failed.
>
> Which is a regression caused by:
>
>   7e0cf8b: target/arm: Convert division from feature bits to isar0 tests
>
> I think the problem is the we trip over the assert because:
>
>     /* Some features automatically imply others: */
>     if (arm_feature(env, ARM_FEATURE_V8)) {
>         if (arm_feature(env, ARM_FEATURE_M)) {
>             set_feature(env, ARM_FEATURE_V7);
>         } else {
>             set_feature(env, ARM_FEATURE_V7VE);
>         }
>     }
>
> Allows:
>
>     if (arm_feature(env, ARM_FEATURE_V7VE)) {
>         assert(cpu_isar_feature(arm_div, cpu));
>
> Which isn't strictly true on kvm guests.

KVM guests should definitely all be v7VE and all have
the arm divide instruction, if they implement AArch32 at all.
I think what we're hitting here is the case where the host
CPU has no AArch32 support. In that case the ID_ISAR0_EL1
sysreg (which we read from KVM and use to populate the
cpu->isar struct) has an UNKNOWN value.

thanks
-- PMM
