Received: from eggs.gnu.org ([209.51.188.92]:55679)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gqisP-0001Tq-Ay
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:21:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1gqisN-0001FK-Qj
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:21:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40286)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1gqisN-0001B2-Ii
	for qemu-devel@nongnu.org; Mon, 04 Feb 2019 13:21:47 -0500
From: Markus Armbruster <armbru@redhat.com>
References: <20190131130850.6850-1-yuval.shaia@oracle.com>
	<20190131130850.6850-7-yuval.shaia@oracle.com>
	<87bm3rso1t.fsf@dusky.pond.sub.org> <20190204161430.GC14293@lap1>
Date: Mon, 04 Feb 2019 19:21:42 +0100
In-Reply-To: <20190204161430.GC14293@lap1> (Yuval Shaia's message of "Mon, 4
	Feb 2019 18:14:30 +0200")
Message-ID: <87ef8nbeix.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 06/10] hw/pvrdma: Dump device statistics
 counters to file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yuval Shaia <yuval.shaia@oracle.com>
Cc: Markus Armbruster <armbru@redhat.com>, dgilbert@redhat.com, qemu-devel@nongnu.org

Yuval Shaia <yuval.shaia@oracle.com> writes:

> On Mon, Feb 04, 2019 at 02:03:58PM +0100, Markus Armbruster wrote:
>> Yuval Shaia <yuval.shaia@oracle.com> writes:
>> 
>> > Signed-off-by: Yuval Shaia <yuval.shaia@oracle.com>
>> > ---
>> >  hw/rdma/vmw/pvrdma.h      |  1 +
>> >  hw/rdma/vmw/pvrdma_main.c | 72 +++++++++++++++++++++++++++++++++++++++
>> >  2 files changed, 73 insertions(+)
>> >
>> > diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
>> > index 167706ec2c..dc10f21ca0 100644
>> > --- a/hw/rdma/vmw/pvrdma.h
>> > +++ b/hw/rdma/vmw/pvrdma.h
>> > @@ -133,5 +133,6 @@ static inline void post_interrupt(PVRDMADev *dev, unsigned vector)
>> >  }
>> >  
>> >  int pvrdma_exec_cmd(PVRDMADev *dev);
>> > +void pvrdma_dump_statistics(FILE *f, fprintf_function fprintf_func);
>> >  
>> >  #endif
>> 
>> The only user appears in the next patch.  I'd squash the two patches.
>> Matter of taste.
>
> Agree with you.
> I just did to help reviewers so ones that familiar with 'monitor' can
> review the other patch while rdma folks can review this one.
>
> Will probably squash them as soon as the conversion on the other patch will
> be over.
>
>> 
>> > diff --git a/hw/rdma/vmw/pvrdma_main.c b/hw/rdma/vmw/pvrdma_main.c
>> > index cf82e78f08..79900076ec 100644
>> > --- a/hw/rdma/vmw/pvrdma_main.c
>> > +++ b/hw/rdma/vmw/pvrdma_main.c
>> > @@ -14,6 +14,7 @@
>> >   */
>> >  
>> >  #include "qemu/osdep.h"
>> > +#include "qemu/units.h"
>> >  #include "qapi/error.h"
>> >  #include "hw/hw.h"
>> >  #include "hw/pci/pci.h"
>> > @@ -36,6 +37,8 @@
>> >  #include "standard-headers/drivers/infiniband/hw/vmw_pvrdma/pvrdma_dev_api.h"
>> >  #include "pvrdma_qp_ops.h"
>> >  
>> > +GSList *devices;
>> > +
>> >  static Property pvrdma_dev_properties[] = {
>> >      DEFINE_PROP_STRING("netdev", PVRDMADev, backend_eth_device_name),
>> >      DEFINE_PROP_STRING("ibdev", PVRDMADev, backend_device_name),
>> > @@ -55,6 +58,72 @@ static Property pvrdma_dev_properties[] = {
>> >      DEFINE_PROP_END_OF_LIST(),
>> >  };
>> >  
>> > +static void pvrdma_dump_device_statistics(gpointer data, gpointer user_data)
>> > +{
>> > +    CPUListState *s = user_data;
>> > +    PCIDevice *pdev = data;
>> > +    PVRDMADev *dev = PVRDMA_DEV(pdev);
>> > +
>> > +    (*s->cpu_fprintf)(s->file, "%s_%x.%x\n", pdev->name,
>> > +                 PCI_SLOT(pdev->devfn), PCI_FUNC(pdev->devfn));
>> 
>> Why the indirection through CPUListState?  What's wrong with straight
>> monitor_printf()?
>
> No special reasoning, just wanted to utilize an existing mechanism and
> design.

Please use the simplest available mechanism unless you have an actual
need for a more complex one.  Complicating things just to prepare for
future needs rarely pays off, because YAGNI (you ain't gonna need it).
