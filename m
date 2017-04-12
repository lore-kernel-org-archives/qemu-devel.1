Received: from eggs.gnu.org ([2001:4830:134:3::10]:58222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cyK2t-0007Bq-TM
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 11:19:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cyK2p-00029P-14
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 11:18:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47540)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cyK2o-00029E-Qx
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 11:18:54 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <20170411205813.GA4006@rkaganip.lan>
Date: Wed, 12 Apr 2017 17:18:51 +0200
In-Reply-To: <20170411205813.GA4006@rkaganip.lan> (Roman Kagan's message of
	"Tue, 11 Apr 2017 23:58:16 +0300")
Message-ID: <87inm91wo4.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] vmbus bridge: machine property or device?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kagan <rkagan@virtuozzo.com>
Cc: qemu-devel@nongnu.org, Evgeny Yakovlev <eyakovlev@virtuozzo.com>, "Denis V. Lunev" <den@openvz.org>, Eduardo Habkost <ehabkost@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@suse.de>, Paolo Bonzini <pbonzini@redhat.com>

Cc'ing a few more people who might have a reasoned opinion.

Roman Kagan <rkagan@virtuozzo.com> writes:

> While hammering out the VMBus / storage series, we've been struggling to
> figure out the best practices solution to the following problem:
>
> VMBus is provided by a vmbus bridge; it appears the most natural to have
> it subclassed from SysBusDevice.  There can only be one VMBus in the
> VM.

TYPE_DEVICE unless you actually need something TYPE_SYS_BUS_DEVICE
provides.

> Now the question is how to add it to the system:
>
> 1) with a boolean machine property "vmbus" that would trigger the
>    creation of the VMBus bridge; its class would have
>    ->cannot_instantiate_with_device_add_yet = true

This makes it an optional onboard device.  Similar ones exist already,
e.g. various optional onboard USB host controllers controlled by machine
property "usb".

> 2) with a regular -device option; this would require setting
>    ->has_dynamic_sysbus = true for i440fx machines (q35 already have it)

This makes it a pluggable sysbus device.

I'd be tempted to leave old i400FX rot in peace, but your use case may
not allow that.

>
> 3) anything else
>
>
> So far we went with 1) but since it's essentially the API the management
> layer would have to use we'd like to get it right from the beginning.

Asking for advice here is a good idea.

Anyone?
