Received: from eggs.gnu.org ([2001:4830:134:3::10]:47610)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1etu4b-0001aj-4U
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:51:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1etu4Z-0001rt-Rk
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 06:51:01 -0500
References: <20180305180433.106408-1-vsementsov@virtuozzo.com>
	<b8324efe-7fd4-3c44-faac-a7a9e9e1ad3e@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <321b88da-f282-0f14-aa23-2d7c72f9d493@virtuozzo.com>
Date: Thu, 8 Mar 2018 14:50:48 +0300
MIME-Version: 1.0
In-Reply-To: <b8324efe-7fd4-3c44-faac-a7a9e9e1ad3e@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] nbd/server: fix space read
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, den@openvz.org

05.03.2018 22:47, Eric Blake wrote:
> On 03/05/2018 12:04 PM, Vladimir Sementsov-Ogievskiy wrote:
>> In case of io error in nbd_co_send_sparse_read we should not
>> "goto reply:", as it is fatal error and common behavior is
>> disconnect in this case. We should not try to send client an
>> error reply, representing channel-io error on previous try to
>> send a reply.
>
> Good catch.
>
>>
>> Fix this by handle block-status error in nbd_co_send_sparse_read,
>> so nbd_co_send_sparse_read fails only on io error. Then just skip
>> common "reply:" code path in nbd_trip.
>>
>> Note: nbd_co_send_structured_error is moved without changes to be
>> called from nbd_co_send_sparse_read.
>
> Might be easier to read as two patches, one for the code motion, the=20
> other for using the new code.=C2=A0 But I'm not going to insist on a spli=
t.
>
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>
>> PS: this all shows that nbd_trip is tooo complex (and yes, I remember,
>> that its final semantics was made by myself :(.. It should be
>> refactored into several smaller parts. Do you have any ideas?
>>
>> The complexity here is that we should handle channel errors (fatal) and
>> export errors(non fatal) in different ways, and both of error types may
>> have errp, which should be handled differently too..
>>
>> May be, the best way is to make separate functions for each command,
>> avoiding code duplication by using helper-functions instead of common=20
>> code
>> in nbd_trip.
>
> Yes, splitting nbd_trip into smaller helper functions may be worthwhile.
>
>>
>> =C2=A0 nbd/server.c | 64=20
>> +++++++++++++++++++++++++++++++++++-------------------------
>> =C2=A0 1 file changed, 37 insertions(+), 27 deletions(-)
>>
>> diff --git a/nbd/server.c b/nbd/server.c
>> index 4990a5826e..ea6b9467e4 100644
>> --- a/nbd/server.c
>> +++ b/nbd/server.c
>> @@ -21,6 +21,7 @@
>> =C2=A0 #include "qapi/error.h"
>> =C2=A0 #include "trace.h"
>> =C2=A0 #include "nbd-internal.h"
>> +#include "qemu/error-report.h"
>
> I'm a bit worried about this one.=C2=A0 The server has previously not=20
> needed this, so it may be the wrong thing to pull it in now.
>
>
>> +
>> =C2=A0 static int coroutine_fn nbd_co_send_sparse_read(NBDClient *client=
,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ui=
nt64_t handle,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ui=
nt64_t offset,
>
> It doesn't help that we are lacking comments on the contract of this=20
> function.
>
>> @@ -1361,8 +1386,15 @@ static int coroutine_fn=20
>> nbd_co_send_sparse_read(NBDClient *client,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool final;
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (status=
 < 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r_setg_errno(errp, -status, "unable to check for=20
>> holes");
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn status;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 char=
 *msg =3D g_strdup_printf("unable to check for holes:=20
>> %s",
>> + strerror(-status));
>
> Indentation looks off.
>
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r_report("%s", msg);
>
> Do we really need to report this on the server's stderr, or is sending=20
> the reply to the client good enough?


I'm just trying to save current behavior in nbd_trip... Why not? Is it=20
fair that client knows about some strange io error on server-side, but=20
server logs lacks this information?

and it needs "qemu/error-report.h".. nbd_trip uses error_report_err=20
instead. error_report_err calls error_report anyway.

>
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =
=3D nbd_co_send_structured_error(client, handle,=20
>> -status, msg,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 errp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_fr=
ee(msg);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn ret;
>
> So if we have an early return here, then pre-patch, we were=20
> unconditionally setting errp and returning -1 (even if the client is=20
> still alive); post-patch errp is only set if we failed to do I/O with=20
> the client.=C2=A0 That change is right, but harder to see without comment=
s=20
> giving a function contract.
>
>> @@ -1567,7 +1575,7 @@ static coroutine_fn void nbd_trip(void *opaque)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 request.from, req->data,=20
>> request.len,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &local_err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 if (ret < 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto reply;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 goto replied;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 goto done;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> @@ -1664,6 +1672,8 @@ reply:
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 req->data, reply_data_len,=20
>> &local_err);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(msg);
>> +
>> +replied:
>
> This part makes sense.
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 error_prepend(&lo=
cal_err, "Failed to send reply: ");
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 goto disconnect;
>>
>


--=20
Best regards,
Vladimir
