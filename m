Received: from eggs.gnu.org ([2001:4830:134:3::10]:35887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1er5o9-0004VL-Mg
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 12:46:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1er5o8-0008M5-Ed
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 12:46:25 -0500
Date: Wed, 28 Feb 2018 18:46:16 +0100
From: Kevin Wolf <kwolf@redhat.com>
Message-ID: <20180228174616.GJ4855@localhost.localdomain>
References: <20180223235142.21501-1-jsnow@redhat.com>
	<20180223235142.21501-17-jsnow@redhat.com>
	<f475702e-fd2b-c1f2-ae32-4d34791f67ce@redhat.com>
	<048dacc1-b256-778f-4c8a-e5662cb587e6@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <048dacc1-b256-778f-4c8a-e5662cb587e6@redhat.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [RFC v4 16/21] blockjobs: add waiting status
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>
Cc: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, pkrempa@redhat.com, jtc@redhat.com, qemu-devel@nongnu.org

Am 27.02.2018 um 21:50 hat John Snow geschrieben:
>=20
>=20
> On 02/27/2018 03:00 PM, Eric Blake wrote:
> > On 02/23/2018 05:51 PM, John Snow wrote:
> >> For jobs that are stuck waiting on others in a transaction, it would
> >> be nice to know that they are no longer "running" in that sense, but
> >> instead are waiting on other jobs in the transaction.
> >>
> >> Jobs that are "waiting" in this sense cannot be meaningfully altered
> >> any longer as they have left their running loop. The only meaningful
> >> user verb for jobs in this state is "cancel," which will cancel the
> >> whole transaction, too.
> >>
> >> Transitions:
> >> Running -> Waiting:=A0=A0 Normal transition.
> >> Ready=A0=A0 -> Waiting:=A0=A0 Normal transition.
> >> Waiting -> Aborting:=A0 Transactional cancellation.
> >> Waiting -> Concluded: Normal transition.
> >>
> >> Removed Transitions:
> >> Running -> Concluded: Jobs must go to WAITING first.
> >> Ready=A0=A0 -> Concluded: Jobs must go to WAITING fisrt.
> >=20
> > s/fisrt/first/
> >=20
> >> +++ b/blockjob.c
> >=20
> >> @@ -3934,6 +3938,29 @@
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'offset': 'int',
> >> =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 'speed' : 'int' } }
> >> =A0 +##
> >> +# @BLOCK_JOB_WAITING:
> >> +#
> >> +# Emitted when a block job that is part of a transction has stopped
> >> work and is
> >=20
> > s/transction/transaction/
> >=20
> >> +# waiting for other jobs in the transaction to reach the same state=
.
> >=20
> > Is this event emitted only for 'new-style' transactions (old drivers
> > will never see it, because they don't request new style), or always (=
old
> > drivers will see, but presumably ignore, it)?
> >=20
>=20
> ...! Actually, I meant to remove the WAITING *event* entirely, this is =
a
> mistake.
>=20
> It's purely an informational state that clients likely cannot make any
> real use of, because regardless of old or new style, jobs will
> transition automatically to "PENDING."
>=20
> That said, old or new, the state is visible from query-block-jobs.

It means that the block job isn't working any more, which could possibly
be useful information.

Umm... When mirror transitions into WAITING, it stops working, but
doesn't change the graph yet. Isn't that a problem? Currently it doesn't
cause bugs because mirror doesn't support transactions, but we should
design things so that mirror could become transactionable later on.

I suppose one way to achieve this would be that mirror only transitions
into WAITING when the whole transaction is ready to move forward. In
this case, block-job-complete wouldn't tell mirror any more to actually
complete, but just to signal that the user is ready to have this job
completed.

Essentially this would split READY in two: The first state is when the
job has completed the bulk job and waits for the user, and the second
state is after the user sent block-job-complete. The second state
automatically transitions into WAITING as soon as all other jobs in the
transaction are either WAITING or in the second READY state.

Alternatively, mirror jobs could stay active in the WAITING phase, which
would then become the second READY phase. In this case, the state
machine would stay as it is, just the semantics of WAITING would change.

The result is either way that the WAITING event becomes uninteresting,
so after all I think I agree with completely removing it.

Kevin
