Received: from eggs.gnu.org ([2001:4830:134:3::10]:35441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPW5u-00073f-EI
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:06:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPW5r-0005YX-7l
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:06:14 -0500
Received: from mx1.redhat.com ([209.132.183.28]:53609)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPW5q-0005Wu-Uj
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 10:06:11 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB491804EB
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 15:06:10 +0000 (UTC)
References: <20170105160701.22118-1-berrange@redhat.com>
	<20170105160701.22118-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <f4a593e8-5d2a-062b-398c-1223a9ec4efc@redhat.com>
Date: Fri, 6 Jan 2017 09:06:08 -0600
MIME-Version: 1.0
In-Reply-To: <20170105160701.22118-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="r4Wxjn2MxNj87Ns2lTIcSqT70QOsuF2tq"
Subject: Re: [Qemu-devel] [PATCH 2/8] ui: fix reporting of VNC auth in
 query-vnc-servers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r4Wxjn2MxNj87Ns2lTIcSqT70QOsuF2tq
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Message-ID: <f4a593e8-5d2a-062b-398c-1223a9ec4efc@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/8] ui: fix reporting of VNC auth in
 query-vnc-servers
References: <20170105160701.22118-1-berrange@redhat.com>
 <20170105160701.22118-3-berrange@redhat.com>
In-Reply-To: <20170105160701.22118-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:06 AM, Daniel P. Berrange wrote:
> Currently the VNC authentication info is emitted at the
> top level of the query-vnc-servers data. This is wrong
> because the authentication scheme differs between plain
> and websockets when TLS is enabled. We should instead
> report auth against the individual servers. e.g.
>=20
> (QEMU) query-vnc-servers
> {
>     "return": [
>         {
>             "clients": [],
>             "id": "default",
>             "auth": "vencrypt",

So we have to keep the old location for back-compat,...

>             "vencrypt": "x509-vnc",
>             "server": [
>                 {
>                     "host": "127.0.0.1"
>                     "service": "5901",
>                     "websocket": false,
>                     "family": "ipv4",
>                     "auth": "vencrypt",
>                     "vencrypt": "x509-vnc",

No trailing comma (JSON is too picky)

>                 }
>                 {
>                     "host": "127.0.0.1",
>                     "service": "5902",
>                     "websocket": true,
>                     "family": "ipv4",
>                     "auth": "vnc"

=2E..but add the new location to fix the problem.
>                 },

No trailing comma

>             ]
>         }
>     ]
> }
>=20
> This also future proofs the QMP schema so that we can
> cope with multiple VNC server instances, listening on
> different interfaces or ports, with different auth
> setup.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  qapi-schema.json | 26 +++++++++++++++--
>  ui/vnc.c         | 85 +++++++++++++++++++++++++++++++++---------------=
--------
>  2 files changed, 73 insertions(+), 38 deletions(-)
>=20

> =20
> +
> +##
> +# @VncServerInfo2
> +#
> +# The network connection information for server
> +#
> +# @auth: The current authentication type used by the server
> +#
> +# @vencrypt: #optional The vencrypt sub authentication type used by th=
e server,
> +#            only specified in case auth =3D=3D vencrypt.
> +#
> +# Since: 2.8

2.9, actually

> @@ -1210,7 +1230,7 @@
>  # @clients: A list of @VncClientInfo of all currently connected client=
s.
>  #           The list can be empty, for obvious reasons.
>  #
> -# @auth: The current authentication type used by the server
> +# @auth: The current authentication type used by the non-websockets se=
rver

Since server is an array, should this read 'servers' or even 'server(s)'?=


>  #
>  # @vencrypt: #optional The vencrypt sub authentication type used by th=
e server,
>  #            only specified in case auth =3D=3D vencrypt.
> @@ -1221,7 +1241,7 @@
>  ##
>  { 'struct': 'VncInfo2',
>    'data': { 'id'        : 'str',
> -            'server'    : ['VncBasicInfo'],
> +            'server'    : ['VncServerInfo2'],

Backwards-compatible, so you're fine making the change.

Once the nits are resolved, you can add:
Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--r4Wxjn2MxNj87Ns2lTIcSqT70QOsuF2tq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYb7JgAAoJEKeha0olJ0Nq/lEH+wXaFZkbZlNmHaitIV0oBH6T
DCqE0+R48fbZ+9AtjEBod+4Hn/PBNWPjVvlbhtXBicL0BUUxxzoDDAQBsBUhKfLq
EQdGnS2OzHIA4VJ4PkkcrGjx75LEvKBPR6gy4r0mEjjpWUSsVT/d6R69T4rV8UBL
b4OLzkSiaWi3/NpGD4filoWSDKJ7Dt4gaCXFP7IkWnsK2Fm0outVVvwqQSsmGV4C
84vq3EhumSJGjRYqzF+LfvUpOutE0mGLxKB1xh74+5ozH89PivvxZW7oMSsCVX08
H70Q1fo3/nduGkGYJLxwKywqSlpZoxKSO2+mkuqfSlvhMRerwMSaogq4Aik95Ug=
=yqJn
-----END PGP SIGNATURE-----

--r4Wxjn2MxNj87Ns2lTIcSqT70QOsuF2tq--
