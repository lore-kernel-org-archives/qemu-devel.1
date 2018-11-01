Received: from eggs.gnu.org ([2001:4830:134:3::10]:38457)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gIGk8-00035D-QT
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:26:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gIGk5-0004Ov-7c
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:26:52 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:40311)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gIGk4-0004NV-Vs
	for qemu-devel@nongnu.org; Thu, 01 Nov 2018 13:26:49 -0400
Received: by mail-wr1-x444.google.com with SMTP id i17-v6so20784946wre.7
	for <qemu-devel@nongnu.org>; Thu, 01 Nov 2018 10:26:47 -0700 (PDT)
References: <20181024113709.16599-1-richard.henderson@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181024113709.16599-1-richard.henderson@linaro.org>
Date: Thu, 01 Nov 2018 17:26:44 +0000
Message-ID: <87sh0k6757.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


Richard Henderson <richard.henderson@linaro.org> writes:

> My previous patch set for replacing feature bits with id registers
> failed to consider that these id registers are beginning to control
> migration, and thus we must fill them in for KVM as well.
>
> Thus, we want to initialize these values within CPU from the host.
>
> Finally, re-send the T32EE conversion patch, fixing the build
> failure on an arm32 host in kvm32.c.
>
> Tested on arm64; cross-build tested for arm32.

I'm still seeing the following assert on qemu-test:

  qemu-system-aarch64: /home/alex/lsrc/qemu.git/target/arm/cpu.c:832: arm_c=
pu_realizefn: Assertion `cpu_isar_feature(arm_div, cpu)' failed.

Which is a regression caused by:

  7e0cf8b: target/arm: Convert division from feature bits to isar0 tests

I think the problem is the we trip over the assert because:

    /* Some features automatically imply others: */
    if (arm_feature(env, ARM_FEATURE_V8)) {
        if (arm_feature(env, ARM_FEATURE_M)) {
            set_feature(env, ARM_FEATURE_V7);
        } else {
            set_feature(env, ARM_FEATURE_V7VE);
        }
    }

Allows:

    if (arm_feature(env, ARM_FEATURE_V7VE)) {
        assert(cpu_isar_feature(arm_div, cpu));

Which isn't strictly true on kvm guests.


>
>
> r~
>
>
> Richard Henderson (5):
>   target/arm: Install ARMISARegisters from kvm host
>   target/arm: Fill in ARMISARegisters for kvm64
>   target/arm: Introduce read_sys_reg32 for kvm32
>   target/arm: Fill in ARMISARegisters for kvm32
>   target/arm: Convert t32ee from feature bit to isar3 test
>
>  target/arm/cpu.h     |  6 +++-
>  target/arm/kvm_arm.h |  1 +
>  linux-user/elfload.c |  2 +-
>  target/arm/cpu.c     |  4 ---
>  target/arm/helper.c  |  2 +-
>  target/arm/kvm.c     |  1 +
>  target/arm/kvm32.c   | 75 +++++++++++++++++++++++++-------------------
>  target/arm/kvm64.c   | 63 +++++++++++++++++++++++++++++++++++--
>  target/arm/machine.c |  3 +-
>  9 files changed, 114 insertions(+), 43 deletions(-)


--
Alex Benn=C3=A9e
