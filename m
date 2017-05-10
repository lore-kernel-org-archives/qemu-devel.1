Received: from eggs.gnu.org ([2001:4830:134:3::10]:34599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d8Udo-0008Dr-5H
	for qemu-devel@nongnu.org; Wed, 10 May 2017 12:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1d8Udn-0002FZ-AW
	for qemu-devel@nongnu.org; Wed, 10 May 2017 12:39:08 -0400
References: <20170510143205.32013-1-pbonzini@redhat.com>
	<20170510143205.32013-4-pbonzini@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <d885ccd0-abd8-2a3f-f96f-a959ef576c82@redhat.com>
Date: Wed, 10 May 2017 18:38:58 +0200
MIME-Version: 1.0
In-Reply-To: <20170510143205.32013-4-pbonzini@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="PODkhE4mg5Mt0dNmGsm4ORl3bjswOLQio"
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 3/7] curl: avoid recursive
 locking of BDRVCURLState mutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PODkhE4mg5Mt0dNmGsm4ORl3bjswOLQio
From: Max Reitz <mreitz@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-stable@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com
Message-ID: <d885ccd0-abd8-2a3f-f96f-a959ef576c82@redhat.com>
Subject: Re: [Qemu-block] [PATCH 3/7] curl: avoid recursive locking of
 BDRVCURLState mutex
References: <20170510143205.32013-1-pbonzini@redhat.com>
 <20170510143205.32013-4-pbonzini@redhat.com>
In-Reply-To: <20170510143205.32013-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10.05.2017 16:32, Paolo Bonzini wrote:
> The curl driver has a ugly hack where, if it cannot find an empty CURLS=
tate,
> it just uses aio_poll to wait for one to be empty.  This is probably
> buggy when used together with dataplane, and the simplest way to fix it=

> is to use coroutines instead.
>=20
> A more immediate effect of the bug however is that it can cause a
> recursive call to curl_readv_bh_cb and recursively taking the
> BDRVCURLState mutex.  This causes a deadlock.
>=20
> The fix is to unlock the mutex around aio_poll, but for cleanliness we
> should also take the mutex around all calls to curl_init_state, even if=

> reaching the unlock/lock pair is impossible.  The same is true for
> curl_clean_state.
>=20
> Reported-by: Richard W.M. Jones <rjones@redhat.com>
> Cc: jcody@redhat.com
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/curl.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--PODkhE4mg5Mt0dNmGsm4ORl3bjswOLQio
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlkTQiMSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AxcEH/jTShoywRBAPayrKzWF2k1MpL2mrJayE
qarrNWjq0d+5eENeAj9lx035tS94Al1pUQ51J8h1YdVdw2Jy31iCwRhJDG2Zlcnx
TZCp3TDq1BdyKEFjzL11megr2dDAFpNm+RAVKqYSdW5LPA8J++XU8PL93GOMsF6U
7MxEY/WH9WR4H3qMAvIbtmdYSm2zDYKF7Cs4O8JCB9id4ObCx3jvpYRlpNtrt+li
JOSbaMIxzbDG84f8FM98BTF9OrDZVL/OWQNCVAoGh0O1Hb7Ho6SfG1nFTGigFsUc
NZtmUaOQGs278Ox0lCV/Lejw8xO+KJgVSWELJ9XCENfcDJphCXxWbp4=
=eMWu
-----END PGP SIGNATURE-----

--PODkhE4mg5Mt0dNmGsm4ORl3bjswOLQio--
