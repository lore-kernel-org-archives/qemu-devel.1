Received: from eggs.gnu.org ([209.51.188.92]:36095)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gk3Ym-0001qw-RR
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:02:04 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gk3Yg-0002MG-OT
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 04:02:00 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190111140857.4211-1-philmd@redhat.com>
	<20190111140857.4211-4-philmd@redhat.com>
	<875zuqjea7.fsf@dusky.pond.sub.org>
	<403ad2e4-3282-051c-1ff5-8a3a23899293@redhat.com>
	<be75e72a-9f54-c9b5-4a1f-e87e28df8ba5@redhat.com>
	<87sgxtatod.fsf@dusky.pond.sub.org>
	<4b24723e-5a27-f25f-76c1-f2f4e94757ba@redhat.com>
	<20190116113455.dyl6uctl4dpaqh6v@sirius.home.kraxel.org>
	<ad34caf3-5f1f-dffc-4aed-60bb90ba2e5f@redhat.com>
	<20190116091801-mutt-send-email-mst@kernel.org>
Date: Thu, 17 Jan 2019 10:01:04 +0100
In-Reply-To: <20190116091801-mutt-send-email-mst@kernel.org> (Michael
	S. Tsirkin's message of "Wed, 16 Jan 2019 09:48:52 -0500")
Message-ID: <87imyn64kv.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 03/15] hw/ssi: Remove SSIBus from
 "qemu/typedefs.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-block@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Laszlo Ersek <lersek@redhat.com>, Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org, Greg Kurz <groug@kaod.org>, qemu-arm@nongnu.org, Gerd Hoffmann <kraxel@redhat.com>, =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>, Igor Mammedov <imammedo@redhat.com>, Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@redhat.com>, Philippe =?utf-8?Q?M?= =?utf-8?Q?athieu-Daud=C3=A9?= <f4bug@amsat.org>

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Wed, Jan 16, 2019 at 12:49:07PM +0100, Paolo Bonzini wrote:
>> On 16/01/19 12:34, Gerd Hoffmann wrote:
>> >   Hi,
>> > 
>> >> typedefs.h is useful to avoid rebuilding the world too often if a type
>> >> is used many times as a pointer, but rarely as a struct and rarely has
>> >> functions called on its instances.
>> > 
>> > Related:  Can also be used to keep struct content private.  struct
>> > QemuConsole for example is private to ui/console.c, but pointers to
>> > QemuConsole are passed around alot in ui/* and hw/display/* code.
>> 
>> True, though as we switch more and more from pointers to embedded
>> structs that does not work that much anymore.  Another way to do that is
>> to split the header in include/path/to/foo.h and path/to/foo_internal.h.
>> 
>> Paolo
>
> Not sure this will help since no tool checks structure isn't
> actually used even though it's in internal.
>
> If you want to go overboard it's solvable of course, e.g.
> something like this will work:
>
>
> E.g. in virtio.h
>
> #ifndef VIRTIO_PRIVATE
> #define VIRTIO_PRIVATE(f) (VIRTIO_PIVATE_##f)
> #endif
>
> struct VirtioPrivate {
> 	int VIRTIO_PRIVATE(bar);
> };
>
> and in virtio.c:
>
> #define VIRTIO_PRIVATE(f) (f)
> #include <virtio.h>

I don't like such games at all.

Instead, I'd recommend to keep internal headers out of include/, and
rely on review / grep to catch, correct and prevent inappropriate uses.
