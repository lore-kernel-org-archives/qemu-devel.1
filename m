Received: from eggs.gnu.org ([209.51.188.92]:51181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjmVC-0003rF-4u
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:49:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gjmVA-0002K1-Ct
	for qemu-devel@nongnu.org; Wed, 16 Jan 2019 09:49:10 -0500
Date: Wed, 16 Jan 2019 09:48:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20190116091801-mutt-send-email-mst@kernel.org>
References: <20190111140857.4211-1-philmd@redhat.com>
	<20190111140857.4211-4-philmd@redhat.com>
	<875zuqjea7.fsf@dusky.pond.sub.org>
	<403ad2e4-3282-051c-1ff5-8a3a23899293@redhat.com>
	<be75e72a-9f54-c9b5-4a1f-e87e28df8ba5@redhat.com>
	<87sgxtatod.fsf@dusky.pond.sub.org>
	<4b24723e-5a27-f25f-76c1-f2f4e94757ba@redhat.com>
	<20190116113455.dyl6uctl4dpaqh6v@sirius.home.kraxel.org>
	<ad34caf3-5f1f-dffc-4aed-60bb90ba2e5f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad34caf3-5f1f-dffc-4aed-60bb90ba2e5f@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>, Xiao Guangrong <xiaoguangrong.eric@gmail.com>, qemu-block@nongnu.org, Alistair Francis <alistair@alistair23.me>, qemu-devel@nongnu.org, Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>, Greg Kurz <groug@kaod.org>, qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>, Laszlo Ersek <lersek@redhat.com>, =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>

On Wed, Jan 16, 2019 at 12:49:07PM +0100, Paolo Bonzini wrote:
> On 16/01/19 12:34, Gerd Hoffmann wrote:
> >   Hi,
> > 
> >> typedefs.h is useful to avoid rebuilding the world too often if a type
> >> is used many times as a pointer, but rarely as a struct and rarely has
> >> functions called on its instances.
> > 
> > Related:  Can also be used to keep struct content private.  struct
> > QemuConsole for example is private to ui/console.c, but pointers to
> > QemuConsole are passed around alot in ui/* and hw/display/* code.
> 
> True, though as we switch more and more from pointers to embedded
> structs that does not work that much anymore.  Another way to do that is
> to split the header in include/path/to/foo.h and path/to/foo_internal.h.
> 
> Paolo

Not sure this will help since no tool checks structure isn't
actually used even though it's in internal.

If you want to go overboard it's solvable of course, e.g.
something like this will work:


E.g. in virtio.h

#ifndef VIRTIO_PRIVATE
#define VIRTIO_PRIVATE(f) (VIRTIO_PIVATE_##f)
#endif

struct VirtioPrivate {
	int VIRTIO_PRIVATE(bar);
};

and in virtio.c:

#define VIRTIO_PRIVATE(f) (f)
#include <virtio.h>


-- 
MST
