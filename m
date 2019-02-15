Received: from eggs.gnu.org ([209.51.188.92]:40506)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gubFS-0007ED-Ue
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:01:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1gubEs-0003hg-8P
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:01:05 -0500
Received: from mx1.redhat.com ([209.132.183.28]:35024)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1gubEs-0003ex-2E
	for qemu-devel@nongnu.org; Fri, 15 Feb 2019 06:01:02 -0500
Date: Fri, 15 Feb 2019 11:00:56 +0000
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20190215110056.GB2630@work-vm>
References: <20190214185351.5927-1-dgilbert@redhat.com>
	<20190215015549.GA3232@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190215015549.GA3232@xz-x1>
Subject: Re: [Qemu-devel] [PATCH] migration/rdma: Fix qemu_rdma_cleanup null
 check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, quintela@redhat.com, peter.maydell@linaro.org

* Peter Xu (peterx@redhat.com) wrote:
> On Thu, Feb 14, 2019 at 06:53:51PM +0000, Dr. David Alan Gilbert (git) wrote:
> > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > 
> > If the migration fails before the channel is open (e.g. a bad
> > address) we end up in the cleanup with rdma->channel==NULL.
> > 
> > Spotted by Coverity: CID 1398634
> > Fixes: fbbaacab2758cb3f32a0
> > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > ---
> >  migration/rdma.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/migration/rdma.c b/migration/rdma.c
> > index 54a3c11540..9fa3b176eb 100644
> > --- a/migration/rdma.c
> > +++ b/migration/rdma.c
> > @@ -2321,7 +2321,9 @@ static void qemu_rdma_cleanup(RDMAContext *rdma)
> >          rdma->connected = false;
> >      }
> >  
> > -    qemu_set_fd_handler(rdma->channel->fd, NULL, NULL, NULL);
> > +    if (rdma->channel) {
> > +        qemu_set_fd_handler(rdma->channel->fd, NULL, NULL, NULL);
> > +    }
> 
> IIUC there's no strict ordering constraint on resetting the fd
> handler, then how about simply moving this line into the below "if
> (rdma->channel)" altogether?

The logic around the closing of the return path makes that check later a
bit messy; rdma->channel can get set to Null before the other check.

Dave

> Regards,
> 
> -- 
> Peter Xu
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
