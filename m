Received: from eggs.gnu.org ([2001:4830:134:3::10]:37520)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1diozn-0000iy-0s
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:40:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1diozj-0003aB-0u
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:39:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54572)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1diozi-0003ZB-Mo
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 17:39:54 -0400
References: <20170818211542.5380-1-eblake@redhat.com>
	<20170818211542.5380-3-eblake@redhat.com>
	<cb8a8b43-e511-a892-24a7-09cac4836648@amsat.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d39d17a5-7f78-08e5-ade5-8a173c5f0393@redhat.com>
Date: Fri, 18 Aug 2017 16:39:51 -0500
MIME-Version: 1.0
In-Reply-To: <cb8a8b43-e511-a892-24a7-09cac4836648@amsat.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="s0dLIfsijFNCFjVp6dA1339qwPCgtbNlq"
Subject: Re: [Qemu-devel] [PATCH v5 02/13] qtest: Don't perform side effects
 inside assertion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: armbru@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--s0dLIfsijFNCFjVp6dA1339qwPCgtbNlq
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com
Message-ID: <d39d17a5-7f78-08e5-ade5-8a173c5f0393@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v5 02/13] qtest: Don't perform side effects
 inside assertion
References: <20170818211542.5380-1-eblake@redhat.com>
 <20170818211542.5380-3-eblake@redhat.com>
 <cb8a8b43-e511-a892-24a7-09cac4836648@amsat.org>
In-Reply-To: <cb8a8b43-e511-a892-24a7-09cac4836648@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/18/2017 04:33 PM, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Eric,
>=20
> On 08/18/2017 06:15 PM, Eric Blake wrote:
>> Assertions should be separate from the side effects, since in
>> theory, g_assert() can be disabled (in practice, we can't really
>> ever do that).
>=20
> What about the suggestion on your "Hacks for building on gcc 7 / Fedora=

> 26" series about avoid building without assertions?

NDEBUG doesn't affect g_assert() (only assert(), but that wasn't in use
here) - I have to double-check glib documentation to see whether
g_assert() can be crippled in a manner similar to how I know assert()
can be crippled.  Ideally, we have a form that always performs side
effects exactly once, whether or not abort-on-error is enabled (assert()
does not have that, but I don't know whether glib does).

>=20
> The obvious win is a more readable code.
>=20
> http://lists.nongnu.org/archive/html/qemu-devel/2017-07/msg06084.html

Indeed, that's a patch proposal that I still haven't written, but it can
be done independently of this series.

Still, even if we guarantee that assertions will never be crippled for
qemu, it is bad practice to code side-effects in an assert(), because it
makes the code harder to copy-and-paste into projects that DO work with
assertions disabled, and it raises red flags in reviewers' minds of
whether it was intentional.

[And truth be told, this particular patch is not really about libqtest,
so much as something that horrified me when I was grepping for
qemu_strtoul() in order to fix the checkpatch warning I got on
libqtest's raw use of strtol() in patch 6, and which necessitated me to
write patch 5 - even though the name of the file in question is 'qtest.c'=
]

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--s0dLIfsijFNCFjVp6dA1339qwPCgtbNlq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmXXqcACgkQp6FrSiUn
Q2qZCgf/WLZ6EVwZJ17SRpCEFRSgLzsthKGmKWsCny1hebisejbeifei8sQ9/040
UCGqAVoJv6kLVyIN32bgPmR/wvNuLZozhtaU1Bc97U2y+iE4mYr/v+CMKmEA8mDn
rH0R2BzxehRzGdZF13EPSTR4T3JNgrTkIceFhMHgUMPOZEHSlwCyGxmizW7oDzxb
NNf9mzQFEIXP5v0wMoZte5oucJQvpv5rFepxpFWghOF+YXqBnhSzNd7W1T07zbCg
OcKzDBGTQ/9QdG3QlrheWgh43ZLbPtveMUpYBrQ0alu1GlgwDwjXjOpDb7FMG8Ll
ml084ZvWaNbyx6V4KQcjVuD9K9bcjg==
=LyD4
-----END PGP SIGNATURE-----

--s0dLIfsijFNCFjVp6dA1339qwPCgtbNlq--
