Received: from eggs.gnu.org ([2001:4830:134:3::10]:35134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5ci1-00047g-Qr
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:11:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5ci0-0005RH-RZ
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 15:11:53 -0400
References: <20171019222637.17890-1-eblake@redhat.com>
	<20171019222637.17890-7-eblake@redhat.com>
	<fc70554b-fe64-0b33-af5f-142259d56036@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <ae7945f3-c0c0-2238-7ad6-0f92cffaa816@redhat.com>
Date: Fri, 20 Oct 2017 14:11:44 -0500
MIME-Version: 1.0
In-Reply-To: <fc70554b-fe64-0b33-af5f-142259d56036@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Dv7H9WC1TAhhPewL437TKLwtWMXOGAQ6v"
Subject: Re: [Qemu-devel] [PATCH v5 06/11] nbd: Minimal structured read for
 server
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Dv7H9WC1TAhhPewL437TKLwtWMXOGAQ6v
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org
Message-ID: <ae7945f3-c0c0-2238-7ad6-0f92cffaa816@redhat.com>
Subject: Re: [PATCH v5 06/11] nbd: Minimal structured read for server
References: <20171019222637.17890-1-eblake@redhat.com>
 <20171019222637.17890-7-eblake@redhat.com>
 <fc70554b-fe64-0b33-af5f-142259d56036@virtuozzo.com>
In-Reply-To: <fc70554b-fe64-0b33-af5f-142259d56036@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/20/2017 02:03 PM, Vladimir Sementsov-Ogievskiy wrote:
> 20.10.2017 01:26, Eric Blake wrote:
>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> Minimal implementation of structured read: one structured reply chunk,=

>> no segmentation.
>> Minimal structured error implementation: no text message.
>> Support DF flag, but just ignore it, as there is no segmentation any
>> way.
>>

>> +
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ca=
se NBD_OPT_STRUCTURED_REPLY:
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (length) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_check_zero_leng=
th(client, length,
>> option, errp);
>=20
> here same thing like in previous patch, about success in
> nbd_check_zero_length

Here, successfully answering the client with an error message should NOT
stop negotiating, so THIS return is correct.

>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 } else if (client->structured_reply) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_negotiate_send_=
rep_err(
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 cli=
ent->ioc, NBD_REP_ERR_INVALID, option, errp,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "st=
ructured reply already negotiated");
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 } else {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_negotiate_send_=
rep(client->ioc,
>> NBD_REP_ACK,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opt=
ion, errp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>=20
> you've dropped "if (ret < 0) { return ret }", but the following two
> lines should not be
> executed if ret < 0.. May be it doesn't matter (we will abort connectio=
n
> anyway after switch {}) but
> it looks strange.
>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 client->structured_reply =3D true;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 myflags |=3D NBD_FLAG_SEND_DF;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 break;

Indeed, these two lines are harmless due to the catch-all 'ret < 0'
after the switch at the tail end of the loop (which is why I dropped the
'if' here).


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--Dv7H9WC1TAhhPewL437TKLwtWMXOGAQ6v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnqSnAACgkQp6FrSiUn
Q2oKLAf7B+WezmjT7q9LKANRuszP7/GrGXwsDxyf6S3HLdpG2pbJpfFr00gtR9lH
y7LzY0sXaPWcu4wFPPAIk5VWwQW3LuST+cd0Xyb3lFpNYl/iBVJKed6FzJfj14PF
I4dH1KIDBLSFu2BLis8SibvAZp+cHJA6IBwITRjKSMqUmAlClW4dgOfw0AwToPWG
pYcM5EN2gX+PKC5DpMMcxQW992+JineLFXTkZQGh2WHBULiihf7yVnwQ0OkxfHKf
hhlJJ6Ol1UBadmrrM1u8em5sG4xq/RYcQ6tAr4XbV3HELc0xvwerWW4HXq042xTo
sM6+CGma0tMZDJJWdA08FhqGMgvGTQ==
=y+3d
-----END PGP SIGNATURE-----

--Dv7H9WC1TAhhPewL437TKLwtWMXOGAQ6v--
