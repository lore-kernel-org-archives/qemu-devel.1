Received: from eggs.gnu.org ([2001:4830:134:3::10]:41378)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ePlP3-00081K-DP
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:31:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ePlP0-0005EB-7W
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:31:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53636)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ePlOz-0005Cp-Kq
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:31:29 -0500
Date: Fri, 15 Dec 2017 16:31:08 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171215083108.GO7780@xz-mi>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-10-peterx@redhat.com>
	<20171213162022.GJ7173@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171213162022.GJ7173@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v5 09/26] monitor: create monitor dedicate
 iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Wed, Dec 13, 2017 at 04:20:22PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 05, 2017 at 01:51:43PM +0800, Peter Xu wrote:
> > @@ -208,6 +209,12 @@ struct Monitor {
> >      QTAILQ_ENTRY(Monitor) entry;
> >  };
> >  
> > +struct MonitorGlobal {
> > +    IOThread *mon_iothread;
> > +};
> > +
> > +static struct MonitorGlobal mon_global;
> 
> structs can be anonymous.  That avoids the QEMU coding style violation
> (structs must be typedefed):
> 
>   static struct {
>       IOThread *mon_iothread;
>   } mon_global;

Will fix this up.  Thanks.

> 
> In general global variables are usually top-level variables in QEMU.
> I'm not sure why wrapping globals in a struct is useful.

Because I see too many global variables for monitor code, and from
this patch I wanted to start moving them altogether into this global
struct.  I didn't really do that in current series because it's more
like a clean up, but if you see future patches, it at least grows with
new monitor global variables introduced with current series.

I can add a comment in the commit message, like: "Let's start to
create a struct to keep monitor global variables together".  Would
that help?

> 
> > @@ -4117,6 +4136,16 @@ void monitor_cleanup(void)
> >  {
> >      Monitor *mon, *next;
> >  
> > +    /*
> > +     * We need to explicitly stop the iothread (but not destroy it),
> > +     * cleanup the monitor resources, then destroy the iothread.  See
> > +     * again on the glib bug mentioned in 2b316774f6 for a reason.
> > +     *
> > +     * TODO: the bug is fixed in glib 2.28, so we can remove this hack
> > +     * as long as we won't support glib versions older than it.
> > +     */
> 
> I find this comment confusing.  There is no GSource .finalize() in
> monitor.c so why does monitor_cleanup() need to work around the bug?
> 
> I see that monitor_data_destroy() is not thread-safe so the IOThread
> must be stopped first.  That is unrelated to glib.

Yeah actually that's a suggestion by Dave and Dan in previous review
comments which makes sense to me:

  http://lists.gnu.org/archive/html/qemu-devel/2017-11/msg04344.html

I'm fine with either way: keep it as it is, or instead saying
"monitor_data_destroy() is not thread-safe" (which finally will still
root cause to that glib bug).  But how about we just keep it in case
it may be helpful some day?

Thanks,

> 
> > +    iothread_stop(mon_global.mon_iothread);
> > +
> >      qemu_mutex_lock(&monitor_lock);
> >      QTAILQ_FOREACH_SAFE(mon, &mon_list, entry, next) {
> >          QTAILQ_REMOVE(&mon_list, mon, entry);
> > @@ -4124,6 +4153,9 @@ void monitor_cleanup(void)
> >          g_free(mon);
> >      }
> >      qemu_mutex_unlock(&monitor_lock);
> > +
> > +    iothread_destroy(mon_global.mon_iothread);
> > +    mon_global.mon_iothread = NULL;
> >  }
> >  
> >  QemuOptsList qemu_mon_opts = {
> > -- 
> > 2.14.3
> > 

-- 
Peter Xu
