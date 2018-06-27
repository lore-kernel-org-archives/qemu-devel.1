Received: from eggs.gnu.org ([2001:4830:134:3::10]:37765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fY9Ee-0004eZ-7o
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:07:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fY9EZ-00084B-8S
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:07:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33168 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fY9EZ-000830-1V
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 08:07:39 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
	[10.11.54.6])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B6D97406EA4F
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 12:07:38 +0000 (UTC)
Date: Wed, 27 Jun 2018 20:07:33 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180627120733.GD2516@xz-mi>
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org>
	<87tvpoadcc.fsf_-_@dusky.pond.sub.org>
	<87wouk8vul.fsf@dusky.pond.sub.org>
	<20180627102043.GD30628@redhat.com>
	<8760248odg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8760248odg.fsf@dusky.pond.sub.org>
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
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>, qemu-devel@nongnu.org

On Wed, Jun 27, 2018 at 01:23:07PM +0200, Markus Armbruster wrote:
> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>=20
> > On Wed, Jun 27, 2018 at 10:41:38AM +0200, Markus Armbruster wrote:
> >> Markus Armbruster <armbru@redhat.com> writes:
> >>=20
> >> > Markus Armbruster <armbru@redhat.com> writes:
> >> >
> >> >> I fooled around a bit, and I think there are a few lose ends.
> >> > [...]
> >> >> Talking to a QMP monitor that supports OOB:
> >> >>
> >> >>     $ socat UNIX:test-qmp READLINE,history=3D$HOME/.qmp_history,p=
rompt=3D'QMP> '
> >> >>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "majo=
r": 2}, "package": "v2.12.0-1703-gb909799463"}, "capabilities": ["oob"]}}
> >> >>     QMP> { "execute": "qmp_capabilities", "arguments": { "oob": t=
rue } }
> >> >>     {"error": {"class": "GenericError", "desc": "Parameter 'oob' =
is unexpected"}}
> >> >>     QMP> { "execute": "qmp_capabilities", "arguments": { "enable"=
: ["oob"] } }
> >> >>     {"return": {}}
> >> >>     QMP> { "execute": "query-qmp-schema" }
> >> >>     {"error": {"class": "GenericError", "desc": "Out-Of-Band capa=
bility requires that every command contains an 'id' field"}}
> >> >>
> >> >> Why does every command require 'id'?
> >> >
> >> > I found one reason: event COMMAND_DROPPED wants it.  Any other rea=
son?
> >> >
> >> > [...]
> >>=20
> >> Apropos COMMAND_DROPPED: we send an event rather than an error respo=
nse
> >> because we may send it out-of-order.  Makes sense.
> >>=20
> >> However, broadcasting it to all monitors doesn't make sense.  We cou=
ld
> >> use a way to send an event to just one monitor.

True.

(Sorry for the late responses; I was on Linuxcon China in the past few
days)

> >
> > Worse than that - broadcasting to all monitors is categorically broke=
n.
> > Different monitors make use the same "id" formatting scheme, so if yo=
u
> > broadcast COMMAND_DROPPED to a different monitor you might have clash=
ing
> > "id" and thus incorrectly tell a client its command was dropped when =
in
> > fact it was processed. You'd have to be fairly unlucky in timing, but
> > it could happen.
>=20
> Right.  Must fix bug.

Even more true.

>=20
> I'm glad I went over this one more time, and in public!

I had a glance at current qmp-spec, it seems that we don't have any
restriction currently on "we must send events to all the monitors".
Does it mean that we should be free to have per-monitor events
starting from this event?

My current plan is that I can touch up scripts/qapi/events.py and
related stuff to allow QMPEventFuncEmit to take a monitor parameter,
then we pass in NULL when we want to send the event to all monitors.

Would that work?

Thanks,

--=20
Peter Xu
