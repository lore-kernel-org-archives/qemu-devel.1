Received: from eggs.gnu.org ([2001:4830:134:3::10]:43336)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eeGQ8-000208-1v
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 03:28:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eeGQ4-00033B-2v
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 03:28:36 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35608)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eeGQ3-00030l-Sq
	for qemu-devel@nongnu.org; Wed, 24 Jan 2018 03:28:32 -0500
Date: Wed, 24 Jan 2018 16:28:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180124082817.GF8001@xz-mi>
References: <20171205065307.21853-1-peterx@redhat.com>
	<20171205065307.21853-27-peterx@redhat.com>
	<20171219105859.GC2730@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171219105859.GC2730@work-vm>
Subject: Re: [Qemu-devel] [PATCH v5 26/28] migration: allow migrate_cancel
 to pause postcopy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Andrea Arcangeli <aarcange@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>

On Tue, Dec 19, 2017 at 10:58:59AM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > It was allowed in the past to even cancel a postcopy migration, but it
> > does not really make sense, and no one should be using it, since
> > cancelling a migration during postcopy means crashing the VM at no time.
> > 
> > Let's just use re-use this command as a way to pause the postcopy
> > migration when we detected that we are in postcopy migration.  This can
> > be used when we want to trigger the postcopy recovery manually.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Yes, OK, this is a little odd without having any flags or anything, but
> it's essentially the saem reason that cancel exists - to stop a
> migration we know that's broken for some reason.
> 
> (I could argue whether this should be special cased in migrate_fd_cancel
> instead, but that's just a preference).
> 
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Firstly, thanks for the r-b.

Now after knowing your iptable test, I think we reached a consensus
that we need to provide a command (for example, reuse migrate-cancel)
to allow destination to shutdown its incoming migration port too.  At
the same time, if we want to make sure the command can always work on
destination, we'd better also let that command to be OOB-capable.

However I'm not sure whether I can let migrate-cancel be OOB-capable
since recently we added bdrv_invalidate_cache_all() into
migrate_fd_cancel().  That invalidation needs some mutex which might
block.  I don't know whether it means migrate-cancel will no longer be
suitable as an OOB command now.

So, maybe now I can do this: firstly, drop this patch; then add a new
command to do the shutdown explicitly (allow either src/dst to
shutdown its migration fd) and keep migrate-cancel untouched. In that
case, I can make sure the new command will be OOB-compatible.

What do you think?

-- 
Peter Xu
