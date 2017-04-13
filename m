Received: from eggs.gnu.org ([2001:4830:134:3::10]:60979)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1cyffB-0002Sf-KR
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 10:23:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rkagan@virtuozzo.com>) id 1cyff8-0006zE-EL
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 10:23:57 -0400
Received: from mail-db5eur01on0100.outbound.protection.outlook.com
	([104.47.2.100]:53954
	helo=EUR01-DB5-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <rkagan@virtuozzo.com>)
	id 1cyff8-0006wT-3M
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 10:23:54 -0400
Date: Thu, 13 Apr 2017 17:08:04 +0300
From: Roman Kagan <rkagan@virtuozzo.com>
Message-ID: <20170413140804.GC14312@rkaganb.sw.ru>
References: <20170411205813.GA4006@rkaganip.lan>
	<87inm91wo4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <87inm91wo4.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] vmbus bridge: machine property or device?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis
	V. Lunev" <den@openvz.org>, Eduardo Habkost <ehabkost@redhat.com>, Peter
	Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@suse.de>, Paolo
	Bonzini <pbonzini@redhat.com>

On Wed, Apr 12, 2017 at 05:18:51PM +0200, Markus Armbruster wrote:
> Roman Kagan <rkagan@virtuozzo.com> writes:
> > VMBus is provided by a vmbus bridge; it appears the most natural to have
> > it subclassed from SysBusDevice.  There can only be one VMBus in the
> > VM.
> 
> TYPE_DEVICE unless you actually need something TYPE_SYS_BUS_DEVICE
> provides.

I thought VMBus looked similar to an ISA or PCI bus in its relation to
the system, and those bridges were TYPE_SYS_BUS_DEVICE.

If it's subclassed directly from TYPE_DEVICE how is it connected to the
rest of the QOM tree?

> > Now the question is how to add it to the system:
> >
> > 1) with a boolean machine property "vmbus" that would trigger the
> >    creation of the VMBus bridge; its class would have
> >    ->cannot_instantiate_with_device_add_yet = true
> 
> This makes it an optional onboard device.  Similar ones exist already,
> e.g. various optional onboard USB host controllers controlled by machine
> property "usb".
> 
> > 2) with a regular -device option; this would require setting
> >    ->has_dynamic_sysbus = true for i440fx machines (q35 already have it)
> 
> This makes it a pluggable sysbus device.

VMBus can't be hot-plugged into the system.  Besides, there can be no
more than one VMBus in the system, so multiple -device vmbus-bridge
options would not be allowed; I thought this semantics was clearer with
a machine option.

> I'd be tempted to leave old i400FX rot in peace, but your use case may
> not allow that.

It doesn't ;)  Besides, we've had no specal cases for i440fx vs q35 in
our VMBus code so far, so I don't see any reason to not to support both.

Thanks,
Roman.
