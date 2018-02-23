Received: from eggs.gnu.org ([2001:4830:134:3::10]:53354)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epGn1-00072g-41
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:05:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1epGn0-0005Nl-8w
	for qemu-devel@nongnu.org; Fri, 23 Feb 2018 12:05:43 -0500
Date: Fri, 23 Feb 2018 18:05:25 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180223170525.GF3470@localhost.localdomain>
References: <20180213202701.15858-1-eblake@redhat.com>
	<20180213202701.15858-10-eblake@redhat.com>
	<20180214120525.GB4766@localhost.localdomain>
	<afb56cfd-4f42-07e5-9a65-d929b2ea9916@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <afb56cfd-4f42-07e5-9a65-d929b2ea9916@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v8 09/21] null: Switch to
 .bdrv_co_block_status()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>

Am 23.02.2018 um 17:43 hat Eric Blake geschrieben:
> > OFFSET_VALID | DATA might be excusable because I can see that it's
> > convenient that a protocol driver refers to itself as *file instead of
> > returning NULL there and then the offset is valid (though it would be
> > pointless to actually follow the file pointer), but OFFSET_VALID without
> > DATA probably isn't.
> 
> So OFFSET_VALID | DATA for a protocol BDS is not just convenient, but
> necessary to avoid breaking qemu-img map output.  But you are also right
> that OFFSET_VALID without data makes little sense at a protocol layer. So
> with that in mind, I'm auditing all of the protocol layers to make sure
> OFFSET_VALID ends up as something sane.

That's one way to look at it.

The other way is that qemu-img map shouldn't ask the protocol layer for
its offset because it already knows the offset (it is what it passes as
a parameter to bdrv_co_block_status).

Anyway, it's probably not worth changing the interface, we should just
make sure that the return values of the individual drivers are
consistent.

Kevin
