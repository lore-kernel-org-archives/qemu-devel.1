Received: from eggs.gnu.org ([2001:4830:134:3::10]:47260)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fb0c5-0005EQ-Kv
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:31:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fb0c2-00088P-Ef
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:31:45 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56704 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fb0c2-00087Q-7j
	for qemu-devel@nongnu.org; Thu, 05 Jul 2018 05:31:42 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id BDD7ADFF8
	for <qemu-devel@nongnu.org>; Thu,  5 Jul 2018 09:31:41 +0000 (UTC)
Date: Thu, 5 Jul 2018 17:31:36 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180705093136.GF1389@xz-mi>
References: <20180705031755.3254-1-peterx@redhat.com>
	<20180705031755.3254-3-peterx@redhat.com>
	<20180705091546.GC2538@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180705091546.GC2538@work-vm>
Subject: Re: [Qemu-devel] [PATCH for-3.0 2/9] migration: loosen recovery
 check when load vm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Juan Quintela <quintela@redhat.com>

On Thu, Jul 05, 2018 at 10:15:47AM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > We were checking against -EIO, assuming that it will cover all IO
> > failures.  But actually it is not.  One example is that in
> > qemu_loadvm_section_start_full() we can have tons of places that will
> > return -EINVAL even if the error is caused by IO failures on the
> > network.
> 
> I suspect we should fix those; but OK; I think the only cases
> in there that could hit that are the get_counted_string and the
> check_section_footer; they could both be fixed to return an errno
> like the other cases.
> 
> > Let's loosen the recovery check logic here to cover all the error cases
> > happened by removing the explicit check against -EIO.  After all we
> > won't lose anything here if any other failure happened.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  migration/savevm.c | 16 ++++++----------
> >  1 file changed, 6 insertions(+), 10 deletions(-)
> > 
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 851d74e8b6..efcc795071 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -2276,18 +2276,14 @@ out:
> >          qemu_file_set_error(f, ret);
> >  
> >          /*
> > -         * Detect whether it is:
> > -         *
> > -         * 1. postcopy running (after receiving all device data, which
> > -         *    must be in POSTCOPY_INCOMING_RUNNING state.  Note that
> > -         *    POSTCOPY_INCOMING_LISTENING is still not enough, it's
> > -         *    still receiving device states).
> > -         * 2. network failure (-EIO)
> > -         *
> > -         * If so, we try to wait for a recovery.
> > +         * If we are during an active postcopy, then we pause instead
> > +         * of bail out to at least keep the VM's dirty data.  Note
> > +         * that POSTCOPY_INCOMING_LISTENING stage is still not enough,
> > +         * during which we're still receiving device states and we
> > +         * still haven't yet started the VM on destination.
> >           */
> >          if (postcopy_state_get() == POSTCOPY_INCOMING_RUNNING &&
> > -            ret == -EIO && postcopy_pause_incoming(mis)) {
> > +            postcopy_pause_incoming(mis)) {
> 
> Hmm, OK; It does make me a bit nervous we might trigger this
> too often, but I see the other cases where we're missing stuff
> we should trigger it.  We might find we need to go the other way
> and blacklist some errors.

AFAIU the difference will be only that we pause instead of quit QEMU.
IMHO the whitelist/blacklist will be more meaningful when there is a
third choice for us (besides "quit" and "go into pause state").

> 
> 
> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>

Thanks!

-- 
Peter Xu
