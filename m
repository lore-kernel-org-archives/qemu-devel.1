Received: from eggs.gnu.org ([2001:4830:134:3::10]:38452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frKoM-000122-CH
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 06:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1frKoL-0001SQ-QI
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 06:19:54 -0400
Received: from mail-oi0-x233.google.com ([2607:f8b0:4003:c06::233]:38011)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1frKoL-0001S9-DK
	for qemu-devel@nongnu.org; Sun, 19 Aug 2018 06:19:53 -0400
Received: by mail-oi0-x233.google.com with SMTP id v8-v6so21107887oie.5
	for <qemu-devel@nongnu.org>; Sun, 19 Aug 2018 03:19:51 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 19 Aug 2018 11:19:29 +0100
Message-ID: <CAFEAcA-psdr-AagwvRnVTH7Q-ZN+g1y8+ja3C7wHFOWApaw6Ag@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: [Qemu-devel] any suggestions for how to handle guests which expect
 to be executing out of icache?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Richard Henderson <richard.henderson@linaro.org>

Hi; I've been playing around this weekend with writing a QEMU
model for a music player I have (an XDuoo X3). This has a MIPS
SoC, and its boot process is that the SoC's boot rom loads the
guest binary into the CPU's icache and dcache (by playing tricks
with the cache tag bits so that it appears to be precached content
for a particular physaddr range). The guest binary then runs
purely out of cache, until it can initialise the real SDRAM and
relocate itself into that.

Unfortunately this causes problems for QEMU, because the guest
binary expects that while it is running out of the icache at
addresses 0x80000000-0x80004000 it can happily write data to the
SDRAM at that address without overwriting its own code. Since
QEMU isn't modelling caches at all, the writes cause the guest
to corrupt its own code and it falls over.

Does anybody have any suggestions for how we could model this
kind of thing?

thanks
-- PMM
