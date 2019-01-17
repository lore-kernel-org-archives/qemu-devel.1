Received: from eggs.gnu.org ([209.51.188.92]:60443)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gk7p9-0003QO-8Z
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:35:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gk7od-0002TN-Sw
	for qemu-devel@nongnu.org; Thu, 17 Jan 2019 08:35:11 -0500
References: <20190112175812.27068-1-eblake@redhat.com>
	<20190112175812.27068-20-eblake@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d163e895-3e0e-7042-899d-5f2577652794@redhat.com>
Date: Thu, 17 Jan 2019 07:34:05 -0600
MIME-Version: 1.0
In-Reply-To: <20190112175812.27068-20-eblake@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="KjvA2YINcqAIJ99zmGtFdGD72mPRkMW0K"
Subject: Re: [Qemu-devel] [PATCH v3 19/19] iotests: Enhance 223,
 233 to cover 'qemu-nbd --list'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com, qemu-block@nongnu.org, rjones@redhat.com, Max Reitz <mreitz@redhat.com>, nsoffer@redhat.com, jsnow@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KjvA2YINcqAIJ99zmGtFdGD72mPRkMW0K
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, vsementsov@virtuozzo.com,
 qemu-block@nongnu.org, rjones@redhat.com, Max Reitz <mreitz@redhat.com>,
 nsoffer@redhat.com, jsnow@redhat.com
Message-ID: <d163e895-3e0e-7042-899d-5f2577652794@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 19/19] iotests: Enhance 223, 233 to cover
 'qemu-nbd --list'
References: <20190112175812.27068-1-eblake@redhat.com>
 <20190112175812.27068-20-eblake@redhat.com>
In-Reply-To: <20190112175812.27068-20-eblake@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/12/19 11:58 AM, Eric Blake wrote:
> Any good new feature deserves some regression testing :)
> Coverage includes:
> - 223: what happens when there are 0 or more than 1 export,
> proof that we can see multiple contexts including qemu:dirty-bitmap
> - 233: proof that we can list over TLS, and that mix-and-match of
> plain/TLS listings will behave sanely
>=20
> Signed-off-by: Eric Blake <eblake@redhat.com>
> Reviewed-by: Richard W.M. Jones <rjones@redhat.com>
> Tested-by: Richard W.M. Jones <rjones@redhat.com>
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>=20
> ---
> v3: Rebase to earlier changes
> ---
>  tests/qemu-iotests/223     |  2 ++
>  tests/qemu-iotests/223.out | 20 ++++++++++++++++++++
>  tests/qemu-iotests/233     | 19 +++++++++++++------
>  tests/qemu-iotests/233.out | 15 +++++++++++++++
>  4 files changed, 50 insertions(+), 6 deletions(-)

Test 233 has a pre-existing race, but this patch made it more likely to
hit. I got:

+++ /home/eblake/qemu/tests/qemu-iotests/233.out.bad	2019-01-16
22:16:17.482019114 -0600
@@ -42,8 +42,8 @@
 =3D=3D check TLS with different CA fails =3D=3D
 qemu-nbd: option negotiation failed: Verify failed: No certificate was
found.
 qemu-img: Could not open
'driver=3Dnbd,host=3D127.0.0.1,port=3DPORT,tls-creds=3Dtls0': The certifi=
cate
hasn't got a known issuer
-qemu-nbd: option negotiation failed: Verify failed: No certificate was
found.
 qemu-nbd: The certificate hasn't got a known issuer
+qemu-nbd: option negotiation failed: Verify failed: No certificate was
found.


The problem? We have output from two separate qemu-nbd processes (the
server, and the --list client), which are getting interleaved in an
arbitrary fashion according to who wins the scheduler race. I'm working
on a fix; probably by capturing the server's output to a file and then
cat'ing that file at the end.


--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--KjvA2YINcqAIJ99zmGtFdGD72mPRkMW0K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxAhE4ACgkQp6FrSiUn
Q2qOHAgArAYPc135DmUS4kvfAG4cEqSF0LAlNOixPCTGSMaJIdah5trJ71ytUadB
dCrhsX+5wRoA8bNCqGVclFBJ8eBp0khKIiNoY0+7AKpTi98HXbvExURGwB14yqO7
oRYC+AFp//utTLF0Fvybb2HPTrwPISsd35udCab/RKlmTra0++/m07LAGFK27ggx
l8pYR3AMKPcf+xejODHgNfBC4dJEqXKXA1PO6GvjZ1HpNOB90OUJ0YE3bYAnnezm
Uv4R6FVF1B9ShstV/DLoaUFIOnQ81aFCUmGShVFRToDkyIQfgqCgOb4k2ykXeyRR
yQ9X+ZaN2vUE+W64Ci5KMzGdF1Nguw==
=PfTF
-----END PGP SIGNATURE-----

--KjvA2YINcqAIJ99zmGtFdGD72mPRkMW0K--
