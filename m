Received: from eggs.gnu.org ([2001:4830:134:3::10]:55131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1euN3k-0005sa-CE
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:48:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1euN3j-0003Vp-B8
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 13:48:04 -0500
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-7-git-send-email-vsementsov@virtuozzo.com>
	<b570a199-9139-5652-5ad8-407820680620@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <90a94d99-17c2-00ea-fd11-8a9ebbdebb6c@virtuozzo.com>
Date: Fri, 9 Mar 2018 21:47:50 +0300
MIME-Version: 1.0
In-Reply-To: <b570a199-9139-5652-5ad8-407820680620@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 6/9] nbd: BLOCK_STATUS for standard
 get_block_status function: client part
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: mreitz@redhat.com, kwolf@redhat.com, pbonzini@redhat.com, den@openvz.org

16.02.2018 23:40, Eric Blake wrote:
> On 02/15/2018 07:51 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Minimal realization: only one extent in server answer is supported.
>> Flag NBD_CMD_FLAG_REQ_ONE is used to force this behavior.

[...]

>> +=C2=A0=C2=A0=C2=A0 memcpy(extent, payload, sizeof(*extent));
>> +=C2=A0=C2=A0=C2=A0 be32_to_cpus(&extent->length);
>> +=C2=A0=C2=A0=C2=A0 be32_to_cpus(&extent->flags);
>
> Instead of doing a memcpy() and then in-place bit-swizzling, you could=20
> do the swapping as part of assignment, for one less function call (and=20
> make the code a bit easier to extend, if we later drop our REQ_ONE=20
> limitation on only having one extent, because you'll advance payload=20
> as needed):
>
> extent->length =3D payload_advance32(&payload);
> extent->flags =3D payload_advance32(&payload);

Aha, yes. The funny thing is that these are my own helpers.

>
> We should probably validate that the length field is a multiple of=20
> min_block (if a server tells us that all operations must be 512-byte=20
> aligned, then reports an extent that is smaller than 512 bytes, we=20
> have no way to ask for the status of the second half of the sector).=20
> Probably also something that needs to be explicitly stated in the NBD=20
> spec. [1]
>
>> +
>> +=C2=A0=C2=A0=C2=A0 if (extent->length > orig_length) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_setg(errp, "Protocol e=
rror: server sent chunk=20
>> exceeding requested"
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 " region");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>
> That matches the current spec wording, but I'm not sure I agree with=20
> it - what's wrong with a server providing a final extent that extends=20
> beyond the request, if the information was already available for free=20
> (the classic example: if the server never replies with HOLE or ZERO,=20
> then the entire file has the same status, so all requests could=20
> trivially be replied to by taking the starting offset to the end of=20
> the file as the returned length, rather than just clamping at the=20
> requested length).

Maybe. But our already released clients not prepared to such change =3D(

But, on the other hand, this gives us possibility to understand, the the=20
whole target (for backup/mirror) is zero in one request, skipping=20
target-zeroing loop by 4gb chunks.. What about adding such possibility=20
with an additionally negotiated option or something like this? (and=20
don't we now have same possibility with something like INFO?)

>
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return 0;
>> +}
>> +
>> =C2=A0 /* nbd_parse_error_payload
>> =C2=A0=C2=A0 * on success @errp contains message describing nbd error re=
ply
>> =C2=A0=C2=A0 */

--=20
Best regards,
Vladimir
