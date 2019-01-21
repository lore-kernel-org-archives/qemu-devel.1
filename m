Received: from eggs.gnu.org ([209.51.188.92]:51881)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1glbve-0003KM-1s
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 10:56:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1glbvc-0004DR-1K
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 10:56:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:32862)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>) id 1glbva-0004By-Vk
	for qemu-devel@nongnu.org; Mon, 21 Jan 2019 10:55:59 -0500
Date: Mon, 21 Jan 2019 16:55:53 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20190121155553.GD5638@linux.fritz.box>
References: <e5021228-184b-cc1b-7aba-3bba795127a6@msgid.tls.msk.ru>
	<20190114105132.GA2524@work-vm>
	<20190114115205.GD6837@linux.fritz.box>
	<20190118155703.GF2146@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190118155703.GF2146@work-vm>
Subject: Re: [Qemu-devel] 3.1: second invocation of migrate crashes qemu
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, quintela@redhat.com, qemu-devel <qemu-devel@nongnu.org>

Am 18.01.2019 um 16:57 hat Dr. David Alan Gilbert geschrieben:
> * Kevin Wolf (kwolf@redhat.com) wrote:
> > Am 14.01.2019 um 11:51 hat Dr. David Alan Gilbert geschrieben:
> > > * Michael Tokarev (mjt@tls.msk.ru) wrote:
> > > > $ qemu-system-x86_64 -monitor stdio -hda foo.img
> > > > QEMU 3.1.0 monitor - type 'help' for more information
> > > > (qemu) stop
> > > > (qemu) migrate "exec:cat >/dev/null"
> > > > (qemu) migrate "exec:cat >/dev/null"
> > > > qemu-system-x86_64: /build/qemu/qemu-3.1/block.c:4647: bdrv_inactivate_recurse: Assertion `!(bs->open_flags & BDRV_O_INACTIVE)' failed.
> > > > Aborted
> > > 
> > > And on head as well;  it only happens if the 1st migrate is succesful;
> > > if it got cancelled the 2nd one works, so it's not too bad.
> > > 
> > > I suspect the problem here is all around locking/ownership - the block
> > > devices get shutdown at the end of migration since the assumption is
> > > that the other end has them open now and we had better release them.
> > 
> > Yes, only "cont" gets control back to the source VM.
> > 
> > I think we really should limit the possible monitor commands in the
> > postmigrate status, and possibly provide a way to get back to the
> > regular paused state (which means getting back control of the resources)
> > without resuming the VM first.
> 
> This error is a little interesting if you'd done something like:
> 
> 
>      src:
>          stop
>          migrate
> 
>      dst:
>          <kill qemu for some reason>
>          start a new qemu
> 
>      src:
>          migrate
> 
> Now that used to work (safely) - note we've not started
> a VM succesfully anywhere else.
> 
> Now the source refuses to let that happen - with a rather
> nasty abort.

Essentially it's another effect of the problem that migration has always
lacked a proper model of ownership transfer. And it's still treating
this as a block layer problem rather than making it a core concept of
migration as it should.

We can stack another one-off fix on top, and get back control of the
block devices automatically on a second 'migrate'. But it feels like a
hack and not like VMs had a properly designed and respected state
machine.

Kevin
