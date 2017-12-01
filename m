Received: from eggs.gnu.org ([2001:4830:134:3::10]:39032)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKo56-0007vH-4r
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:23:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKo4E-0005N8-3U
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:22:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54534)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eKo4D-0005LW-RB
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:21:33 -0500
Date: Fri, 1 Dec 2017 18:23:51 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171201102351.GG2712@xz-mi>
References: <20171108060130.3772-1-peterx@redhat.com>
	<20171130200053.GF2248@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171130200053.GF2248@work-vm>
Subject: Re: [Qemu-devel] [PATCH v4 00/32] Migration: postcopy failure
 recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P. Berrange" <berrange@redhat.com>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Thu, Nov 30, 2017 at 08:00:54PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Tree is pushed here for better reference and testing:
> >   github.com/xzpeter postcopy-recovery-support
> 
> Hi Peter,
>   Do you have a git with this code + your OOB world in?
> I'd like to play with doing recovery and see what happens;
> I still worry a bit about whether the (potentially hung) main loop
> is needed for the new incoming connection to be accepted by the
> destination.

Good question...

I'd say I thought it was okay.  The reason is that as long as we run
migrate-incoming command using run-oob=true, it'll be run in iothread,
and our iothread implementation has this in iothread_run():

    g_main_context_push_thread_default(iothread->worker_context);

This _should_ mean that from now on NULL context will be replaced with
iothread->worker_context (which is the monitor context, rather than
main thread any more) mostly (I say mostly because there are corner
cases that glib won't use this thread-local var but still the global
one, though it should not be our case I guess).

I tried to confirm this by breaking at the entry of function
socket_accept_incoming_migration() on destination side.  Sadly, I was
wrong.  It's still running in main().

I found that the problem is that g_source_attach() implementation is
still using the g_main_context_default() rather than
g_main_context_get_thread_default() for the cases where context=NULL
is passed in.  I don't know whether this is a glib bug:

g_source_attach (GSource      *source,
		 GMainContext *context)
{
  guint result = 0;
  ...
  if (!context)
    context = g_main_context_default ();
  ...
}

I'm CCing some more people who may know better on glib than me.

For now, I think a simple solution can be that, we just call
g_main_context_get_thread_default() explicitly for QIO code.  But also
I'd like to see how other people think too.

I'll prepare one branch soon, including the two series (postcopy
recovery + oob), after the solution is settled down.  Thanks,

-- 
Peter Xu
