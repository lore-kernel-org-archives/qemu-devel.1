Received: from eggs.gnu.org ([2001:4830:134:3::10]:47318)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZNdg-0004g2-Cw
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 17:14:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gZNdf-00057m-4r
	for qemu-devel@nongnu.org; Tue, 18 Dec 2018 17:14:56 -0500
References: <20181102151152.288399-1-vsementsov@virtuozzo.com>
	<20181102151152.288399-4-vsementsov@virtuozzo.com>
	<48002129-16ef-f0ad-2701-893fc88ecdd0@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1f4b1812-48c0-2ad6-cddc-0f3c09cb1fb2@redhat.com>
Date: Tue, 18 Dec 2018 16:14:45 -0600
MIME-Version: 1.0
In-Reply-To: <48002129-16ef-f0ad-2701-893fc88ecdd0@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 3/3] block/nbd-client: use traces instead
 of noisy error_report_err
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: kwolf@redhat.com, armbru@redhat.com, mdroth@linux.vnet.ibm.com, mreitz@redhat.com, den@openvz.org, pbonzini@redhat.com

On 12/18/18 3:23 PM, Eric Blake wrote:
> On 11/2/18 10:11 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Reduce extra noise of nbd-client, change 083 correspondingly.
>=20
> This says what, but not why. The details from the cover letter are=20
> important to include here, namely:
>=20
>> It was discussed, that error messages, produced by error_reprt_err's,
>> added in f140e300 are
>> 1. not really needed
>> 2. subject to race conditions
>>
>> And it was decided to drop them (switch to trace-points), look thread
>> https://lists.gnu.org/archive/html/qemu-devel/2018-08/msg00833.html
>>
>> So, I've also dropped error_report_err, added earlier in be41c100c0d
>> and later in 78a33ab5878.
>=20

>> @@ -79,7 +81,9 @@ static coroutine_fn void nbd_read_reply_entry(void=20
>> *opaque)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 assert(s->reply=
.handle =3D=3D 0);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_rec=
eive_reply(s->ioc, &s->reply, &local_err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (local_err) =
{
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 er=
ror_report_err(local_err);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tr=
ace_nbd_read_reply_entry_fail(ret,=20
>> error_get_pretty(local_err),
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_get_hint(local_err)=20
>> ?: "");
>=20
> I'm not sold on the error hint being useful in the trace message.=C2=A0=
 For=20
> that matter, even error_get_pretty() seems like it might be rather verb=
ose.
>=20
> I do see why you are trying it, though: in nbd/client.c,=20
> nbd_handle_reply_err(), we have:

Actually, on looking further, the ONLY use of error_append_hint() in=20
nbd/client.c is when handling NBD_OPT_ which is synchronous when first=20
establishing the connection; but all of the additions of trace_nbd_*=20
calls in this file occur during transmission phase, where we don't have=20
any hints appended.  I could NOT trigger any error path where a hint=20
would be present in the first place (although I will admit that I may=20
have missed a spot in my tracing).

> But instead of trying to make all the tracepoints in block/nbd-client.c=
=20
> extract this information, we could just improve nbd/client.c to have a=20
> tracepoint for any server-received error message at the same point wher=
e=20
> it calls error_append_hint().
>=20

This part is still true, even if it is no longer relevant to this patch.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org
