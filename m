Received: from eggs.gnu.org ([2001:4830:134:3::10]:44687)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fapTO-0000oB-35
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 17:38:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fapTN-0000wN-0T
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 17:38:02 -0400
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:45134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fapTM-0000w8-Ii
	for qemu-devel@nongnu.org; Wed, 04 Jul 2018 17:38:00 -0400
Received: by mail-oi0-x243.google.com with SMTP id m2-v6so12997799oim.12
	for <qemu-devel@nongnu.org>; Wed, 04 Jul 2018 14:38:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180703163446.9943-1-alistair.francis@wdc.com>
References: <20180703163446.9943-1-alistair.francis@wdc.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Jul 2018 22:37:39 +0100
Message-ID: <CAFEAcA-k3s5s9wCxcHVqwjgSx4-j=7Tr1cS6QFyBe9-yV2K72w@mail.gmail.com>
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
To: Alistair Francis <alistair.francis@wdc.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, Alistair Francis <alistair23@gmail.com>

On 3 July 2018 at 17:34, Alistair Francis <alistair.francis@wdc.com> wrote:
> The following changes since commit f988c7e191141e92de2059d04a5f9a9bb01f399c:
>
>   Merge remote-tracking branch 'remotes/shorne/tags/pull-or-20180703' into staging (2018-07-03 16:04:41 +0100)
>
> are available in the Git repository at:
>
>   git@github.com:alistair23/qemu.git tags/pull-riscv-pull-20180703
>
> for you to fetch changes up to 41fd29c43424cb3d660231ba75e9f52246639b08:
>
>   hw/riscv/sifive_u: Connect the Cadence GEM Ethernet device (2018-07-03 09:31:35 -0700)
>
> ----------------------------------------------------------------
> RISC-V: SoCify SiFive boards and connect GEM
>
> This series has three tasks:
>  1. To convert the SiFive U and E machines into SoCs and boards
>  2. To connect the Cadence GEM device to the SiFive U board
>  3. Fix some device tree problems with the SiFive U board
>
> After this series the SiFive E and U boards have their SoCs split into
> seperate QEMU objects, which can be used on future boards if desired.
>
> The RISC-V Virt and Spike boards have not been converted. They haven't
> been converted as they aren't physical boards, so it doesn't make a
> whole lot of sense to split them into an SoC and board. The only
> disadvantage with this is that they now differ to the SiFive boards.
>
> This series also connect the Cadence GEM device to the SiFive U board.
> There are some interrupt line changes requried before this is possible.

Hi -- this seems to fail 'make check':

TEST: tests/device-introspect-test... (pid=25542)
  /riscv32/device/introspect/list:                                     OK
  /riscv32/device/introspect/list-fields:                              OK
  /riscv32/device/introspect/none:                                     OK
  /riscv32/device/introspect/abstract:                                 OK
  /i386/qom/pc-0.14:                                                   OK
  /riscv32/device/introspect/concrete:
RAMBlock "riscv.sifive.u.mrom" already registered, abort!
Broken pipe
FAIL
GTester: last random seed: R02S26c1f5ee936cd6398b20e9983b7c15a8
(pid=25562)
  /riscv32/device/introspect/abstract-interfaces:                      OK
FAIL: tests/device-introspect-test

It looks like riscv_sifive_u_soc_init() is creating a RAM memory
region with a NULL parent. This means you can't create more
than one of these devices (because they'll have clashing
names). Other problems here: you're adding it to the system
memory space, which devices really shouldn't do (the system
memory space is owned by the board object, and devices
shouldn't map themselves into it). You definitely shouldn't
be doing that in the init function, because init isn't
supposed to cause changes to the system (realize would be
ok, I think).

My guess is the test failure is some combination of doing
this in init rather than realize and not using the right
parent pointer for memory_region_init_rom(). Having the
device map its regions itself will work, it's just not
really the right way round...

thanks
-- PMM
