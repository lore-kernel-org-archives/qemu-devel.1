Received: from eggs.gnu.org ([2001:4830:134:3::10]:51621)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpc2c-0000R0-ES
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:15:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1dpc2W-0006c3-CV
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:14:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40512)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1dpc2W-0006bV-6g
	for qemu-devel@nongnu.org; Wed, 06 Sep 2017 11:14:52 -0400
Date: Wed, 6 Sep 2017 16:14:37 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20170906151436.GF2215@work-vm>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<20170906145043.GG15535@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170906145043.GG15535@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [RFC v2 0/8] monitor: allow per-monitor thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, mdroth@linux.vnet.ibm.com, Paolo Bonzini <pbonzini@redhat.com>

* Stefan Hajnoczi (stefanha@gmail.com) wrote:
> On Wed, Aug 23, 2017 at 02:51:03PM +0800, Peter Xu wrote:
> > The root problem is that, monitor commands are all handled in main
> > loop thread now, no matter how many monitors we specify. And, if main
> > loop thread hangs due to some reason, all monitors will be stuck.
> 
> I see a larger issue with postcopy: existing QEMU code assumes that
> guest memory access is instantaneous.
> 
> Postcopy breaks this assumption and introduces blocking points that can
> now take unbounded time.
> 
> This problem isn't specific to the monitor.  It can also happen to other
> components in QEMU like the gdbstub.
> 
> Do we need an asynchronous memory API?  Synchronous memory access should
> only be allowed in vcpu threads.

It would probably be useful for gdbstub where the overhead of async
doesn't matter;  but doing that for all IO emulation is hard.

Dave

> Stefan
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
