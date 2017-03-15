Received: from eggs.gnu.org ([2001:4830:134:3::10]:40363)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1co690-0000jP-9F
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1co68z-0000PW-55
	for qemu-devel@nongnu.org; Wed, 15 Mar 2017 06:27:02 -0400
Date: Wed, 15 Mar 2017 10:26:44 +0000
From: "Daniel P. Berrange" <berrange@redhat.com>
Message-ID: <20170315102644.GF7770@redhat.com>
Reply-To: "Daniel P. Berrange" <berrange@redhat.com>
References: <20170310031521.630-1-eblake@redhat.com>
	<033881fe-b3d3-2c3a-48fc-c08691f2c9cb@redhat.com>
	<19efa7dc-fa97-410f-df4d-3962453dcd8e@redhat.com>
	<20170315101835.GF8147@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170315101835.GF8147@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH for-2.9] mirror: Fix backwards mirror_yield
 parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

On Wed, Mar 15, 2017 at 06:18:35PM +0800, Stefan Hajnoczi wrote:
> On Fri, Mar 10, 2017 at 02:49:22PM -0600, Eric Blake wrote:
> > And here's where I'm stuck: the makefiles are broken.  Touching
> > scripts/tracetool/format/h.py does NOT cause tracetool to be re-run by a
> > mere 'make'; I've had to resort to 'make -B block/trace.h-timestamp' to
> > get things to rebuild.  And this is in spite of the fact that h.py
> > _should_ be getting listed in $(tracetool-y) by trace/Makefile.objs, and
> > $(tracetool-y) is listed as a dependency of %/trace.h-timestamp in the
> > top-level Makefile.  I would appreciate anyone with advice or an idea on
> > how to patch Makefile to get the dependency working without me having to
> > manually kick it.
> 
> Also CCing Daniel Berrange.  He recently touched the tracing Makefiles
> and may have ideas.

I've been looking at this and I'm damned if I understand what's broken.
All the required dependancies look to be expressed in the Makefile

  %/trace.h: %/trace.h-timestamp
  %/trace.h-timestamp: $(SRC_PATH)/%/trace-events $(tracetool-y)

and $(tracetool-y) expands to the list of source files

  tracetool-y = $(SRC_PATH)/scripts/tracetool.py
  tracetool-y += $(shell find $(SRC_PATH)/scripts/tracetool -name "*.py")


If I do 'touch hw/net/trace-events', then hw/net/trace.h gets rebuilt,
but if do 'touch scripts/tracetool.py' it doesn't get built. So somehow
make seems to be dropping the $(tracetool-y) deps despite being listed
against the %/trace-h-timestamp file, and despite earlier deps on
trace-events being honoured

Regards,
Daniel
-- 
|: http://berrange.com      -o-    http://www.flickr.com/photos/dberrange/ :|
|: http://libvirt.org              -o-             http://virt-manager.org :|
|: http://entangle-photo.org       -o-    http://search.cpan.org/~danberr/ :|
