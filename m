Received: from eggs.gnu.org ([2001:4830:134:3::10]:58357)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTqQT-0000zz-CD
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:37:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1cTqQS-0008Oo-80
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 08:37:21 -0500
References: <20170111181432.18868-1-mreitz@redhat.com>
	<20170116204921.31578-6-mreitz@redhat.com>
	<a01b3de1-a92f-098e-8cb4-8203f20e8c25@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <931153f9-1c2a-3cb9-d99d-8f0493d57d46@redhat.com>
Date: Wed, 18 Jan 2017 14:37:11 +0100
MIME-Version: 1.0
In-Reply-To: <a01b3de1-a92f-098e-8cb4-8203f20e8c25@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="hNp8mIgqMf0WfrGq3PcW8G3xlSb8SjWpi"
Subject: Re: [Qemu-devel] [PATCH v4 13/25] block/nbd: Implement
 bdrv_dirname()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hNp8mIgqMf0WfrGq3PcW8G3xlSb8SjWpi
From: Max Reitz <mreitz@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Alberto Garcia <berto@igalia.com>,
 Kevin Wolf <kwolf@redhat.com>
Message-ID: <931153f9-1c2a-3cb9-d99d-8f0493d57d46@redhat.com>
Subject: Re: [PATCH v4 13/25] block/nbd: Implement bdrv_dirname()
References: <20170111181432.18868-1-mreitz@redhat.com>
 <20170116204921.31578-6-mreitz@redhat.com>
 <a01b3de1-a92f-098e-8cb4-8203f20e8c25@redhat.com>
In-Reply-To: <a01b3de1-a92f-098e-8cb4-8203f20e8c25@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 17.01.2017 00:21, Eric Blake wrote:
> On 01/16/2017 02:49 PM, Max Reitz wrote:
>> The idea behind this implementation is that the export name might be
>> interpreted as a path (which is the only apparent interpretation of
>> relative filenames for NBD paths).
>>
>> The default implementation of bdrv_dirname() would handle that just fi=
ne
>> for nbd+tcp, but not for nbd+unix, because in that case, the last
>> element of the path is the Unix socket path and not the export name.
>> Therefore, we need to implement an own bdrv_dirname() which uses the
>> legacy NBD URL which has the export name at the end.
>>
>> Signed-off-by: Max Reitz <mreitz@redhat.com>
>> ---
>>  block/nbd.c | 31 +++++++++++++++++++++++++++++++
>>  1 file changed, 31 insertions(+)
>>
>> diff --git a/block/nbd.c b/block/nbd.c
>> index 35f24be069..42f0cd638c 100644
>> --- a/block/nbd.c
>> +++ b/block/nbd.c
>> @@ -552,6 +552,34 @@ static void nbd_refresh_filename(BlockDriverState=
 *bs, QDict *options)
>>      bs->full_open_options =3D opts;
>>  }
>> =20
>> +static char *nbd_dirname(BlockDriverState *bs, Error **errp)
>> +{
>> +    BDRVNBDState *s =3D bs->opaque;
>> +    const char *host =3D NULL, *port =3D NULL, *path =3D NULL;
>> +
>> +    if (s->saddr->type =3D=3D SOCKET_ADDRESS_KIND_INET) {
>> +        const InetSocketAddress *inet =3D s->saddr->u.inet.data;
>> +        if (!inet->has_ipv4 && !inet->has_ipv6 && !inet->has_to) {
>> +            host =3D inet->host;
>> +            port =3D inet->port;
>> +        }
>> +    } else if (s->saddr->type =3D=3D SOCKET_ADDRESS_KIND_UNIX) {
>> +        path =3D s->saddr->u.q_unix.data->path;
>> +    }
>> +
>=20
> Should we be catering to SOCKET_ADDRESS_KIND_VSOCK or
> SOCKET_ADDRESS_KIND_FD (if only to assert that they aren't possible wit=
h
> NBD)?

In those cases, the generic "Cannot generate..." error below will be
returned. I think that should be enough.

>> +    if (path) {
>> +        return g_strdup_printf("nbd:unix:%s:exportname=3D%s%s", path,=

>> +                               s->export ?: "", s->export ? "/" : "")=
;
>> +    } else if (host) {
>> +        return g_strdup_printf("nbd://%s:%s/%s%s", host, port,
>> +                               s->export ?: "", s->export ? "/" : "")=
;
>> +    }
>> +
>> +    error_setg(errp, "Cannot generate a base directory for NBD node '=
%s'",
>> +               bs->filename);
>> +    return NULL;
>> +}
>> +
>=20
> The NBD protocol doesn't require the server to support directories, but=

> also doesn't place any requirements on export names, so this approach
> assumes a particular server behavior, but is probably as good as any
> other approach.  But I'm still not sold that we need this, vs. just
> declaring that NBD has no directory structure and therefore we always
> return NULL (even with nbd+tcp, and whether or not the older nbd: URI
> was used).  So I'm not quite ready for R-b on this one yet.

Right. Perhaps it's better to just always make it an error for now and
maybe revisit it later if someone asks for it (which I can't imagine...).=


Max


--hNp8mIgqMf0WfrGq3PcW8G3xlSb8SjWpi
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlh/b4cSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AO5MIAJTsWdGhJPutt2lvXOw4tTpBXUNVymeK
vsdJozzxWpLrd2BucP0uIbCaTZcpsPE+tXi9y0sU8MQ68+ljgnSFmKPVG8fN3gte
FE+u2d4KyOvtO9RbFqJD51fQMMfAJOvW46ubDzrDyLnM+w2np0REYTKyHCoK6mB1
pE0ZD94AkzBKXao699RSf1L/HVhAGDXPhH2J/If7+uPEWzlRnMn9wNKwPNiXf647
26j0jeeQpIrBUXfGdQlPCORY1/B79lqd3MUE8Bx8Av23ysp0KIy28Xk7KQseYMTk
2JX8mXL+zdZzH+n9Vkzd6q5ujCZbZT6pQwKYl/6/1GqhVVLhc7h9DtQ=
=Cr9K
-----END PGP SIGNATURE-----

--hNp8mIgqMf0WfrGq3PcW8G3xlSb8SjWpi--
