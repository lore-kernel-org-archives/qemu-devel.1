Received: from eggs.gnu.org ([2001:4830:134:3::10]:37156)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eJH4N-0003Au-G0
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 05:55:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eJH4J-0004nX-EK
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 05:55:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44064)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eJH4J-0004mN-5n
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 05:55:19 -0500
Date: Mon, 27 Nov 2017 18:54:50 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171127105450.GA2678@xz-mi>
References: <20171116130610.23582-1-peterx@redhat.com>
	<20171116130610.23582-22-peterx@redhat.com>
	<20171124131452.GD2302@work-vm> <20171127052003.GB5153@xz-mi>
	<20171127104426.GB2338@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171127104426.GB2338@work-vm>
Subject: Re: [Qemu-devel] [RFC v4 21/27] qmp: let migrate-incoming allow
 out-of-band
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com

On Mon, Nov 27, 2017 at 10:44:26AM +0000, Dr. David Alan Gilbert wrote:

[...]

> > > 
> > > But then I added a break on pthread_mutex_lock, and I've got
> > > this set caused by qemu_start_incoming_migration sending a
> > > MIGRATION_STATUS_SETUP event:
> > > 
> > > #1  0x0000555555ba6eba in qemu_mutex_lock (mutex=mutex@entry=0x5555563f9ba0 <monitor_lock>)
> > >     at /home/dgilbert/git/qemu/util/qemu-thread-posix.c:65
> > > #2  0x00005555557f01c1 in monitor_qapi_event_queue (event=QAPI_EVENT_MIGRATION, qdict=0x555557d93c00, errp=<optimized out>) at /home/dgilbert/git/qemu/monitor.c:442
> > > 
> > > 440	    trace_monitor_protocol_event_queue(event, qdict, evconf->rate);
> > > 441	
> > > 442	    qemu_mutex_lock(&monitor_lock);
> > > 443	
> > > 
> > > #3  0x0000555555b92722 in qapi_event_send_migration (status=status@entry=MIGRATION_STATUS_SETUP, errp=0x555556859320 <error_abort>) at qapi-event.c:661
> > > #4  0x0000555555a6159f in qemu_start_incoming_migration (uri=0x555557693f30 "tcp:0:4444", errp=0x7fffffffc700)
> > >     at /home/dgilbert/git/qemu/migration/migration.c:253
> > > #5  0x0000555555a641c5 in qmp_migrate_incoming (uri=0x555557693f30 "tcp:0:4444", errp=0x7fffffffc730)
> > >     at /home/dgilbert/git/qemu/migration/migration.c:1321
> > > 
> > > is there anything which protects us there?
> > 
> > IIUC you mean what if we e.g. page fault during taking the
> > monitor_lock?  IMHO it just can't happen - monitor_lock is really used
> > in limited places and during those critical sections there is no guest
> > memory access at all (which only protects the monitor logic itself
> > AFAICT).
> 
> OK, so we should document somewhere which locks it's OK to take in an
> OOB command, and then make sure that for each of those locks we add
> a note saying that anyone taking them must be careful.
> We should also add a note above teh qmp_migrate_incoming that it's an
> OOB command and to take care.

Makes sense.  I think it will be hard to document what locks can be
taken during OOB command handing since there can be too many locks
there...  But at least I can add a comment to qmp_migrate_incoming()
along with current patch to note that this function should be OOB
friendly from now on.

> 
> However, since you've convinced me it's OK:
> 
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks!

-- 
Peter Xu
