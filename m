Received: from eggs.gnu.org ([2001:4830:134:3::10]:57226)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erStJ-0006W2-ML
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 13:25:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erStI-0000om-Qn
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 13:25:17 -0500
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<20180226165723.17818-1-eblake@redhat.com>
	<20180226165723.17818-3-eblake@redhat.com>
	<0d8f572a-b099-75f9-c161-09226564a4aa@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <271c677b-901f-fe44-e02f-e196cf28c2d9@redhat.com>
Date: Thu, 1 Mar 2018 12:25:08 -0600
MIME-Version: 1.0
In-Reply-To: <0d8f572a-b099-75f9-c161-09226564a4aa@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/2] nbd/client: fix error messages in
 nbd_handle_reply_err
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "open list:Network Block Dev..." <qemu-block@nongnu.org>

On 03/01/2018 06:10 AM, Vladimir Sementsov-Ogievskiy wrote:
> 26.02.2018 19:57, Eric Blake wrote:
>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> 1. NBD_REP_ERR_INVALID is not only about length, so, make message more
>> =C2=A0=C2=A0=C2=A0 general
>>
>> 2. hex format is not very good: it's hard to read something like
>> =C2=A0=C2=A0=C2=A0 "option a (set meta context)", so switch to dec.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> Message-Id: <1518702707-7077-6-git-send-email-vsementsov@virtuozzo.com=
>
>> [eblake: expand scope of patch: ALL uses of nbd_opt_lookup are now
>> decimal, all uses of nbd_rep_lookup are prefixed hex]
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> one thought: isn't it better to have all NBD constants in dec, like in=20
> spec?

Sure, I can make that change.

>> @@ -378,8 +378,8 @@ static int nbd_opt_go(QIOChannel *ioc, const char=20
>> *wantname,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 return 1;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (reply.type =
!=3D NBD_REP_INFO) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
ror_setg(errp, "unexpected reply type %" PRIx32
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " (%s), e=
xpected %x",
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
ror_setg(errp, "unexpected reply type 0x%" PRIx32
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 " (%s), e=
xpected 0x%x",
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
reply.type, nbd_rep_lookup(reply.type),=20
>> NBD_REP_INFO);

That is, I'll respin with this and other nbd_rep_lookup()s using decimal=20
output.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
