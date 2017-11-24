Received: from eggs.gnu.org ([2001:4830:134:3::10]:41230)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eIDpA-0003ek-Mq
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:15:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1eIDp6-0002lt-KN
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:15:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1eIDp6-0002kr-D9
	for qemu-devel@nongnu.org; Fri, 24 Nov 2017 08:15:16 -0500
Date: Fri, 24 Nov 2017 13:14:53 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20171124131452.GD2302@work-vm>
References: <20171116130610.23582-1-peterx@redhat.com>
	<20171116130610.23582-22-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20171116130610.23582-22-peterx@redhat.com>
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
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Stefan Hajnoczi <shajnocz@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, mdroth@linux.vnet.ibm.com, Eric Blake <eblake@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Markus Armbruster <armbru@redhat.com>, marcandre.lureau@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> So it can get rid of being run on main thread.
> 
> Signed-off-by: Peter Xu <peterx@redhat.com>

Last time I asked if you were sure that we didn't do locking,
and you explained that we end up just setting up a callback
that happens in the mainloop, and this shouldn't take a lock.
I confirmed this by:

  running with -incoming defer
  breakpointing in hmp_migrate_incoming
  doing   migrate_incoming tcp:0:4444
  once I hit that breakpointing adding two more breakpoints:
     a) qemu_mutex_lock_iothread
     b) the end of hmp's handle_hmp_command

  and indeed it hit the end of handle_hmp_command without
having hit the qemu_mutex_lock_iothread; so initially that
looks ok.

But then I added a break on pthread_mutex_lock, and I've got
this set caused by qemu_start_incoming_migration sending a
MIGRATION_STATUS_SETUP event:

#1  0x0000555555ba6eba in qemu_mutex_lock (mutex=mutex@entry=0x5555563f9ba0 <monitor_lock>)
    at /home/dgilbert/git/qemu/util/qemu-thread-posix.c:65
#2  0x00005555557f01c1 in monitor_qapi_event_queue (event=QAPI_EVENT_MIGRATION, qdict=0x555557d93c00, errp=<optimized out>) at /home/dgilbert/git/qemu/monitor.c:442

440	    trace_monitor_protocol_event_queue(event, qdict, evconf->rate);
441	
442	    qemu_mutex_lock(&monitor_lock);
443	

#3  0x0000555555b92722 in qapi_event_send_migration (status=status@entry=MIGRATION_STATUS_SETUP, errp=0x555556859320 <error_abort>) at qapi-event.c:661
#4  0x0000555555a6159f in qemu_start_incoming_migration (uri=0x555557693f30 "tcp:0:4444", errp=0x7fffffffc700)
    at /home/dgilbert/git/qemu/migration/migration.c:253
#5  0x0000555555a641c5 in qmp_migrate_incoming (uri=0x555557693f30 "tcp:0:4444", errp=0x7fffffffc730)
    at /home/dgilbert/git/qemu/migration/migration.c:1321

is there anything which protects us there?

Dave
    
> ---
>  qapi/migration.json | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/qapi/migration.json b/qapi/migration.json
> index bbc4671ded..95098072dd 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1063,7 +1063,8 @@
>  # <- { "return": {} }
>  #
>  ##
> -{ 'command': 'migrate-incoming', 'data': {'uri': 'str' } }
> +{ 'command': 'migrate-incoming', 'data': {'uri': 'str' },
> +  'allow-oob': true }
>  
>  ##
>  # @xen-save-devices-state:
> -- 
> 2.13.6
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
