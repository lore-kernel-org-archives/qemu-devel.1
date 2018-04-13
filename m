Received: from eggs.gnu.org ([2001:4830:134:3::10]:45074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f6y0M-0007wx-VZ
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:40:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f6y0L-0002a3-Tx
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 08:40:38 -0400
Date: Fri, 13 Apr 2018 14:40:16 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180413124016.GD4134@localhost.localdomain>
References: <20180412111143.GB5004@localhost.localdomain>
	<569800ae-12f8-53f1-012a-50408700ba39@redhat.com>
	<20180412115316.GC5004@localhost.localdomain>
	<306e73f3-9e72-e60f-123c-47a8a72915e2@redhat.com>
	<20180412132735.GD5004@localhost.localdomain>
	<dc693c45-e1dc-5a3d-3c95-adcb946c65d6@redhat.com>
	<20180412142519.GE5004@localhost.localdomain>
	<302b4aea-7e42-a321-f8db-4d0f69794bbf@redhat.com>
	<20180413080105.GA4134@localhost.localdomain>
	<a8e995b9-039d-0f0c-25a1-eaa8ee1ea725@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a8e995b9-039d-0f0c-25a1-eaa8ee1ea725@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 07/19] block: Really pause
 block jobs on drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, stefanha@redhat.com, qemu-block@nongnu.org, mreitz@redhat.com

Am 13.04.2018 um 13:05 hat Paolo Bonzini geschrieben:
> On 13/04/2018 10:01, Kevin Wolf wrote:
> >> Or bs->quiescent, for the sake of bikeshedding.
> > Yes, that sounds better.
> > 
> > The only problem with the proposal as I made it is that it's wrong. We
> > can't keep bs->quiescent until bdrv_do_drained_end() because the caller
> > can issue new requests and then have a nested drained section that needs
> > to wait for all requests again instead of deciding that everything is
> > already quiescent.
> > 
> > Maybe where we should really reset it is in the initial recursion of
> > bdrv_do_drained_begin(), specifically in bdrv_do_drained_begin_quiesce()
> > which is called by both the parent and the child recursion.
> > 
> > There don't seem to be completely obviously correct solutions (can't an
> > I/O thread be draining a specific node while the main loop runs
> > drain_all?), but this would probably be the most obvious one.
> 
> Or use a hash table?

I don't think it would be any more obvious, but it would bring in quite
a bit of additional complexity (structural, not computational), with
multiple places that create a hash table and then it would have to be
passed down to all functions involved in the recursion etc.

The fundamental question would stay the same as with bool quiescent:
When do you have to enter a node in the hash table, and when do you have
to remove it again?

The first question is easy, you mark it quiescent when bdrv_drain_poll()
returns false. The second is a bit harder, but reseting the quiescent
state in bdrv_do_drained_begin_quiesce() feels like the best place. It's
much simpler than recursively resetting it in all places that start new
activity (which would include BlockBackend users, not only nodes).

Kevin
