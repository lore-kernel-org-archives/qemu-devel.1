Received: from eggs.gnu.org ([2001:4830:134:3::10]:42350)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPmLL-0002cb-3P
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:36:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gPmLH-0002j1-1r
	for qemu-devel@nongnu.org; Thu, 22 Nov 2018 05:36:19 -0500
Date: Thu, 22 Nov 2018 11:30:29 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20181122103029.GA31879@linux.fritz.box>
References: <20181121124747.30696-1-rjones@redhat.com>
	<3a13e435-2051-a27c-a660-4e63dbc66234@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3a13e435-2051-a27c-a660-4e63dbc66234@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] scsi-disk: Fix crash if underlying host
 file or disk returns error.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Richard W.M. Jones" <rjones@redhat.com>, famz@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org

Am 21.11.2018 um 19:31 hat Paolo Bonzini geschrieben:
> On 21/11/18 13:47, Richard W.M. Jones wrote:
> > Commit 40dce4ee6 "scsi-disk: fix rerror/werror=ignore" introduced a
> > bug which causes qemu to crash with the assertion error below if the
> > host file or disk returns an error:
> > 
> >   qemu-system-x86_64: hw/scsi/scsi-bus.c:1374: scsi_req_complete:
> >   Assertion `req->status == -1' failed.
> > 
> > Kevin Wolf suggested this fix:
> > 
> >   < kwolf> Hm, should the final return false; in that patch
> >            actually be a return true?
> >   < kwolf> Because I think he didn't intend to change anything
> >            except BLOCK_ERROR_ACTION_IGNORE
> > 
> > Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> > Buglink: https://bugs.launchpad.net/qemu/+bug/1804323
> > ---
> >  hw/scsi/scsi-disk.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/hw/scsi/scsi-disk.c b/hw/scsi/scsi-disk.c
> > index 6eb258d3f3..0e9027c8f3 100644
> > --- a/hw/scsi/scsi-disk.c
> > +++ b/hw/scsi/scsi-disk.c
> > @@ -482,7 +482,7 @@ static bool scsi_handle_rw_error(SCSIDiskReq *r, int error, bool acct_failed)
> >      if (action == BLOCK_ERROR_ACTION_STOP) {
> >          scsi_req_retry(&r->req);
> >      }
> > -    return false;
> > +    return true;
> >  }
> >  
> >  static void scsi_write_complete_noio(SCSIDiskReq *r, int ret)
> > 
> 
> Looks good.  I was confused because now the function always returns
> true.  "If an arm was returning true, the other must be returning false...".

Yes. And we should probably simplify the function by removing the return
value, but the minimal fix is better for 3.1.

Kevin
