Received: from eggs.gnu.org ([2001:4830:134:3::10]:43768)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cty0w-0005Wr-6e
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:58:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cty0t-0007tH-5m
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:58:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cty0s-0007sQ-TX
	for qemu-devel@nongnu.org; Fri, 31 Mar 2017 10:58:55 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A6A997AEA4
	for <qemu-devel@nongnu.org>; Fri, 31 Mar 2017 14:58:53 +0000 (UTC)
Date: Fri, 31 Mar 2017 15:58:45 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170331145844.GL4514@work-vm>
References: <20170323204544.12015-1-quintela@redhat.com>
	<20170323204544.12015-12-quintela@redhat.com>
	<20170327092350.GH11497@pxdev.xzpeter.org>
	<8737dxqm1y.fsf@secure.mitica>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8737dxqm1y.fsf@secure.mitica>
Subject: Re: [Qemu-devel] [PATCH 11/51] ram: Move dup_pages into RAMState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Juan Quintela <quintela@redhat.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org

* Juan Quintela (quintela@redhat.com) wrote:
> Peter Xu <peterx@redhat.com> wrote:
> > On Thu, Mar 23, 2017 at 09:45:04PM +0100, Juan Quintela wrote:
> >> Once there rename it to its actual meaning, zero_pages.
> >> 
> >> Signed-off-by: Juan Quintela <quintela@redhat.com>
> >> Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> >
> > Reviewed-by: Peter Xu <peterx@redhat.com>
> >
> > Will post a question below though (not directly related to this patch
> > but context-wide)...
> >>  {
> >>      int pages = -1;
> >>  
> >>      if (is_zero_range(p, TARGET_PAGE_SIZE)) {
> >> -        acct_info.dup_pages++;
> >> +        rs->zero_pages++;
> >>          *bytes_transferred += save_page_header(f, block,
> >>                                                 offset | RAM_SAVE_FLAG_COMPRESS);
> >>          qemu_put_byte(f, 0);
> >> @@ -822,11 +826,11 @@ static int ram_save_page(RAMState *rs, MigrationState *ms, QEMUFile *f,
> >>              if (bytes_xmit > 0) {
> >>                  acct_info.norm_pages++;
> >>              } else if (bytes_xmit == 0) {
> >> -                acct_info.dup_pages++;
> >> +                rs->zero_pages++;
> >
> > This code path looks suspicous... since iiuc currently it should only
> > be triggered by RDMA case, and I believe here qemu_rdma_save_page()
> > should have met something wrong (so that it didn't return with
> > RAM_SAVE_CONTROL_DELAYED). Then is it correct we do increase zero page
> > counting unconditionally here? (hmm, the default bytes_xmit is zero as
> > well...)
> 
> My head hurts at this point.
> ok.  bytse_xmit can only be zero if we called qemu_rdma_save_page() with
> size=0 or there has been an RDMA error.  We ver call the function with
> size = 0.  And if there is one error, we are in very bady shape already.
> 
> > Another thing is that I see when RDMA is enabled we are updating
> > accounting info with acct_update_position(), while we updated it here
> > as well. Is this an issue of duplicated accounting?
> 
> I think stats and rdma are not right.  I have to check more that.

It should be vaguely right; the rdma code calls back into acct_update_position
to update them; but I agree it looks odd;  that line almost looks like it's the error
case - so why is it incrementing dup_pages?

Dave

> Thanks, Juan.
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
