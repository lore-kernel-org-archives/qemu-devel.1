Received: from eggs.gnu.org ([2001:4830:134:3::10]:35779)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1cyitQ-0008QB-IX
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:50:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1cyitL-00062j-LM
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:50:52 -0400
Received: from mail-db5eur01on0135.outbound.protection.outlook.com
	([104.47.2.135]:18144
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1cyitL-00061V-0E
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 13:50:47 -0400
Date: Thu, 13 Apr 2017 18:15:34 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20170413151533.GD14312@rkaganb.sw.ru>
References: <20170411205813.GA4006@rkaganip.lan>
	<87inm91wo4.fsf@dusky.pond.sub.org>
	<20170412200720.GA27126@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20170412200720.GA27126@thinpad.lan.raisama.net>
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

On Wed, Apr 12, 2017 at 05:07:20PM -0300, Eduardo Habkost wrote:
> On Wed, Apr 12, 2017 at 05:18:51PM +0200, Markus Armbruster wrote:
> > Roman Kagan <rkagan@virtuozzo.com> writes:
> > > VMBus is provided by a vmbus bridge; it appears the most natural to have
> > > it subclassed from SysBusDevice.  There can only be one VMBus in the
> > > VM.
> > 
> > TYPE_DEVICE unless you actually need something TYPE_SYS_BUS_DEVICE
> > provides.
> > 
> > > Now the question is how to add it to the system:
> > >
> > > 1) with a boolean machine property "vmbus" that would trigger the
> > >    creation of the VMBus bridge; its class would have
> > >    ->cannot_instantiate_with_device_add_yet = true
> > 
> > This makes it an optional onboard device.  Similar ones exist already,
> > e.g. various optional onboard USB host controllers controlled by machine
> > property "usb".
> > 
> > > 2) with a regular -device option; this would require setting
> > >    ->has_dynamic_sysbus = true for i440fx machines (q35 already have it)
> > 
> > This makes it a pluggable sysbus device.
> > 
> > I'd be tempted to leave old i400FX rot in peace, but your use case may
> > not allow that.
> 
> I have sent a RFC some time ago that replaces the all-or-nothing
> has_dynamic_sysbus flag with an explicit sysbus device whitelist,
> so i440fx wouldn't be a big problem.

I looked at the patchset, and it seems to adress this very nicely,
indeed.

> But as you noted above, if
> you don't need TYPE_SYS_BUS_DEVIC, you can just use TYPE_DEVICE.

Can you (or anybody else) please help me decide if I need
TYPE_SYS_BUS_DEVICE?  Logically the VMBus bridge is "attached directly
to the main system bus" as written at the top of include/hw/sysbus.h.
OTOH we use neither mmio nor pio members of SysBusDevice; nor do we
currently use any of its *_irq helpers, but we may eventually need to
(the guests require VMBus to announce two IRQs in its ACPI description
but nothing seems to use them so we just hardcode two (almost) random
numbers).

> > > 3) anything else
> > >
> > >
> > > So far we went with 1) but since it's essentially the API the management
> > > layer would have to use we'd like to get it right from the beginning.
> > 
> > Asking for advice here is a good idea.
> > 
> > Anyone?
> > 
> 
> I would go with (2) instead of (1): it allows more flexibility in
> case the device needs additional arguments, and will
> automatically benefit from (present and future) mechanisms for
> reporting available device-types and buses. Asking QEMU if
> "-device FOO" is supported is easy and reliable; the mechanisms
> for asking QEMU about supported "-machine" options are obscure
> and probably not well-tested.

Good point in favor of -device, thanks.

Is there an idiom to express that no more than a single vmbus-bridge can
be present in the system?  Or the only way to ensure that is with a
static or a class variable and checking / setting it in ->realize?

Thanks,
Roman.
