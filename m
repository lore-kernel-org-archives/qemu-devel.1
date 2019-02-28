Received: from eggs.gnu.org ([209.51.188.92]:38588)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzM07-0005xU-8z
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 08:45:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gzM02-00077R-SQ
	for qemu-devel@nongnu.org; Thu, 28 Feb 2019 08:45:24 -0500
References: <20190223002209.23084-1-jsnow@redhat.com>
	<20190223002209.23084-2-jsnow@redhat.com>
	<5678ed17-fda7-4083-b4c6-488b3d6f916d@virtuozzo.com>
	<86bbc4f0-288b-4b3a-1f6a-cb3de29d80f4@virtuozzo.com>
	<fb9fc496-02f7-5724-06fd-fc4dcfc2b9c9@redhat.com>
	<8337ab64-9bf2-6990-be87-731fd92fe043@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <537c57d3-abb8-567b-3ee0-09c4ded81ad1@redhat.com>
Date: Thu, 28 Feb 2019 07:44:56 -0600
MIME-Version: 1.0
In-Reply-To: <8337ab64-9bf2-6990-be87-731fd92fe043@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/4] block/dirty-bitmaps: add
 inconsistent bit
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, John Snow <jsnow@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>, Juan Quintela <quintela@redhat.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

On 2/28/19 4:13 AM, Vladimir Sementsov-Ogievskiy wrote:

>>>>> +++ b/qapi/block-core.json
>>>>> @@ -470,12 +470,16 @@
>>>>>  =C2=A0 # @persistent: true if the bitmap will eventually be flushe=
d to persistent
>>>>>  =C2=A0 #=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 storage (since 4.0)
>>>
>>> so, bitmap can't be inconsistent and persistent, as we don't want to =
flush
>>> inconsistent bitmaps...
>>>
>>
>> I think ideally I'd just change this phrasing to say something like
>> "true if the bitmap is stored on-disk, or is scheduled to be flushed t=
o
>> disk."
>=20
> And such wording leads to immediate question: why it could be stored on=
 disk but
> _not_ scheduled to be flushed..
>=20
> So if you want, more honest is something like "true if bitmap will be f=
lushed to
> storage or if it is @inconsistent (read ahead)." but it's not looking n=
ice...
>=20
> May be something like this?
>=20
> true if bitmap is marked to be flushed to persistent storage. Bitmap ma=
y or may not
> already persist in the storage. Also true if bitmap persist in the stor=
age but
> considered inconsistent, in which case it will not be flushed and only =
may be removed,
> look at @inconsistent field description.

Too long. As @inconsistent is rare, I'd be happy with just:

@persistent: true if the bitmap is marked for association with
persistent storage

which covers both future flushes (for a bitmap that is not yet on disk,
but will get there later) and prior inconsistent images (where we
learned that it was inconsistent because of its existing associate with
persistent storage).

>=20
> Another thing: what about migration? I don't think we are going to teac=
h migration protocol
> to migrate them. So, migration is a way to get rid of inconsistent bitm=
aps? Or what? Or
> we should restrict migration, if there are any inconsistent bitmap, to =
force user to remove
> them first?

A conservative approach is to start by treating an inconsistent bitmap
as a migration blocker, and could be relaxed later if someone has an
argument for why making migration a backdoor for deletion of
inconsistent bitmaps is a good thing.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org
