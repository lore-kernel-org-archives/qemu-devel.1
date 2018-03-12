Received: from eggs.gnu.org ([2001:4830:134:3::10]:52270)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evJgH-0006UN-Ar
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:23:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1evJgG-00011Z-Dd
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 05:23:45 -0400
References: <1518702707-7077-1-git-send-email-vsementsov@virtuozzo.com>
	<1518702707-7077-7-git-send-email-vsementsov@virtuozzo.com>
	<b570a199-9139-5652-5ad8-407820680620@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <1eb5421b-eed4-25a3-cf39-6f1b8eb7e75c@virtuozzo.com>
Date: Mon, 12 Mar 2018 12:23:25 +0300
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

>
>> +++ b/nbd/client.c
>> @@ -594,6 +594,108 @@ static QIOChannel=20
>> *nbd_receive_starttls(QIOChannel *ioc,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return QIO_CHANNEL(tioc);
>> =C2=A0 }
>> =C2=A0 +/* nbd_negotiate_simple_meta_context:
>> + * Set one meta context. Simple means that reply must contain zero (not
>> + * negotiated) or one (negotiated) contexts. More contexts would be=20
>> considered
>> + * as a protocol error.
>> + * return 1 for successful negotiation, context_id is set
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0 if operation is unsuppor=
ted,
>> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -errno with errp set for a=
ny other error
>> + */
>
> Good enough for our first use.=C2=A0 Will obviously need improvements if =
we=20
> support base:allocation AND dirty bitmap exposure at the same time, in=20
> future patches ;)
>
>> +static int nbd_negotiate_simple_meta_context(QIOChannel *ioc,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *export,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const char *context,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t *context_id,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 int ret;
>> +=C2=A0=C2=A0=C2=A0 NBDOptionReply reply;
>> +=C2=A0=C2=A0=C2=A0 uint32_t received_id;
>> +=C2=A0=C2=A0=C2=A0 bool received;
>> +=C2=A0=C2=A0=C2=A0 size_t export_len =3D strlen(export);
>> +=C2=A0=C2=A0=C2=A0 size_t context_len =3D strlen(context);
>> +=C2=A0=C2=A0=C2=A0 size_t data_len =3D 4 + export_len + 4 + 4 + context=
_len;

[...]

> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nbd_read(ioc, &received_=
id, sizeof(received_id), errp) <=20
>> 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn -EIO;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 be32_to_cpus(&received_id);
>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 len =3D reply.length - sizeo=
f(received_id);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name =3D g_malloc(len + 1);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (nbd_read(ioc, name, len,=
 errp) < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_fr=
ee(name);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 retu=
rn -EIO;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name[len] =3D '\0';
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (strcmp(context, name)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 erro=
r_setg(errp, "Failed to negotiate meta context '%s',=20
>> server "
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "answered w=
ith different context '%s'", context,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 name);
>
> This check may not be valid for other context namespaces, but is=20
> correct for "base:allocation".

so, it is negotiation of "simple meta context". I'll improve somehow=20
comment about the functions...




--=20
Best regards,
Vladimir
