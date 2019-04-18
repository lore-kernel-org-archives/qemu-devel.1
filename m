Received: from eggs.gnu.org ([209.51.188.92]:56086)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hH9sh-000415-Aa
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:27:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hH9r0-0002G6-CM
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:25:39 -0400
Received: from forwardcorp1p.mail.yandex.net ([77.88.29.217]:60216)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yury-kotov@yandex-team.ru>) id 1hH9qz-0002F0-OY
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 12:25:38 -0400
From: Yury Kotov <yury-kotov@yandex-team.ru>
In-Reply-To: <20190418160300.GI2984@work-vm>
References: <251681555323421@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415102520.GG5718@redhat.com>
	<259551555324396@vla1-1374b6242101.qloud-c.yandex.net>
	<20190415104725.GI5718@redhat.com> <20190415111511.GG2852@work-vm>
	<20190415111911.GK5718@redhat.com> <20190415113045.GI2852@work-vm>
	<612681555412465@iva6-8a76e93b6298.qloud-c.yandex.net>
	<20190418141956.GF2984@work-vm>
	<1285061555601789@iva6-8a76e93b6298.qloud-c.yandex.net>
	<20190418160300.GI2984@work-vm>
MIME-Version: 1.0
Date: Thu, 18 Apr 2019 19:25:35 +0300
Message-Id: <1201831555604730@vla1-1374b6242101.qloud-c.yandex.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] migration: Fix handling fd protocol
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: =?utf-8?B?RGFuaWVsIFAuIEJlcnJhbmfDqQ==?= <berrange@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "yc-core@yandex-team.ru" <yc-core@yandex-team.ru>, Juan Quintela <quintela@redhat.com>

18.04.2019, 19:03, "Dr. David Alan Gilbert" <dgilbert@redhat.com>:
> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>> =C2=A018.04.2019, 17:20, "Dr. David Alan Gilbert" <dgilbert@redhat.com=
>:
>> =C2=A0> * Yury Kotov (yury-kotov@yandex-team.ru) wrote:
>> =C2=A0>> =C2=A015.04.2019, 14:30, "Dr. David Alan Gilbert" <dgilbert@r=
edhat.com>:
>> =C2=A0>> =C2=A0> * Daniel P. Berrang=C3=A9 (berrange@redhat.com) wrote=
:
>> =C2=A0>> =C2=A0>> =C2=A0On Mon, Apr 15, 2019 at 12:15:12PM +0100, Dr. =
David Alan Gilbert wrote:
>> =C2=A0>> =C2=A0>> =C2=A0> * Daniel P. Berrang=C3=A9 (berrange@redhat.c=
om) wrote:
>> =C2=A0>> =C2=A0>> =C2=A0> > On Mon, Apr 15, 2019 at 01:33:21PM +0300, =
Yury Kotov wrote:
>> =C2=A0>> =C2=A0>> =C2=A0> > > 15.04.2019, 13:25, "Daniel P. Berrang=C3=
=A9" <berrange@redhat.com>:
>> =C2=A0>> =C2=A0>> =C2=A0> > > > On Mon, Apr 15, 2019 at 01:17:06PM +03=
00, Yury Kotov wrote:
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A015.04.2019, 13:11, "Daniel P. B=
errang=C3=A9" <berrange@redhat.com>:
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> On Mon, Apr 15, 2019 at 12:50=
:08PM +0300, Yury Kotov wrote:
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0Hi,
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>>
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0Just to clarify. I see=
 two possible solutions:
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>>
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A01) Since the migration=
 code doesn't receive fd, it isn't responsible for
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0closing it. So, it may=
 be better to use migrate_fd_param for both
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0incoming/outgoing and =
add dupping for migrate_fd_param. Thus, clients must
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0close the fd themselve=
s. But existing clients will have a leak.
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> We can't break existing clien=
ts in this way as they are correctly
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> using the monitor with its cu=
rrent semantics.
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A02) If we don't duplica=
te fd, then at least we should remove fd from
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0the corresponding list=
. Therefore, the solution is to fix qemu_close to find
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0the list and remove fd=
 from it. But qemu_close is currently consistent with
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0qemu_open (which opens=
/dups fd), so adding additional logic might not be
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0a very good idea.
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> qemu_close is not appropriate=
 place to deal with something speciifc
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> to the montor.
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0I don't see any other =
solution, but I might miss something.
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>> =C2=A0What do you think?
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> All callers of monitor_get_fd=
() will close() the FD they get back.
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> Thus monitor_get_fd() should =
remove it from the list when it returns
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0> it, and we should add API doc=
s to monitor_get_fd() to explain this.
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0>
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0Ok, it sounds reasonable. But m=
onitor_get_fd is only about outgoing migration.
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0But what about the incoming mig=
ration? It doesn't use monitor_get_fd but just
>> =C2=A0>> =C2=A0>> =C2=A0> > > >> =C2=A0converts input string to int an=
d use it as fd.
>> =C2=A0>> =C2=A0>> =C2=A0> > > >
>> =C2=A0>> =C2=A0>> =C2=A0> > > > The incoming migration expects the FD =
to be passed into QEMU by the mgmt
>> =C2=A0>> =C2=A0>> =C2=A0> > > > app when it is exec'ing the QEMU binar=
y. It doesn't interact with the
>> =C2=A0>> =C2=A0>> =C2=A0> > > > monitor at all AFAIR.
>> =C2=A0>> =C2=A0>> =C2=A0> > > >
>> =C2=A0>> =C2=A0>> =C2=A0> > >
>> =C2=A0>> =C2=A0>> =C2=A0> > > Oh, sorry. This use case is not obvious.=
 We used add-fd to pass fd for
>> =C2=A0>> =C2=A0>> =C2=A0> > > migrate-incoming and such way has descri=
bed problems.
>> =C2=A0>> =C2=A0>> =C2=A0> >
>> =C2=A0>> =C2=A0>> =C2=A0> > That's a bug in your usage of QEMU IMHO, a=
s the incoming code is not
>> =C2=A0>> =C2=A0>> =C2=A0> > designed to use add-fd.
>> =C2=A0>> =C2=A0>> =C2=A0>
>> =C2=A0>> =C2=A0>> =C2=A0> Hmm, that's true - although:
>> =C2=A0>> =C2=A0>> =C2=A0> a) It's very non-obvious
>> =C2=A0>> =C2=A0>> =C2=A0> b) Unfortunate, since it would go well with =
-incoming defer
>> =C2=A0>> =C2=A0>>
>> =C2=A0>> =C2=A0>> =C2=A0Yeah I think this is a screw up on QMEU's part=
 when introducing 'defer'.
>> =C2=A0>> =C2=A0>>
>> =C2=A0>> =C2=A0>> =C2=A0We should have mandated use of 'add-fd' when u=
sing 'defer', since FD
>> =C2=A0>> =C2=A0>> =C2=A0inheritance-over-execve() should only be used =
for command line args,
>> =C2=A0>> =C2=A0>> =C2=A0not monitor commands.
>> =C2=A0>> =C2=A0>>
>> =C2=A0>> =C2=A0>> =C2=A0Not sure how to best fix this is QEMU though w=
ithout breaking back
>> =C2=A0>> =C2=A0>> =C2=A0compat for apps using 'defer' already.
>> =C2=A0>> =C2=A0>
>> =C2=A0>> =C2=A0> We could add mon-fd: transports that has the same beh=
aviour as now for
>> =C2=A0>> =C2=A0> outgoing, and for incoming uses the add-fd stash.
>> =C2=A0>> =C2=A0>
>> =C2=A0>>
>> =C2=A0>> =C2=A0Oh, I'm sorry again. I think my suggestion about monito=
r_fd_param wasn't
>> =C2=A0>> =C2=A0relevant to this issue. If migrate-incoming + "fd:" + a=
dd-fd is an invalid use
>> =C2=A0>> =C2=A0case, should we disallow this?
>> =C2=A0>> =C2=A0I may add a check to fd_start_incoming_migration if fd =
is in mon fds list.
>> =C2=A0>> =C2=A0But I'm afraid there are users like me who are already =
using this wrong use case.
>> =C2=A0>> =C2=A0Because currently nothing in QEMU's docs disallow this.
>> =C2=A0>>
>> =C2=A0>> =C2=A0So which solution is better in your opinion?
>> =C2=A0>> =C2=A01) Disallow fd's from mon fds list in fd_start_incoming=
_migration
>> =C2=A0>
>> =C2=A0> I'm surprised anything could be doing that - how would a user =
know what
>> =C2=A0> the correct fd index was?
>> =C2=A0>
>>
>> =C2=A0Hmm, add-fd returns correct fd value. Maybe I din't catch you qu=
estion...
>
> I don't understand, where does it return it?
>

>From misc.json:
# Example:
#
# -> { "execute": "add-fd", "arguments": { "fdset-id": 1 } }
# <- { "return": { "fdset-id": 1, "fd": 3 } }
#

"fd": 3 is a valid fd for migrate-incoming(uri =3D "fd:3")

>> =C2=A0>> =C2=A02) Allow these fds, but dup them or close them correctl=
y
>> =C2=A0>
>> =C2=A0> I think I'd leave the current (confusing) fd: as it is, maybe =
put a note
>> =C2=A0> in the manual.
>> =C2=A0>
>>
>> =C2=A0So, using fd from fdset will be an undefined behavior, right?
>
> For incoming, yes.
>
>> =C2=A0>> =C2=A0And how to migrate-incoming defer through fd correctly?
>> =C2=A0>> =C2=A01) Add "mon-fd:" protocol to work with fds passed by "a=
dd-fd/remove-fd" commands
>> =C2=A0>> =C2=A0as suggested by Dave
>> =C2=A0>
>> =C2=A0> That's my preference; it's explicitly named and consistent, an=
d it
>> =C2=A0> doesn't touch the existing fd code.
>> =C2=A0>
>>
>> =C2=A0Ok, but please tell me what you think of my suggestion (2) about=
 using fd added
>> =C2=A0by the "getfd" command for incoming migration. It doesn't requir=
es introducing
>> =C2=A0new protocol and will be consistent with outgoing migration thro=
ugh fd.
>
> I worry how qemu knows whether the command means it comes from the getf=
d
> command or is actually a normal fd like now?
> Can you give an example.
>

getfd manages naming fds list.
# -> { "execute": "getfd", "arguments": { "fdname": "fd1" } }
So, for migrate (not incoming) is now valid migrate(uri=3D"fd:fd1")

I want the same for migrate-incoming. If fdname is parseable int, then it=
 is
an old format. Otherwise - it is a name of fd added by addfd.

There is a function "monitor_fd_param" which do exactly what I mean:
int monitor_fd_param(Monitor *mon, const char *fdname, Error **errp) {
    ... local vars ...
    if (!qemu_isdigit(fdname[0]) && mon) {
        fd =3D monitor_get_fd(mon, fdname, &local_err);
    } else {
        fd =3D qemu_parse_fd(fdname);
    }
    ... report err to errp ...
}

>> =C2=A0>
>> =C2=A0>> =C2=A02) My suggestion about monitor_fd_param and make "fd:" =
for
>> =C2=A0>> =C2=A0migrate/migrate-incoming consistent. So user will be ab=
le to use
>> =C2=A0>> =C2=A0getfd + migrate-incoming
>> =C2=A0>> =C2=A03) Both of them or something else
>> =C2=A0>>
>>

Regards,
Yury
