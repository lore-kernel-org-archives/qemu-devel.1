Received: from eggs.gnu.org ([2001:4830:134:3::10]:51420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eHbUq-0008NU-Mh
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 15:19:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <andrew.smirnov@gmail.com>) id 1eHbUp-0004rZ-69
	for qemu-devel@nongnu.org; Wed, 22 Nov 2017 15:19:48 -0500
MIME-Version: 1.0
In-Reply-To: <CAFEAcA8u2-o2u93OfgV8-4hTx0NwTZ1zC7DjFF6GmTXhxo3-Qg@mail.gmail.com>
References: <20171106154813.19936-1-andrew.smirnov@gmail.com>
	<CAFEAcA8u2-o2u93OfgV8-4hTx0NwTZ1zC7DjFF6GmTXhxo3-Qg@mail.gmail.com>
From: Andrey Smirnov <andrew.smirnov@gmail.com>
Date: Wed, 22 Nov 2017 12:19:41 -0800
Message-ID: <CAHQ1cqErRbmw2HGc-jY+-3P_MyOijtPry5RZaJ3GOTX+X6zD-Q@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v3 00/30] Initial i.MX7 support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>, QEMU Developers <qemu-devel@nongnu.org>, Andrey Yurovsky <yurovsky@gmail.com>

On Tue, Nov 21, 2017 at 10:34 AM, Peter Maydell
<peter.maydell@linaro.org> wrote:
> On 6 November 2017 at 15:47, Andrey Smirnov <andrew.smirnov@gmail.com> wrote:
>> Hi everyone,
>>     - Added proper USB emulation code, so now it should be possible to
>>       emulated guest's USB bus
>
> The patchset is huge as it is, if you add more stuff to it
> it makes it even more likely to sink to the bottom of my
> to-review queue...
>

USB peripheral emulation had to be a part of a patch-set, either in
dummy or a full featured form, in order to be able to boot vanilla
Linux kernel because you insisted that I don't use
"ignore_memory_transaction_failures". The reason why the dummy
emulation version of it it was not a part of v2 was because I did my
test with a bad kernel config where USB was disabled, didn't realize
USB was essential and did not write code to support it. Now, once I
realized it, I wrote a dummy version, and then later, while waiting
for v2 to be reviewed, worked on proper USB emulation the code. Said
code turned out to be comparatively trivial to the first dummy
implementation, so instead of going through the exercise of submitting
dummy first and then proper version later I squashed both and the
result in v3.


>> Peter, I didn't hear anything from you about the code of
>> mcimx7d_add_psci_node(), as discussed here:
>>
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg486874.html
>>
>> so I kept the original code intact. As I mentioned before, my goal was
>> to be able to boot into vanilla Linux kerenel and have working SMP
>> without needing to use a PSCI implementing bootloader. If that is
>> something that new board code shouldn't do, please let me know.
>
> Broadly, board code should work the same way the real hardware
> does, unless there's a clear reason why not.

Yes, this all makes sense. As far as I understand convenience being
able to boot Linux directly in QEMU has long been the "clear reason
why not". Now that certain SoC specific versions of Linux are not as
self-sufficient and can't support SMP without external help, emulating
PSCI and doing appropriate DTB fixups for that is just an adaptaion of
the old convenience mechanism to new times and circumstances, IMHO.

> "virt" is special because it writes its own dtb entirely.
>
> Maybe PSCI does need to be a different special case, since we're
> emulating part of a bootloader here.

OK, I'll ignore the "maybe" part and proceed as if we are in agreement
on PSCI for v4.

> But if so I think that code belongs more in hw/arm/boot.c, so that we automatically fix up the
> dtb to say "we have psci" if we are (a) booting a kernel directly
> and (b) the CPU has the psci-conduit property set to enable QEMU's
> PSCI implementation.
>

OK, sure, makes sense. I'll change the patch to use shared
infrastructure for that.

> (Also the code in virt.c for adding a PSCI node is considerably
> fuller-featured than yours is.)
>

Okay... My code is targeting both fixed PSCI conduit (smc) and PSCI
implementation (0.2/1.0), implementing support for anything but that
in my board specific code would've been, IMHO, silly. OK, I'll
interpret that comment not as a slight, but as a request to use
virt.c's implementation for shared infrastructure.

>> Thanks,
>> Andrey Smirnov
>>
>> [v2] https://lists.gnu.org/archive/html/qemu-devel/2017-10/msg05516.html
>> [v1] https://lists.gnu.org/archive/html/qemu-devel/2017-09/msg04770.html
>>
>>
>> Andrey Smirnov (30):
>>   imx_fec: Do not link to netdev
>>   imx_fec: Refactor imx_eth_enable_rx()
>>   imx_fec: Change queue flushing heuristics
>>   imx_fec: Use ENET_FTRL to determine truncation length
>>   imx_fec: Use MIN instead of explicit ternary operator
>>   imx_fec: Emulate SHIFT16 in ENETx_RACC
>>   imx_fec: Add support for multiple Tx DMA rings
>>   imx_fec: Use correct length for packet size
>>   imx_fec: Fix a typo in imx_enet_receive()
>>   imx_fec: Reserve full 4K page for the register file
>>   sdhci: Add i.MX specific subtype of SDHCI
>>   sdhci: Implement write method of ACMD12ERRSTS register
>
> Everything above here is pretty nearly ready to go in;
> if you send that as a patchseries then it should be easy
> to review and queue ready for 2.12 (which will open up
> for new commits in mid-december).
>

I'm not quite sure where you stand on "imx_fec: Use ENET_FTRL to
determine truncation length", but sure, sounds good, I'll prepare the
rest of them as a separate patch set and submit it, as soon as I get a
chance.

>>   i.MX: Add code to emulate i.MX7 CCM, PMU and ANALOG IP blocks
>>   i.MX: Add code to emulate i.MX2 watchdog IP block
>>   i.MX: Add code to emulate i.MX7 SNVS IP-block
>>   i.MX: Add code to emulate GPCv2 IP block
>>   i.MX: Add code to emulate i.MX7 IOMUXC IP block
>>   i.MX: Add i.MX7 GPT variant
>>   i.MX: Add code to emulate SDMA IP block
>>   i.MX: Add code to emulate FlexCAN IP block
>>   i.MX: Add implementation of i.MX7 GPR IP block
>>   pci: Add support for Designware IP block
>>   i.MX: Add code to emulate i.MX7 USBMISC IP block
>>   i.MX: Add code to emulate i.MX7 ADC IP block
>>   i.MX: Add code to emulate i.MX7 SRC IP-block
>>   usb: Add basic code to emulate Chipidea USB IP
>>   ARM: Add basic code to emulate A7MPCore DAP block
>>   i.MX: Add code to emulate i.MX LCD block
>>   i.MX: Add i.MX7 SOC implementation.
>>   Implement support for i.MX7 Sabre board
>
> My review in this part of the patchset is more sketchy,
> but you can probably adjust the later patches as per
> remarks on the earlier ones.
>

OK, no problem. I am fine on iterating on the rest of the series until
it's in good shape.

Thanks,
Andrey Smirnov
