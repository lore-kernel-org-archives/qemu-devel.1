Received: from eggs.gnu.org ([2001:4830:134:3::10]:43303)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fg4W5-0001Xm-N1
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 04:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1fg4W2-0007X3-J1
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 04:42:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36922 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1fg4W2-0007We-Dn
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 04:42:26 -0400
Date: Thu, 19 Jul 2018 10:42:22 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20180719104222.60370566.cohuck@redhat.com>
In-Reply-To: <20180719044923.GC4071@xz-mi>
References: <20180717222721.14019.27548.stgit@gimli.home>
	<20180718064803.GA6197@xz-mi>
	<20180718113640.7b3b905d.cohuck@redhat.com>
	<20180719044923.GC4071@xz-mi>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 0/3] Balloon inhibit enhancements
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org

On Thu, 19 Jul 2018 12:49:23 +0800
Peter Xu <peterx@redhat.com> wrote:

> On Wed, Jul 18, 2018 at 11:36:40AM +0200, Cornelia Huck wrote:
> > On Wed, 18 Jul 2018 14:48:03 +0800
> > Peter Xu <peterx@redhat.com> wrote:

> > > I totally have no idea on whether people would like to use vfio-pci
> > > and the balloon device at the same time.  After all vfio-pci are
> > > majorly for performance players, then I would vaguely guess that they
> > > don't really care thin provisioning of memory at all, hence the usage
> > > scenario might not exist much.  Is that the major reason that we'd
> > > just like to disable it (which makes sense to me)?  
> > 
> > Don't people use vfio-pci as well if they want some special
> > capabilities from the passed-through device? (At least that's the main
> > use case for vfio-ccw, not any performance considerations.)  
> 
> Good to know these.
> 
> Out of topic: could I further ask what's these capabilities, and why
> these capabilities can't be emulated (or hard to be emulated) if we
> don't care about performance?

For vfio-ccw, the (current) main use case is ECKD DASD. While this is
basically a block device, it has some useful features (path failover,
remote copy, exclusive locking) that are not replicated by any emulated
device (and I'm not sure how to do this, either). It also has things
like a weird disk layout, which we _could_ emulate, but I'm not sure
why we would do that (it is mainly interesting if you want to share a
disk with a traditional mainframe OS).

Other usecases I'm thinking about are related to the
on-list-but-not-yet-merged vfio-ap crypto adapter support: Using a
crypto adapter that has been certified without needing to make keys
available to the OS, getting real randomness out of the card and so on.

Generally, I'd think anything that needs complicated transformations,
interaction with other ecosystems or exploiting reliability features
might be a case for using assignment: not just because of performance,
but also because you don't need to reinvent the wheel.
