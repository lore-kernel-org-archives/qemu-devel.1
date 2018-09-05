Received: from eggs.gnu.org ([2001:4830:134:3::10]:43236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fxOtK-0005fd-Ep
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 23:54:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fxOtE-0006Kg-Or
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 23:54:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39594 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fxOtE-0006KD-IN
	for qemu-devel@nongnu.org; Tue, 04 Sep 2018 23:54:00 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A88247788F
	for <qemu-devel@nongnu.org>; Wed,  5 Sep 2018 03:53:59 +0000 (UTC)
Date: Wed, 5 Sep 2018 11:53:49 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180905035349.GB16809@xz-x1>
References: <20180903043149.4076-1-peterx@redhat.com>
	<20180903043149.4076-5-peterx@redhat.com>
	<87a7oz9g1y.fsf@dusky.pond.sub.org> <20180903101606.GB14774@xz-x1>
	<87k1o2671t.fsf@dusky.pond.sub.org>
	<55829207-b0f7-0869-6ec7-90bc2fb67e3a@redhat.com>
	<20180903144116.GH14377@redhat.com> <20180904053055.GE14774@xz-x1>
	<87bm9dwuxb.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87bm9dwuxb.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v7 4/7] qapi: remove COMMAND_DROPPED event
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org

On Tue, Sep 04, 2018 at 10:04:00AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
>=20
> > On Mon, Sep 03, 2018 at 03:41:16PM +0100, Daniel P. Berrang=C3=A9 wro=
te:
> >> On Mon, Sep 03, 2018 at 09:30:52AM -0500, Eric Blake wrote:
> >> > On 09/03/2018 08:31 AM, Markus Armbruster wrote:
> >> >=20
> >> > > Example:
> >> > >=20
> >> > >      client sends in-band command #1
> >> > >      QEMU reads and queues
> >> > >      QEMU dequeues in-band command #1
> >> > >      in-band command #1 starts executing, but it's slooow
> >> > >      client sends in-band command #2
> >> > >      QEMU reads and queues
> >> > >      ...
> >> > >      client sends in-band command #8
> >> > >      QEMU reads, queues and suspends the monitor
> >> > >      client sends out-of-band command
> >> > > --> time passes...
> >> > >      in-band command #1 completes, QEMU sends reply
> >> > >      QEMU dequeues in-band command #2, resumes the monitor
> >> > >      in-band command #2 starts executing
> >> > >      QEMU reads and executes out-of-band command
> >> > >      out-of-band command completes, QEMU sends reply
> >> > >      in-band command #2 completes, QEMU sends reply
> >> > >      ... same for remaining in-band commands ...
> >> > >=20
> >> > > The out-of-band command gets stuck behind the in-band commands.
> >
> > (It's a shame of me to have just noticed that the out-of-band command
> >  will be stuck after we dropped the COMMAND_DROP event... so now I
> >  agree it's not that ideal any more to drop the event but maybe still
> >  preferable)
>=20
> We can queue without limit, we can drop commands, or we can suspend
> reading.  Each of these has drawbacks:
>=20
> * Queuing without limit is simple for the client, but unsafe for QEMU.
>=20
> * Dropping commands requires the client to cope with dropped commands.
>   As currently designed, it's just as unsafe for QEMU: instead of
>   queuing commands without limit, we get to queue their COMMAND_DROPPED
>   events without limit.  A better design could avoid this flaw.
>=20
> * Suspending reading requires the client to manage the flow of commands
>   if it wants to keep the monitor available for out-of-band commands.
>=20
> We decided that clients having to manage the flow of commands is no
> worse than clients having to cope with dropped commands.  There's still
> time to challenge this decision.
>=20
> This series acts upon the decision: it switches from dropping commands
> to suspending reading.  Makes the input direction safe.  The output
> direction remains as unsafe as it's always been.  Fixing that is left
> for later.

Yes.  Options (1) and (2) seems not really acceptable for me, but my
conclusion is based on that I think QEMU should still protect itself
from the client.  Take the example of QEMU & Libvirt: I think death or
bug of either of the program should not affect the other one.  But
maybe I misunderstood somewhere since I saw that you emphasized it at
[1] below...

And for (3), I really think a proper client should never trigger that
queue full state.  Hopefully with that then the client would never
lost the out-of-band feature due to a stuck input channel.

>=20
> >> > >=20
> >> > > The client can avoid this by managing the flow of in-band comman=
ds: have
> >> > > no more than 7 in flight, so the monitor never gets suspended.
> >> > >=20
> >> > > This is a potentially useful thing to do for clients, isn't it?
> >> > >=20
> >> > > Eric, Daniel, is it something libvirt would do?
> >> >=20
> >> > Right now, libvirt serializes commands - it never sends a QMP comm=
and until
> >> > the previous command's response has been processed. But that may n=
ot help
> >> > much, since libvirt does not send OOB commands.
> >>=20
> >> Note that is not merely due to the QMP monitor restriction either.
> >>=20
> >> Libvirt serializes all its public APIs that can change state of a ru=
nning
> >> domain.  It usually aims to allow read-only APIs to be run in parall=
el with
> >> APIs that change state.
> >>=20
> >> The exception to the rule right now are some of the migration APIs w=
hich
> >> we allow to be invoked to manage the migration process.=20
> >>=20
> >> > I guess when we are designing what libvirt should do, and deciding=
 WHEN it
> >> > should send OOB commands, we have the luxury of designing libvirt =
to enforce
> >> > how many in-flight in-band commands it will ever have pending at o=
nce
> >> > (whether the current 'at most 1', or even if we make it more paral=
lel to 'at
> >> > most 7'), so that we can still be ensured that the OOB command wil=
l be
> >> > processed without being stuck in the queue of suspended in-band co=
mmands.
> >> > If we never send more than one in-band at a time, then it's not a =
concern
> >> > how deep the qemu queue is; but if we do want libvirt to start par=
allel
> >> > in-band commands, then you are right that having a way to learn th=
e qemu
> >> > queue depth is programmatically more precise than just guessing th=
e maximum
> >> > depth.  But it's also hard to argue we need that complexity if we =
don't have
> >> > an immediate use envisioned for it.
> >>=20
> >> In terms of what libvirt would want to parallelize, I think it is re=
asonable
> >> to consider any of the query-XXXX commands desirable. Other stuff is=
 likely
> >> to remain serialized from libvirt's side.
> >
> > IMHO concurrency won't help much now even for query commands, since
> > our current concurrency is still "partly" - the executions of query
> > commands (which is the most time consuming part) will still be done
> > sequentially, so even if we send multiple query commands in parallel
> > (without waiting for a response of any sent commands), the total time
> > used for the list of commands would be mostly the same.
>=20
> Yes.  We execute all in-band commands (regardless of their monitor) in
> the main thread.  Out-of-band commands can execute in @mon_iothread,
> which provides a modest degree of concurrency.
>=20
> > My understanding for why we have such a queue length now is that it
> > came from a security concern: after we have a queue, we need that
> > queue length to limit the memory usages for the QMP server.  Though
> > that might not help much for real users like Libvirt, it's majorly
> > serving as a way to protect QEMU QMP from being attacked or from bein=
g
> > turned down by a buggy QMP client.
>=20
> Yes.
>=20
> QEMU has to trust its QMP clients, so malice is not a concern, but
> accidents are.  Robust software does not buffer without bounds.

[1]

>=20
> > But I agree now that the queue length information might still be
> > helpful some day.  Maybe, we can hide that until we support executing
> > commands in parallel for some of them.
>=20
> Queue length can become interesting long before we get general
> concurrency.
>=20
> If you use QMP only synchronously (send command #1; receive reply #1;
> send command #2; ...), then out-of-band does exactly nothing for you.
> To make use of it, you have to send an out-of-band command *before* you
> receive the previous command's reply.  That's a form of pipelining.

Yes, out-of-band should be special here, but as Dave has already
mentioned (possibly someone else too) that we may just need a length=3D1
queue for in-band command and length=3D1 queue for out-of-band command
and that should be enough at least for now (say, oob command will
never block, and oob commands will be executed once a time).  By that
extra length=3D1 out-of-band queue we gain the ability to talk to QMP
any time we want when necessary (though with limited list of cmds).

>=20
> Note there's still no general concurrency.  There's a bit of pipelining=
,
> and there's a bit of concurrency between one in-band command (executing
> in main thread) and out-of-band command (executing in @mon_iothread).
>=20
> Since we need to support a bit of pipelining anyway, why not support it
> more generally?  All it takes it raising the queue length limit above
> the minimum required for the use of OOB I just sketched.
>=20
> Note that "since we need to support a bit of concurrency anyway, why no=
t
> support it more generally?" would be ludicrously naive :)

Regards,

--=20
Peter Xu
