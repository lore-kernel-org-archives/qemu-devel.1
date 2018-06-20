Received: from eggs.gnu.org ([2001:4830:134:3::10]:48529)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVZeN-0001Ua-5q
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 05:43:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vsementsov@virtuozzo.com>) id 1fVZeI-0004r2-3p
	for qemu-devel@nongnu.org; Wed, 20 Jun 2018 05:43:39 -0400
References: <20180609151758.17343-1-vsementsov@virtuozzo.com>
	<20180609151758.17343-4-vsementsov@virtuozzo.com>
	<a3f528cb-ca69-13f7-f270-9aa5b04fb8d8@redhat.com>
From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <b9aebe12-d305-09c8-93e6-40b197ea3c1d@virtuozzo.com>
Date: Wed, 20 Jun 2018 12:43:27 +0300
MIME-Version: 1.0
In-Reply-To: <a3f528cb-ca69-13f7-f270-9aa5b04fb8d8@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v5 3/6] nbd/server: add
 nbd_meta_empty_or_pattern helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: armbru@redhat.com, pbonzini@redhat.com, mreitz@redhat.com, kwolf@redhat.com, den@openvz.org

19.06.2018 23:24, Eric Blake wrote:
> On 06/09/2018 10:17 AM, Vladimir Sementsov-Ogievskiy wrote:
>> Add nbd_meta_pattern() and nbd_meta_empty_or_pattern() helpers for
>> metadata query parsing. nbd_meta_pattern() will be reused for "qemu"
>
> s/for/for the/
>
>> namespace in following patches.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>> ---
>> =C2=A0 nbd/server.c | 86=20
>> +++++++++++++++++++++++++++++++++++++++++-------------------
>> =C2=A0 1 file changed, 59 insertions(+), 27 deletions(-)
>
> Feels like growth, even though the goal of refactoring is reuse; but=20
> the reuse comes later so I'm okay with it.
>
>>
>> diff --git a/nbd/server.c b/nbd/server.c
>> index 567561a77e..2d762d7289 100644
>> --- a/nbd/server.c
>> +++ b/nbd/server.c
>> @@ -733,52 +733,83 @@ static int=20
>> nbd_negotiate_send_meta_context(NBDClient *client,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return qio_channel_writev_all(client->ioc=
, iov, 2, errp) < 0 ?=20
>> -EIO : 0;
>> =C2=A0 }
>> =C2=A0 -/* nbd_meta_base_query
>> - *
>> - * Handle query to 'base' namespace. For now, only base:allocation=20
>> context is
>
> [1]...
>
>> - * available in it.=C2=A0 'len' is the amount of text remaining to be=20
>> read from
>> - * the current name, after the 'base:' portion has been stripped.
>> +/* Read strlen(@pattern) bytes, and set @match to true if they match=20
>> @pattern.
>> + * @match is never set to false.
>> =C2=A0=C2=A0 *
>> =C2=A0=C2=A0 * Return -errno on I/O error, 0 if option was completely ha=
ndled by
>> =C2=A0=C2=A0 * sending a reply about inconsistent lengths, or 1 on succe=
ss.
>> =C2=A0=C2=A0 *
>> - * Note: return code =3D 1 doesn't mean that we've parsed=20
>> "base:allocation"
>> - * namespace. It only means that there are no errors.*/
>> -static int nbd_meta_base_query(NBDClient *client,=20
>> NBDExportMetaContexts *meta,
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t len, Error **errp)
>> + * Note: return code =3D 1 doesn't mean that we've read exactly @patter=
n
>> + * It only means that there are no errors. */
>
> Comment tail on its own line (now that we've got a patch pending for=20
> HACKING to document that, I'll start abiding by it...)
>
>> +static int nbd_meta_pattern(NBDClient *client, const char *pattern,=20
>> bool *match,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 Error **errp)
>> =C2=A0 {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int ret;
>> -=C2=A0=C2=A0=C2=A0 char query[sizeof("allocation") - 1];
>> -=C2=A0=C2=A0=C2=A0 size_t alen =3D strlen("allocation");
>> +=C2=A0=C2=A0=C2=A0 char *query;
>> +=C2=A0=C2=A0=C2=A0 int len =3D strlen(pattern);
>
> size_t is better than len for strlen() results.
>
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (len =3D=3D 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (client->opt =3D=3D NBD_O=
PT_LIST_META_CONTEXT) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meta=
->base_allocation =3D true;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nbd_negotiate_meta_que=
ry_parse("base:");
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>> -=C2=A0=C2=A0=C2=A0 }
>> -
>> -=C2=A0=C2=A0=C2=A0 if (len !=3D alen) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nbd_negotiate_meta_que=
ry_skip("not base:allocation");
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nbd_opt_skip(client, =
len, errp);
>> -=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 assert(len);
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 query =3D g_malloc(len);
>
> At first, I wondered if we could just use a pre-allocated stack buffer=20
> larger than any string we ever anticipate.=C2=A0 But thinking about it,=20
> your dirty bitmap exports expose a name under user control, which=20
> means a user could (spitefully) pick a name longer than our buffer=20
> (well, up to the 4k name limit imposed by the NBD protocol).=C2=A0 So I c=
an=20
> live with the malloc.
>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_opt_read(client, query, len, =
errp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (ret <=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_free(query);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 -=C2=A0=C2=A0=C2=A0 if (strncmp(query, "allocation", alen) =3D=3D=
 0) {
>> - trace_nbd_negotiate_meta_query_parse("base:allocation");
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 meta->base_allocation =3D tr=
ue;
>> +=C2=A0=C2=A0=C2=A0 if (strncmp(query, pattern, len) =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nbd_negotiate_meta_que=
ry_parse(pattern);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *match =3D true;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nbd_negotiate_meta_que=
ry_skip("not base:allocation");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nbd_negotiate_meta_que=
ry_skip(pattern);
>
> Would this one read better as "not %s", pattern?

may be, but how? introduce malloced string variable to sprintf?

>
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 g_free(query);
>> =C2=A0 =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>> =C2=A0 }
>> =C2=A0 +/* Read @len bytes, and set @match to true if they match @patter=
n,=20
>> or if @len
>> + * is 0 and the client is performing _LIST_. @match is never set to=20
>> false.
>> + *
>> + * Return -errno on I/O error, 0 if option was completely handled by
>> + * sending a reply about inconsistent lengths, or 1 on success.
>> + *
>> + * Note: return code =3D 1 doesn't mean that we've read exactly @patter=
n
>> + * It only means that there are no errors. */
>
> More comment formatting.

hm, we need something in checkpatch for it

>
>> +static int nbd_meta_empty_or_pattern(NBDClient *client, const char=20
>> *pattern,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ui=
nt32_t len, bool *match,=20
>> Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 if (len =3D=3D 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (client->opt =3D=3D NBD_O=
PT_LIST_META_CONTEXT) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 *mat=
ch =3D true;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nbd_negotiate_meta_que=
ry_parse("empty");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 1;
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 if (len !=3D strlen(pattern)) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nbd_negotiate_meta_que=
ry_skip("different lengths");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nbd_opt_skip(client, =
len, errp);
>> +=C2=A0=C2=A0=C2=A0 }
>> +
>> +=C2=A0=C2=A0=C2=A0 return nbd_meta_pattern(client, pattern, match, errp=
);
>> +}
>> +
>> +/* nbd_meta_base_query
>> + *
>> + * Handle query to 'base' namespace. For now, only base:allocation=20
>> context is
>
> Pre-existing (see [1]), but reads better as "Handle queries to the=20
> 'base' namespace"
>
>> + * available in it.=C2=A0 'len' is the amount of text remaining to be=20
>> read from
>> + * the current name, after the 'base:' portion has been stripped.
>> + *
>> + * Return -errno on I/O error, 0 if option was completely handled by
>> + * sending a reply about inconsistent lengths, or 1 on success. */
>> +static int nbd_meta_base_query(NBDClient *client,=20
>> NBDExportMetaContexts *meta,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t len, Error **errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 return nbd_meta_empty_or_pattern(client, "allocation=
", len,
>> + &meta->base_allocation, errp);
>> +}
>> +
>> =C2=A0 /* nbd_negotiate_meta_query
>> =C2=A0=C2=A0 *
>> =C2=A0=C2=A0 * Parse namespace name and call corresponding function to p=
arse=20
>> body of the
>> @@ -822,6 +853,7 @@ static int nbd_negotiate_meta_query(NBDClient=20
>> *client,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nbd_opt_sk=
ip(client, len, errp);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0 +=C2=A0=C2=A0=C2=A0 trace_nbd_negotiate_meta_query_parse("base:")=
;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return nbd_meta_base_query(client, meta, =
len, errp);
>> =C2=A0 }
>>
>
> My findings were trivial; the code refactoring itself looks sane.
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>


--=20
Best regards,
Vladimir
