Received: from eggs.gnu.org ([2001:4830:134:3::10]:37093)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f6teC-0002xq-Dw
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 04:01:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1f6te8-0004uP-DV
	for qemu-devel@nongnu.org; Fri, 13 Apr 2018 04:01:28 -0400
Date: Fri, 13 Apr 2018 10:01:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180413080105.GA4134@localhost.localdomain>
References: <20180412095157.GA5004@localhost.localdomain>
	<f30ff8e9-4273-c01b-ae67-5784d5914c7a@redhat.com>
	<20180412111143.GB5004@localhost.localdomain>
	<569800ae-12f8-53f1-012a-50408700ba39@redhat.com>
	<20180412115316.GC5004@localhost.localdomain>
	<306e73f3-9e72-e60f-123c-47a8a72915e2@redhat.com>
	<20180412132735.GD5004@localhost.localdomain>
	<dc693c45-e1dc-5a3d-3c95-adcb946c65d6@redhat.com>
	<20180412142519.GE5004@localhost.localdomain>
	<302b4aea-7e42-a321-f8db-4d0f69794bbf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <302b4aea-7e42-a321-f8db-4d0f69794bbf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/19] block: Really pause block jobs on
 drain
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-block@nongnu.org, mreitz@redhat.com, famz@redhat.com, stefanha@redhat.com, qemu-devel@nongnu.org

Am 12.04.2018 um 22:44 hat Paolo Bonzini geschrieben:
> On 12/04/2018 16:25, Kevin Wolf wrote:
> > This is already the order we have there. What is probably different from
> > what you envision is that after the parents have concluded, we still
> > check that they are still quiescent in every iteration.
> 
> Yes, and that's the quadratic part.
> 
> > What we could do easily is introducing a bool bs->quiesce_concluded or
> > something that bdrv_drain_poll() sets to true the first time that it
> > returns false. It also gets a shortcut so that it returns false
> > immediately if bs->quiesce_concluded is true. The field is reset in
> > bdrv_do_drained_end() when bs->quiesce_counter reaches 0.
> 
> Or bs->quiescent, for the sake of bikeshedding.

Yes, that sounds better.

The only problem with the proposal as I made it is that it's wrong. We
can't keep bs->quiescent until bdrv_do_drained_end() because the caller
can issue new requests and then have a nested drained section that needs
to wait for all requests again instead of deciding that everything is
already quiescent.

Maybe where we should really reset it is in the initial recursion of
bdrv_do_drained_begin(), specifically in bdrv_do_drained_begin_quiesce()
which is called by both the parent and the child recursion.

There don't seem to be completely obviously correct solutions (can't an
I/O thread be draining a specific node while the main loop runs
drain_all?), but this would probably be the most obvious one.

Hm... Or actually, reset bs->quiescent in bdrv_inc_in_flight()? Would
this be enough?

Kevin
