Received: from eggs.gnu.org ([2001:4830:134:3::10]:43256)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dprOJ-0005oZ-DW
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 03:38:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1dprOG-0004Bz-7S
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 03:38:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59392)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1dprOG-0004BL-2H
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 03:38:20 -0400
Date: Thu, 7 Sep 2017 15:38:08 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170907073808.GA22637@pxdev.xzpeter.org>
References: <1503471071-2233-1-git-send-email-peterx@redhat.com>
	<20170906145043.GG15535@stefanha-x1.localdomain>
	<20170906151436.GF2215@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170906151436.GF2215@work-vm>
Subject: Re: [Qemu-devel] [RFC v2 0/8] monitor: allow per-monitor thread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Stefan Hajnoczi <stefanha@gmail.com>, qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, mdroth@linux.vnet.ibm.com, Paolo Bonzini <pbonzini@redhat.com>

On Wed, Sep 06, 2017 at 04:14:37PM +0100, Dr. David Alan Gilbert wrote:
> * Stefan Hajnoczi (stefanha@gmail.com) wrote:
> > On Wed, Aug 23, 2017 at 02:51:03PM +0800, Peter Xu wrote:
> > > The root problem is that, monitor commands are all handled in main
> > > loop thread now, no matter how many monitors we specify. And, if main
> > > loop thread hangs due to some reason, all monitors will be stuck.
> > 
> > I see a larger issue with postcopy: existing QEMU code assumes that
> > guest memory access is instantaneous.
> > 
> > Postcopy breaks this assumption and introduces blocking points that can
> > now take unbounded time.
> > 
> > This problem isn't specific to the monitor.  It can also happen to other
> > components in QEMU like the gdbstub.
> > 
> > Do we need an asynchronous memory API?  Synchronous memory access should
> > only be allowed in vcpu threads.
> 
> It would probably be useful for gdbstub where the overhead of async
> doesn't matter;  but doing that for all IO emulation is hard.

Agreed.

IIUC one problem is that we should have code that cached the HVA for
specific GPA, then when it wants to write to that GPA, it directly
writes to corresponding HVA.  No memory API is used.  I am not sure
whether it's possible to convert all these usages into memory APIs
(even if it supports async operations).

-- 
Peter Xu
