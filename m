Received: from eggs.gnu.org ([2001:4830:134:3::10]:49132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ePlhw-0006eb-0f
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:51:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ePlhu-0006H7-1U
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:51:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:49748)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ePlht-0006GH-Od
	for qemu-devel@nongnu.org; Fri, 15 Dec 2017 03:51:01 -0500
Date: Fri, 15 Dec 2017 16:50:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171215085044.GP7780@xz-mi>
References: <20171205055200.16305-1-peterx@redhat.com>
	<20171205055200.16305-11-peterx@redhat.com>
	<20171213163500.GA8317@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171213163500.GA8317@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v5 10/26] monitor: allow to use IO thread for
 parsing
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

On Wed, Dec 13, 2017 at 04:35:00PM +0000, Stefan Hajnoczi wrote:
> On Tue, Dec 05, 2017 at 01:51:44PM +0800, Peter Xu wrote:
> > @@ -583,6 +585,7 @@ static void monitor_data_init(Monitor *mon, bool skip_flush)
> >      /* Use *mon_cmds by default. */
> >      mon->cmd_table = mon_cmds;
> >      mon->skip_flush = skip_flush;
> > +    mon->use_io_thr = use_io_thr;
> 
> Why is mon->use_io_thr is a field instead of a monitor_init() argument.

It's used in other part of code when we want to know whether IOThread
is enabled for a monitor.

> 
> > @@ -4117,19 +4121,37 @@ void monitor_init(Chardev *chr, int flags)
> >          monitor_read_command(mon, 0);
> >      }
> >  
> > +    if (mon->use_io_thr) {
> > +        /*
> > +         * When use_io_thr is set, we use the global shared dedicated
> > +         * IO thread for this monitor to handle input/output.
> > +         */
> > +        context = monitor_io_context_get();
> > +        /* We should have inited globals before reaching here. */
> > +        assert(context);
> > +    } else {
> > +        /* The default main loop, which is the main thread */
> > +        context = NULL;
> > +    }
> > +
> > +    /*
> > +     * Add the monitor before running it (which is triggered by
> > +     * qemu_chr_fe_set_handlers), otherwise one monitor may find
> > +     * itself not on the mon_list when running.
> > +     */
> > +    qemu_mutex_lock(&monitor_lock);
> > +    QTAILQ_INSERT_HEAD(&mon_list, mon, entry);
> > +    qemu_mutex_unlock(&monitor_lock);
> > +
> >      if (monitor_is_qmp(mon)) {
> >          qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qmp_read,
> > -                                 monitor_qmp_event, NULL, mon, NULL, true);
> > +                                 monitor_qmp_event, NULL, mon, context, true);
> >          qemu_chr_fe_set_echo(&mon->chr, true);
> >          json_message_parser_init(&mon->qmp.parser, handle_qmp_command, mon);
> 
> The comment above mentions the race condition between
> qemu_chr_fe_set_handlers() and mon_list.  I think that means the order
> must be:
> 
>   json_message_parser_init(&mon->qmp.parser, handle_qmp_command, mon);
>   qemu_chr_fe_set_echo(&mon->chr, true);
>   qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_qmp_read,
>                            monitor_qmp_event, NULL, mon, context, true);

Yeh this looks safer!

> 
> >      } else {
> 
> assert(!context);  /* HMP does not support IOThreads */

I can add this.  Thanks,

> 
> >          qemu_chr_fe_set_handlers(&mon->chr, monitor_can_read, monitor_read,
> >                                   monitor_event, NULL, mon, NULL, true);
> >      }
> > -
> > -    qemu_mutex_lock(&monitor_lock);
> > -    QLIST_INSERT_HEAD(&mon_list, mon, entry);
> > -    qemu_mutex_unlock(&monitor_lock);
> >  }
> >  
> >  void monitor_cleanup(void)
> > -- 
> > 2.14.3
> > 



-- 
Peter Xu
