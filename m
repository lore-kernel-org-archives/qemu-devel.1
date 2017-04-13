Received: from eggs.gnu.org ([2001:4830:134:3::10]:46346)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cyi5T-0000yn-9x
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 12:59:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cyi5S-0002LU-9P
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 12:59:15 -0400
Received: from mail-wr0-x234.google.com ([2a00:1450:400c:c0c::234]:33490)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cyi5S-0002L5-28
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 12:59:14 -0400
Received: by mail-wr0-x234.google.com with SMTP id l28so39301271wre.0
	for <qemu-devel@nongnu.org>; Thu, 13 Apr 2017 09:59:13 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170413164457.GX32646@thinpad.lan.raisama.net>
References: <20170411205813.GA4006@rkaganip.lan>
	<87inm91wo4.fsf@dusky.pond.sub.org>
	<20170412200720.GA27126@thinpad.lan.raisama.net>
	<20170413151533.GD14312@rkaganb.sw.ru>
	<20170413164457.GX32646@thinpad.lan.raisama.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 13 Apr 2017 17:58:51 +0100
Message-ID: <CAFEAcA_VQGDXmMmcTdzwb-UA4sVF1jeXfnXyUBNnZU2E4jdUPw@mail.gmail.com>
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

On 13 April 2017 at 17:44, Eduardo Habkost <ehabkost@redhat.com> wrote:
> On Thu, Apr 13, 2017 at 06:15:34PM +0300, Roman Kagan wrote:
>> Can you (or anybody else) please help me decide if I need
>> TYPE_SYS_BUS_DEVICE?  Logically the VMBus bridge is "attached directly
>> to the main system bus" as written at the top of include/hw/sysbus.h.
>
> I think that documentation was written before we supported
> bus-less devices.

The major question to ask to determine whether you need to be
a sysbus device is how does the guest interact with this thing?
In particular, does it have memory mapped registers (and is it
not part of some other more specific interface like a PCI device) ?

> I'm not sure about the consequences of simply connecting IRQs
> inside ->realize() without using the sysbus *_irq helpers. I hope
> others can clarify this.

Connecting what IRQs to what? If your device has an IRQ
then it isn't the device's job to connect it up -- it is
the job of the machine model, because only the machine
model knows what the IRQ controller is, whether the IRQ
needs to be advertised via ACPI or device tree, and so on.
You can do that without sysbus though, by using the core
DeviceState's qdev_init_gpio_* APIs. (NB that if you do
this then you're by necessity not a device creatable
with -device, since the board code has to wire you up.)

If you're not using sysbus then watch out for reset:
all sysbus devices get automatically reset on QEMU
system reset; if you're directly using the DeviceState
baseclass then you have to arrange reset for yourself
somehow.

thanks
-- PMM
