Received: from eggs.gnu.org ([2001:4830:134:3::10]:45710)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmjae-00070u-77
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:42:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dmjaa-0005eO-7a
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:42:12 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36584)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1dmjaZ-0005dx-Th
	for qemu-devel@nongnu.org; Tue, 29 Aug 2017 12:42:08 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D95744DD4B
	for <qemu-devel@nongnu.org>; Tue, 29 Aug 2017 16:42:06 +0000 (UTC)
References: <20170829162727.13081-1-berrange@redhat.com>
	<a51f6738-f858-1ea2-ec08-eb68339eff90@redhat.com>
	<20170829163427.GG25801@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <3aec24f8-b5ba-b18c-58ec-462c3483f6f0@redhat.com>
Date: Tue, 29 Aug 2017 11:42:05 -0500
MIME-Version: 1.0
In-Reply-To: <20170829163427.GG25801@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cGfxeqFMiQ1cPOAlexRMAaqbq1G79QqmV"
Subject: Re: [Qemu-devel] [PATCH] crypto: fix test cert generation to not
 use SHA1 algorithm
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cGfxeqFMiQ1cPOAlexRMAaqbq1G79QqmV
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>
Cc: qemu-devel@nongnu.org
Message-ID: <3aec24f8-b5ba-b18c-58ec-462c3483f6f0@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] crypto: fix test cert generation to not use
 SHA1 algorithm
References: <20170829162727.13081-1-berrange@redhat.com>
 <a51f6738-f858-1ea2-ec08-eb68339eff90@redhat.com>
 <20170829163427.GG25801@redhat.com>
In-Reply-To: <20170829163427.GG25801@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/29/2017 11:34 AM, Daniel P. Berrange wrote:
> On Tue, Aug 29, 2017 at 11:31:24AM -0500, Eric Blake wrote:
>> On 08/29/2017 11:27 AM, Daniel P. Berrange wrote:
>>> GNUTLS 3.6.0 marked SHA1 as untrusted for certificates.
>>> Unfortunately the gnutls_x509_crt_sign() method we are
>>> using to create certificates in the test suite is fixed
>>> to always use SHA1. We must switch to a different method
>>> and explicitly ask for SHA256.
>>>
>>> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
>>> ---
>>>  tests/crypto-tls-x509-helpers.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/tests/crypto-tls-x509-helpers.c b/tests/crypto-tls-x509-=
helpers.c
>>> index 64073d3bd3..173d4e28fb 100644
>>> --- a/tests/crypto-tls-x509-helpers.c
>>> +++ b/tests/crypto-tls-x509-helpers.c
>>> @@ -406,7 +406,8 @@ test_tls_generate_cert(QCryptoTLSTestCertReq *req=
,
>>>       * If no 'ca' is set then we are self signing
>>>       * the cert. This is done for the root CA certs
>>>       */
>>> -    err =3D gnutls_x509_crt_sign(crt, ca ? ca : crt, privkey);
>>> +    err =3D gnutls_x509_crt_sign2(crt, ca ? ca : crt, privkey,
>>> +                                GNUTLS_DIG_SHA256, 0);
>>
>> Is _sign2() available on all the older versions of gnutls that we must=

>> support, or do we need this to be a conditional compilation?
>=20
> It dates to gnutls 1.2.0 from 2005, so we're fine even if using RHEL5
> vintage :-)

Good to know. Not sure if it's worth mentioning that in the commit
message.  Either way,

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--cGfxeqFMiQ1cPOAlexRMAaqbq1G79QqmV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmlmV0ACgkQp6FrSiUn
Q2qsgwf/eSMH+D+w658K8CnFOG+QK+5kVrEJaGtw4eWMysLSmXIFHZo1jG0UT2yB
QXw2vH1RR5QY0sb9j6RcACf6stUDebum+vE/iBJYy3b6ukMG9u5lBgcPj+RzxHZ/
D8zsClJ42xAUeS23uUYz069trbyPaWI9ZQNWhfeTor5dUHL8OrUJAu7STcBF7fU5
XXu/oE+GWpdh20cU06c3kNSYGXXnQiUDgN/ah5UL8YzuZjyH6YWoiG0T0ARL4mV0
SUn0Kkf+4y8Hw2Zlj3GeeRNBDwPSv05dI43AHzkFnlfQHG3y88Lv6ZwmISLWHE85
qEvCA1YLOQjRN80Gd2Q1RCZnVJJ6dw==
=s17N
-----END PGP SIGNATURE-----

--cGfxeqFMiQ1cPOAlexRMAaqbq1G79QqmV--
