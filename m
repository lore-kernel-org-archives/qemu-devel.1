Received: from eggs.gnu.org ([2001:4830:134:3::10]:56657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1d3Sl5-0001WG-UP
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 15:37:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aarcange@redhat.com>) id 1d3Sl2-0006v2-SM
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 15:37:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42734)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aarcange@redhat.com>) id 1d3Sl2-0006uH-Jy
	for qemu-devel@nongnu.org; Wed, 26 Apr 2017 15:37:48 -0400
Date: Wed, 26 Apr 2017 21:37:43 +0200
From: Andrea Arcangeli <aarcange@redhat.com>
Message-ID: <20170426193743.GF3508@redhat.com>
References: <20170426183721.7482-1-dgilbert@redhat.com>
	<20170426183721.7482-2-dgilbert@redhat.com>
	<8a107a40-073c-8181-75aa-e5700f2900a7@de.ibm.com>
	<20170426190442.GG2394@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170426190442.GG2394@work-vm>
Subject: Re: [Qemu-devel] [PATCH 1/2] Postcopy: Force allocation of all-zero
 precopy pages
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, qemu-devel@nongnu.org, quintela@redhat.com, lvivier@redhat.com, peterx@redhat.com

Hello,

On Wed, Apr 26, 2017 at 08:04:43PM +0100, Dr. David Alan Gilbert wrote:
> * Christian Borntraeger (borntraeger@de.ibm.com) wrote:
> > On 04/26/2017 08:37 PM, Dr. David Alan Gilbert (git) wrote:
> > > From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
> > > 
> > > When an all-zero page is received during the precopy
> > > phase of a postcopy-enabled migration we must force
> > > allocation otherwise accesses to the page will still
> > > get blocked by userfault.
> > > 
> > > Symptom:
> > >   a) If the page is accessed by a device during device-load
> > >     then we get a deadlock as the source finishes sending
> > >     all its pages but the destination device-load is still
> > >     paused and so doesn't clean up.
> > > 
> > >   b) If the page is accessed later, then the thread will stay
> > >     paused until the end of migration rather than carrying on
> > >     running, until we release userfault at the end.
> > > 
> > > Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > > Reported-by: Christian Borntraeger <borntraeger@de.ibm.com>
> > 
> > CC stable? after all the guest hangs on both sides
> > 
> > Has survived 40 migrations (usually failed at the 2nd)
> > Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
> 
> Great...but.....
> Andrea (added to the mail) says this shouldn't be necessary.
> The read we were doing in the is_zero_range() should have been sufficient
> to get the page mapped and that zero page should have survived.
> 
> So - I guess that's back a step, we need to figure out why the
> page disapepars for you.

Yes reading during precopy is enough to fill the hole and prevent
userfault missing faults to trigger.

Somehow the pagetable must be mapped by a zeropage or a hugezeropage
or a regular page allocated during a previous precopy pass or a
pre-zeroed subpage part of a THP.

Even if the hugezeropage is splitted later by a MADV_DONTNEED with
postcopy starts, they will become 4k zeropages.

After a read succeeds, nothing (except MADV_DONTNEED or other explicit
syscalls which qemu would need to invoke explicitly between
is_zero_range and UFFDIO_REGISTER) should be able to bring the
pagetable back to its "pte_none/pmd_none" state that will then trigger
missing userfaults during postcopy later.

Thanks,
Andrea
