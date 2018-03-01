Received: from eggs.gnu.org ([2001:4830:134:3::10]:41328)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erELT-0005m2-Hg
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 21:53:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1erELO-00079K-Ld
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 21:53:23 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52110 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1erELO-00078d-HQ
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 21:53:18 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 181B840FB646
	for <qemu-devel@nongnu.org>; Thu,  1 Mar 2018 02:53:18 +0000 (UTC)
Date: Thu, 1 Mar 2018 10:53:12 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180301025312.GN27381@xz-mi>
References: <20180228050633.7410-1-peterx@redhat.com>
	<20180228050633.7410-5-peterx@redhat.com>
	<20180228174349.GJ2981@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180228174349.GJ2981@work-vm>
Subject: Re: [Qemu-devel] [PATCH 04/14] migration: let incoming side use
 thread context
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Laurent Vivier <lvivier@redhat.com>

On Wed, Feb 28, 2018 at 05:43:50PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > The old incoming migration is running in main thread and default
> > gcontext.  With the new qio_channel_add_watch_full() we can now let it
> > run in the thread's own gcontext (if there is one).
> > 
> > Currently this patch does nothing alone.  But when any of the incoming
> > migration is run in another iothread (e.g., the upcoming migrate-recover
> > command), this patch will bind the incoming logic to the iothread
> > instead of the main thread (which may already get page faulted and
> > hanged).
> 
> Does this make any difference to the Postcopy listener thread, which
> takes over reading from the main thread once in postcopy mode?
> (See savevm.c:postcopy_ram_listen_thread).

It should not.  It should only affect when use sends a
"migrate-recover" with "run-oob=true".  The rest should be the same as
before.  And since the postcopy ram load thread is a standalone thread
with its own initial thread stack (so it's not really in a gmainloop),
I can hardly tell how that can be affected since it'll always use its
own thread stack.

Or, have I missed anything?

-- 
Peter Xu
