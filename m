Received: from eggs.gnu.org ([2001:4830:134:3::10]:38223)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQcKb-0003Wq-BF
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:57:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cQcKa-0008Nv-Ah
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:57:57 -0500
Received: from mail-vk0-x22b.google.com ([2607:f8b0:400c:c05::22b]:33319)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cQcKa-0008Nk-4Y
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 10:57:56 -0500
Received: by mail-vk0-x22b.google.com with SMTP id 137so343971125vkl.0
	for <qemu-devel@nongnu.org>; Mon, 09 Jan 2017 07:57:55 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKNy=NeOPJs7C+3LgyCGMoy6W9gAhz5M5BgJ7t9YwTLA4g@mail.gmail.com>
References: <1481625384-15077-1-git-send-email-peter.maydell@linaro.org>
	<CAKmqyKNy=NeOPJs7C+3LgyCGMoy6W9gAhz5M5BgJ7t9YwTLA4g@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Jan 2017 15:57:35 +0000
Message-ID: <CAFEAcA9S+tsneJsi1Q+andFK=w_W3=ApXJNXJkbFThfPRL_30Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 00/23] arm: Add virtualization to GICv3,
 and enable EL2 on 64-bit CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, Andrew Jones <drjones@redhat.com>, Christoffer Dall <christoffer.dall@linaro.org>, Patch Tracking <patches@linaro.org>

On 19 December 2016 at 22:20, Alistair Francis <alistair23@gmail.com> wrote:
> If I manually enable EL2 and EL3 for the Xilinx EP108 board I can
> replicate a full hardware flow from ATF -> u-boot -> Linux.
>
> Unfortunately Linux doesn't get too far as I get the error below. This
> is further then it was getting before though, so I'm still including
> this:
>
> Tested-by: Alistair Francis <alistair.francis@xilinx.com>
>
> [       24547.770] Detected VIPT I-cache on CPU1
> [       24667.370] CPU features: SANITY CHECK: Unexpected variation in
> SYS_CNTFRQ_EL0. Boot CPU: 0x00000005f5e100, CPU1: 0x00000003b9aca0
> [       24769.210] Unsupported CPU feature variation.

I'm not sure what's going on here -- in a full-EL3 setup then
we should be using the ATF PSCI implementation and it's the
firmware's job to ensure that SYS_CNTFRQ_EL0 is the same on
the booted up CPU (by pulling it out of the memory mapped system
timer, usually). On reset the CPUs will all have the same
CNTFRQ_EL0 value so unless EL3 firmware is writing dodgy values
to it they shouldn't end up out of sync. Might also be worth
checking we're not accidentally trying to use QEMU's PSCI
implementation.

I suspect this will be easier for you to investigate than me --
is this related to the system timer implementation you sent
patches for?

thanks
-- PMM
