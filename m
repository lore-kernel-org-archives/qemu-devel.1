Received: from eggs.gnu.org ([209.51.188.92]:32929)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjQyy-0008JP-JC
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:50:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gjQyp-0004zQ-Fv
	for qemu-devel@nongnu.org; Tue, 15 Jan 2019 10:50:22 -0500
References: <20190112175812.27068-1-eblake@redhat.com>
	<20190112175812.27068-12-eblake@redhat.com>
	<5d182b61-b17a-fefb-4f9f-c4e697bba8a7@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ce3e0fa8-4b7e-4dd9-e191-6ade2cb5bb2f@redhat.com>
Date: Tue, 15 Jan 2019 09:50:03 -0600
MIME-Version: 1.0
In-Reply-To: <5d182b61-b17a-fefb-4f9f-c4e697bba8a7@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mTAT0TcYtizXdkXNh5wLQ9mFjYr7nKNk7"
Subject: Re: [Qemu-devel] [PATCH v3 11/19] nbd/client: Split out
 nbd_receive_one_meta_context()
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
--mTAT0TcYtizXdkXNh5wLQ9mFjYr7nKNk7
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "nsoffer@redhat.com" <nsoffer@redhat.com>,
 "rjones@redhat.com" <rjones@redhat.com>, "jsnow@redhat.com"
 <jsnow@redhat.com>, "qemu-block@nongnu.org" <qemu-block@nongnu.org>
Message-ID: <ce3e0fa8-4b7e-4dd9-e191-6ade2cb5bb2f@redhat.com>
Subject: Re: [PATCH v3 11/19] nbd/client: Split out
 nbd_receive_one_meta_context()
References: <20190112175812.27068-1-eblake@redhat.com>
 <20190112175812.27068-12-eblake@redhat.com>
 <5d182b61-b17a-fefb-4f9f-c4e697bba8a7@virtuozzo.com>
In-Reply-To: <5d182b61-b17a-fefb-4f9f-c4e697bba8a7@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/15/19 9:05 AM, Vladimir Sementsov-Ogievskiy wrote:
> 12.01.2019 20:58, Eric Blake wrote:
>> Extract portions of nbd_negotiate_simple_meta_context() to
>> a new function nbd_receive_one_meta_context() that copies the
>> pattern of nbd_receive_list() for performing the argument
>> validation of one reply.  The error message when the server
>> replies with more than one context changes slightly, but
>> that shouldn't happen in the common case.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> Message-Id: <20181215135324.152629-15-eblake@redhat.com>
>>
>> ---
>> v3: rebase, without changing into a loop
>> ---

>>=20
>> +static int nbd_receive_one_meta_context(QIOChannel *ioc,
>> +                                        uint32_t opt,
>> +                                        char **name,
>> +                                        uint32_t *id,
>> +                                        Error **errp)
>> +{

>> +    reply.length -=3D sizeof(local_id);
>> +    local_name =3D g_malloc(reply.length + 1);
>> +    if (nbd_read(ioc, local_name, reply.length, errp) < 0) {
>> +        g_free(local_name);
>> +        return -1;
>> +    }
>> +    local_name[reply.length] =3D '\0';
>> +    trace_nbd_opt_meta_reply(nbd_opt_lookup(opt), local_name, local_i=
d);
>> +

[1]

>> @@ -746,36 +796,20 @@ static int nbd_negotiate_simple_meta_context(QIO=
Channel *ioc,
>>               return -1;
>>           }
>>           g_free(name);
>> -
>> -        trace_nbd_opt_meta_reply(context, info->context_id);
>>           received =3D true;
>>
>> -        /* receive NBD_REP_ACK */
>> -        if (nbd_receive_option_reply(ioc, NBD_OPT_SET_META_CONTEXT, &=
reply,
>> -                                     errp) < 0)
>> -        {
>> +        ret =3D nbd_receive_one_meta_context(ioc, NBD_OPT_SET_META_CO=
NTEXT,
>> +                                       &name, &info->context_id, errp=
);
>=20
> indent, and, no reasons to use variables instead of NULL, NULL, as succ=
ess here is an error
> path anyway

Not sure how I missed the indent, and good point about not needing &name
or &info->context_id on this second call.

>> +++ b/nbd/trace-events
>> @@ -13,7 +13,7 @@ nbd_receive_query_exports_success(const char *wantna=
me) "Found desired export na
>>   nbd_receive_starttls_new_client(void) "Setting up TLS"
>>   nbd_receive_starttls_tls_handshake(void) "Starting TLS handshake"
>>   nbd_opt_meta_request(const char *optname, const char *context, const=
 char *export) "Requesting %s %s for export %s"
>> -nbd_opt_meta_reply(const char *context, uint32_t id) "Received mappin=
g of context %s to id %" PRIu32
>> +nbd_opt_meta_reply(const char *optname, const char *context, uint32_t=
 id) "Received %s mapping of %s to id %" PRIu32
>=20
> nbd_opt_lookup

Added at [1], so I'm not sure what you are still wanting here.

>=20
>>   nbd_receive_negotiate(void *tlscreds, const char *hostname) "Receivi=
ng negotiation tlscreds=3D%p hostname=3D%s"
>>   nbd_receive_negotiate_magic(uint64_t magic) "Magic is 0x%" PRIx64
>>   nbd_receive_negotiate_server_flags(uint32_t globalflags) "Global fla=
gs are 0x%" PRIx32
>>
>=20
> With at least nbd_opt_lookup:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--mTAT0TcYtizXdkXNh5wLQ9mFjYr7nKNk7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlw+ASsACgkQp6FrSiUn
Q2pulQf/XjaAJcYen+jcHq6ZlE0Vxu5+9lC5G2Zpx40zaohv1gJKqZ0hjBAiXgN7
GEA5XO5dAaIAwvh9S1EQts1kHQVYbfjmu8+Zs7y53lLWVskyjvvbiHOC09UlpAoX
fCSwGFh30SO7tcf2Truvljr8QKFJC67AA3Lq6k8U9WHGHmnMKmf6sI+UOc7zk/QG
esLEmNWW1YAlPOo4gjlAzaEzQpttw35NDb+RCNOQKzsdon9/nDFTxOSGi+YEgiwG
NIasn8pgQ7vzipnDFoztU9WEG6QLEJWeinN6ZyE14vPuKIOPoejzP75U2jArh412
6oF2R1EcQsyR8B4T7wRXNF0d5jxZ+Q==
=docw
-----END PGP SIGNATURE-----

--mTAT0TcYtizXdkXNh5wLQ9mFjYr7nKNk7--
