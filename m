Received: from eggs.gnu.org ([2001:4830:134:3::10]:48392)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fps2V-0006I1-8T
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 05:24:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fps2F-0008OE-AF
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 05:24:24 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
References: <20180530003550.21531-1-eblake@redhat.com>
	<40c5a402-9137-aff7-2622-85ab62b5fa36@virtuozzo.com>
Message-ID: <085ca5bd-a90b-4e3a-27db-0563858c77bf@virtuozzo.com>
Date: Wed, 15 Aug 2018 12:23:46 +0300
MIME-Version: 1.0
In-Reply-To: <40c5a402-9137-aff7-2622-85ab62b5fa36@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] doc: Permit BLOCK_STATUS reply to extend
 beyond request
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, nbd@other.debian.org
Cc: w@uter.be, Paolo Bonzini <pbonzini@redhat.com>, Alex Bligh <alex@alex.org.uk>, qemu-devel <qemu-devel@nongnu.org>, qemu block <qemu-block@nongnu.org>

ping.

Finally, Qemu 3.0 released, and it is incompatible with current NBD=20
protocol. Please, commit this patch.

13.08.2018 15:02, Vladimir Sementsov-Ogievskiy wrote:
> ping
>
> Qemu 3.0 is near to release, and it is not correspond to current=20
> version of spec, it corresponds to this patch. Can we push it?
>
> 30.05.2018 03:35, Eric Blake wrote:
>> When the NBD_CMD_BLOCK_STATUS extension was first discussed, the
>> idea of having the client's length be a hint was proposed, where
>> the server could reply beyond the client's request in order to
>> allow for fewer transactions when querying the entire disk. The
>> portion beyond the client's original request can only occur in
>> the final extent for a given context, and only if the additional
>> length matches the type given for the last byte actually requested
>> by the client.
>>
>> In the meantime, qemu 2.12 was released as a first client
>> implementation of NBD_CMD_BLOCK_STATUS, which always sends the
>> NBD_CMD_FLAG_REQ_ONE flag, and which disconnects from the server
>> if the server's length exceeds the client request.=C2=A0 This was
>> relaxed for subsequent qemu, but it means that we have to be
>> explicit that a server should not send extra length except when
>> the client is not limiting its request to exactly one extent.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>>
>> I brought this topic up a few days back, but realized I never
>> actually posted a patch to go along with it.
>>
>> =C2=A0 doc/proto.md | 25 ++++++++++++++++++-------
>> =C2=A0 1 file changed, 18 insertions(+), 7 deletions(-)
>>
>> diff --git a/doc/proto.md b/doc/proto.md
>> index 4b73e0b..bd5f61e 100644
>> --- a/doc/proto.md
>> +++ b/doc/proto.md
>> @@ -1709,8 +1709,8 @@ MUST initiate a hard disconnect.
>>
>> =C2=A0=C2=A0=C2=A0 *length* MUST be 4 + (a positive integer multiple of =
8). This reply
>> =C2=A0=C2=A0=C2=A0 represents a series of consecutive block descriptors =
where the sum
>> -=C2=A0 of the length fields within the descriptors MUST not be greater =
than
>> -=C2=A0 the length of the original request. This chunk type MUST appear
>> +=C2=A0 of the length fields within the descriptors are subject to furth=
er
>> +=C2=A0 constraints documented below. This chunk type MUST appear
>> =C2=A0=C2=A0=C2=A0 exactly once per metadata ID in a structured reply.
>>
>> =C2=A0=C2=A0=C2=A0 The payload starts with:
>> @@ -1725,7 +1725,14 @@ MUST initiate a hard disconnect.
>> =C2=A0=C2=A0=C2=A0 32 bits, status flags
>>
>> =C2=A0=C2=A0=C2=A0 If the client used the `NBD_CMD_FLAG_REQ_ONE` flag in=
 the request,
>> -=C2=A0 then every reply chunk MUST NOT contain more than one descriptor=
.
>> +=C2=A0 then every reply chunk MUST NOT contain more than one descriptor=
,
>> +=C2=A0 and the descriptor MUST NOT exceed the *length* of the request.
>> +=C2=A0 Otherwise, when the server returns N extents for a given context=
,
>> +=C2=A0 the sum of the *length* fields of the first N-1 extents MUST be
>> +=C2=A0 smaller than the overall *length* of the client's request, but t=
he
>> +=C2=A0 final extent MAY exceed the requested length if the server has t=
hat
>> +=C2=A0 information anyway as a side effect of reporting the status of t=
he
>> +=C2=A0 requested region.
>>
>> =C2=A0=C2=A0=C2=A0 Even if the client did not use the `NBD_CMD_FLAG_REQ_=
ONE` flag in
>> =C2=A0=C2=A0=C2=A0 its request, the server MAY return fewer descriptors =
in the reply
>> @@ -2037,10 +2044,14 @@ The following request types exist:
>>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 The list of block status descriptors with=
in the
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 `NBD_REPLY_TYPE_BLOCK_STATUS` chunk repre=
sent consecutive portions
>> -=C2=A0=C2=A0=C2=A0 of the file starting from specified *offset*, and th=
e sum of the
>> -=C2=A0=C2=A0=C2=A0 *length* fields of each descriptor MUST not be great=
er than the
>> -=C2=A0=C2=A0=C2=A0 overall *length* of the request. This means that the=
 server MAY
>> -=C2=A0=C2=A0=C2=A0 return less data than required. However the server M=
UST return at
>> +=C2=A0=C2=A0=C2=A0 of the file starting from specified *offset*.=C2=A0 =
If the client used
>> +=C2=A0=C2=A0=C2=A0 the `NBD_CMD_FLAG_REQ_ONE` flag, each chunk contains=
 exactly one
>> +=C2=A0=C2=A0=C2=A0 descriptor where the *length* of the descriptor MUST=
 NOT be greater
>> +=C2=A0=C2=A0=C2=A0 than the *length* of the request; otherwise, a chunk=
 MAY contain
>> +=C2=A0=C2=A0=C2=A0 multiple descriptors, and the final descriptor MAY e=
xtend beyond
>> +=C2=A0=C2=A0=C2=A0 the original requested size if the server can determ=
ine a larger
>> +=C2=A0=C2=A0=C2=A0 length without additional effort.=C2=A0 On the other=
 hand, the server=20
>> MAY
>> +=C2=A0=C2=A0=C2=A0 return less data than requested. However the server =
MUST return at
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 least one status descriptor (and since ea=
ch status descriptor has
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 a non-zero length, a client can always ma=
ke progress on a
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 successful return).=C2=A0 The server SHOU=
LD use different *status*
>
>


--=20
Best regards,
Vladimir
