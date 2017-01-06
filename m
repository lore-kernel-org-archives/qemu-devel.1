Received: from eggs.gnu.org ([2001:4830:134:3::10]:58650)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPXdp-0000Yz-5W
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:45:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cPXdl-0003hM-8e
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:45:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:48860)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1cPXdk-0003hD-WC
	for qemu-devel@nongnu.org; Fri, 06 Jan 2017 11:45:17 -0500
Received: from int-mx14.intmail.prod.int.phx2.redhat.com
	(int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EDD56C0567B5
	for <qemu-devel@nongnu.org>; Fri,  6 Jan 2017 16:45:16 +0000 (UTC)
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
	<20170105165329.17227-2-marcandre.lureau@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <eb000893-3982-016f-e4dc-81ce0f50b6ce@redhat.com>
Date: Fri, 6 Jan 2017 10:45:14 -0600
MIME-Version: 1.0
In-Reply-To: <20170105165329.17227-2-marcandre.lureau@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="i72h1K78XWwKgraTQCeKNGpEQmhOpmo8W"
Subject: Re: [Qemu-devel] [PATCH 01/20] tests: fix linking test-char on win32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--i72h1K78XWwKgraTQCeKNGpEQmhOpmo8W
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com
Message-ID: <eb000893-3982-016f-e4dc-81ce0f50b6ce@redhat.com>
Subject: Re: [PATCH 01/20] tests: fix linking test-char on win32
References: <20170105165329.17227-1-marcandre.lureau@redhat.com>
 <20170105165329.17227-2-marcandre.lureau@redhat.com>
In-Reply-To: <20170105165329.17227-2-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 01/05/2017 10:53 AM, Marc-Andr=C3=A9 Lureau wrote:
> test-char.exe needs main-loop.o symbols, among others. Linking with
> $(test-block-obj-y) brings what's necessary. We could try to eventually=

> strip to the minimum if needed.
>=20
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  tests/Makefile.include | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Can I have a bit more background? I'm guessing this doesn't fix an
actual failure at the moment (probably due to one of the other files
dragging in stuff indirectly), but rather cleans up a latent problem
that would otherwise be exposed with patches later in the series (where
splitting files means the stuff is no longer dragged in indirectly, so
we need to mention it explicitly)?

Even mentioning _which_ main-loop.o symbol to be grepping for in
test-char.c might be helpful to the review.

>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 4841d582a1..a8f3d12e49 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -489,7 +489,7 @@ tests/check-qjson$(EXESUF): tests/check-qjson.o $(t=
est-util-obj-y)
>  tests/check-qom-interface$(EXESUF): tests/check-qom-interface.o $(test=
-qom-obj-y)
>  tests/check-qom-proplist$(EXESUF): tests/check-qom-proplist.o $(test-q=
om-obj-y)
> =20
> -tests/test-char$(EXESUF): tests/test-char.o qemu-char.o qemu-timer.o $=
(test-util-obj-y) $(qtest-obj-y) $(test-io-obj-y)
> +tests/test-char$(EXESUF): tests/test-char.o qemu-char.o qemu-timer.o $=
(test-util-obj-y) $(qtest-obj-y) $(test-block-obj-y)

At any rate, test-block-obj-y is simply test-io-obj-y plus the
additional block-obj-y, so you're merely adding an additional dependency
on block-obj-y files.  While a nicer commit message may help, I don't
see any technical problem in the change, so here's a weak:

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--i72h1K78XWwKgraTQCeKNGpEQmhOpmo8W
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYb8maAAoJEKeha0olJ0Nqs9IH/iYv5NkQVitIsR/rmsbdJAyw
wr46edzI6OE7y7NgerinaWKRz+0DwbympB1LifHIJEprCDPq5m/VkCTriIkEwCxg
P9BRKmtpozDsAGSwuIa2ORxE3tu+4hD01zpE0JGV7g9z0jVeKAyQ3+fRG1vMPZ65
5o1F0CsR7QBUz3iMwHV3fP1ACT19BAyTV05s9dM15dql2GlMBMGxL3vreKQo1pxi
vPTZ6+fc7wTdW+MU1wg7YAck2G561npzWDB30RHwkr+oHEuOTdnVSH5q1IjqBfPR
ysm9ugANZ19PrF+9VcFEZCmP1+Hu7UmGASemkhJudHo6YHs3QONllCKHlgHSnz8=
=MaCl
-----END PGP SIGNATURE-----

--i72h1K78XWwKgraTQCeKNGpEQmhOpmo8W--
