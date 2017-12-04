Received: from eggs.gnu.org ([2001:4830:134:3::10]:59045)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eLi9J-0001NF-BV
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 23:14:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eLi9G-0006dx-5v
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 23:14:33 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eLi9F-0006df-W9
	for qemu-devel@nongnu.org; Sun, 03 Dec 2017 23:14:30 -0500
Date: Mon, 4 Dec 2017 12:14:22 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20171204041422.GC7916@xz-mi>
References: <20171108060130.3772-1-peterx@redhat.com>
	<20171108060130.3772-31-peterx@redhat.com>
	<20171201123431.GB3101@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171201123431.GB3101@work-vm>
Subject: Re: [Qemu-devel] [PATCH v4 30/32] migration: delay the
 postcopy-active state switch
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

On Fri, Dec 01, 2017 at 12:34:32PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Switch the state until we try to start the VM on destination side.  The
> > problem is that without doing this we may have a very small window that
> > we'll be in such a state:
> > 
> > - dst VM is in postcopy-active state,
> > - main thread is handling MIG_CMD_PACKAGED message, which loads all the
> >   device states,
> > - ram load thread is reading memory data from source.
> > 
> > Then if we failed at this point when reading the migration stream we'll
> > also switch to postcopy-paused state, but that is not what we want.  If
> > device states failed to load, we should fail the migration directly
> > instead of pause.
> > 
> > Postponing the state switch to the point when we have already loaded the
> > devices' states and been ready to start running destination VM.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> If it's the only way, then this is OK; but I'd prefer you use a separate
> flag somewhere to let you know this, because this means that
> POSTCOPY_ACTIVE on the destination happens at a different point that it
> does on the source (and changing it on the source I think will break
> lots of things).

Yes, I thought it was fine to postpone it a bit to the point even
after receiving the packed data, but I fully understand your point.

> Can't you use the PostcopyState value and check if it's in
> POSTCOPY_INCOMING_RUNNING?

I think, yes. :)

Let me drop this patch, instead I'll check explicitly on
POSTCOPY_INCOMING_RUNNING state in patch 6.  Thanks,

-- 
Peter Xu
