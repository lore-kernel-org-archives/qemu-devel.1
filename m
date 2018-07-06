Received: from eggs.gnu.org ([2001:4830:134:3::10]:36650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbMlf-0002LG-QJ
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 05:11:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fbMle-0002US-U8
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 05:11:07 -0400
Received: from mail-oi0-x242.google.com ([2607:f8b0:4003:c06::242]:40312)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fbMle-0002QN-Go
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 05:11:06 -0400
Received: by mail-oi0-x242.google.com with SMTP id w126-v6so22185127oie.7
	for <qemu-devel@nongnu.org>; Fri, 06 Jul 2018 02:11:06 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAKmqyKOEUWg38Aj0L0ij35u3x1aCVG1we8gE-FNzuZUNzcx3gQ@mail.gmail.com>
References: <20180703163446.9943-1-alistair.francis@wdc.com>
	<CAFEAcA-k3s5s9wCxcHVqwjgSx4-j=7Tr1cS6QFyBe9-yV2K72w@mail.gmail.com>
	<CAKmqyKOEUWg38Aj0L0ij35u3x1aCVG1we8gE-FNzuZUNzcx3gQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Jul 2018 10:10:45 +0100
Message-ID: <CAFEAcA8ip0Z91RwaDxPVOraR6-Am4dtG-L8XXg_YcUXoirSQrg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v3 0/7] riscv-pull queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair23@gmail.com>
Cc: Alistair Francis <alistair.francis@wdc.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On 6 July 2018 at 02:24, Alistair Francis <alistair23@gmail.com> wrote:
> I think the SoC device should map it's own ROM (it lines up more with
> the physical SoC).
>
> I think that is how other SoC devices do it as well. I'm not really
> sure what other address space to map it to.

I generally suggest the approach where the SoC object takes a
MemoryRegion as a link QOM property. The board code puts the
board-level devices into the system memory, and then passes
that up to the SoC. The SoC creates a container MR, puts the
thing it got passed by the board in as a background region,
and then adds its own devices/ROMs/etc to the container. It
also creates the CPU object(s). Then it passes the container
to the CPU object. This approach broadly follows what the
hardware does -- the SoC controls what goes where for the
devices it is dealing with, but doesn't need to care what is
outside it. Example in hw/arm/mps2-tz.c and probably others.

thanks
-- PMM
