Received: from eggs.gnu.org ([2001:4830:134:3::10]:43101)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f5bzW-0005Pk-U1
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 14:58:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1f5bzU-000238-Cc
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 14:58:10 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:44784 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1f5bzU-00022p-7C
	for qemu-devel@nongnu.org; Mon, 09 Apr 2018 14:58:08 -0400
Date: Mon, 9 Apr 2018 19:57:47 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180409185747.GL2449@work-vm>
References: <bb088a1ba2e344273db32402f7c9fae4@linux.vnet.ibm.com>
	<20180404080600.GA10540@xz-mi>
	<0a48a834f08d064eaa3eb4ef1b41235f@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a48a834f08d064eaa3eb4ef1b41235f@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH] migration: calculate expected_downtime
 with ram_bytes_remaining()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Balamuruhan S <bala24@linux.vnet.ibm.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, quintela@redhat.com, dgibson@redhat.com

* Balamuruhan S (bala24@linux.vnet.ibm.com) wrote:
> On 2018-04-04 13:36, Peter Xu wrote:
> > On Wed, Apr 04, 2018 at 11:55:14AM +0530, Balamuruhan S wrote:
> > 
> > [...]
> > 
> > > > too. So still I'll put aside the "which one is better" question.
> > > >
> > > > For your use case, you can have a look on either of below way to
> > > > have a converged migration:
> > > >
> > > > - auto-converge: that's a migration capability that throttles CPU
> > > >   usage of guests
> > > 
> > > I used auto-converge option before hand and still it doesn't help
> > > for migration to complete
> > 
> > Have you digged about why?  AFAIK auto-convergence will at last absort
> > merely the whole vcpu resource (99% of them maximum).  Maybe you are
> > not with the best throttle values?  Or do you think that could be a
> > auto-convergence bug too?
> 
> I am not sure, I will work on it to find why.

> > 
> > > 
> > > >
> > > > - postcopy: that'll let you start the destination VM even without
> > > >   transferring all the RAMs before hand
> > > 
> > > I am seeing issue in postcopy migration between POWER8(16M) ->
> > > POWER9(1G)
> > > where the hugepage size is different. I am trying to enable it but
> > > host
> > > start
> > > address have to be aligned with 1G page size in
> > > ram_block_discard_range(),
> > > which I am debugging further to fix it.
> > 
> > I thought the huge page size needs to be matched on both side
> > currently for postcopy but I'm not sure.
> 
> you are right! it should be matched, but we need to support
> POWER8(16M) -> POWER9(1G)
> 
> > CC Dave (though I think Dave's still on PTO).

There's two problems there:
  a) Postcopy with really big huge pages is a problem, because it takes
     a long time to send the whole 1G page over the network and the vCPU
     is paused during that time;  for example on a 10Gbps link, it takes
     about 1 second to send a 1G page, so that's a silly time to keep
     the vCPU paused.

  b) Mismatched pagesizes are a problem on postcopy; we require that the
     whole of a hostpage is sent continuously, so that it can be
     atomically placed in memory, the source knows to do this based on
     the page sizes that it sees.  There are some other cases as well 
     (e.g. discards have to be page aligned.)

Both of the problems are theoretically fixable; but neither case is
easy.
(b) could be fixed by sending the hugepage size back to the source,
so that it knows to perform alignments on a larger boundary to it's
own RAM blocks.

(a) is a much much harder problem; one *idea* would be a major
reorganisation of the kernels hugepage + userfault code to somehow
allow them to temporarily present as normal pages rather than a
hugepage.

Does P9 really not have a hugepage that's smaller than 1G?

Dave

--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
