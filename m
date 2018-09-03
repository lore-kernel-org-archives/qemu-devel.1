Received: from eggs.gnu.org ([2001:4830:134:3::10]:59631)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fwnns-0006tw-S6
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:18:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fwnno-0004Ad-UK
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:18:00 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56010 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fwnno-0004AM-Pu
	for qemu-devel@nongnu.org; Mon, 03 Sep 2018 08:17:56 -0400
Date: Mon, 3 Sep 2018 13:17:53 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180903121752.GC2414@work-vm>
References: <20180830173657.22939-1-dgilbert@redhat.com>
	<90c91534-ea52-42a8-0a01-5c8e5898b6d0@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90c91534-ea52-42a8-0a01-5c8e5898b6d0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] migration/rdma: Fix uninitialised
 rdma_return_path
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, cohuck@redhat.com, jemmy858585@gmail.com

* Thomas Huth (thuth@redhat.com) wrote:
> On 2018-08-30 19:36, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > Clang correctly errors out moaning that rdma_return_path
> > is used uninitialised in the earlier error paths.
> > Make it NULL so that the error path ignores it.
> > 
> > Fixes: 55cc1b5937a8e709e4c102e74b206281073aab82
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Reprorted by: Cornelia Huck <cohuck@redhat.com>
> > ---
> >  migration/rdma.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/migration/rdma.c b/migration/rdma.c
> > index ae07515e83..9b2e7e10aa 100644
> > --- a/migration/rdma.c
> > +++ b/migration/rdma.c
> > @@ -4012,7 +4012,7 @@ static void rdma_accept_incoming_migration(void *opaque)
> >  void rdma_start_incoming_migration(const char *host_port, Error **errp)
> >  {
> >      int ret;
> > -    RDMAContext *rdma, *rdma_return_path;
> > +    RDMAContext *rdma, *rdma_return_path = NULL;
> >      Error *local_err = NULL;
> >  
> >      trace_rdma_start_incoming_migration();
> 
> This will silence the error from clang for sure, so:
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> 
> But actually, the g_free(rdma_return_path); at the end of the function
> is dead code, since it will always be called with rdma_return_path ==
> NULL. Maybe we should rather remove that g_free() instead?

It's nice keeping the rdma/rdma_return_path semetric there so that if
we add other code into it the err path still cleans up.

Dave

>  Thomas
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
