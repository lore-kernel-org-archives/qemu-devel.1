Received: from eggs.gnu.org ([2001:4830:134:3::10]:33295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRMS4-00024u-FC
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:12:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cRMS0-0007Sn-E5
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:12:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48886)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cRMS0-0007S9-74
	for qemu-devel@nongnu.org; Wed, 11 Jan 2017 12:12:40 -0500
References: <20170111164105.27164.30697.malonedeb@chaenomeles.canonical.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4fc41772-1607-7e55-ffa1-80e3579b964d@redhat.com>
Date: Wed, 11 Jan 2017 11:12:38 -0600
MIME-Version: 1.0
In-Reply-To: <20170111164105.27164.30697.malonedeb@chaenomeles.canonical.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="34iWOJUlsh3Tr2o9taRGOko8QOjNJ4vF4"
Subject: Re: [Qemu-devel] [Bug 1655708] [NEW] target/ppc/int_helper.c:2806:
 strange expression ?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1655708 <1655708@bugs.launchpad.net>, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--34iWOJUlsh3Tr2o9taRGOko8QOjNJ4vF4
From: Eric Blake <eblake@redhat.com>
To: Bug 1655708 <1655708@bugs.launchpad.net>, qemu-devel@nongnu.org
Message-ID: <4fc41772-1607-7e55-ffa1-80e3579b964d@redhat.com>
Subject: Re: [Qemu-devel] [Bug 1655708] [NEW] target/ppc/int_helper.c:2806:
 strange expression ?
References: <20170111164105.27164.30697.malonedeb@chaenomeles.canonical.com>
In-Reply-To: <20170111164105.27164.30697.malonedeb@chaenomeles.canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/11/2017 10:41 AM, dcb wrote:
> Public bug reported:
>=20
> target/ppc/int_helper.c:2806:25: warning: =E2=80=98*=E2=80=99 in boolea=
n context,
> suggest =E2=80=98&&=E2=80=99 instead [-Wint-in-bool-context]
>=20
> Source code is
>=20
>        zone_digit =3D (i * 2) ? b->u8[BCD_DIG_BYTE(i * 2)] >> 4 :
> zone_lead;

Also, looking at BCD_DIG_BYTE():

#if defined(HOST_WORDS_BIGENDIAN)
#define BCD_DIG_BYTE(n) (15 - (n/2))
#else
#define BCD_DIG_BYTE(n) (n/2)
#endif

Oops. n is under-parenthesized, and will cause invalid expansions for
some expressions.  Let's fix that as well.


> so I think the compiler warning is for the i * 2 lhs of the ?.

Yes - the compiler is complaining that 'i * 2' can only be non-zero if
'i' was non-zero (given that the code occurs in a loop for i between 0
and 16), so it is just as easy to write 'i ? ...' instead of the weirder
'(i * 2) ? ...'.

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--34iWOJUlsh3Tr2o9taRGOko8QOjNJ4vF4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYdmeGAAoJEKeha0olJ0NqeJgH/j21mP2WwE68BuSrMWeyX4LT
2k/F0JFyjSyfoORHIiT40hIGYDPWE9eG1EH+DAnBx69dFY2FxalqWxGjD3Xy2sG/
3AUMsyXi9Q1pPg9xg2Y1dAvkAfAjxbfh6Zu0W00YlEwUToSyJ67mZ3wN1IYHyxHK
zIpgFbr8v70D2L/44bFj8si8dBq2omEDGwUskprK2majixYqPpNnsmyJYo9Au1iY
zvEsikhFNK5azGTzCOPh+jOkVqlJg5gd1NeR+rQ3Fi7Voj0EdgHdkUSsI11VAzYf
KX2+ce64CY4gQ8aXFUtAhYQ+585RXJ4KuvZWFSX6OXMUK/fAQKFukPw9xHPnYms=
=1vKh
-----END PGP SIGNATURE-----

--34iWOJUlsh3Tr2o9taRGOko8QOjNJ4vF4--
