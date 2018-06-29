Received: from eggs.gnu.org ([2001:4830:134:3::10]:56726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fYobh-0007Y6-R4
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:18:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fYobb-0000mE-8G
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:18:17 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:52678 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fYobb-0000kI-39
	for qemu-devel@nongnu.org; Fri, 29 Jun 2018 04:18:11 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 9F2734075767
	for <qemu-devel@nongnu.org>; Fri, 29 Jun 2018 08:18:10 +0000 (UTC)
Date: Fri, 29 Jun 2018 16:18:06 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180629081806.GG2455@xz-mi>
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org>
	<87tvpoadcc.fsf_-_@dusky.pond.sub.org>
	<87wouk8vul.fsf@dusky.pond.sub.org>
	<20180627102043.GD30628@redhat.com>
	<8760248odg.fsf@dusky.pond.sub.org> <20180627120733.GD2516@xz-mi>
	<877emj5rij.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <877emj5rij.fsf@dusky.pond.sub.org>
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] monitor: enable OOB by default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org

On Thu, Jun 28, 2018 at 08:55:48AM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
>=20
> > On Wed, Jun 27, 2018 at 01:23:07PM +0200, Markus Armbruster wrote:
> >> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
> >>=20
> >> > On Wed, Jun 27, 2018 at 10:41:38AM +0200, Markus Armbruster wrote:
> >> >> Markus Armbruster <armbru@redhat.com> writes:
> >> >>=20
> >> >> > Markus Armbruster <armbru@redhat.com> writes:
> >> >> >
> >> >> >> I fooled around a bit, and I think there are a few lose ends.
> >> >> > [...]
> >> >> >> Talking to a QMP monitor that supports OOB:
> >> >> >>
> >> >> >>     $ socat UNIX:test-qmp READLINE,history=3D$HOME/.qmp_histor=
y,prompt=3D'QMP> '
> >> >> >>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "m=
ajor": 2}, "package": "v2.12.0-1703-gb909799463"}, "capabilities": ["oob"=
]}}
> >> >> >>     QMP> { "execute": "qmp_capabilities", "arguments": { "oob"=
: true } }
> >> >> >>     {"error": {"class": "GenericError", "desc": "Parameter 'oo=
b' is unexpected"}}
> >> >> >>     QMP> { "execute": "qmp_capabilities", "arguments": { "enab=
le": ["oob"] } }
> >> >> >>     {"return": {}}
> >> >> >>     QMP> { "execute": "query-qmp-schema" }
> >> >> >>     {"error": {"class": "GenericError", "desc": "Out-Of-Band c=
apability requires that every command contains an 'id' field"}}
> >> >> >>
> >> >> >> Why does every command require 'id'?
> >> >> >
> >> >> > I found one reason: event COMMAND_DROPPED wants it.  Any other =
reason?
> >> >> >
> >> >> > [...]
> >> >>=20
> >> >> Apropos COMMAND_DROPPED: we send an event rather than an error re=
sponse
> >> >> because we may send it out-of-order.  Makes sense.
> >> >>=20
> >> >> However, broadcasting it to all monitors doesn't make sense.  We =
could
> >> >> use a way to send an event to just one monitor.
> >
> > True.
> >
> > (Sorry for the late responses; I was on Linuxcon China in the past fe=
w
> > days)
>=20
> No need to be sorry :)
>=20
> >> >
> >> > Worse than that - broadcasting to all monitors is categorically br=
oken.
> >> > Different monitors make use the same "id" formatting scheme, so if=
 you
> >> > broadcast COMMAND_DROPPED to a different monitor you might have cl=
ashing
> >> > "id" and thus incorrectly tell a client its command was dropped wh=
en in
> >> > fact it was processed. You'd have to be fairly unlucky in timing, =
but
> >> > it could happen.
> >>=20
> >> Right.  Must fix bug.
> >
> > Even more true.
> >
> >>=20
> >> I'm glad I went over this one more time, and in public!
> >
> > I had a glance at current qmp-spec, it seems that we don't have any
> > restriction currently on "we must send events to all the monitors".
> > Does it mean that we should be free to have per-monitor events
> > starting from this event?
>=20
> Changing an existing event from broadcast to unicast is an observable
> change in existing behavior.  Compatibility break unless we can show
> nobody can use / uses the observation.
>=20
> Creating a new event is not a compatibility break by itself[*],
> regardless of broadcast vs. unicast.

Yeah.

Though this change will be a bit unique in that basically we should
not break anyone but fix potential problems that the clients might
encounter.

Firstly I really suspect anyone has really started to use OOB
commands...  But let's just assume there is.

Then if a client has implemented the COMMAND_DROPPED event, our change
should still keep that event be there when any of the command is
dropped for that monitor.  What we really changed in the behavior is
that we won't send incorrect COMMAND_DROPPED events to them which
should not belong to them.  From that point of view, it's not really
the spec/api that is changed, we just try to fix a bug from a broken
implementation (from me) of the spec. :)

So if you would agree I'd prefer to directly change that bit to change
COMMAND_DROPPED as per-monitor event.  It should only benefit existing
clients (from not receiving broken events) rather than breaking any of
them.

>=20
> > My current plan is that I can touch up scripts/qapi/events.py and
> > related stuff to allow QMPEventFuncEmit to take a monitor parameter,
> > then we pass in NULL when we want to send the event to all monitors.
> >
> > Would that work?
>=20
> Think so.
>=20
> Alternatively, a pair of functions:
>=20
>     void qapi_event_bcast_EVENT(... event params ..., Error **errp);
>     void qapi_event_send_EVENT(Monitor *mon, ... event params ..., Erro=
r **errp);
>=20
> Slightly more compact in the broadcast case, might be a bit easier to
> read.

Yeah I can try this.

>=20
>=20
> [*] In the case of COMMAND_DROPPED, the compatibility break is dropping
> commands (the event's trigger), caused by the command queuing feature.
> That's why command queuing has to be opt-in.  Details discussed
> elsewhere in this thread.

Thanks,

--=20
Peter Xu
