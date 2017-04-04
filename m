Received: from eggs.gnu.org ([2001:4830:134:3::10]:36677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cvQda-0005lV-Gn
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:44:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1cvQdW-0007T1-9E
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:44:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:34138)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1cvQdW-0007Sd-47
	for qemu-devel@nongnu.org; Tue, 04 Apr 2017 11:44:50 -0400
Date: Tue, 4 Apr 2017 16:44:42 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170404154441.GH2147@work-vm>
References: <1490599288-11751-1-git-send-email-peterx@redhat.com>
	<1490599288-11751-6-git-send-email-peterx@redhat.com>
	<aa26e76e-e5fd-c205-8919-6cc927a6d3ce@redhat.com>
	<20170331191321.GI2408@work-vm>
	<3171819.10011849.1490989617665.JavaMail.zimbra@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3171819.10011849.1490989617665.JavaMail.zimbra@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 5/5] cpu: throttle: fix throttle time slice
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, jjherne@linux.vnet.ibm.com, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Juan Quintela <quintela@redhat.com>

* Paolo Bonzini (pbonzini@redhat.com) wrote:
> 
> 
> > > So I'm inclined _not_ to take your patch.  One possibility could be to
> > > do the following:
> > > 
> > > - for throttling between 0% and 80%, use the current algorithm.  At 66%,
> > > the CPU will work for 10 ms and sleep for 40 ms.
> > > 
> > > - for throttling above 80% adapt your algorithm to have a variable
> > > timeslice, going from 50 ms at 66% to 100 ms at 100%.  This way, the CPU
> > > time will shrink below 10 ms and the sleep time will grow.
> 
> Oops, all the 66% should be 80%.
> 
> > It seems odd to have a threshold like that on something that's supposedly
> > a linear scale.
> 
> I futzed a bit with the threshold until the first derivative of the CPU
> time was zero at the threshold, and the result was 80%.  That is, if you
> switch before 80%, the CPU time slice can grow to more than 10 ms right
> after the threshold, and then start shrinking.
> 
> > > It looks like this: http://i.imgur.com/lyFie04.png
> > > 
> > > So at 99% the timeslice will be 97.5 ms; the CPU will work for 975 us
> > > and sleep for the rest (10x more than with just your patch).  But I'm
> > > not sure it's really worth it.
> > 
> > Can you really run a CPU for 975us ?
> 
> It's 2-3 million clock cycles, should be doable.

I wasn't really worrying about the CPU running, I was more worried
about timer resolution in stopping it.  If you're timer isn't that accurate
in starting/stopping the CPU then the errors might be so large as to
make that a bit odd.

Dave

> Paolo
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
