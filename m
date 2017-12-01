Received: from eggs.gnu.org ([2001:4830:134:3::10]:42284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKnlr-00067E-2h
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:03:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eKnlH-0003Ct-TL
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:02:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51624)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eKnlH-0003Bb-Mj
	for qemu-devel@nongnu.org; Fri, 01 Dec 2017 11:01:59 -0500
Date: Fri, 1 Dec 2017 16:56:35 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171201085635.GD2712@xz-mi>
References: <20171108060130.3772-1-peterx@redhat.com>
	<20171108060130.3772-6-peterx@redhat.com>
	<20171130104945.GB2248@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171130104945.GB2248@work-vm>
Subject: Re: [Qemu-devel] [PATCH v4 05/32] migration: implement
 "postcopy-pause" src logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Alexey Perevalov <a.perevalov@samsung.com>, "Daniel P . Berrange" <berrange@redhat.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Thu, Nov 30, 2017 at 10:49:45AM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Now when network down for postcopy, the source side will not fail the
> > migration. Instead we convert the status into this new paused state, and
> > we will try to wait for a rescue in the future.
> > 
> > If a recovery is detected, migration_thread() will reset its local
> > variables to prepare for that.
> > 
> > Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> 
> That's still OK; you might want to consider reusing the 'pause_sem' that I
> added to MigrationStatus for the other pause case.

Yes I can.  I am just a bit worried about how these two different
features cross-affect each other.  Say, what if something tries to
execute "migrate-continue" during a postcopy network failure?  IMHO it
should not be allowed, but we don't yet have a protection so far.

So I would prefer to still separate these two semaphores.

Though I found that I can move init/destroy of the two new semaphores
(postcopy_pause_sem, postcopy_pause_rp_sem) into object init/destroy
just like what we did for pause_sem, which seems to be cleaner.  I
hope I can still keep your r-b if I do that small change.  Thanks,

-- 
Peter Xu
