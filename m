Received: from eggs.gnu.org ([2001:4830:134:3::10]:53928)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eI8Xe-0004si-T5
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:37:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eI8Xa-0006iV-Vo
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:36:54 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53616)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eI8Xa-0006i5-NY
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 02:36:50 -0500
Date: Fri, 24 Nov 2017 15:36:42 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171124073642.GD10471@xz-mi>
References: <20171116130610.23582-1-peterx@redhat.com>
	<20171116130610.23582-10-peterx@redhat.com>
	<20171123104625.GA2462@work-vm> <20171123105142.GA3153@work-vm>
	<20171123105308.GF8166@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171123105308.GF8166@redhat.com>
Subject: Re: [Qemu-devel] [RFC v4 09/27] monitor: create monitor dedicate
 iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com

On Thu, Nov 23, 2017 at 10:53:08AM +0000, Daniel P. Berrange wrote:
> On Thu, Nov 23, 2017 at 10:51:43AM +0000, Dr. David Alan Gilbert wrote:
> > * Dr. David Alan Gilbert (dgilbert@redhat.com) wrote:
> > > * Peter Xu (peterx@redhat.com) wrote:
> > > > Create one IOThread for the monitors, prepared to handle all the
> > > > input/output IOs using existing iothread framework.
> > > > 
> > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > ---
> > > >  monitor.c | 29 +++++++++++++++++++++++++++++
> > > >  1 file changed, 29 insertions(+)
> > > > 
> > > > diff --git a/monitor.c b/monitor.c
> > > > index a70ab5606b..4ce9828fab 100644
> > > > --- a/monitor.c
> > > > +++ b/monitor.c
> > > > @@ -76,6 +76,7 @@
> > > >  #include "qmp-introspect.h"
> > > >  #include "sysemu/qtest.h"
> > > >  #include "sysemu/cpus.h"
> > > > +#include "sysemu/iothread.h"
> > > >  #include "qemu/cutils.h"
> > > >  #include "qapi/qmp/dispatch.h"
> > > >  
> > > > @@ -208,6 +209,12 @@ struct Monitor {
> > > >      QTAILQ_ENTRY(Monitor) entry;
> > > >  };
> > > >  
> > > > +struct MonitorGlobal {
> > > > +    IOThread *mon_iothread;
> > > > +};
> > > > +
> > > > +static struct MonitorGlobal mon_global;
> > > > +
> > > >  /* QMP checker flags */
> > > >  #define QMP_ACCEPT_UNKNOWNS 1
> > > >  
> > > > @@ -4034,12 +4041,24 @@ static void sortcmdlist(void)
> > > >      qsort((void *)info_cmds, array_num, elem_size, compare_mon_cmd);
> > > >  }
> > > >  
> > > > +static GMainContext *monitor_io_context_get(void)
> > > > +{
> > > > +    return iothread_get_g_main_context(mon_global.mon_iothread);
> > > > +}
> > > > +
> > > > +static void monitor_iothread_init(void)
> > > > +{
> > > > +    mon_global.mon_iothread = iothread_create("monitor_iothread",
> > > > +                                              &error_abort);
> > > 
> > > That name is one character too long for pthread_setname_np that it
> > > ends up being passed too (it's 16 char including the terminator);
> > > that probably means the thread ends up unnamed.  I suggest
> > > you make it "mon_iothread"

Will do.

> > > 
> > > > +}
> > > > +
> > > >  void monitor_init_globals(void)
> > > >  {
> > > >      monitor_init_qmp_commands();
> > > >      monitor_qapi_event_init();
> > > >      sortcmdlist();
> > > >      qemu_mutex_init(&monitor_lock);
> > > > +    monitor_iothread_init();
> > > >  }
> > > >  
> > > >  /* These functions just adapt the readline interface in a typesafe way.  We
> > > > @@ -4117,6 +4136,13 @@ void monitor_cleanup(void)
> > > >  {
> > > >      Monitor *mon, *next;
> > > >  
> > > > +    /*
> > > > +     * We need to explicitly stop the iothread (but not destroy it),
> > > > +     * cleanup the monitor resources, then destroy the iothread.  See
> > > > +     * again on the glib bug mentioned in 2b316774f6 for a reason.
> > > 
> > > I wonder if that bug is still live?   2b316774f6 says that:
> > >    'glib developers found and fixed the deadlock as part of implementing
> > > child sources.'
> > >    but doesn't say which glib version that was fixed in; we have
> > > increased the minimum glib version we support since 2013, so maybe...
> > 
> > Paolo says it wasn't fixed until 2.28 and we still allow 2.22 ; so a
> > little way before we can declare that one dead.
> 
> Please update the comment to mention that we can remove the hack
> in 2.28, since I bet we'll forget about this by the time that time
> comes :=)

Yes worth a comment!

Thanks all.

-- 
Peter Xu
