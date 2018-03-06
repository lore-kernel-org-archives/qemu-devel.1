Received: from eggs.gnu.org ([2001:4830:134:3::10]:50238)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1etAeg-0003K9-R3
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:21:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1etAed-0002Hr-J7
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:21:14 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44318 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1etAed-0002Hl-E2
	for qemu-devel@nongnu.org; Tue, 06 Mar 2018 06:21:11 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
	[10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 18273D1426
	for <qemu-devel@nongnu.org>; Tue,  6 Mar 2018 11:21:11 +0000 (UTC)
Date: Tue, 6 Mar 2018 11:20:56 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180306112056.GG3096@work-vm>
References: <20180216131625.9639-1-dgilbert@redhat.com>
	<20180216131625.9639-12-dgilbert@redhat.com>
	<20180228084234.GA27381@xz-mi> <20180305174241.GR3131@work-vm>
	<20180306070654.GF3615@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180306070654.GF3615@xz-mi>
Subject: Re: [Qemu-devel] [PATCH v3 11/29] vhost+postcopy: Transmit 'listen'
 to client
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, imammedo@redhat.com, mst@redhat.com, quintela@redhat.com, aarcange@redhat.com

* Peter Xu (peterx@redhat.com) wrote:
> On Mon, Mar 05, 2018 at 05:42:42PM +0000, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > On Fri, Feb 16, 2018 at 01:16:07PM +0000, Dr. David Alan Gilbert (git) wrote:
> > > 
> > > [...]
> > > 
> > > >  typedef struct VuVirtqElement {
> > > > diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> > > > index 621543e654..bdec9ec0e8 100644
> > > > --- a/docs/interop/vhost-user.txt
> > > > +++ b/docs/interop/vhost-user.txt
> > > > @@ -682,6 +682,12 @@ Master message types
> > > >        the slave must open a userfaultfd for later use.
> > > >        Note that at this stage the migration is still in precopy mode.
> > > >  
> > > > + * VHOST_USER_POSTCOPY_LISTEN
> > > > +      Id: 27
> > > > +      Master payload: N/A
> > > > +
> > > > +      Master advises slave that a transition to postcopy mode has happened.
> > > 
> > > Could we add something to explain why this listen needs to be
> > > broadcasted to clients?  Since I failed to find it out quickly
> > > myself. :(
> > 
> > I've changed this to:
> > 
> >  * VHOST_USER_POSTCOPY_LISTEN
> >       Id: 29
> >       Master payload: N/A
> > 
> >       Master advises slave that a transition to postcopy mode has happened.
> >       The slave must ensure that shared memory is registered with userfaultfd
> >       to cause faulting of non-present pages.
> 
> But shouldn't this be assured by the SET_MEM_TABLE call?

Yes, it is the set_mem_table that does the register - but it only
registers it with userfaultfd if it's received a 'listen' notification,
otherwise it assumes it's a normal precopy migration.

> Sorry for being not that familiar with vhost-user protocol... but
> what's the correct order of these commands?
> 
>   POSTCOPY_ADVISE
>   POSTCOPY_LISTEN
>   SET_MEM_TABLE

Right.

Dave

> ?  Thanks,
> 
> > 
> >       This is always sent sometime after a VHOST_USER_POSTCOPY_ADVISE, and
> >       thus only when VHOST_USER_PROTOCOL_F_PAGEFAULT is supported.
> > 
> > Dave
> > 
> > > -- 
> > > Peter Xu
> > --
> > Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
