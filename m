Received: from eggs.gnu.org ([2001:4830:134:3::10]:45464)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH9mZ-0004Ty-0g
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:48:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gH9mY-0003s8-93
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:48:46 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:36055)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gH9mX-0003gD-IU
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:48:46 -0400
Received: by mail-ot1-x342.google.com with SMTP id x4so8008890otg.3
	for <qemu-devel@nongnu.org>; Mon, 29 Oct 2018 08:48:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <cebd5ce7-f33e-454c-0796-82b10515362d@arm.com>
References: <20181024113709.16599-1-richard.henderson@linaro.org>
	<20181024113709.16599-5-richard.henderson@linaro.org>
	<CAFEAcA_WJ7hRd8RfM2OTQBPcryUVDOJkFbRzb69xWTM-yNBLmA@mail.gmail.com>
	<CAFEAcA_zK8n0Bkwn-4x8M-CFduOviCmUGS-uSfw45SzRriE9Rg@mail.gmail.com>
	<cebd5ce7-f33e-454c-0796-82b10515362d@arm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 29 Oct 2018 15:48:06 +0000
Message-ID: <CAFEAcA_x_g3TEnC=A=EjugWRo33C1BwL2YL=iJQXgzre7gJQLA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH 4/5] target/arm: Fill in ARMISARegisters
 for kvm32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marc Zyngier <marc.zyngier@arm.com>
Cc: Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>, Christoffer Dall <christoffer.dall@arm.com>

On 29 October 2018 at 15:40, Marc Zyngier <marc.zyngier@arm.com> wrote:
> My temptation would be not to expose it at all when running on a v7
> core, and return an error rather than zero.
>
> The other issue is that we currently don't support running 32bit KVM on
> any ARMv8 platform, as we strictly check the CPUs we want to run on (A7
> and A15). I remember seeing patches that would allow any host core to be
> used (similar to what we have on the 64bit side), but that never made it
> in the tree.

Ah, that's convenient in some ways. It means we can define the
API to be "for v7, no register available via the ONE_REG API;
for v8, always present", provided we add the constant and the
support before we turn on any actual v8 CPUs for 32-bit KVM
(avoiding the awkward case of "v8 but kernel doesn't expose
MVFR2").

I don't think we particularly care about the 32-bit-kvm-on-v8
part, but it would be good to nail down this wrinkle so we don't
forget about it, maybe ?

thanks
-- PMM
