Received: from eggs.gnu.org ([2001:4830:134:3::10]:39690)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1faNgX-0002gS-I6
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:57:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1faNgW-0003t7-Dr
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:57:45 -0400
Received: from mail-lf0-x243.google.com ([2a00:1450:4010:c07::243]:37979)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1faNgW-0003sQ-5a
	for qemu-devel@nongnu.org; Tue, 03 Jul 2018 11:57:44 -0400
Received: by mail-lf0-x243.google.com with SMTP id a4-v6so2034658lff.5
	for <qemu-devel@nongnu.org>; Tue, 03 Jul 2018 08:57:43 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8ceyqpyBg6RNoMQsuyvCbjiew2OJDyBVP80bO8L4Y_iQ@mail.gmail.com>
References: <20180629172215.29475-1-alistair.francis@wdc.com>
	<CAFEAcA8ceyqpyBg6RNoMQsuyvCbjiew2OJDyBVP80bO8L4Y_iQ@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 3 Jul 2018 08:57:11 -0700
Message-ID: <CAKmqyKPMCbXvWixgJr1tQ_3zcby2nsZLVd-Z+5+R6exb0R+XtA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL v2 0/7] riscv-pull queue
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair.francis@wdc.com>, QEMU Developers <qemu-devel@nongnu.org>, Michael Clark <mjc@sifive.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>

On Sat, Jun 30, 2018 at 5:53 AM, Peter Maydell <peter.maydell@linaro.org> wrote:
> On 29 June 2018 at 18:22, Alistair Francis <alistair.francis@wdc.com> wrote:
>> The following changes since commit 75507f1aba6feb73ae43329922d51571550b9128:
>>
>>   Merge remote-tracking branch 'remotes/berrange/tags/min-glib-pull-request' into staging (2018-06-29 15:04:20 +0100)
>>
>> are available in the Git repository at:
>>
>>   git@github.com:alistair23/qemu.git tags/pull-riscv-pull-20180629
>>
>> for you to fetch changes up to e4847c96685e210649e6ec90fecd732a744dad75:
>>
>>   hw/riscv/sifive_u: Connect the Cadence GEM Ethernet device (2018-06-29 09:51:05 -0700)
>>
>> ----------------------------------------------------------------
>> RISC-V: SoCify SiFive boards and connect GEM
>>
>> This series has three tasks:
>>  1. To convert the SiFive U and E machines into SoCs and boards
>>  2. To connect the Cadence GEM device to the SiFive U board
>>  3. Fix some device tree problems with the SiFive U board
>>
>> After this series the SiFive E and U boards have their SoCs split into
>> seperate QEMU objects, which can be used on future boards if desired.
>>
>> The RISC-V Virt and Spike boards have not been converted. They haven't
>> been converted as they aren't physical boards, so it doesn't make a
>> whole lot of sense to split them into an SoC and board. The only
>> disadvantage with this is that they now differ to the SiFive boards.
>>
>> This series also connect the Cadence GEM device to the SiFive U board.
>> There are some interrupt line changes requried before this is possible.
>
> Hi; this fails to build I'm afraid:
>
>   LINK    riscv32-softmmu/qemu-system-riscv32
> ../fsdev/qemu-fsdev.o:(.data.rel.ro+0x8): undefined reference to `local_ops'
> ../fsdev/qemu-fsdev.o:(.data.rel.ro+0x18): undefined reference to `handle_ops'
> ../fsdev/qemu-fsdev.o:(.data.rel.ro+0x28): undefined reference to `synth_ops'
> ../fsdev/qemu-fsdev.o:(.data.rel.ro+0x38): undefined reference to `proxy_ops'
>
> I'm not sure exactly what's going on here but I suspect
> commit e4847c96685, which made the riscv default-config
> files stop including virtio.mak.
>
> I think the bit of code that defines these _ops structs and the
> bit of code that's using them aren't guarded by exactly the same
> set of CONFIG_* defines. That inconsistency is arguably a bug,
> but nobody notices it because you just use virtio.mak to get all
> the virtio defines.
>
> The definitions are guarded by "CONFIG_VIRTIO_9P || CONFIG_XEN"
> but the use by "CONFIG_VIRTFS && (CONFIG_VIRTIO || CONFIG_XEN)",
> so if you define CONFIG_VIRTIO without CONFIG_VIRTIO_9P you're
> going to run into this.
>
> The guard on the definitions was only added in commit b5dfdb082fc350f3,
> so you've had an unfortunate race with that pullreq I think.
>
> All that said, it looks to me like e4847c98 should not have been
> changing how the virtio configs are set -- the commit message
> doesn't say anything about it -- so the simplest thing is just to
> fix that up.

Ok, I'm sending an updated PR now. I can't reproduce the failure for
some reason so hopefully I have fixed the problem by not modifying the
virtio include.

Alistair

>
> thanks
> -- PMM
