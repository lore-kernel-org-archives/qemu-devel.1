Received: from eggs.gnu.org ([2001:4830:134:3::10]:59868)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5YtZ-0000wY-4v
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:07:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e5YtX-0000o9-Qi
	for qemu-devel@nongnu.org; Fri, 20 Oct 2017 11:07:33 -0400
References: <20171019222637.17890-1-eblake@redhat.com>
	<20171019222637.17890-6-eblake@redhat.com>
	<ff85f750-2531-a687-199b-b3e0f6931e3a@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <1a2498fc-47f8-e53c-b83e-47934cccc2ff@redhat.com>
Date: Fri, 20 Oct 2017 10:07:21 -0500
MIME-Version: 1.0
In-Reply-To: <ff85f750-2531-a687-199b-b3e0f6931e3a@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="FqLRvauUa70g9sqHEuhJ13svWEhhQ7m7n"
Subject: Re: [Qemu-devel] [PATCH v5 05/11] nbd/server: Refactor zero-length
 option check
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
--FqLRvauUa70g9sqHEuhJ13svWEhhQ7m7n
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org
Message-ID: <1a2498fc-47f8-e53c-b83e-47934cccc2ff@redhat.com>
Subject: Re: [PATCH v5 05/11] nbd/server: Refactor zero-length option check
References: <20171019222637.17890-1-eblake@redhat.com>
 <20171019222637.17890-6-eblake@redhat.com>
 <ff85f750-2531-a687-199b-b3e0f6931e3a@virtuozzo.com>
In-Reply-To: <ff85f750-2531-a687-199b-b3e0f6931e3a@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/20/2017 03:34 AM, Vladimir Sementsov-Ogievskiy wrote:
> 20.10.2017 01:26, Eric Blake wrote:
>> Consolidate the check for a zero-length payload to an option
>> into a new function, nbd_check_zero_length(); this check will
>> also be used when introducing support for structured replies.
>>
>> By sticking a catch-all check at the end of the loop for
>> processing options, we can simplify several of the intermediate
>> cases.
>>
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>=20
> looks like two patches in one, however I'm not against (considering my
> big patches =3D)).
> I've already put an r-b here but suddenly understood a hidden behavior
> change you've made,
> which may considered like a bug, see below.
>=20

>> +/* nbd_check_zero_length: Handle any unexpected payload.
>> + * Return:
>> + * -errno=C2=A0 on error, errp is set
>> + * 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 on successful negotiation, e=
rrp is not set
>> + */
>> +static int nbd_check_zero_length(NBDClient *client, uint32_t length,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t option, Error *=
*errp)
>> +{
>> +=C2=A0=C2=A0=C2=A0 if (!length) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return 0;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 if (nbd_drop(client->ioc, length, errp) < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>> +=C2=A0=C2=A0=C2=A0 }
>> +=C2=A0=C2=A0=C2=A0 return nbd_negotiate_send_rep_err(client->ioc,
>> NBD_REP_ERR_INVALID, option,
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 errp, "option %s should have
>> zero length",
>=20
> may be quotes around %s or your trace-notation %d (%s) would be more
> readable

quotes don't hurt, but since none of the option names contain spaces,
it's not quite as important as when you are quoting a message sent over
the wire.

>=20
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 nbd_opt_lookup(option));
>> +}
>> +
>> =C2=A0 /* nbd_negotiate_options
>> =C2=A0=C2=A0 * Process all NBD_OPT_* client option commands, during fi=
xed newstyle
>> =C2=A0=C2=A0 * negotiation.
>> @@ -674,7 +672,11 @@ static int nbd_negotiate_options(NBDClient
>> *client, uint16_t myflags,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 switch (option) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 case NBD_OPT_STARTTLS:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 tioc =3D nbd_negotiate_handle_starttls(client, leng=
th,
>> errp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_check_zero_length(client, length, optio=
n,
>> errp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>=20
> no, you should not continue if length>0 (old behavior).
> nbd_negotiate_send_rep_err returns 0 on success
> in nbd_check_zero_length().

Oh, good catch. But it's subtler than that. In the old code,
nbd_negotiate_handle_starttls() returns NULL on non-zero length (even if
it sent a message to the client), because we really want to kill the
connection if a client can't turn on TLS correctly...

>> @@ -712,9 +711,9 @@ static int nbd_negotiate_options(NBDClient
>> *client, uint16_t myflags,
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 } else if (fixe=
dNewstyle) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 switch (option) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 case NBD_OPT_LIST:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_negotiate_handle_list(client, length, e=
rrp);
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (ret < 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return ret;
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_check_zero_length(client, length, optio=
n,
>> errp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (!ret) {
>=20
> the same here
>=20

while nbd_negotiate_handle_list() used to return 0 if the client sent
non-zero length (we handled the incorrect message from the client just
fine, and can continue listening for more options).

Maybe I can fix it with a tri-state return: 1 if correct length, 0 if
nonzero length but error message sent successfully, and negative on
transmission failure; although then it's trickier for callers.  I'll
have to think about it...

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 case NBD_OPT_STARTTLS:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (nbd_drop(client->ioc, length, errp) < 0) {
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EIO;
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (client->tlscreds) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (length) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ret =3D nbd_check_zero_leng=
th(client, length,
>> option, errp);

Maybe explicitly checking for length at each caller is the simplest
approach for getting the decision logic correct, since I really wasn't
able to abstract a clean "failure to communicate" vs. "error message
sent, go on to next message or abort connection as appropriate" vs.
"everything validated, proceed with rest of handing current option".

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--FqLRvauUa70g9sqHEuhJ13svWEhhQ7m7n
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlnqESkACgkQp6FrSiUn
Q2rRmAf/VrDorMPBFB1u0p8P+j1xPmWhMoK7V7cJXwG0GlBlhk1o2/arSBA1Vess
Ny+RbjfAWTRb4iAQbuQptKuv+IMDP/JQZelP6UDhaR4lf/QGCTEJFHSVVtahflgA
NC44AYAlnIqJbwq47l/eUibpPiXVLfTRM4cTDskEmUXmJiTYvlavjC9jfnOj4pzX
SW77TYpUDabFSByQM/h2DtCSLmvBaHez9M11msCboTpM44HkwlOIq5G1VJ4Z/2eP
5ePaIeoRL6dMRbMhJwmRUe1lb+/wGjfuzv+7+LxellZqqEGCtCWAIvCiWeJYn8LV
WGrdNrEzyJA/OK0yBAYfu33Kxjm8BA==
=aXHE
-----END PGP SIGNATURE-----

--FqLRvauUa70g9sqHEuhJ13svWEhhQ7m7n--
