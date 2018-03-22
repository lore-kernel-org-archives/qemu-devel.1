Received: from eggs.gnu.org ([2001:4830:134:3::10]:55108)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eysLL-0007ZY-Ns
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 01:00:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1eysKv-0001j4-Uh
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 01:00:51 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42982 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1eysKv-0001iT-KP
	for qemu-devel@nongnu.org; Thu, 22 Mar 2018 01:00:25 -0400
Date: Thu, 22 Mar 2018 13:00:02 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180322050002.GF32362@xz-mi>
References: <20180309090006.10018-1-peterx@redhat.com>
	<20180309090006.10018-15-peterx@redhat.com>
	<CAJ+F1C+3f9RAC86YxRuvGWbX1tegA01iaY760yLOB2W5OyHaNA@mail.gmail.com>
	<20180321200933.GB3466@work-vm>
	<3e0a2365-a90e-3798-2c73-70ef2df67977@redhat.com>
	<CAJ+F1C+mcAxMVGXzYhbOoh932rKkEue22rk0ApqMHuOqbDDNGg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJ+F1C+mcAxMVGXzYhbOoh932rKkEue22rk0ApqMHuOqbDDNGg@mail.gmail.com>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v8 14/23] monitor: separate QMP parser and
 dispatcher
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Eric Blake <eblake@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Fam Zheng <famz@redhat.com>, Juan Quintela <quintela@redhat.com>, QEMU <qemu-devel@nongnu.org>, Michael Roth <mdroth@linux.vnet.ibm.com>, Markus Armbruster <armbru@redhat.com>, Stefan Hajnoczi <shajnocz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On Thu, Mar 22, 2018 at 12:32:36AM +0100, Marc-Andr=C3=A9 Lureau wrote:
> Hi
>=20
> On Wed, Mar 21, 2018 at 9:33 PM, Eric Blake <eblake@redhat.com> wrote:
> > On 03/21/2018 03:09 PM, Dr. David Alan Gilbert wrote:
> >
> >>>>
> >>>> So the parsing job and the dispatching job is isolated now.  It gi=
ves us
> >>>> a chance in following up patches to totally move the parser outsid=
e.
> >>>>
> >>>> The isolation is done using one QEMUBH. Only one dispatcher QEMUBH=
 is
> >>>> used for all the monitors.
> >>>>
> >
> >>>> +
> >>>> +    /*
> >>>> +     * If OOB is not enabled on current monitor, we'll emulate th=
e old
> >>>> +     * behavior that we won't process current monitor any more un=
til
> >>>> +     * it is responded.  This helps make sure that as long as OOB=
 is
> >>>> +     * not enabled, the server will never drop any command.
> >>>> +     */
> >>>> +    if (!qmp_oob_enabled(mon)) {
> >>>> +        monitor_suspend(mon);
> >>>> +        req_obj->need_resume =3D true;
> >>>> +    }
> >>>> +
> >>>> +    /*
> >>>> +     * Put the request to the end of queue so that requests will =
be
> >>>> +     * handled in time order.  Ownership for req_obj, req, id,
> >>>
> >>>
> >>> I think the order is not respected if subsequent messages have erro=
rs
> >>> (in either json parsing, dispatch_check_obj, oob_check). So if I
> >>> enable oob, and queue a few command, then send a bad command/messag=
e,
> >>> I won't be able to tell for which command.
> >>
> >>
> >> Doesn't OOB insist on having an ID field with the command?
> >
> >
> > OOB insists on an id field - but there is the situation that SOME err=
ors
> > occur even before the id field has been encountered (for example, if =
you
> > send non-JSON, the parser gets all confused - it has to emit SOME err=
or, but
> > that error can't refer to an id because it wasn't able to parse one y=
et).  A
> > well-formed client will never do this, but we MUST be robust even in =
the
> > face of a malicious client (or even a well-intentioned client but a n=
oisy
> > communication medium that manages to corrupt bytes). I'm not sure if =
the
> > testsuite adequately covers what happens in this scenario.  Peter?
>=20
> I think a solution would be to queue the error reply (the reply only)
> instead of replying directly.

IMHO this should be fine.

Note that to be compatible with existing QMP we'll suspend the monitor
if OOB is not enabled in the session on receiving the first command.
It means even if another faulty command is sent after the good one,
it'll not be read by QMP parser until the first one is fully complete.

Since I'm working on some test patches after all, I'll try to add a
test case for this to see whether Eric would like them too.

>=20
> Another problem I see with the current solution is that pending
> commands are not discarded when a new client connects. So I suppose a
> new client can receive replies for commands it didn't make, with id
> namespace that may conflict with its own. breaking ordering etc. A
> possible solution is to mark the pending request to not send the reply
> somehow?

Yeah, to be simpler - maybe we can even drop the commands that have
not yet been dispatched?

I'll treat a command as "complete" only until the client receives a
response, otherwise if a client disconnects before receiving a reply
then I think it's fine the behavior is undefined - IMHO it's fine
either the QMP server executes the command or not (and no matter what,
we drop the responses).  Would that work?

Thanks,

--=20
Peter Xu
