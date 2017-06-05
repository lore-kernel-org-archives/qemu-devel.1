Received: from eggs.gnu.org ([2001:4830:134:3::10]:57505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dHoOg-0000UL-OD
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 05:34:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1dHoOb-0001mo-Rd
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 05:34:02 -0400
Received: from mail-ve1eur01on0100.outbound.protection.outlook.com
	([104.47.1.100]:48807
	helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vsementsov@virtuozzo.com>)
	id 1dHoOb-0001lL-5w
	for qemu-devel@nongnu.org; Mon, 05 Jun 2017 05:33:57 -0400
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Date: Mon, 5 Jun 2017 09:33:53 +0000
Message-ID: <e7fc4198-0ada-d3dc-59d8-d461f3493745@virtuozzo.com>
References: <20170530143052.165002-1-vsementsov@virtuozzo.com>
	<20170530143052.165002-16-vsementsov@virtuozzo.com>
	<eadf1060-4198-a5c4-f337-003a2ec0c917@redhat.com>
In-Reply-To: <eadf1060-4198-a5c4-f337-003a2ec0c917@redhat.com>
Content-Language: ru-RU
Content-Type: text/plain; charset="koi8-r"
Content-ID: <A3D5985587AD4E4D8C76C199EC32326A@virtuozzo.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: Re: [Qemu-devel] [PATCH 15/19] nbd/server: use errp instead of LOG
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "pbonzini@redhat.com" <pbonzini@redhat.com>, Denis Lunev <den@virtuozzo.com>



On 04.06.2017 00:46, Eric Blake wrote:
> On 05/30/2017 09:30 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Move to modern errp scheme from just LOGging errors.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>>   nbd/server.c | 257 ++++++++++++++++++++++++++++++++++-----------------=
--------
>>   1 file changed, 150 insertions(+), 107 deletions(-)
>>
>> @@ -143,30 +143,30 @@ static int nbd_negotiate_send_rep_len(QIOChannel *=
ioc, uint32_t type,
>>             type, opt, len);
>>  =20
>>       magic =3D cpu_to_be64(NBD_REP_MAGIC);
>> -    ret =3D write_sync(ioc, &magic, sizeof(magic), NULL);
>> +    ret =3D write_sync(ioc, &magic, sizeof(magic), errp);
>>       if (ret < 0) {
>> -        LOG("write failed (rep magic)");
>> +        error_prepend(errp, "write failed (rep magic): ");
>>           return ret;
>>       }
> I'm wondering how much we really want to use error_prepend(), or if we
> could just get away with using the original error message unchanged.
> I'm not saying to rewrite the patch now that you've done the work, so
> much as asking aloud whether the additional information in the error
> messages will prove useful.
>
> There are definitely some ripple effects from your v2 posting of the
> first half of the series that will require you to rebase this, but the
> overall idea is sound.

I've tried to save old messages as is (+ additional info)

>
>>   /* Send an error reply.
>>    * Return -errno on error, 0 on success. */
>> -static int GCC_FMT_ATTR(4, 5)
>> +static int GCC_FMT_ATTR(5, 6)
>>   nbd_negotiate_send_rep_err(QIOChannel *ioc, uint32_t type,
>> -                           uint32_t opt, const char *fmt, ...)
>> +                           uint32_t opt, Error **errp, const char *fmt,=
 ...)
> Having errp not be the last argument is unusual, but I don't see how you
> can do any differently with the var-args nature of the call.
>
>> @@ -505,26 +515,33 @@ static int nbd_negotiate_options(NBDClient *client=
)
>>                    * disconnecting, but that we must also tolerate
>>                    * guests that don't wait for our reply. */
>>                   ret =3D nbd_negotiate_send_rep(client->ioc, NBD_REP_AC=
K,
>> -                                             clientflags);
>> -                return ret < 0 && ret !=3D -EPIPE ? ret : 1;
>> +                                             clientflags, &local_err);
>> +
>> +                if (ret < 0 && ret !=3D -EPIPE) {
>> +                    error_propagate(errp, local_err);
>> +                    return ret;
>> +                }
>> +
>> +                error_free(local_err);
>> +                return 1;
> Of course, you'll have to simplify this portion.  This is probably the
> one place where you actually DO want to use:
>
> nbd_negotiate_send_rep(client->ioc, NBD_REP_ACK,
>                         clientflags, NULL)
>
> because you truly do not care whether you had an error.
>
>> @@ -1090,18 +1113,18 @@ static int nbd_co_receive_request(NBDRequestData=
 *req, NBDRequest *request)
>>  =20
>>       /* Sanity checks, part 2. */
>>       if (request->from + request->len > client->exp->size) {
>> -        LOG("operation past EOF; From: %" PRIu64 ", Len: %" PRIu32
>> -            ", Size: %" PRIu64, request->from, request->len,
>> -            (uint64_t)client->exp->size);
>> +        error_setg(errp, "operation past EOF; From: %" PRIu64 ", Len: %=
" PRIu32
>> +                   ", Size: %" PRIu64, request->from, request->len,
>> +                   (uint64_t)client->exp->size);
>>           return request->type =3D=3D NBD_CMD_WRITE ? -ENOSPC : -EINVAL;
> Question - now that we are consistently setting a decent errp, do we
> have any callers that care about specific -errno return values, or could
> we further simplify the functions by just returning -1 (instead of
> worrying about -errno) on failures?

I think it is not bad to have informative error codes.. Example is=20
previous discussion about EPIPE.

>
>
>> @@ -1244,21 +1268,33 @@ static coroutine_fn void nbd_trip(void *opaque)
>>  =20
>>   reply:
>> +    if (local_err) {
>> +        error_report_err(local_err);
>> +        local_err =3D NULL;
>> +    }
> This says that after we detect an error, we report it,
>
>> +
>> +    if (nbd_co_send_reply(req, &reply, reply_data_len) < 0) {
>> +        error_setg(&local_err, "Failed to send reply");
>> +        goto disconnect;
>> +    }
> ...but then blindly try to send the reply anyways, forgetting that we
> ever detected the original error.  Is that going to bite us?

Reported error is blk_* error, which should be returned to client. But I=20
think it is not bad to report is on server too (and this corresponds to=20
the old behavior). Creating extra "Error *blk_err" may help.

>

--=20
Best regards,
Vladimir.
