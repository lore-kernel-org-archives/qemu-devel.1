Received: from eggs.gnu.org ([2001:4830:134:3::10]:34126)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cymkC-0004cs-Cs
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 17:57:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cymkB-0002qo-NJ
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 17:57:36 -0400
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:38223)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cymkB-0002pQ-Fa
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 17:57:35 -0400
Received: by mail-wm0-x230.google.com with SMTP id t189so55913671wmt.1
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 14:57:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170413181518.GY32646@thinpad.lan.raisama.net>
References: <20170411205813.GA4006@rkaganip.lan>
	<87inm91wo4.fsf@dusky.pond.sub.org>
	<20170412200720.GA27126@thinpad.lan.raisama.net>
	<20170413151533.GD14312@rkaganb.sw.ru>
	<20170413164457.GX32646@thinpad.lan.raisama.net>
	<CAFEAcA_VQGDXmMmcTdzwb-UA4sVF1jeXfnXyUBNnZU2E4jdUPw@mail.gmail.com>
	<20170413181518.GY32646@thinpad.lan.raisama.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Apr 2017 22:57:13 +0100
Message-ID: <CAFEAcA-WKS697Hy7NBkQiUNdTpkd4OfEJ3pJ4NKPKzeFuOAuLQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] vmbus bridge: machine property or device?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Roman Kagan <rkagan@virtuozzo.com>, Markus Armbruster <armbru@redhat.com>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, Alexander Graf <agraf@suse.de>, QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On 13 April 2017 at 19:15, Eduardo Habkost <ehabkost@redhat.com> wrote:
> I can't say it's a good idea, but it looks like there are devices
> that do that (probably they are machine-specific, so they know
> which machine they are being connected to?).
>
> I looked for realize functions that call sysbus_mmio_map() or
> get_system_memory() directly, and I've found a few:

Yeah. Ideally these should get cleaned up. The way I think is
the right approach here is that the board code uses the
system memory address space to map its devices, and then
it passes a MemoryRegion to the SoC container device via a
QOM link property. The SoC then maps its devices inside that
MemoryRegion, and hands an MR to the CPU (and the CPU does
its accesses to that MR). You can see some of this with
stm32f205_soc.c and armv7m.c.

I think most of your examples are SoCs which are just
slightly old-style/lazy and using the system memory
address space directly (since the SoC covers the whole
of the address space anyway). The real bad code is devices
which directly map their own memory regions into the
system memory space even though they're just a leaf
device like a UART (common in not-yet-converted-to-QOM code).

> And the ones that call sysbus_connect_irq() directly:

Calling sysbus_connect_irq() is fine because it's
what you use to wire up a sysbus device's input IRQ
line to something else. If you (as an SoC container
object) have created both the IRQ chip and the other
device then it's also your job to wire the two together.

> Isn't "the board code has to wire you up" true for both sysbus
> and bus-less devices?

If you need no wiring up at all then it's ok.
hw/core/generic-loader.c is an example of that.

thanks
-- PMM
