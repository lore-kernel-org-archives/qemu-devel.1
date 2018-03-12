Received: from eggs.gnu.org ([2001:4830:134:3::10]:56848)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evK46-0001B4-HD
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:48:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evK45-0003VR-LC
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:48:22 -0400
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-7-git-send-email-vsementsov@virtuozzo.com>
	<b570a199-9139-5652-5ad8-407820680620@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <5794d630-c4ba-a691-60a1-6e568e9663e8@virtuozzo.com>
Date: Mon, 12 Mar 2018 12:48:07 +0300
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
>>
>> Tests 140, 147 and 205 are fixed due to now server failed on searching
>> export in context of NBD_OPT_SET_META_CONTEXT option negotiation.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>

[...]

>> =C2=A0 void nbd_client_detach_aio_context(BlockDriverState *bs)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 NBDClientSession *client =3D nbd_get_clie=
nt_session(bs);
>> @@ -828,6 +966,7 @@ int nbd_client_init(BlockDriverState *bs,
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 client->info.request_sizes =3D tru=
e;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 client->info.structured_reply =3D true;
>> +=C2=A0=C2=A0=C2=A0 client->info.base_allocation =3D true;
>
> Hmm - the combination structured_reply =3D false and base_allocation =3D=
=20
> true is bogus.=C2=A0 Then again, these two fields are in-out; left false=
=20
> when handing over to the kernel NBD transmission phase (since the=20
> kernel module does not yet support structured replies let alone block=20
> status), and true when requested with qemu as the transmission driver=20
> (since we want to use it if available).=C2=A0 I don't know if having a=20
> single tri-state enum is any better than two bools (on input, it is=20
> either all-or-none; on output, it is either none (old server),=20
> structured reads only (qemu 2.11 server, for example), or all (this=20
> series' server).
>


ohh, sorry for replying in so many emails.

about this: I'd prefer to leave it as is, and rethink (if needed) when=20
implementing dirty-bitmaps context, because it's now obvious now, how it=20
will be refactored for dirty bitmaps.



--=20
Best regards,
Vladimir
