Received: from eggs.gnu.org ([2001:4830:134:3::10]:55489)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1cyr4g-0002tM-Ai
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 22:35:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1cyr4d-0004fu-6Q
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 22:35:02 -0400
Received: from mail-db5eur01on0135.outbound.protection.outlook.com
	([104.47.2.135]:54352
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1cyr4c-0004ei-L4
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 22:34:59 -0400
Date: Thu, 13 Apr 2017 20:04:03 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20170413170403.GE14312@rkaganb.sw.ru>
References: <20170411205813.GA4006@rkaganip.lan>
	<87inm91wo4.fsf@dusky.pond.sub.org>
	<20170412200720.GA27126@thinpad.lan.raisama.net>
	<20170413151533.GD14312@rkaganb.sw.ru>
	<20170413164457.GX32646@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20170413164457.GX32646@thinpad.lan.raisama.net>
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
Cc: Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, Alexander Graf <agraf@suse.de>, qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Denis V. Lunev" <den@openvz.org>

On Thu, Apr 13, 2017 at 01:44:57PM -0300, Eduardo Habkost wrote:
> On Thu, Apr 13, 2017 at 06:15:34PM +0300, Roman Kagan wrote:
> > Can you (or anybody else) please help me decide if I need
> > TYPE_SYS_BUS_DEVICE?  Logically the VMBus bridge is "attached directly
> > to the main system bus" as written at the top of include/hw/sysbus.h.
> 
> I think that documentation was written before we supported
> bus-less devices.

I see.  Then we should be good subclassing TYPE_DEVICE.

> > OTOH we use neither mmio nor pio members of SysBusDevice; nor do we
> > currently use any of its *_irq helpers, but we may eventually need to
> > (the guests require VMBus to announce two IRQs in its ACPI description
> > but nothing seems to use them so we just hardcode two (almost) random
> > numbers).
> 
> I'm not sure about the consequences of simply connecting IRQs
> inside ->realize() without using the sysbus *_irq helpers.

We don't connect IRQs; we just compose the appropriate AML fragments
with arbitrarily chosen irq numbers and forget about them.  The guests
refuse to use VMBus if the respective clauses aren't in the ACPI, but
don't seem to care if they point nowhere.

> > Is there an idiom to express that no more than a single vmbus-bridge can
> > be present in the system?  Or the only way to ensure that is with a
> > static or a class variable and checking / setting it in ->realize?
> 
> I wouldn't use a static or class variable. You have some
> alternatives:
> 
> You could check if a TYPE_VMBUS device already exists anywhere in
> the device tree, or always create it at a specific QOM path.
> 
> Or, if your device is 100% specific for PC machines, you could
> add a PCMachineState struct field pointing to the existing vmbus
> device.

Makes sense, thanks!
(And IIUC there's no generic way to express this, like, e.g. with a
class property ->single_instance or ->max_instances=1, right?)

Thanks a lot for the advices, we'll be back with a patchset ;)
Roman.
