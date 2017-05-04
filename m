Received: from eggs.gnu.org ([2001:4830:134:3::10]:35921)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d6Cjq-0004DZ-OR
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:07:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <imammedo@redhat.com>) id 1d6Cjp-0004kB-Ij
	for qemu-devel@nongnu.org; Thu, 04 May 2017 05:07:54 -0400
Date: Thu, 4 May 2017 11:07:41 +0200
From: Igor Mammedov <imammedo@redhat.com>
Message-ID: <20170504110741.7c7cb552@nial.brq.redhat.com>
In-Reply-To: <20170503173109.GS3482@thinpad.lan.raisama.net>
References: <1493816238-33120-1-git-send-email-imammedo@redhat.com>
	<1493816238-33120-10-git-send-email-imammedo@redhat.com>
	<20170503150429.GO3482@thinpad.lan.raisama.net>
	<20170503181950.3aed0972@nial.brq.redhat.com>
	<20170503173109.GS3482@thinpad.lan.raisama.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 09/24] numa: add check that board
 supports cpu_index to node mapping
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Andrew Jones <drjones@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Shannon Zhao <zhaoshenglong@huawei.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org

On Wed, 3 May 2017 14:31:09 -0300
Eduardo Habkost <ehabkost@redhat.com> wrote:

> On Wed, May 03, 2017 at 06:19:50PM +0200, Igor Mammedov wrote:
> > On Wed, 3 May 2017 12:04:29 -0300
> > Eduardo Habkost <ehabkost@redhat.com> wrote:
> >   
> > > On Wed, May 03, 2017 at 02:57:03PM +0200, Igor Mammedov wrote:  
> > > > Default node mapping initialization already checks that board
> > > > supports cpu_index to node mapping and refuses to start if
> > > > it's not supported. Do the same for explicitly provided
> > > > mapping "-numa node,cpus=..."
> > > > 
> > > > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > > > ---
> > > >  numa.c | 13 ++++++++++---
> > > >  1 file changed, 10 insertions(+), 3 deletions(-)
> > > > 
> > > > diff --git a/numa.c b/numa.c
> > > > index ab1661d..b517870 100644
> > > > --- a/numa.c
> > > > +++ b/numa.c
> > > > @@ -140,10 +140,12 @@ uint32_t numa_get_node(ram_addr_t addr, Error **errp)
> > > >      return -1;
> > > >  }
> > > >  
> > > > -static void numa_node_parse(NumaNodeOptions *node, QemuOpts *opts, Error **errp)
> > > > +static void numa_node_parse(MachineState *ms, NumaNodeOptions *node,
> > > > +                            QemuOpts *opts, Error **errp)
> > > >  {
> > > >      uint16_t nodenr;
> > > >      uint16List *cpus = NULL;
> > > > +    MachineClass *mc = MACHINE_GET_CLASS(ms);
> > > >  
> > > >      if (node->has_nodeid) {
> > > >          nodenr = node->nodeid;
> > > > @@ -162,6 +164,10 @@ static void numa_node_parse(NumaNodeOptions *node, QemuOpts *opts, Error **errp)
> > > >          return;
> > > >      }
> > > >  
> > > > +    if (!mc->cpu_index_to_instance_props) {
> > > > +        error_report("CPUs to NUMA node mapping isn't supported");
> > > > +        exit(1);
> > > > +    }    
> > > 
> > > The error message sounds very confusing me. Maybe this could
> > > become just: "NUMA is not supported by the %s machine-type"?  
> > If I replace this specific error message with a generic one and do
> > the same in 5/24, it will be harder for us/user to figure out
> > where exactly error happened.  
> 
> I don't think we need to change the message in 5/24 if we change
> this one.
ok

> > 
> > Would be following clearer:
> > "option -numa node,cpus= is not supported by the %s machine-type"  
> 
> It would work if this was really the case. But the error message
> is unconditional here, appearing even if cpus= is not set:
> 
>   $ qemu-system-x86_64 -m 1G -smp 1 -numa node,mem=1G -machine none
>   qemu-system-x86_64: -numa node,mem=1G: CPUs to NUMA node mapping isn't supported
I'll change error message as you suggested before.
