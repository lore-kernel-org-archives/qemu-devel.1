Received: from eggs.gnu.org ([2001:4830:134:3::10]:50434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crPyl-0006fx-AG
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:14:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1crPyk-0000VL-E2
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:14:11 -0400
Received: from mail-wm0-x229.google.com ([2a00:1450:400c:c09::229]:33968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1crPyk-0000V9-5E
	for qemu-devel@nongnu.org; Fri, 24 Mar 2017 10:14:10 -0400
Received: by mail-wm0-x229.google.com with SMTP id w204so7773061wmd.1
	for <qemu-devel@nongnu.org>; Fri, 24 Mar 2017 07:14:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20170324134821.GC28530@thinpad.lan.raisama.net>
References: <20170322203140.GA12155@thinpad.lan.raisama.net>
	<3d10c7b3-b702-3c16-7f3e-dfc6b332fbd4@redhat.com>
	<b5516794-4592-569e-66ba-05dc40573a10@redhat.com>
	<20170324134821.GC28530@thinpad.lan.raisama.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 24 Mar 2017 14:13:48 +0000
Message-ID: <CAFEAcA8q=GDx_DKv=YyPmVVM2EeKqeafcmWJivLLvzNZUeUEbg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] q35 and sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: Marcel Apfelbaum <marcel@redhat.com>, Laszlo Ersek <lersek@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Markus Armbruster <armbru@redhat.com>

On 24 March 2017 at 13:48, Eduardo Habkost <ehabkost@redhat.com> wrote:
> The problem with today's mechanism is that we have no way to make
> a machine accept one type of sysbus device without making it
> start accepting every other sysbus devices. If we thought all
> !cannot_instantiate_with_device_add_yet sysbus devices were
> already safe, we wouldn't have has_dynamic_sysbus in the first
> place, would we?

Almost all sysbus devices are not dynamically instantiable
and never will be because they need to map mmio and wire
up IRQs and so on, and we have no mechanism for doing that.
So the default position is "no, you can't do that (but maybe
a subclass which knows better might override)". has_dynamic_sysbus
is a dodgy hack for boards which support the "platform bus"
which is a special case where the user can use -device
for certain sysbus devices that the platform bus knows about
and can wire up itself (in a range of irqs and memory that
the board has set aside for that purpose). The default
is still "no, you can't dynamically instantiate this", but
instead of this (and the handful of exceptions) being imposed
at compile time it's imposed (with exceptions) at runtime.

So for instance the ARM 'virt' board sets has_dynamic_sysbus,
which allows a few devices to be added with -device, but
most still do not permit it (they'll end up hitting the
error_report() in hw/arm/sysbus-fdt.c:add_fdt_node()).

thanks
-- PMM
