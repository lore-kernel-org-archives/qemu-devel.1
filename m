Received: from eggs.gnu.org ([2001:4830:134:3::10]:32999)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fW1zk-0004WC-4h
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fW1zh-0000Dw-1C
	for qemu-devel@nongnu.org; Thu, 21 Jun 2018 11:59:36 -0400
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
	<20180609151758.17343-7-vsementsov@virtuozzo.com>
	<be6cae77-ed51-320f-8a86-fda7865c84b0@redhat.com>
	<4f1dd453-77a4-f45f-f2c9-15d42e95d429@virtuozzo.com>
	<5b4d2ffa-3489-6a93-0352-dbce9221519d@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <43ed9c89-4730-d333-51ff-2befd03d5462@virtuozzo.com>
Date: Thu, 21 Jun 2018 18:59:25 +0300
MIME-Version: 1.0
In-Reply-To: <5b4d2ffa-3489-6a93-0352-dbce9221519d@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v5 6/6] docs/interop: add
 nbd.txt
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org, armbru@redhat.com, mreitz@redhat.com

20.06.2018 23:58, John Snow wrote:
>
> On 06/20/2018 10:16 AM, Vladimir Sementsov-Ogievskiy wrote:
>> 20.06.2018 14:33, Eric Blake wrote:
>>> On 06/09/2018 10:17 AM, Vladimir Sementsov-Ogievskiy wrote:
>>>> Describe new metadata namespace: "qemu".
>>>>
>>>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>>> ---
>>>>  =C2=A0 docs/interop/nbd.txt | 37 ++++++++++++++++++++++++++++++++++++=
+
>>>>  =C2=A0 MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0 1 +
>>>>  =C2=A0 2 files changed, 38 insertions(+)
>>>>  =C2=A0 create mode 100644 docs/interop/nbd.txt
>>>>
>>>> diff --git a/docs/interop/nbd.txt b/docs/interop/nbd.txt
>>>> new file mode 100644
>>>> index 0000000000..7366269fc0
>>>> --- /dev/null
>>>> +++ b/docs/interop/nbd.txt
>>>> @@ -0,0 +1,37 @@
>>>> +Qemu supports NBD protocol, and has internal NBD client (look at
>>> s/supports/supports the/
>>>
>>>> +block/nbd.c), internal NBD server (look at blockdev-nbd.c) as well as
>>> s/internal/an internal/2
>>>
>>>> +external NBD server tool - qemu-nbd.c. The common code is placed in
>>> s/external/an external/
>>>
>>>> +nbd/*.
>>>> +
>>>> +NBD protocol is specified here:
>>> s/NBD/The NBD/
>>>
>>>> +https://github.com/NetworkBlockDevice/nbd/blob/master/doc/proto.md
>>>> +
>>>> +This following paragraphs describe some specific properties of NBD
>>>> +protocol realization in Qemu.
>>>> +
>>>> +
>>>> +=3D Metadata namespaces =3D
>>>> +
>>>> +Qemu supports "base:allocation" metadata context as defined in the NB=
D
>>> s/supports/supports the/
>>>
>>>> +protocol specification and defines own metadata namespace: "qemu".
>>> s/own/an additional/
>>>
>>>> +
>>>> +
>>>> +=3D=3D "qemu" namespace =3D=3D
>>>> +
>>>> +For now, the only type of metadata context in the namespace is dirty
>>>> +bitmap. All available metadata contexts have the following form:
>>> maybe:
>>>
>>> The "qemu" namespace currently contains only one type of context,
>>> related to exposing the contents of a dirty bitmap alongside the
>>> associated disk contents.=C2=A0 The available metadata context has the
>>> following form:
>> Ok
>>
>>>> +
>>>> +=C2=A0=C2=A0 qemu:dirty-bitmap:<dirty-bitmap-export-name>
>>>> +
>>>> +Each dirty-bitmap metadata context defines the only one flag for
>>>> +extents in reply for NBD_CMD_BLOCK_STATUS:
>>>> +
>>>> +=C2=A0=C2=A0=C2=A0 bit 0: NBD_STATE_DIRTY, means that the extent is "=
dirty"
>>>> +
>>>> +For NBD_OPT_LIST_META_CONTEXT the following queries are supported
>>>> +additionally to "qemu:dirty-bitmap:<dirty-bitmap-export-name>":
>>> s/additionally/in addition/
>>>
>>>> +
>>>> +* "qemu:" : returns list of all available metadata contexts in the
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 na=
mespace.
>>>> +* "qemu:dirty-bitmap:" : returns list of all available dirty-bitmap
>>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 metadata contexts.
>>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>>> index e187b1f18f..887b479440 100644
>>>> --- a/MAINTAINERS
>>>> +++ b/MAINTAINERS
>>>> @@ -1923,6 +1923,7 @@ F: nbd/
>>>>  =C2=A0 F: include/block/nbd*
>>>>  =C2=A0 F: qemu-nbd.*
>>>>  =C2=A0 F: blockdev-nbd.c
>>>> +F: docs/interop/nbd.txt
>>>>  =C2=A0 T: git git://repo.or.cz/qemu/ericb.git nbd
>>>>  =C2=A0 =C2=A0 NFS
>>>>
>>> Reviewed-by: Eric Blake <eblake@redhat.com>
>>>
>>> At this point, I think I'll touch up the issues I've spotted and
>>> submit a pull request, in order to make it easier for me to test my
>>> libvirt code.
>>>
>> Ok, thank you!
>>
> ACK; the x- prefixes will help us get everything rolling together much
> faster and gives us some leeway to change things later as needed.
>
> Vladimir, can you jog our memories and let us know which series still
> need to hit QEMU for 3.0 for safe persistence/migration et al?
>
> (Not including any of my own qemu-img patches which I'll get to by freeze=
.)

not a trivial question :)

at least, there are the following pending patches:

migration
 =C2=A0=C2=A0 [PATCH] migration: invalidate cache before source start

persistance
 =C2=A0=C2=A0 [PATCH v2] qcow2: add overlap check for bitmap directory
 =C2=A0=C2=A0 [PATCH] block/qcow2: fix logic around dirty_bitmaps_loaded
 =C2=A0=C2=A0 thread "bug in reopen arch", there is no final solution for n=
ow
 =C2=A0=C2=A0 also, I need to finally rethink and make a patch to don't hav=
e any=20
persistent bitmaps in inactive mode

fleecing
 =C2=A0=C2=A0 [PATCH] block/fleecing-filter: new filter driver for fleecing=
 (new=20
patch, but I remember, I've already started to discuss this..)

--=20
Best regards,
Vladimir
