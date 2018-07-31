Received: from eggs.gnu.org ([2001:4830:134:3::10]:60065)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fkMjE-0001ox-Lc
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 00:57:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mail@sebastianbauer.info>) id 1fkMjD-00045C-Qt
	for qemu-devel@nongnu.org; Tue, 31 Jul 2018 00:57:48 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date: Tue, 31 Jul 2018 06:57:31 +0200
From: Sebastian Bauer <mail@sebastianbauer.info>
In-Reply-To: <20180731001847.GF2708@umbus.fritz.box>
References: <20180730043904.17023-1-mail@sebastianbauer.info>
	<alpine.BSF.2.21.1807301254450.49677@zero.eik.bme.hu>
	<fbaa741e42e50457a0ba9c7654e1d03d@sebastianbauer.info>
	<alpine.BSF.2.21.1807310009440.24147@zero.eik.bme.hu>
	<CAFEAcA8VqaqSzc4NBwjR4F8TMAHD2vhdMMi0fwkTj1fiX=wjyQ@mail.gmail.com>
	<alpine.BSF.2.21.1807310111280.24147@zero.eik.bme.hu>
	<20180731001847.GF2708@umbus.fritz.box>
Message-ID: <52bff728ba683daa71e32be776a55ff0@sebastianbauer.info>
Subject: Re: [Qemu-devel] [PATCH] sam460ex: Fix PCI interrupt connections
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@suse.de>, qemu-ppc <qemu-ppc@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

Am 2018-07-31 02:18, schrieb David Gibson:
>> David, can you please drop this patch, we'll come up with a different 
>> fix.
> Done.  Should have looked at that patch a bit closer.

I created a follow up patch, unfortunately, based on the previous patch, 
as I did not spot your mail earlier than now. Note that the previous 
patch was an improvement over the old behaviour and under normal 
conditions the difference was not visible (as the OS serves both 
interrupts in the same run and at least on AmigaOS the interrupt 
handling is deferred but IRQs are acked quickly; it is still not correct 
though). The old implementation was not correct at all, i.e., all 
interrupts were missed. So it was technical an improvement (and the 
easiest to come up without deep understanding QEMU) ;)

Anyway, I don't know if that follow up patch is the right approach. But 
building the logical or gate seems also be very much code, especially as 
in pci.c the case of multiple irqs sources are seems to be already 
handled (if I understand that code correctly). The follow up patch most 
likely does not model the hardware correctly, but the behaviour should 
be the same. The logical or gate would model the hardware more closely.

Let me know if I should rebase to the state before my initial patch (I 
just looked and the previous patch was still not dropped) if you think 
that the change is fine.

There is also the possibility to make the special (num-irqs == 1) the 
common case, as the Sam460ex platform is the only user of this bus so 
far (and probably stays the only one). I'm not sure if it is worth all 
the hassle. Also note that the entire ppc440_pcix.c source file seems to 
be created for the sam board. I have no idea why that mapping function 
based on slots was chosen in the first place so I kept it. I would also 
be fine to remove that, which would simplify things a lot.

Let me know how to proceed.

Bye
Sebastian
