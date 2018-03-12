Received: from eggs.gnu.org ([2001:4830:134:3::10]:48859)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evVLt-0008Fy-FN
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:51:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1evVLs-0001PT-I3
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 17:51:29 -0400
References: <20180308184636.178534-1-vsementsov@virtuozzo.com>
	<20180308184636.178534-4-vsementsov@virtuozzo.com>
	<bc19fbc1-71b9-59cd-2556-3b388a886091@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <efa02563-7c61-9812-2487-90d2a6cb9f97@redhat.com>
Date: Mon, 12 Mar 2018 16:51:22 -0500
MIME-Version: 1.0
In-Reply-To: <bc19fbc1-71b9-59cd-2556-3b388a886091@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/5] nbd/server: fix: check client->closing
 before reply sending
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

On 03/09/2018 03:51 PM, Eric Blake wrote:
> On 03/08/2018 12:46 PM, Vladimir Sementsov-Ogievskiy wrote:

In the subject: s/reply sending/sending reply/

>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>
>> It's like an RFC. I'm not sure, but this place looks like a bug.=20
>> Shouldn't
>> we chack client-closing even before nbd_client_receive_next_request()=20
>> call?
>>

> Your RFC question is whether we can just check client->closing before=20
> checking ret, and skip nbd_client_receive_next_request() in that case=20
> (in other words, why even bother to queue up a coroutine that will do=20
> nothing, if we already know the client is going away).=C2=A0 And my ans=
wer is=20
> yes, I think that makes more sense.=C2=A0 So that would be:
>=20
> diff --git c/nbd/server.c w/nbd/server.c
> index 5f292064af0..b230ecb4fb8 100644
> --- c/nbd/server.c
> +++ w/nbd/server.c
> @@ -1543,14 +1543,6 @@ static coroutine_fn void nbd_trip(void *opaque)
>  =C2=A0=C2=A0=C2=A0=C2=A0 req =3D nbd_request_get(client);
>  =C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_co_receive_request(req, &request,=
 &local_err);
>  =C2=A0=C2=A0=C2=A0=C2=A0 client->recv_coroutine =3D NULL;
> -=C2=A0=C2=A0=C2=A0 nbd_client_receive_next_request(client);
> -=C2=A0=C2=A0=C2=A0 if (ret =3D=3D -EIO) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto disconnect;
> -=C2=A0=C2=A0=C2=A0 }
> -
> -=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto reply;
> -=C2=A0=C2=A0=C2=A0 }
>=20
>  =C2=A0=C2=A0=C2=A0=C2=A0 if (client->closing) {
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> @@ -1560,6 +1552,15 @@ static coroutine_fn void nbd_trip(void *opaque)
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto done;
>  =C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> +=C2=A0=C2=A0=C2=A0 nbd_client_receive_next_request(client);
> +=C2=A0=C2=A0=C2=A0 if (ret =3D=3D -EIO) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto disconnect;
> +=C2=A0=C2=A0=C2=A0 }
> +
> +=C2=A0=C2=A0=C2=A0 if (ret < 0) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto reply;
> +=C2=A0=C2=A0=C2=A0 }
> +
>  =C2=A0=C2=A0=C2=A0=C2=A0 switch (request.type) {
>  =C2=A0=C2=A0=C2=A0=C2=A0 case NBD_CMD_READ:
>  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* XXX: NBD Protocol =
only documents use of FUA with WRITE */
>=20
>=20
> Unless this revised form fails testing or gets any other review=20
> comments, I will go ahead and amend your commit in this manner.

I figured out why iotests were failing for an unrelated issue (thanks to=20
Max for recognizing the symptoms on IRC), and my changes still passed,=20
so I'm squashing them in as part of staging this series on my NBD queue.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
