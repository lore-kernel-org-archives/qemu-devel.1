Received: from eggs.gnu.org ([2001:4830:134:3::10]:53620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ds1y0-0007xu-B7
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:20:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1ds1xw-0005TV-A9
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:20:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51976)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <imammedo@redhat.com>) id 1ds1xw-0005Re-4k
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 03:20:08 -0400
Date: Wed, 13 Sep 2017 09:19:59 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170913091959.336e86f3@nial.brq.redhat.com>
In-Reply-To: <d086a0f8-5440-23ae-2644-8864e835cd84@redhat.com>
References: <20170911152150.12535-1-david@redhat.com>
	<20170911152150.12535-12-david@redhat.com>
	<20170912144330.3f07b30b@nial.brq.redhat.com>
	<d086a0f8-5440-23ae-2644-8864e835cd84@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v4 11/21] s390x: allow only 1 CPU with TCG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: Matthew Rosato <mjrosato@linux.vnet.ibm.com>, thuth@redhat.com, Eduardo Habkost <ehabkost@redhat.com>, Markus Armbruster <armbru@redhat.com>, cohuck@redhat.com, Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, borntraeger@de.ibm.com, Paolo Bonzini <pbonzini@redhat.com>

On Tue, 12 Sep 2017 17:42:35 +0200
David Hildenbrand <david@redhat.com> wrote:

> On 12.09.2017 14:43, Igor Mammedov wrote:
> > On Mon, 11 Sep 2017 17:21:40 +0200
> > David Hildenbrand <david@redhat.com> wrote:
> >   
> >> Specifying more than 1 CPU (e.g. -smp 5) leads to SIGP errors (the
> >> guest tries to bring these CPUs up but fails), because we don't support
> >> multiple CPUs on s390x under TCG.
> >>
> >> Let's bail out if more than 1 is specified, so we don't raise people's
> >> hope. Make it a define, so we can easily bump it up later.
> >>
> >> Tested-by: Matthew Rosato <mjrosato@linux.vnet.ibm.com>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >> ---
> >>  hw/s390x/s390-virtio-ccw.c | 10 ++++++++++
> >>  1 file changed, 10 insertions(+)
> >>
> >> diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
> >> index f67b4b5d58..f1198b2745 100644
> >> --- a/hw/s390x/s390-virtio-ccw.c
> >> +++ b/hw/s390x/s390-virtio-ccw.c
> >> @@ -23,6 +23,7 @@
> >>  #include "hw/s390x/css.h"
> >>  #include "virtio-ccw.h"
> >>  #include "qemu/config-file.h"
> >> +#include "qemu/error-report.h"
> >>  #include "s390-pci-bus.h"
> >>  #include "hw/s390x/storage-keys.h"
> >>  #include "hw/s390x/storage-attributes.h"
> >> @@ -47,6 +48,8 @@ S390CPU *s390_cpu_addr2state(uint16_t cpu_addr)
> >>      return cpu_states[cpu_addr];
> >>  }
> >>  
> >> +/* #define S390_TCG_SMP_SUPPORT */  
> > I'd drop define and ifdef for something that doesn't exists  
> 
> Conny requested it as we might see some work on that area (supporting
> smp) soon. So as long as there are no other opinions, I'll stick to the
> current version.
> 
> Thanks!
> 
I've just removed a bunch of TODO cpu models in PPC with
corresponding macro, my guess they were also introduced
with similar intent but ended up as dead code.

So it's better to add new code when it actually is needed,
instead of just in case.
