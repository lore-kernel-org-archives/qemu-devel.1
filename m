Received: from eggs.gnu.org ([2001:4830:134:3::10]:52702)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEMGS-00036W-5Q
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:23:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cEMGN-0003e6-Mz
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:23:00 -0500
Received: from mail-wm0-f65.google.com ([74.125.82.65]:34964)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cEMGN-0003dn-H4
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 15:22:55 -0500
Received: by mail-wm0-f65.google.com with SMTP id a20so23843864wme.2
	for <qemu-devel@nongnu.org>; Tue, 06 Dec 2016 12:22:55 -0800 (PST)
Date: Tue, 6 Dec 2016 20:21:51 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20161206202151.GE2521@stefanha-x1.localdomain>
References: <1481047629-7763-1-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M/SuVGWktc5uNpra"
Content-Disposition: inline
In-Reply-To: <1481047629-7763-1-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH for-2.8] exec.c: Fix breakpoint
 invalidation race
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, Julian Brown <julian@codesourcery.com>, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>


--M/SuVGWktc5uNpra
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 06, 2016 at 06:07:09PM +0000, Peter Maydell wrote:
> A bug (1647683) was reported showing a crash when removing
> breakpoints.  The reproducer was bisected to 3359baad when tb_flush
> was finally made thread safe.  While in MTTCG the locking in
> breakpoint_invalidate would have prevented any problems, but
> currently tb_lock() is a NOP for system emulation.
>=20
> The race is between a tb_flush from the gdbstub and the
> tb_invalidate_phys_addr() in breakpoint_invalidate().
>=20
> Ideally we'd have actual locking here; for the moment the
> simple fix is to do a full tb_flush() for a bp invalidate,
> since that is thread-safe even if no lock is taken.
>=20
> Reported-by: Julian Brown <julian@codesourcery.com>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This is quite similar to Alex's patch
> http://patchwork.ozlabs.org/patch/703188/
> ("exec.c: simplify the breakpoint invalidation logic").
> The difference is that this patch doesn't drop the
> breakpoint_invalidate() function entirely. I think this
> is better both for a future "correct fix" and as a
> minimal "just fix this for 2.8 release" change.
> ---
>  exec.c | 25 ++++++-------------------
>  1 file changed, 6 insertions(+), 19 deletions(-)

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--M/SuVGWktc5uNpra
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYRx3fAAoJEJykq7OBq3PI0t4IAK6f+3QbZimNVVZ/7rzeHx9v
9zF8y7FNKsLAkLQj2Af0K7IYCS4vUVX4G2oGZ62g6kceGCzIrJvpsSaBGeN1vwom
m9+TLR6+/wIzGtpb5af3WiTQlWniNolQMD4Bvq/6T+vHOnKKy8IleIuxa5lVeDzx
gct+4ur/55407e/sx+M91QVAXk54a8fIiTDuGJ6dRQZI/t5qD5ScD7KV5VJYEDLX
49w4KhloBUMBVpoVeLczuG83uLyYOknygGkYymOrVyj4OTNF35tpmprLnqtV8+IS
5mDgbzG23rmj4RRKMg82Ffot64DI1SQbsBDz5V4sfA3ZrwMZqeCHyF8A+xqeFOE=
=NUiL
-----END PGP SIGNATURE-----

--M/SuVGWktc5uNpra--
