Received: from eggs.gnu.org ([2001:4830:134:3::10]:34482)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fXOEM-00049A-Hb
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:56:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <hongbo.zhang@linaro.org>) id 1fXOEL-0002Iw-LU
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:56:18 -0400
Received: from mail-io0-x242.google.com ([2607:f8b0:4001:c06::242]:44066)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <hongbo.zhang@linaro.org>)
	id 1fXOEL-0002Ib-F2
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 05:56:17 -0400
Received: by mail-io0-x242.google.com with SMTP id g7-v6so11928994ioh.11
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 02:56:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA90hDS17L64YZ5H_B-kYkMaMV+ofBtdD=TEKgsnT+wUqA@mail.gmail.com>
References: <1529663827-28854-1-git-send-email-hongbo.zhang@linaro.org>
	<CAFEAcA8Bx7b_0zUxbdxFgtANFycVkUiSiemAwHpr0wpyxuLKmw@mail.gmail.com>
	<CAHmQWvCczwh0Yto=9s2j7d00ULokZ0=VrxykAyXBvvHzQaUEMA@mail.gmail.com>
	<CAFEAcA90hDS17L64YZ5H_B-kYkMaMV+ofBtdD=TEKgsnT+wUqA@mail.gmail.com>
From: Hongbo Zhang <hongbo.zhang@linaro.org>
Date: Mon, 25 Jun 2018 17:56:16 +0800
Message-ID: <CAHmQWvBxTaX9f+xH3zue5w5s-eiLo00jmHq2OZ4gXTAJg0XLjA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] hw/arm/virt: fix psci conduit in acpi when
 el3 enabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 25 June 2018 at 17:06, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 25 June 2018 at 05:06, Hongbo Zhang <hongbo.zhang@linaro.org> wrote:
>> Hi Peter,
>> Yes, your considerations reasonable.
>> But in practice of hardware platforms, programmer checks that Arm TF
>> is using SMC for PSCI call conduit, then fix it manually in the ACPI
>> table, reason may be that Arm TF is lack of ACPI support, if device
>> tree used, there should be no such thing because Arm TF can support
>> it.
>> On QEMU, I just mimic the situation, if a complete reasonable
>> solution, further efforts are needed to figure it out.
>
> I'm afraid I don't really understand what you're saying
> here. Could you try rephrasing it?
>
Sorry, I say in the real hardware platforms, in practice programmer
has to write a fixed PSCI conduit value in ACPI. then on the qemu
platform, I did the similar thing -- write a fixed value too.
I know it is not a perfect solution for it, I have no better one for now.

> If we're running at EL3 and booting firmware, then QEMU doesn't
> provide PSCI. The firmware we're booting is the only thing that
> can know if that firmware has implemented PSCI. So only it can
> decide whether the ACPI tables and DTB should say that PSCI is
> present.

Agree with your comments, I hope ACPI's psci conduit node can reflect
firmware's implementation, even when firmware PSCI conduit changes,
ACPI node changes accordingly.
But for ACPI and DTB, there are different situations now.

If DTB is used, firmware(with psci implementation) can generate DTB
nodes, saying which PSCI conduit is used - smc or hvc, then uboot or
uefi can get this DTB add more DTB nodes before transfer it to kernel.
That is, using DTB, we can achieve the goal.

But when ACPI used, there is no codes in firmware to generate ACPI
node to show which PSCI conduit is used, then uefi or later stage
cannot get this info dynamically from any codes as far as I know.
(this is why programmer manually check that firmware is using smc,
then write a fixed value in ACPI FADT).
So, if we want to fix this neatly, adding ACPI support in Arm trusted
firmware may be the solution, but it should be a big feature for
firmware, not QEMU.

(since many components involved, hope my understanding correct)
>
> thanks
> -- PMM
