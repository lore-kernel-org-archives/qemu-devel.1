Received: from eggs.gnu.org ([2001:4830:134:3::10]:47445)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1djhR6-0003vA-Gf
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 03:47:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1djhR2-0007IG-KG
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 03:47:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40962)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1djhR2-0007Hw-Dk
	for qemu-devel@nongnu.org; Mon, 21 Aug 2017 03:47:44 -0400
Date: Mon, 21 Aug 2017 15:47:44 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170821074744.GA30356@pxdev.xzpeter.org>
References: <1501229198-30588-1-git-send-email-peterx@redhat.com>
	<20170803155753.GD3673@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170803155753.GD3673@work-vm>
Subject: Re: [Qemu-devel] [RFC 00/29] Migration: postcopy failure recovery
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <lvivier@redhat.com>, Alexey Perevalov <a.perevalov@samsung.com>, Juan Quintela <quintela@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, berrange@redhat.com

On Thu, Aug 03, 2017 at 04:57:54PM +0100, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > As we all know that postcopy migration has a potential risk to lost
> > the VM if the network is broken during the migration. This series
> > tries to solve the problem by allowing the migration to pause at the
> > failure point, and do recovery after the link is reconnected.
> > 
> > There was existing work on this issue from Md Haris Iqbal:
> > 
> > https://lists.nongnu.org/archive/html/qemu-devel/2016-08/msg03468.html
> > 
> > This series is a totally re-work of the issue, based on Alexey
> > Perevalov's recved bitmap v8 series:
> > 
> > https://lists.gnu.org/archive/html/qemu-devel/2017-07/msg06401.html
> 
> 
> Hi Peter,
>   See my comments on the individual patches; but at a top level I think
> it looks pretty good.
> 
>   I still worry about two related things, one I see is similar to what
> you discussed with Dan.
> 
>   1) Is what happens if we end up hanging on a missing page with the bql
>   taken and can't use the monitor.
>   Checking my notes from when I was chatting to Harris last year,
>     'info cpu' was pretty good at doing this because it needed the vcpus
>   to come out of their loops, so if any vcpu was blocked on memory we'd
>   block waiting.  The other case is where an emulated IO device accesses
>   it, and that's easiest by doing a migrate with inbound network
>   traffic.
>   In this case, will your 'accept' still work?

It will not work.

To solve this problem, I posted the series:

  [RFC 0/6] monitor: allow per-monitor thread

Let's see whether that is acceptable.

> 
>   2) Similar to Dan's question of what happens if the network just hangs
>   as opposed to gives an error;  it should eventually sort itself out
>   with TCP timeouts - eventually.  Perhaps the easiest way to test this
>   is just to add a iptables -j DROP  for the migration port - it's
>   probably easier to trigger (1).

Yeah, so I think I'll just avoid considering this for now.  Thanks,

-- 
Peter Xu
