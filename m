Received: from eggs.gnu.org ([2001:4830:134:3::10]:36720)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnPmN-0002eZ-1m
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:12:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cnPmJ-0004Bs-0m
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:12:51 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41222)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cnPmI-0004Bk-OH
	for qemu-devel@nongnu.org; Mon, 13 Mar 2017 09:12:46 -0400
From: Markus Armbruster <armbru@redhat.com>
References: <1489385927-6735-1-git-send-email-armbru@redhat.com>
	<CAJ+F1CKiE2FHjS0_K2F+yS-ByZMtVVFh6+NLm_q4_myeg=_KdQ@mail.gmail.com>
	<87lgs974rd.fsf@dusky.pond.sub.org>
	<CAJ+F1CL_iQNVN5a=rZ93bWnnG89710aBkN7iT_eiqNtwJRk=7w@mail.gmail.com>
Date: Mon, 13 Mar 2017 14:12:43 +0100
In-Reply-To: <CAJ+F1CL_iQNVN5a=rZ93bWnnG89710aBkN7iT_eiqNtwJRk=7w@mail.gmail.com>
	(=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Mon, 13 Mar 2017
	12:21:59 +0000")
Message-ID: <8760jd5nhw.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH for-2.9 00/47] qapi: Put type information
 back into QMP documentation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org, mdroth@linux.vnet.ibm.com

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

> Hi
>
> On Mon, Mar 13, 2017 at 4:14 PM Markus Armbruster <armbru@redhat.com> wro=
te:
>
>> Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:
>>
>> > Hi
>> >
>> > On Mon, Mar 13, 2017 at 10:23 AM Markus Armbruster <armbru@redhat.com>
>> > wrote:
>> >
>> >> I'm proposing this is 2.9 because it fixes a documentation regression.
>> >> It affects only documentation; generated C code is unchanged except
>> >> for the removal of trailing space in PATCH 46.
>> >>
>> >> Based on my qapi-next branch, which contains Marc-Andr=C3=A9's PATCH =
1/2.
>> >>
>> >> Marc-Andr=C3=A9's work to merge qmp-commands.txt and qmp-events.txt i=
nto
>> >> the QAPI schema and generate their replacements from the schema
>> >> (commit b6af8ea..56e8bdd) was a big step forward.  As committed, it
>> >> also was a step back: the documentation lost information on JSON
>> >> types, because I didn't like Marc-Andr=C3=A9's patch to add it.  He
>> >> reposted it for further review afterwards:
>> >>
>> >>     Subject: [PATCH 0/2] qapi2texi: add type information
>> >>     Message-Id: <20170125130308.16104-1-marcandre.lureau@redhat.com>
>> >>     https://lists.gnu.org/archive/html/qemu-devel/2017-01/msg05432.ht=
ml
>> >>
>> >> His PATCH 1/2 is a straightforward cleanup.  His PATCH 2/2 adds type
>> >> descriptions in a new formal language to the generated documentation.
>> >> Quoting the commit message:
>> >>
>> >>     Array types have the following syntax: type[]. Ex: str[].
>> >>
>> >>     - Struct, commands and events use the following members syntax:
>> >>
>> >>       { 'member': type, ('foo': str), ... }
>> >>
>> >>     Optional members are under parentheses.
>> >>
>> >>     A structure with a base type will have 'BaseStruct +' prepended.
>> >>
>> >>     - Alternates use the following syntax:
>> >>
>> >>       [ 'foo': type, 'bar': type, ... ]
>> >>
>> >>     - Simple unions use the following syntax:
>> >>
>> >>       { 'type': str, 'data': 'type' =3D [ 'foo': type, 'bar': type...=
 ] }
>> >>
>> >>     - Flat unions use the following syntax:
>> >>
>> >>       BaseStruct + 'discriminator' =3D [ 'foo': type, 'bar': type... ]
>> >>
>> >> End quote.  Looks like this in generated documentation:
>> >>
>> >>  -- Event: VNC_CONNECTED {'server': VncServerInfo, 'client':
>> >>           VncBasicInfo}
>> >>
>> >>      Emitted when a VNC client establishes a connection
>> >>      ''server''
>> >>           server information
>> >>      ''client''
>> >>           client information
>> >>
>> >>      Note: This event is emitted before any authentication takes plac=
e,
>> >>      thus the authentication ID is not provided
>> >> [...]
>> >>
>> >>  -- Struct: VncServerInfo VncBasicInfo + {('auth': str)}
>> >>
>> >>      The network connection information for server
>> >>      ''auth'' (optional)
>> >>           authentication method used for the plain (non-websocket) VNC
>> >>           server
>> >>
>> >>      Since: 2.1
>> >>
>> >>  -- Simple Union: SocketAddress { 'type': str, 'data': 'type' =3D ['i=
net':
>> >>           InetSocketAddress, 'unix': UnixSocketAddress, 'vsock':
>> >>           VsockSocketAddress, 'fd': String] }
>> >>
>> >>      Captures the address of a socket, which could also be a named fi=
le
>> >>      descriptor
>> >>
>> >>      Since: 1.3
>> >>
>> >> Here's my counter-proposal: instead of inventing a formal language,
>> >> fix the natural language documentation to actually mention *all*
>> >> members, and add type information in a plain, easy-to-understand way.
>> >> Looks like this:
>> >>
>> >>  -- Event: VNC_CONNECTED
>> >>
>> >>      Emitted when a VNC client establishes a connection
>> >>
>> >>      Arguments:
>> >>      'server: VncServerInfo'
>> >>           server information
>> >>      'client: VncBasicInfo'
>> >>           client information
>> >>
>> >>      Note: This event is emitted before any authentication takes plac=
e,
>> >>      thus the authentication ID is not provided
>> >> [...]
>> >>
>> >>  -- Object: VncServerInfo
>> >>
>> >>      The network connection information for server
>> >>
>> >>      Members:
>> >>      'auth: string' (optional)
>> >>           authentication method used for the plain (non-websocket) VNC
>> >>           server
>> >>      The members of 'VncBasicInfo'
>> >>
>> >>      Since: 2.1
>> >>
>> >>  -- Object: SocketAddress
>> >>
>> >>      Captures the address of a socket, which could also be a named fi=
le
>> >>      descriptor
>> >>
>> >>      Members:
>> >>      'type'
>> >>           One of "inet", "unix", "vsock", "fd"
>> >>      'data: InetSocketAddress' when 'type' is "inet"
>> >>      'data: UnixSocketAddress' when 'type' is "unix"
>> >>      'data: VsockSocketAddress' when 'type' is "vsock"
>> >>      'data: String' when 'type' is "fd"
>> >>
>> >>      Since: 1.3
>> >>
>> >>
>> > I like both, to me they serve different purposes. I like to have a sho=
rt
>> > overview / signature and then a more detailed documentation for each
>> field.
>>
>> I sympathize with the argument.  Unfortunately, the "short" signatures
>> are anything but for real-world QAPI:
>>
>
> That's a worse case, a regular case is more readable.

There are readable cases, but there are plenty of cases that plainly
aren't.

102 out of 472 signatures don't count because they're empty.

Roughly half the non-empty signatures fit on a single line.  That's short.

A bit under a third take two lines.  I guess that's still short enough.

More than one in six signatures is three lines or more.

>                                                       And it is still
> useful anyway since the common members would be listed first.

Whatever comes first in signatures comes first in the table of members,
too.  The names are easier to spot there, because they're all on the
left.

Compare

 -- Simple Union: SocketAddress { 'type': str, 'data': 'type' =3D ['inet':
          InetSocketAddress, 'unix': UnixSocketAddress, 'vsock':
          VsockSocketAddress, 'fd': String] }

     Captures the address of a socket, which could also be a named file
     descriptor

     Since: 1.3

to

 -- Object: SocketAddress

     Captures the address of a socket, which could also be a named file
     descriptor

     Members:
     'type'
          One of "inet", "unix", "vsock", "fd"
     'data: InetSocketAddress' when 'type' is "inet"
     'data: UnixSocketAddress' when 'type' is "unix"
     'data: VsockSocketAddress' when 'type' is "vsock"
     'data: String' when 'type' is "fd"

     Since: 1.3

In my opinion, the three lines of signature add nothing but noise to the
six lines of member table.
