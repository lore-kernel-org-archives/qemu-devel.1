Received: from eggs.gnu.org ([2001:4830:134:3::10]:46833)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etVwx-00089l-MM
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:05:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etVwu-0002bU-25
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:05:31 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43950 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1etVwt-0002bD-Ne
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 05:05:27 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 29D49818AB08
	for <qemu-devel@nongnu.org>; Wed,  7 Mar 2018 10:05:27 +0000 (UTC)
Date: Wed, 7 Mar 2018 18:05:21 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180307100521.GO17720@xz-mi>
References: <20180216131625.9639-1-dgilbert@redhat.com>
	<20180216131625.9639-12-dgilbert@redhat.com>
	<20180228084234.GA27381@xz-mi> <20180305174241.GR3131@work-vm>
	<20180306070654.GF3615@xz-mi> <20180306112056.GG3096@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180306112056.GG3096@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, maxime.coquelin@redhat.com, marcandre.lureau@redhat.com, imammedo@redhat.com, mst@redhat.com, quintela@redhat.com, aarcange@redhat.com

On Tue, Mar 06, 2018 at 11:20:56AM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Mon, Mar 05, 2018 at 05:42:42PM +0000, Dr. David Alan Gilbert wrote:
> > > * Peter Xu (peterx@redhat.com) wrote:
> > > > On Fri, Feb 16, 2018 at 01:16:07PM +0000, Dr. David Alan Gilbert (git) wrote:
> > > > 
> > > > [...]
> > > > 
> > > > >  typedef struct VuVirtqElement {
> > > > > diff --git a/docs/interop/vhost-user.txt b/docs/interop/vhost-user.txt
> > > > > index 621543e654..bdec9ec0e8 100644
> > > > > --- a/docs/interop/vhost-user.txt
> > > > > +++ b/docs/interop/vhost-user.txt
> > > > > @@ -682,6 +682,12 @@ Master message types
> > > > >        the slave must open a userfaultfd for later use.
> > > > >        Note that at this stage the migration is still in precopy mode.
> > > > >  
> > > > > + * VHOST_USER_POSTCOPY_LISTEN
> > > > > +      Id: 27
> > > > > +      Master payload: N/A
> > > > > +
> > > > > +      Master advises slave that a transition to postcopy mode has happened.
> > > > 
> > > > Could we add something to explain why this listen needs to be
> > > > broadcasted to clients?  Since I failed to find it out quickly
> > > > myself. :(
> > > 
> > > I've changed this to:
> > > 
> > >  * VHOST_USER_POSTCOPY_LISTEN
> > >       Id: 29
> > >       Master payload: N/A
> > > 
> > >       Master advises slave that a transition to postcopy mode has happened.
> > >       The slave must ensure that shared memory is registered with userfaultfd
> > >       to cause faulting of non-present pages.
> > 
> > But shouldn't this be assured by the SET_MEM_TABLE call?
> 
> Yes, it is the set_mem_table that does the register - but it only
> registers it with userfaultfd if it's received a 'listen' notification,
> otherwise it assumes it's a normal precopy migration.

I think I got the picture now.  Please add this after the enhanced
document:

Reviewed-by: Peter Xu <peterx@redhat.com>

Thanks,

-- 
Peter Xu
