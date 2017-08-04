Received: from eggs.gnu.org ([2001:4830:134:3::10]:42869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ddVtE-0001ND-P5
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:15:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1ddVtA-0001lu-Ca
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:15:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45997)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1ddVtA-0001kU-7E
	for qemu-devel@nongnu.org; Fri, 04 Aug 2017 02:15:12 -0400
Date: Fri, 4 Aug 2017 14:15:04 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170804061504.GG5561@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<1501229198-30588-22-git-send-email-peterx@redhat.com>
	<20170803094901.GC2076@work-vm>
	<20170804060833.GF5561@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170804060833.GF5561@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [RFC 21/29] migration: new cmd MIG_CMD_RECV_BITMAP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>

On Fri, Aug 04, 2017 at 02:08:33PM +0800, Peter Xu wrote:
> On Thu, Aug 03, 2017 at 10:49:02AM +0100, Dr. David Alan Gilbert wrote:
> > * Peter Xu (peterx@redhat.com) wrote:
> > > Add a new vm command MIG_CMD_RECV_BITMAP to request received bitmap for
> > > one ramblock.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  migration/savevm.c     | 59 ++++++++++++++++++++++++++++++++++++++++++++++++++
> > >  migration/savevm.h     |  1 +
> > >  migration/trace-events |  1 +
> > >  3 files changed, 61 insertions(+)
> > > 
> > > diff --git a/migration/savevm.c b/migration/savevm.c
> > > index 386788d..0ab13c0 100644
> > > --- a/migration/savevm.c
> > > +++ b/migration/savevm.c
> > > @@ -78,6 +78,7 @@ enum qemu_vm_cmd {
> > >                                        were previously sent during
> > >                                        precopy but are dirty. */
> > >      MIG_CMD_PACKAGED,          /* Send a wrapped stream within this stream */
> > > +    MIG_CMD_RECV_BITMAP,       /* Request for recved bitmap on dst */
> > >      MIG_CMD_MAX
> > >  };
> > >  
> > > @@ -95,6 +96,7 @@ static struct mig_cmd_args {
> > >      [MIG_CMD_POSTCOPY_RAM_DISCARD] = {
> > >                                     .len = -1, .name = "POSTCOPY_RAM_DISCARD" },
> > >      [MIG_CMD_PACKAGED]         = { .len =  4, .name = "PACKAGED" },
> > > +    [MIG_CMD_RECV_BITMAP]      = { .len = -1, .name = "RECV_BITMAP" },
> > >      [MIG_CMD_MAX]              = { .len = -1, .name = "MAX" },
> > >  };
> > >  
> > > @@ -929,6 +931,19 @@ void qemu_savevm_send_postcopy_run(QEMUFile *f)
> > >      qemu_savevm_command_send(f, MIG_CMD_POSTCOPY_RUN, 0, NULL);
> > >  }
> > >  
> > > +void qemu_savevm_send_recv_bitmap(QEMUFile *f, char *block_name)
> > > +{
> > > +    size_t len;
> > > +    char buf[512];
> > 
> > Only needs to be 256 bytes?
> 
> Yes, it is.
> 
> Even, I guess I should use dynamic allocation, since 256 has the
> assumption of block_name size.

Oh wait - we will put the length into first byte, which cannot be
bigger than 255... I'll use 256 directly, then I guess I can keep the
r-b.   Thanks,

-- 
Peter Xu
