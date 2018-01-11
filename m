Received: from eggs.gnu.org ([2001:4830:134:3::10]:33002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZiwZ-0007VC-8M
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:55:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eZiwN-0003Ap-5W
	for qemu-devel@nongnu.org; Thu, 11 Jan 2018 14:55:19 -0500
References: <20180110230825.18321-1-eblake@redhat.com>
	<20180110230825.18321-3-eblake@redhat.com>
	<b95cd0c3-0581-b763-07f2-8f90ef5e2e25@virtuozzo.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <b711b9dc-559a-9381-4fd4-f3c5b0907c18@redhat.com>
Date: Thu, 11 Jan 2018 13:54:46 -0600
MIME-Version: 1.0
In-Reply-To: <b95cd0c3-0581-b763-07f2-8f90ef5e2e25@virtuozzo.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="RpNFVsA6OqVbwY3Ibvsf7bG5WBayJmJo6"
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
--RpNFVsA6OqVbwY3Ibvsf7bG5WBayJmJo6
From: Eric Blake <eblake@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b711b9dc-559a-9381-4fd4-f3c5b0907c18@redhat.com>
Subject: Re: [PATCH v2 2/6] nbd/server: refactor negotiation functions
 parameters
References: <20180110230825.18321-1-eblake@redhat.com>
 <20180110230825.18321-3-eblake@redhat.com>
 <b95cd0c3-0581-b763-07f2-8f90ef5e2e25@virtuozzo.com>
In-Reply-To: <b95cd0c3-0581-b763-07f2-8f90ef5e2e25@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2018 11:55 AM, Vladimir Sementsov-Ogievskiy wrote:
> 11.01.2018 02:08, Eric Blake wrote:
>> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>>
>> Instead of passing currently negotiating option and its length to
>> many of negotiation functions let's just store them on NBDClient
>> struct to be state-variables of negotiation phase.
>>
>> This unifies semantics of negotiation functions and allows
>> tracking changes of remaining option length in future patches.
>>
>> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>=

>> Reviewed-by: Eric Blake <eblake@redhat.com>
>> Message-Id: <20171122101958.17065-2-vsementsov@virtuozzo.com>
>> [eblake: rebase, commit message tweak, assert !optlen after
>> negotiation completes]
>> Signed-off-by: Eric Blake <eblake@redhat.com>
>> ---
>> =C2=A0 nbd/server.c | 168
>> +++++++++++++++++++++++++++++------------------------------
>> =C2=A0 1 file changed, 84 insertions(+), 84 deletions(-)
>=20

>> @@ -1707,6 +1706,7 @@ static coroutine_fn void
>> nbd_co_client_start(void *opaque)
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return;
>> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>>
>> +=C2=A0=C2=A0=C2=A0 assert(!client->optlen);
>=20
>=20
> hmm, should not it be at the end of nbd_negotiate() ? Looks OK anyway.

Sure, I'll squash this in, for no real change in behavior:

diff --git i/nbd/server.c w/nbd/server.c
index c22d5e6ecf..3fd145592e 100644
--- i/nbd/server.c
+++ w/nbd/server.c
@@ -902,6 +902,7 @@ static coroutine_fn int nbd_negotiate(NBDClient
*client, Error **errp)
         }
     }

+    assert(!client->optlen);
     trace_nbd_negotiate_success();

     return 0;
@@ -1726,7 +1727,6 @@ static coroutine_fn void nbd_co_client_start(void
*opaque)
         return;
     }

-    assert(!client->optlen);
     nbd_client_receive_next_request(client);
 }



--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--RpNFVsA6OqVbwY3Ibvsf7bG5WBayJmJo6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpXwQYACgkQp6FrSiUn
Q2oGmgf/VbjCff9M/AfuX2GGViLVjw4XfWNK/Ku2+a5q8JmOo5wNAJAumiqAluDm
Ks0JeBt00xFJQzYgdGH8GJg21m3V1J2GCVCGn0ipenoQbKNa1BngHIGXjmpmRNZu
eFyuUaRW+Z8KdPFgb5MqWaV/xa8U3ySXsYSoL2udFr2T7jC6rT35Mh25wzwZPJlK
Ex1ankb5J2GonZYDoFu1ECUJYnMBJvbtQ7vtR/rUy8PH38n514LXnoFEIhukiV2B
kUxBa3/reaY0tfnaGm2CECBtn8wYV2n8nBOkpsUqmNMCEPtuL2ZeVnjG7jqyisv+
jzNUTDjxhJ8NHeoxD2ra1EjFF2z3gA==
=ddgS
-----END PGP SIGNATURE-----

--RpNFVsA6OqVbwY3Ibvsf7bG5WBayJmJo6--
