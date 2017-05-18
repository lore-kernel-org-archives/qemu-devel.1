Received: from eggs.gnu.org ([2001:4830:134:3::10]:46379)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dBGhX-0000TT-E3
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:22:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1dBGhW-000620-Kg
	for qemu-devel@nongnu.org; Thu, 18 May 2017 04:22:27 -0400
Date: Thu, 18 May 2017 10:22:13 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20170518082213.GC4646@noname.redhat.com>
References: <20170517170941.25850-1-stefanha@redhat.com>
	<20170517170941.25850-3-stefanha@redhat.com>
	<e6d9417e-87bb-a88f-4f55-0a72aae0a212@redhat.com>
	<20170518075759.GA4646@noname.redhat.com>
	<CAJSP0QXgsJfBr5jdU9dyNZRmfqZSOy1Wr1pQzy-adG9e5=oYUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJSP0QXgsJfBr5jdU9dyNZRmfqZSOy1Wr1pQzy-adG9e5=oYUA@mail.gmail.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/3] block: use
 BDRV_POLL_WHILE() in bdrv_rw_vmstate()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, qemu block <qemu-block@nongnu.org>, Fam Zheng <famz@redhat.com>, qemu-devel <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>

Am 18.05.2017 um 10:06 hat Stefan Hajnoczi geschrieben:
> On Thu, May 18, 2017 at 8:57 AM, Kevin Wolf <kwolf@redhat.com> wrote:
> > Am 17.05.2017 um 22:16 hat Eric Blake geschrieben:
> >> On 05/17/2017 12:09 PM, Stefan Hajnoczi wrote:
> >> > Calling aio_poll() directly may have been fine previously, but this is
> >> > the future, man!
> >>
> >> lol
> >>
> >> >  The difference between an aio_poll() loop and
> >> > BDRV_POLL_WHILE() is that BDRV_POLL_WHILE() releases the AioContext
> >> > around aio_poll().
> >> >
> >> > This allows the IOThread to run fd handlers or BHs to complete the
> >> > request.  Failure to release the AioContext causes deadlocks.
> >> >
> >> > Using BDRV_POLL_WHILE() partially fixes a 'savevm' hang with -object
> >> > iothread.
> >>
> >> I'm surprised at how many separate hangs we actually had!
> >
> > How hard would it be to write some test cases for this? Dataplane has
> > a serious lack of automated testing.
> 
> And this hang doesn't even require in-flight guest I/O, so it would be
> easy to reproduce in qemu-iotests if we add an IOThread mode.

I don't think I would make it a separate mode (because people would run
only one or the other - when did you last run qcow2 v2 tests?), but just
add some test cases that make use of it during the normal -qcow2 or -raw
run.

Kevin
