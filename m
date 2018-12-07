Received: from eggs.gnu.org ([2001:4830:134:3::10]:57104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVJTm-0000Bd-7M
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:59:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gVJTj-0006cL-Hs
	for qemu-devel@nongnu.org; Fri, 07 Dec 2018 11:59:53 -0500
References: <20181130220344.3350618-1-eblake@redhat.com>
	<20181130220344.3350618-14-eblake@redhat.com>
	<1827042e-ddf6-47cd-52b3-403e37c7fa1f@virtuozzo.com>
	<ce5520fd-11bf-e927-49c9-1e8422d053f3@redhat.com>
	<c108cdc2-a382-d6da-85c4-468f90bc2b86@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <77a23d5f-6299-3971-129c-5ed5df71b410@redhat.com>
Date: Fri, 7 Dec 2018 10:59:38 -0600
MIME-Version: 1.0
In-Reply-To: <c108cdc2-a382-d6da-85c4-468f90bc2b86@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 13/14] qemu-nbd: Add --list option
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "jsnow@redhat.com" <jsnow@redhat.com>, "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

On 12/7/18 10:49 AM, Vladimir Sementsov-Ogievskiy wrote:

>>>> $ qemu-nbd -L
>>>> exports available: 1
>>>>  =C2=A0=C2=A0 export: ''
>>>>  =C2=A0=C2=A0=C2=A0 size:=C2=A0 65536
>>>>  =C2=A0=C2=A0=C2=A0 flags: 0x4ed ( flush fua trim zeroes df cache )
>>>>  =C2=A0=C2=A0=C2=A0 min block: 512
>>>>  =C2=A0=C2=A0=C2=A0 opt block: 4096
>>>>  =C2=A0=C2=A0=C2=A0 max block: 33554432
>>>>  =C2=A0=C2=A0=C2=A0 available meta contexts: 1
>>>>  =C2=A0=C2=A0=C2=A0=C2=A0 base:allocation
>>>
>>> don't you plan to bind this all to QAPI and expose in json?
>>
>> No. As explained above, QAPI is very much centered on per-BDS actions,=
 while this action is a per-server action (where many servers have only o=
ne export, but it is also possible to have a server with 0 exports or a p=
lurality of exports).=C2=A0 I _can't_ fit this into query-block's ImageIn=
fo details about a block device, because we don't have a way of stating '=
connect to this arbitrary server, create an unspecified number of block d=
evices, tell me about each of them, and then throw them all away because =
we only wanted the info about what the server made available'. The same i=
s true for gluster or other remote access block devices - the QMP command=
s pre-suppose you already know WHICH specific resource you are accessing,=
 rather than providing a way for you to query the remote server about ALL=
 resources available but without actually selecting those resources.
>>
>> I'm open to ideas about a new QMP command to do such a query, but who =
would be the client?=C2=A0 A management app that wants to hotplug a new N=
BD device to a running guest can run 'qemu-nbd --list' just as easily as =
they could run a new QMP command to learn what the server is offering. Wi=
thout a strong reason of a client that would need this in QMP, I don't se=
e the point in adding it to the qemu binary.
>=20
> I didn't mean QMP. For example, QAPI struct ImageCheck is used only in =
qemu-img, to format output.
> Anyway, creating a struct in QAPI for something we want to export is a =
good thing, I think.

Oh, I see where you're going with this. Just as 'qemu-img info' has=20
routines to pretty-print a QAPI structure (and thus adding ImageInfo to=20
the .json files automatically gets output in HMP without any additional=20
work), you're suggesting that NBDExportInfo be converted into a QAPI=20
struct, even if it won't be tied to QMP, in order to make the output=20
more programmatic instead of manual effort.  I'll have to play with=20
that, although it might be a separate series on top of this.

> Also, if, as you said, some management app wants to query this informat=
ion, again strictly
> defined data + json output should be a good option. And, if there would=
 be such users, we'll
> need to track compatibility of exported structure between qemu versions=
 and this is easier
> with QAPI defined structure.
>=20
> And then, defined structure may be then (at least partly) shared with I=
mageInfoSpecificNBD.
>=20
> And if we will need at some point a qmp command like query-nbd-server, =
to get same information through
> current qmp-connection, not running additional nbd-client, it would be =
a simple thing to do.

If we ever need future extensions, we'll want to have QAPI structs in=20
place. But whether we implement the QAPI structs now, or at the time of=20
the future extension, is an engineering tradeoff (how much technical=20
debt are we incurring by not doing it now; and how likely are we to ever=20
want the future extension).

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
