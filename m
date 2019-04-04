Received: from eggs.gnu.org ([209.51.188.92]:43047)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hC57Q-0001Lm-RN
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 12:21:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1hC57P-0001OA-PW
	for qemu-devel@nongnu.org; Thu, 04 Apr 2019 12:21:36 -0400
Date: Thu, 4 Apr 2019 17:21:28 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190404162128.GF2678@work-vm>
References: <1553849325-44201-1-git-send-email-like.xu@linux.intel.com>
	<1553849325-44201-3-git-send-email-like.xu@linux.intel.com>
	<20190404162555.0a2267ee@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190404162555.0a2267ee@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/9] cpu/topology: add general support for
 machine properties
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: Like Xu <like.xu@linux.intel.com>, qemu-trivial@nongnu.org, qemu-devel@nongnu.org, Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, like.xu@intel.com

* Igor Mammedov (imammedo@redhat.com) wrote:
> On Fri, 29 Mar 2019 16:48:38 +0800
> Like Xu <like.xu@linux.intel.com> wrote:
> 
> > Signed-off-by: Like Xu <like.xu@linux.intel.com>
> > ---

<snipp>

> > diff --git a/migration/postcopy-ram.c b/migration/postcopy-ram.c
> > index e2aa57a..ae92f6e 100644
> > --- a/migration/postcopy-ram.c
> > +++ b/migration/postcopy-ram.c
> > @@ -29,6 +29,7 @@
> >  #include "sysemu/balloon.h"
> >  #include "qemu/error-report.h"
> >  #include "trace.h"
> > +#include "hw/boards.h"
> >  
> >  /* Arbitrary limit on size of each discard command,
> >   * keeps them around ~200 bytes
> > @@ -128,6 +129,8 @@ static void migration_exit_cb(Notifier *n, void *data)
> >  
> >  static struct PostcopyBlocktimeContext *blocktime_context_new(void)
> >  {
> > +    MachineState *ms = MACHINE(qdev_get_machine());
> > +    unsigned int smp_cpus = ms->topo.smp_cpus;
> >      PostcopyBlocktimeContext *ctx = g_new0(PostcopyBlocktimeContext, 1);
> >      ctx->page_fault_vcpu_time = g_new0(uint32_t, smp_cpus);
> >      ctx->vcpu_addr = g_new0(uintptr_t, smp_cpus);
> > @@ -141,6 +144,8 @@ static struct PostcopyBlocktimeContext *blocktime_context_new(void)
> >  
> >  static uint32List *get_vcpu_blocktime_list(PostcopyBlocktimeContext *ctx)
> >  {
> > +    MachineState *ms = MACHINE(qdev_get_machine());
> > +    unsigned int smp_cpus = ms->topo.smp_cpus;
> >      uint32List *list = NULL, *entry = NULL;
> >      int i;
> >  
> > @@ -806,8 +811,10 @@ static void mark_postcopy_blocktime_begin(uintptr_t addr, uint32_t ptid,
> >  static void mark_postcopy_blocktime_end(uintptr_t addr)
> >  {
> >      MigrationIncomingState *mis = migration_incoming_get_current();
> > +    MachineState *ms = MACHINE(qdev_get_machine());
> >      PostcopyBlocktimeContext *dc = mis->blocktime_ctx;
> >      int i, affected_cpu = 0;
> > +    unsigned int smp_cpus = ms->topo.smp_cpus;
> >      bool vcpu_total_blocktime = false;
> >      uint32_t read_vcpu_time, low_time_offset;
> 
> I don't know enough about migration to say some thing useful here,
> CCin David for comments.

I think that's OK; we just need to know the total number of vcpus; this
thing calculates some stats based on the number of the vCPUs that are
blocked by postcopy page waits, and in particular if everyone is
blocked.

(I'd slightly prefer macs there rather than ms, just because we tend to
use ms in migration for MigrationState sometimes, but not always).

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
