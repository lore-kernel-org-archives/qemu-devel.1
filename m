Received: from eggs.gnu.org ([2001:4830:134:3::10]:34569)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ea0PV-0005wo-7J
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:34:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1ea0PU-0006Uo-AU
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 09:34:21 -0500
References: <20180110230825.18321-1-eblake@redhat.com>
	<20180110230825.18321-3-eblake@redhat.com>
	<b95cd0c3-0581-b763-07f2-8f90ef5e2e25@virtuozzo.com>
	<b711b9dc-559a-9381-4fd4-f3c5b0907c18@redhat.com>
	<e8c317c0-9650-e0fb-d30d-ea0490698ce6@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d40e657a-61b7-face-d07e-86c95537c78d@redhat.com>
Date: Fri, 12 Jan 2018 08:34:09 -0600
MIME-Version: 1.0
In-Reply-To: <e8c317c0-9650-e0fb-d30d-ea0490698ce6@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="IRcOzr2u2DR7x28CP6VbcFwcJiRkOcfcd"
Subject: Re: [Qemu-devel] [PATCH v2 2/6] nbd/server: refactor negotiation
 functions parameters
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IRcOzr2u2DR7x28CP6VbcFwcJiRkOcfcd
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d40e657a-61b7-face-d07e-86c95537c78d@redhat.com>
Subject: Re: [PATCH v2 2/6] nbd/server: refactor negotiation functions
 parameters
References: <20180110230825.18321-1-eblake@redhat.com>
 <20180110230825.18321-3-eblake@redhat.com>
 <b95cd0c3-0581-b763-07f2-8f90ef5e2e25@virtuozzo.com>
 <b711b9dc-559a-9381-4fd4-f3c5b0907c18@redhat.com>
 <e8c317c0-9650-e0fb-d30d-ea0490698ce6@virtuozzo.com>
In-Reply-To: <e8c317c0-9650-e0fb-d30d-ea0490698ce6@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/12/2018 04:18 AM, Vladimir Sementsov-Ogievskiy wrote:

>>> hmm, should not it be at the end of nbd_negotiate() ? Looks OK anyway=
=2E
>> Sure, I'll squash this in, for no real change in behavior:
>>
>> diff --git i/nbd/server.c w/nbd/server.c
>> index c22d5e6ecf..3fd145592e 100644
>> --- i/nbd/server.c
>> +++ w/nbd/server.c
>> @@ -902,6 +902,7 @@ static coroutine_fn int nbd_negotiate(NBDClient
>> *client, Error **errp)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> +=C2=A0=C2=A0=C2=A0 assert(!client->optlen);
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_nbd_negotiate_success();
>>

This says that after all negotiation is complete, optlen is 0 (so in
reality, it is only checking NBD_OPT_GO and NBD_OPT_EXPORT_NAME - since
those are the only two options that can end negotiation).  But it does
not check state in between individual options during the actual
negotiation.  Also, this is the only spot in the code that can check
that optlen is 0 even for old-style connections (where we do not call
nbd_negotiate_options), so it's a nice spot to prove that when we move
into transmission phase, we aren't stranding any unread data from
handshake phase.

>=20
>=20
> or, even better, in nbd_negotiate_options. and you actually do it in 5/=
6.

Whereas that is stating that optlen is 0 after every option that does
not return early (not possible in this patch, because we need the
nbd_opt_read() helper in 5/6 that clears optlen as we go) - and
meanwhile does NOT cover the places that return early (NBD_OPT_GO and
NBD_OPT_EXPORT_NAME, which we caught here).  So we need both assertions
at the end of the series, and I'm comfortable with introducing them in
separate patches.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--IRcOzr2u2DR7x28CP6VbcFwcJiRkOcfcd
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpYx2EACgkQp6FrSiUn
Q2oLpwf/Q12ojCAdeoR6vZbmGJSU80F2XR/PfDroJQKeuw3bYdK2xPQaWzVxVV9G
NO2IybYJJB6ZLi+zeqQIBxNGGOF0sZPQOMEO6jCDWzbTojuNG2iXzhiQlZrrBwpT
54YYXy848doA0KYmGrzejarDBZNHQyKCLhk3LJjcCHPh3XaVFPJs6xkcEYhuYoSn
oUMPZLvqvwGDm0I/T8NVuy+LGAj9PIvYTjcsqD4pj62kQzubz/kUfa0qsj4AvMDl
ZOEIOmccYkBWVty+BNP/5dp3rZklNArMof9kLVa1b25LNrVYpsud5FkqeQZg7Gqu
z9IUWJCwd4vZkze8SwmsM7Ni6wa/Tw==
=hsIl
-----END PGP SIGNATURE-----

--IRcOzr2u2DR7x28CP6VbcFwcJiRkOcfcd--
