Received: from eggs.gnu.org ([209.51.188.92]:59983)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjQtt-0005MV-Mq
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:45:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjQtq-0003Cn-FT
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:45:13 -0500
References: <20190112175812.27068-1-eblake@redhat.com>
	<20190112175812.27068-11-eblake@redhat.com>
	<e24c7f01-a203-c6ce-ac95-77cb74c590df@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <c0ab928c-3efc-41fd-f16f-6a6b4e465e9a@redhat.com>
Date: Tue, 15 Jan 2019 09:44:56 -0600
MIME-Version: 1.0
In-Reply-To: <e24c7f01-a203-c6ce-ac95-77cb74c590df@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="njA5IAPOBdyHJqXaMnNm5J86XcdOjy9ck"
Subject: Re: [Qemu-devel] [PATCH v3 10/19] nbd/client: Split out
 nbd_send_one_meta_context()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>, "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--njA5IAPOBdyHJqXaMnNm5J86XcdOjy9ck
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Message-ID: <c0ab928c-3efc-41fd-f16f-6a6b4e465e9a@redhat.com>
Subject: Re: [PATCH v3 10/19] nbd/client: Split out
 nbd_send_one_meta_context()
References: <20190112175812.27068-1-eblake@redhat.com>
 <20190112175812.27068-11-eblake@redhat.com>
 <e24c7f01-a203-c6ce-ac95-77cb74c590df@virtuozzo.com>
In-Reply-To: <e24c7f01-a203-c6ce-ac95-77cb74c590df@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/15/19 7:18 AM, Vladimir Sementsov-Ogievskiy wrote:
> 12.01.2019 20:58, Eric Blake wrote:
>> Refactor nbd_negotiate_simple_meta_context() to pull out the
>> code that can be reused to send a LIST request for 0 or 1 query.
>> No semantic change.  The old comment about 'sizeof(uint32_t)'
>> being equivalent to '/* number of queries */' is no longer
>> needed, now that we are computing 'sizeof(queries)' instead.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Message-Id: <20181215135324.152629-14-eblake@redhat.com>
>> Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
>>
>> ---
>> v3: Improve commit message [Rich], formatting tweak [checkpatch],
>> rebase to dropped patch
>> ---

>> +++ b/nbd/client.c
>> @@ -629,6 +629,49 @@ static QIOChannel *nbd_receive_starttls(QIOChanne=
l *ioc,
>>       return QIO_CHANNEL(tioc);
>>   }
>>
>> +/*
>> + * nbd_send_one_meta_context:
>> + * Send 0 or 1 set/list meta context queries.
>> + * Return 0 on success, -1 with errp set for any error
>> + */
>> +static int nbd_send_one_meta_context(QIOChannel *ioc,
>> +                                     uint32_t opt,
>> +                                     const char *export,
>> +                                     const char *query,
>> +                                     Error **errp)
>> +{
>> +    int ret;
>> +    uint32_t export_len =3D strlen(export);
>> +    uint32_t queries =3D !!query;
>=20
> n_ or nb_ prefix may make it more clear
>=20
>> +    uint32_t context_len =3D 0;
>> +    uint32_t data_len;
>> +    char *data;
>> +    char *p;
>> +
>> +    data_len =3D sizeof(export_len) + export_len + sizeof(queries);

[1]

>> +    if (query) {
>> +        context_len =3D strlen(query);
>=20
> looks like it then should be query_len

Sure, an alternative name may make things easier to read (I think this
is somewhat fallout from my rebase churn, where earlier versions of the
patch shared as much code with NBD_OPT_SET_META_CONTEXT, and that code
used the name 'context' rather than 'query'; but now that I've split
things to add a new function, it doesn't have to maintain the old naming)=
=2E

>=20
>> +        data_len +=3D sizeof(context_len) + context_len;
>> +    } else {
>> +        assert(opt =3D=3D NBD_OPT_LIST_META_CONTEXT);
>> +    }
>> +    data =3D g_malloc(data_len);
>> +    p =3D data;
>=20
> may use p =3D data =3D g_malloc

Will do.

>=20
>> +
>> +    trace_nbd_opt_meta_request(nbd_opt_lookup(opt), query ?: "(all)",=
 export);

[2]

>> +    stl_be_p(p, export_len);
>> +    memcpy(p +=3D sizeof(export_len), export, export_len);
>> +    stl_be_p(p +=3D export_len, queries);
>> +    if (query) {
>> +        stl_be_p(p +=3D sizeof(uint32_t), context_len);
>=20
> :), aha, please, s/uint32_t/queries, as you promised

I did up at [1], but should indeed do so again here.

>=20
> Hmm, its my code. It's hard to read and not very comfortable to maintai=
n..
>=20
> In block/nbd-client.c we have
> payload_advance* functions, to read such formatted data, I think, it sh=
ould be
> good to make something like this for server-part. Not about these serie=
s, of course.

Yes, I wouldn't object to even more cleanups to make the code easier to
maintain, but not as part of this series.

>=20
> Interesting, troubles around "don't use be64_to_cpuS, use only be64_to_=
cpu",
> do they apply somehow to *_be_p functions family?

The problem was in the in-place conversion routines where the
destination type was strongly typed to something wider than char*.  This
is not an inplace conversion, because st*_p takes a raw pointer
interpreted as char* as its destination.  So no, clang does not have
problems with this construct.

>=20
>> +        memcpy(p +=3D sizeof(context_len), query, context_len);
>> +    }
>> +
>> +    ret =3D nbd_send_option_request(ioc, opt, data_len, data, errp);
>> +    g_free(data);
>> +    return ret;
>> +}
>> +
>>   /* nbd_negotiate_simple_meta_context:
>>    * Request the server to set the meta context for export @info->name=

>>    * using @info->x_dirty_bitmap with a fallback to "base:allocation",=

>> @@ -653,26 +696,10 @@ static int nbd_negotiate_simple_meta_context(QIO=
Channel *ioc,
>>       NBDOptionReply reply;
>>       const char *context =3D info->x_dirty_bitmap ?: "base:allocation=
";
>>       bool received =3D false;
>> -    uint32_t export_len =3D strlen(info->name);
>> -    uint32_t context_len =3D strlen(context);
>> -    uint32_t data_len =3D sizeof(export_len) + export_len +
>> -                        sizeof(uint32_t) + /* number of queries */
>> -                        sizeof(context_len) + context_len;
>> -    char *data =3D g_malloc(data_len);
>> -    char *p =3D data;
>>
>> -    trace_nbd_opt_meta_request(context, info->name);
>> -    stl_be_p(p, export_len);
>> -    memcpy(p +=3D sizeof(export_len), info->name, export_len);
>> -    stl_be_p(p +=3D export_len, 1);
>> -    stl_be_p(p +=3D sizeof(uint32_t), context_len);
>> -    memcpy(p +=3D sizeof(context_len), context, context_len);
>> -
>> -    ret =3D nbd_send_option_request(ioc, NBD_OPT_SET_META_CONTEXT, da=
ta_len, data,
>> -                                  errp);
>> -    g_free(data);
>> -    if (ret < 0) {
>> -        return ret;
>> +    if (nbd_send_one_meta_context(ioc, NBD_OPT_SET_META_CONTEXT,
>> +                                  info->name, context, errp) < 0) {
>> +        return -1;
>>       }
>>
>>       if (nbd_receive_option_reply(ioc, NBD_OPT_SET_META_CONTEXT, &rep=
ly,
>> @@ -689,7 +716,7 @@ static int nbd_negotiate_simple_meta_context(QIOCh=
annel *ioc,
>>       if (reply.type =3D=3D NBD_REP_META_CONTEXT) {
>>           char *name;
>>
>> -        if (reply.length !=3D sizeof(info->context_id) + context_len)=
 {
>> +        if (reply.length !=3D sizeof(info->context_id) + strlen(conte=
xt)) {
>>               error_setg(errp, "Failed to negotiate meta context '%s',=
 server "
>>                          "answered with unexpected length %" PRIu32, c=
ontext,
>>                          reply.length);
>> diff --git a/nbd/trace-events b/nbd/trace-events
>> index c3966d2b653..59521e47a3d 100644
>> --- a/nbd/trace-events
>> +++ b/nbd/trace-events
>> @@ -12,7 +12,7 @@ nbd_receive_query_exports_start(const char *wantname=
) "Querying export list for
>>   nbd_receive_query_exports_success(const char *wantname) "Found desir=
ed export name '%s'"
>>   nbd_receive_starttls_new_client(void) "Setting up TLS"
>>   nbd_receive_starttls_tls_handshake(void) "Starting TLS handshake"
>> -nbd_opt_meta_request(const char *context, const char *export) "Reques=
ting to set meta context %s for export %s"
>> +nbd_opt_meta_request(const char *optname, const char *context, const =
char *export) "Requesting %s %s for export %s"
>=20
> Hmm, you forget nbd_opt_lookup()

Where? The updated trace point at [2] has nbd_opt_lookup() for
determining optname.

>=20
> With this and s/uint32_t/queries (other tiny things up to you):
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
>>   nbd_opt_meta_reply(const char *context, uint32_t id) "Received mappi=
ng of context %s to id %" PRIu32
>>   nbd_receive_negotiate(void *tlscreds, const char *hostname) "Receivi=
ng negotiation tlscreds=3D%p hostname=3D%s"
>>   nbd_receive_negotiate_magic(uint64_t magic) "Magic is 0x%" PRIx64
>>
>=20
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--njA5IAPOBdyHJqXaMnNm5J86XcdOjy9ck
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw9//gACgkQp6FrSiUn
Q2rp5Af+Mg8K8YtrBRl9EE2orbTm6zqqPGd/dX9NqlwjAOAyumRKbSXI3A0cQFcg
noxPxpLQi+X9z/BtjY7JAeJBeFsZL4VJWiiUIWlV1jButL3epVdMwSkVyatAS6+Z
heCrbPkKajy6kyVGtt9Jdb4vd5+eaiYhHvEn+jQsPF6WoTE3gLMWgDTiC2jxwXWq
dYIWaifcDeQ2/1DJ9zj68lKG0aJqyagMPj+uhXgkEvo8IY7d5FFufKEBC5kKKeEs
0wwQnFARvEHJkqeeu4LI5ro5Cmk3S7L4mo41xSYW0Yyvdl9EL3gorZpI4pXPnwvG
zgCp1aJbaMOZdAm/ig0z+n0e6iK9Kw==
=MvT2
-----END PGP SIGNATURE-----

--njA5IAPOBdyHJqXaMnNm5J86XcdOjy9ck--
