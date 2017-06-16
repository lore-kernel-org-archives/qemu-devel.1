Received: from eggs.gnu.org ([2001:4830:134:3::10]:50727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLsbB-00078g-Cc
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 10:51:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dLsbA-00035F-Ik
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 10:51:45 -0400
Received: from mail-wr0-x235.google.com ([2a00:1450:400c:c0c::235]:35543)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dLsbA-00033a-Bl
	for qemu-devel@nongnu.org; Fri, 16 Jun 2017 10:51:44 -0400
Received: by mail-wr0-x235.google.com with SMTP id y25so629079wrd.2
	for <qemu-devel@nongnu.org>; Fri, 16 Jun 2017 07:51:42 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1701daf4-b2de-a9fb-7337-7aa791676516@lauterbach.com>
References: <1701daf4-b2de-a9fb-7337-7aa791676516@lauterbach.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Jun 2017 15:51:20 +0100
Message-ID: <CAFEAcA_+rS8gjjU+g1e71vBBioxaWX94+SvMqVh=Ta37ZhYGjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target-arm: Bug fix in filling the cp_regs
 hashtable
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, Khaled Jmal <khaled.jmal@lauterbach.com>

On 16 June 2017 at 15:42, Abdallah Bouassida
<abdallah.bouassida@lauterbach.com> wrote:
> Check if the CPU supports AARCH64 before adding  the 64bit view of
> the coprocessor's register to the cp_regs hashtable.
>
> Signed-off-by: Abdallah Bouassida <abdallah.bouassida@lauterbach.com>
> ---
> Bug description: if a register has the .state = ARM_CP_STATE_BOTH, its 64bit
> view will be added to the hashtable even if the CPU is not 64bit.

This is deliberate and required. Where the AArch64 and AArch32
states both have a register which shares underlying architectural
state, QEMU chooses to implement migration of that state usually
via the AArch64 version's ARMCPRegInfo struct. If the AArch64
version is not included in the hashtable for an AArch32-only
CPU then the state of the 32-bit register won't be migrated.
The AArch64 register is of course invisible to the guest because
it is only accessible via 64-bit instructions, but it's used
during migration.

thanks
-- PMM
