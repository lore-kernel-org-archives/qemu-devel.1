Received: from eggs.gnu.org ([2001:4830:134:3::10]:49461)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1deh6L-0000BH-R4
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:25:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1deh6G-0005Ax-Pb
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:25:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36806)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1deh6G-0005AV-Gn
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 08:25:36 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 50BD413A45
	for <qemu-devel@nongnu.org>; Mon,  7 Aug 2017 12:25:35 +0000 (UTC)
Date: Mon, 7 Aug 2017 13:25:29 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170807122529.GA2504@work-vm>
References: <20170804175011.21944-1-dgilbert@redhat.com>
	<20170807072101.GX5561@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170807072101.GX5561@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH f0r 2.11] runstate/migrate: Two more
 transitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, lvivier@redhat.com, pbonzini@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> On Fri, Aug 04, 2017 at 06:50:11PM +0100, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > There's a race if someone does a 'stop' near the end of migrate;
> > the migration process goes through two runstates:
> >     'finish migrate'
> >     'postmigrate'
> > 
> > If the user issues a 'stop' between the two we end up with invalid
> > state transitions.
> > Add the transitions as valid.
> > 
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  vl.c | 2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > diff --git a/vl.c b/vl.c
> > index 99fcfa0442..bacb03f49d 100644
> > --- a/vl.c
> > +++ b/vl.c
> > @@ -621,6 +621,7 @@ static const RunStateTransition runstate_transitions_def[] = {
> >  
> >      { RUN_STATE_PAUSED, RUN_STATE_RUNNING },
> >      { RUN_STATE_PAUSED, RUN_STATE_FINISH_MIGRATE },
> > +    { RUN_STATE_PAUSED, RUN_STATE_POSTMIGRATE },
> >      { RUN_STATE_PAUSED, RUN_STATE_PRELAUNCH },
> >      { RUN_STATE_PAUSED, RUN_STATE_COLO},
> >  
> > @@ -633,6 +634,7 @@ static const RunStateTransition runstate_transitions_def[] = {
> >      { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
> >  
> >      { RUN_STATE_FINISH_MIGRATE, RUN_STATE_RUNNING },
> > +    { RUN_STATE_FINISH_MIGRATE, RUN_STATE_PAUSED },
> >      { RUN_STATE_FINISH_MIGRATE, RUN_STATE_POSTMIGRATE },
> >      { RUN_STATE_FINISH_MIGRATE, RUN_STATE_PRELAUNCH },
> >      { RUN_STATE_FINISH_MIGRATE, RUN_STATE_COLO},
> 
> Do we need this as well?
> 
>     { RUN_STATE_POSTMIGRATE, RUN_STATE_PAUSED },

Apparently not:

(qemu) migrate "exec:cat > /dev/null"
(qemu) infomigrate
unknown command: 'infomigrate'
(qemu) info status
VM status: paused (postmigrate)
(qemu) stop
(qemu) info status
VM status: paused (postmigrate)
(qemu)


so doing a stop at that point doesn't seem to cause any problem.

Dave

> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
