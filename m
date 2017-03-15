Received: from eggs.gnu.org ([2001:4830:134:3::10]:44013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cnzeS-0005bu-OD
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 23:31:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cnzeP-0003nl-KM
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 23:31:04 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51180)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cnzeP-0003nM-EJ
	for qemu-devel@nongnu.org; Tue, 14 Mar 2017 23:31:01 -0400
Date: Wed, 15 Mar 2017 05:30:56 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170315052418-mutt-send-email-mst@kernel.org>
References: <1489496187-624-1-git-send-email-peterx@redhat.com>
	<20170315032001-mutt-send-email-mst@kernel.org>
	<20170315031550.GG12964@pxdev.xzpeter.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170315031550.GG12964@pxdev.xzpeter.org>
Subject: Re: [Qemu-devel] [PATCH] memory: info mtree check mr range overflow
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, mark.cave-ayland@ilande.co.uk, Peter Maydell <peter.maydell@linaro.org>

On Wed, Mar 15, 2017 at 11:15:50AM +0800, Peter Xu wrote:
> On Wed, Mar 15, 2017 at 03:24:04AM +0200, Michael S. Tsirkin wrote:
> > On Tue, Mar 14, 2017 at 08:56:27PM +0800, Peter Xu wrote:
> > > The address of memory regions might overflow when something wrong
> > > happened, like reported in:
> > > 
> > > https://lists.gnu.org/archive/html/qemu-devel/2017-03/msg02043.html
> > > 
> > > For easier debugging, let's try to detect it.
> > > 
> > > Reported-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > 
> > 
> > After a chat with Paolo, I think the following is a more general fix
> > 
> > - fix info mtree to do 128 bit math and display more than
> >   16 digits if necessary
> 
> Could you help elaborate in what case will we really need that 128 bit
> address?

This is how memory API works. It uses 128 bit addresses (in reality
it typically only needs 64 bit addresses but 128 means it can do
math without worrying about it too much).
Thus a region at offset 0xf << 60 in parent with address 0x1 << 60
and size 0x1 << 20 is not "overflowing" it is simply at and address
0x1 << 64 which is outside the range of parent so not visible
in the flat view.
But same can be said for region at offset 0x1 << 60 in same parent
and your patch does nothing to help detect it.

> Btw, thanks for pointing out in the other thread that your patch
> wasn't printing 128 bits but 64 bits, actually I didn't notice that
> before... but even with that, I would still slightly prefer this one
> though considering readability and simplicity.

Right but it's just trying to address the specific problem with
the given device. Which is unlikely to trigger again exactly
in the same way. The general issue is that the child region
address is outside the range of the parent.

> > - add info about region visibility
> >   how much info is appropriate is arguable - after all we already have info mtree -f
> >   we probably should report if region is not visible at all,
> >   how about partially occluded ones? listing all windows is probably not
> >   needed - we have the -f flag for that.
> 
> For me, "info mtree" and its "-f" form work good enough. So I'll leave
> the discussion on this one to people who know better than me...
> 
> Thanks,
> 
> -- peterx
