Received: from eggs.gnu.org ([2001:4830:134:3::10]:42822)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDloT-0007Pn-8I
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:04:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fDloN-0001Ch-C8
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:04:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34586 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fDloN-0001By-25
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:04:23 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id CF793406C773
	for <qemu-devel@nongnu.org>; Wed,  2 May 2018 07:04:11 +0000 (UTC)
Date: Wed, 2 May 2018 15:04:02 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180502070402.GC32728@xz-mi>
References: <20180418090239.13090-1-peterx@redhat.com>
	<20180418090239.13090-3-peterx@redhat.com>
	<20180430101050.GD4002@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180430101050.GD4002@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 2/3] monitor: take mon_lock where proper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Markus Armbruster <armbru@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Mon, Apr 30, 2018 at 11:10:50AM +0100, Stefan Hajnoczi wrote:
> On Wed, Apr 18, 2018 at 05:02:38PM +0800, Peter Xu wrote:
> > diff --git a/monitor.c b/monitor.c
> > index c93aa4e22b..f4951cafbc 100644
> > --- a/monitor.c
> > +++ b/monitor.c
> > @@ -306,16 +306,20 @@ void monitor_read_command(Monitor *mon, int show_prompt)
> >      if (!mon->rs)
> >          return;
> >  
> > +    qemu_mutex_lock(&mon->mon_lock);
> >      readline_start(mon->rs, "(qemu) ", 0, monitor_command_cb, NULL);
> >      if (show_prompt)
> >          readline_show_prompt(mon->rs);
> > +    qemu_mutex_unlock(&mon->mon_lock);
> >  }
> >  
> >  int monitor_read_password(Monitor *mon, ReadLineFunc *readline_func,
> >                            void *opaque)
> >  {
> >      if (mon->rs) {
> > +        qemu_mutex_lock(&mon->mon_lock);
> >          readline_start(mon->rs, "Password: ", 1, readline_func, opaque);
> > +        qemu_mutex_unlock(&mon->mon_lock);
> >          /* prompt is printed on return from the command handler */
> >          return 0;
> >      } else {
> 
> I'm not sure why the lock is being used around readline_start() and
> readline_show_prompt().  There are other readline_*() callers who do not
> take the lock, which is suspicious.
> 
> Can you explain the purpose of this?
> 
> > @@ -1308,8 +1312,7 @@ void qmp_qmp_capabilities(bool has_enable, QMPCapabilityList *enable,
> >      cur_mon->qmp.commands = &qmp_commands;
> >  }
> >  
> > -/* set the current CPU defined by the user */
> > -int monitor_set_cpu(int cpu_index)
> > +static int monitor_set_cpu_locked(Monitor *mon, int cpu_index)
> 
> This function requires the BQL since qemu_get_cpu() accesses the cpus
> list without acquiring qemu_cpu_list_lock.
> 
> Two options:
> 1. Document that monitor_set_cpu() must be called with the BQL held.
> 2. Audit qemu_cpu_list_lock to check that it meets the out-of-band
>    monitor code requirements, document that qemu_cpu_list_lock code must
>    follow out-of-band monitor code requirements, and then take the lock.
> 
> #1 is more practical since we will probably never need to call
> monitor_set_cpu() from out-of-band monitor code.  Anyway, in that case
> mon_lock is not needed unless there is a mon field that needs to be
> protected.

You are right.

After a second thought I think readline is not needed to be protected.
IMHO it's only used in parsing phase, so actually we don't have
multi-threading issue with that (parsing is either happening in main
thread only, or monitor iothread only).

So I'll drop all the readline_* protections, and add a comment for
monitor_set_cpu() on BQL.

> 
> >  {
> >      CPUState *cpu;
> >  
> > @@ -1317,15 +1320,28 @@ int monitor_set_cpu(int cpu_index)
> >      if (cpu == NULL) {
> >          return -1;
> >      }
> > -    g_free(cur_mon->mon_cpu_path);
> > -    cur_mon->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
> > +    g_free(mon->mon_cpu_path);
> > +    mon->mon_cpu_path = object_get_canonical_path(OBJECT(cpu));
> >      return 0;
> >  }
> >  
> > +/* set the current CPU defined by the user */
> > +int monitor_set_cpu(int cpu_index)
> > +{
> > +    int ret;
> > +
> > +    qemu_mutex_lock(&cur_mon->mon_lock);
> > +    ret = monitor_set_cpu_locked(cur_mon, cpu_index);
> > +    qemu_mutex_unlock(&cur_mon->mon_lock);
> > +
> > +    return ret;
> > +}
> > +
> >  static CPUState *mon_get_cpu_sync(bool synchronize)
> >  {
> 
> This function calls monitor_set_cpu() so it must be called from the BQL.
> The locking changes are probably not needed.  This function just needs
> to be documented as BQL-only.

Yes.  Will do.

> 
> > @@ -2239,6 +2258,7 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
> >  {
> >      mon_fd_t *monfd;
> >  
> > +    qemu_mutex_lock(&mon->mon_lock);
> >      QLIST_FOREACH(monfd, &mon->fds, next) {
> >          int fd;
> >  
> > @@ -2252,9 +2272,10 @@ int monitor_get_fd(Monitor *mon, const char *fdname, Error **errp)
> >          QLIST_REMOVE(monfd, next);
> >          g_free(monfd->name);
> >          g_free(monfd);
> > -
> > +        qemu_mutex_unlock(&mon->mon_lock);
> >          return fd;
> >      }
> > +    qemu_mutex_unlock(&mon->mon_lock);
> 
> What about all the other mon->fds users?  They need to lock too,
> otherwise we will QLIST_REMOVE() an fd while they are accessing the
> list!

Indeed!  I think I'll drop most of this patch, only add protection for
mon->fds, and add those comments that you suggested.  They make sense
to me.  Thanks,

-- 
Peter Xu
