Received: from eggs.gnu.org ([2001:4830:134:3::10]:36397)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e9GPn-0003R4-Ta
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:12:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e9GPm-0007AD-Jx
	for qemu-devel@nongnu.org; Mon, 30 Oct 2017 16:12:07 -0400
References: <20171027104037.8319-1-eblake@redhat.com>
	<20171027104037.8319-7-eblake@redhat.com>
	<59449c29-0335-9eaf-47a6-edd6cc35bf73@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <5b8fbdd6-c3cd-aed8-f633-ad5f0d07507d@redhat.com>
Date: Mon, 30 Oct 2017 21:11:53 +0100
MIME-Version: 1.0
In-Reply-To: <59449c29-0335-9eaf-47a6-edd6cc35bf73@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="SXmM7age9sIM3PwstXT1E5E8vVJE8Tgr1"
Subject: Re: [Qemu-devel] [PATCH v6 06/12] nbd/server: Refactor zero-length
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
--SXmM7age9sIM3PwstXT1E5E8vVJE8Tgr1
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, qemu-block@nongnu.org
Message-ID: <5b8fbdd6-c3cd-aed8-f633-ad5f0d07507d@redhat.com>
Subject: Re: [PATCH v6 06/12] nbd/server: Refactor zero-length option check
References: <20171027104037.8319-1-eblake@redhat.com>
 <20171027104037.8319-7-eblake@redhat.com>
 <59449c29-0335-9eaf-47a6-edd6cc35bf73@virtuozzo.com>
In-Reply-To: <59449c29-0335-9eaf-47a6-edd6cc35bf73@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/30/2017 06:22 PM, Vladimir Sementsov-Ogievskiy wrote:
> 27.10.2017 13:40, Eric Blake wrote:
>> Consolidate the response for a non-zero-length option payload
>> into a new function, nbd_reject_length().=C2=A0 This check will
>> also be used when introducing support for structured replies.
>>
>> Note that STARTTLS response differs based on time: if the connection
>> is still unencrypted, we set fatal to true (a client that can't
>> request TLS correctly may still think that we are ready to start
>> the TLS handshake, so we must disconnect); while if the connection
>> is already encrypted, the client is sending a bogus request but
>> is no longer at risk of being confused by continuing the connection.
>>

>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 switch (option) {
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 case NBD_OPT_STARTTLS:
>> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 tioc =3D nbd_negotiate_handle_starttls(client, leng=
th,
>> errp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (length) {
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Unconditionally drop the=
 connection if the client
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * can't start a TLS n=
egotiation correctly */
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 nbd_reject_length(client, l=
ength, option, true,
>> errp);
>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return -EINVAL;
>=20
> why not to return nbd_reject_length's result? this EINVAL may not
> correspond to errp (about EIO for example)..

Somewhat true, if nbd_reject_length() fails. But nbd_reject_length() may
also return 0 without setting errp, in which case, maybe this code
should set errp rather than just blindly returning -EINVAL.

>=20
> with or without this fixed:
>=20
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20

Okay, I'll squash this in, and include it in my pull request to be sent
shortly.

diff --git i/nbd/server.c w/nbd/server.c
index a9480e42cd..91f81a0f19 100644
--- i/nbd/server.c
+++ w/nbd/server.c
@@ -684,8 +684,13 @@ static int nbd_negotiate_options(NBDClient *client,
uint16_t myflags,
                 if (length) {
                     /* Unconditionally drop the connection if the client=

                      * can't start a TLS negotiation correctly */
-                    nbd_reject_length(client, length, option, true, errp=
);
-                    return -EINVAL;
+                    ret =3D nbd_reject_length(client, length, option,
true, errp);
+                    if (!ret) {
+                        error_setg(errp, "option '%s' should have zero
length",
+                                   nbd_opt_lookup(option));
+                        ret =3D -EINVAL;
+                    }
+                    return ret;
                 }
                 tioc =3D nbd_negotiate_handle_starttls(client, errp);
                 if (!tioc) {


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--SXmM7age9sIM3PwstXT1E5E8vVJE8Tgr1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln3h4kACgkQp6FrSiUn
Q2oITAf9HKgYhMJybkwsB70Xxhvq14hUMZKd/gctd8k9oyzErjxuyR11lDXIy9F/
zUkJQWVXxTaQgV+fSviUuNYBdvFr574WTi12dQE9RjsLrHYoZOiCORQu8eZJnOgN
M36b+hcz2kWnlPZ9HOwREB+ra1PI5L5PnF3AmYFX6KRL8+8zZ/UGAuqGwQCpndOc
I4nbJ8qjHTcDjmJz1ABFrKMETMBDQUa/UJT53xMp8Da4WgaCRpA6TY4uZZ4Hm/+6
pB80UXlDJaEZYlTLXsSgi3vQ1k+BDtSETxoCQJ4MQkFNLFVD19JjEqIFXKpc1KMa
JDdBfjw4Nk0pNDEeJSGXq1q7QxYCCw==
=Px6w
-----END PGP SIGNATURE-----

--SXmM7age9sIM3PwstXT1E5E8vVJE8Tgr1--
