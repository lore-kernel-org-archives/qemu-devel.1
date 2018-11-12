Received: from eggs.gnu.org ([2001:4830:134:3::10]:60171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gM9v6-0005x0-UN
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:58:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gM9v6-0003XT-1u
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:58:16 -0500
Received: from mail-oi1-x22f.google.com ([2607:f8b0:4864:20::22f]:46815)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gM9v5-0003WA-AO
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 05:58:15 -0500
Received: by mail-oi1-x22f.google.com with SMTP id e19-v6so6764326oii.13
	for <qemu-devel@nongnu.org>; Mon, 12 Nov 2018 02:58:15 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <a92fc500-6c7c-d995-744d-cf7e36d76e0b@ilande.co.uk>
References: <CAFEAcA9pvsNML+=2jwygO4ciJWr0GmWHznJ-Lb1bcOsWhYjo4A@mail.gmail.com>
	<8a4b7981-cc1f-d2a7-2d92-9bf54a4bb42a@ilande.co.uk>
	<CAFEAcA_L_L-NiqS98P9n4LShHyBBujNrkQXThEgQ0C7nVC86cQ@mail.gmail.com>
	<a92fc500-6c7c-d995-744d-cf7e36d76e0b@ilande.co.uk>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 Nov 2018 10:57:48 +0000
Message-ID: <CAFEAcA-GqB-ZsFW2x+_j6XaaHY7L4m+2gSrD2JRQ7PJ2VANoYg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] List of files containing devices which have not
 been QOMified
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: QEMU Developers <qemu-devel@nongnu.org>

On 10 November 2018 at 15:20, Mark Cave-Ayland
<mark.cave-ayland@ilande.co.uk> wrote:
> On 09/11/2018 10:31, Peter Maydell wrote:
>> I think the code I saw that looked like a non-QOMified
>> device was cpu_timer_create().

> Ah okay. The above timers are certainly internal CPU timers rather than external, so
> should they still be QOMified? How are timers modelled for other CPUs?

So, a couple of caveats first:
 * I haven't really looked at the sparc code
 * as I mentioned elsewhere in this thread, I'm not sure this is
   necessarily our most-important cleanup/refactoring

There are a couple of "QOM-style" ways I know of to do cpu timers:

(1) the Arm Cortex-A9/A15 have some timers that are part of the cpu
in the sense that they're always there in hardware, but they're just
memory-mapped devices at a known address. We model these as
the usual sort of standalone QOM device, with a convenience
container object in hw/cpu/ that instantiates the various devices
and wires things up.

(2) the newer Arm "generic timers" are more closely coupled to the
CPU, because they're programmed via system registers. These we
actually model as part of the CPU object itself, with the code all
in target/arm. The CPU object then exposes outbound GPIO lines
which are the interrupt signals for the timers, and which the board
or SoC code wires up to the interrupt controller.

So it depends on how closely coupled the sparc cpu timers are to
the cpu, I think.

thanks
-- PMM
