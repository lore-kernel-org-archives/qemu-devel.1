Received: from eggs.gnu.org ([2001:4830:134:3::10]:55323)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fY8Xd-0003GM-Kn
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:23:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1fY8XY-0001UU-MO
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:23:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1fY8XY-0001TM-Fr
	for qemu-devel@nongnu.org; Wed, 27 Jun 2018 07:23:12 -0400
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com
	[10.5.11.24])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id A5D73307CF25
	for <qemu-devel@nongnu.org>; Wed, 27 Jun 2018 11:23:11 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
References: <20180620073223.31964-1-peterx@redhat.com>
	<871sctea4y.fsf@dusky.pond.sub.org>
	<87tvpoadcc.fsf_-_@dusky.pond.sub.org>
	<87wouk8vul.fsf@dusky.pond.sub.org>
	<20180627102043.GD30628@redhat.com>
Date: Wed, 27 Jun 2018 13:23:07 +0200
In-Reply-To: <20180627102043.GD30628@redhat.com> ("Daniel P. =?utf-8?Q?Ber?=
	=?utf-8?Q?rang=C3=A9=22's?=
	message of "Wed, 27 Jun 2018 11:20:43 +0100")
Message-ID: <8760248odg.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
To: "Daniel P. =?utf-8?Q?Berrang=C3=A9?=" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Jun 27, 2018 at 10:41:38AM +0200, Markus Armbruster wrote:
>> Markus Armbruster <armbru@redhat.com> writes:
>>=20
>> > Markus Armbruster <armbru@redhat.com> writes:
>> >
>> >> I fooled around a bit, and I think there are a few lose ends.
>> > [...]
>> >> Talking to a QMP monitor that supports OOB:
>> >>
>> >>     $ socat UNIX:test-qmp READLINE,history=3D$HOME/.qmp_history,promp=
t=3D'QMP> '
>> >>     {"QMP": {"version": {"qemu": {"micro": 50, "minor": 12, "major": =
2}, "package": "v2.12.0-1703-gb909799463"}, "capabilities": ["oob"]}}
>> >>     QMP> { "execute": "qmp_capabilities", "arguments": { "oob": true =
} }
>> >>     {"error": {"class": "GenericError", "desc": "Parameter 'oob' is u=
nexpected"}}
>> >>     QMP> { "execute": "qmp_capabilities", "arguments": { "enable": ["=
oob"] } }
>> >>     {"return": {}}
>> >>     QMP> { "execute": "query-qmp-schema" }
>> >>     {"error": {"class": "GenericError", "desc": "Out-Of-Band capabili=
ty requires that every command contains an 'id' field"}}
>> >>
>> >> Why does every command require 'id'?
>> >
>> > I found one reason: event COMMAND_DROPPED wants it.  Any other reason?
>> >
>> > [...]
>>=20
>> Apropos COMMAND_DROPPED: we send an event rather than an error response
>> because we may send it out-of-order.  Makes sense.
>>=20
>> However, broadcasting it to all monitors doesn't make sense.  We could
>> use a way to send an event to just one monitor.
>
> Worse than that - broadcasting to all monitors is categorically broken.
> Different monitors make use the same "id" formatting scheme, so if you
> broadcast COMMAND_DROPPED to a different monitor you might have clashing
> "id" and thus incorrectly tell a client its command was dropped when in
> fact it was processed. You'd have to be fairly unlucky in timing, but
> it could happen.

Right.  Must fix bug.

I'm glad I went over this one more time, and in public!
