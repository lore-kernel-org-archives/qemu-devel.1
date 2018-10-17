Received: from eggs.gnu.org ([2001:4830:134:3::10]:53193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gCihR-0005UQ-IS
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1gCihM-0008GB-HH
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:09 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b]:39778)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1gCihM-000878-4a
	for qemu-devel@nongnu.org; Wed, 17 Oct 2018 06:05:04 -0400
Received: by mail-wm1-x32b.google.com with SMTP id y144-v6so1492398wmd.4
	for <qemu-devel@nongnu.org>; Wed, 17 Oct 2018 03:05:04 -0700 (PDT)
Date: Wed, 17 Oct 2018 11:05:01 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20181017100501.GM22755@stefanha-x1.localdomain>
References: <87efcqniza.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Aaj1jBvBEV7KRjLi"
Content-Disposition: inline
In-Reply-To: <87efcqniza.fsf@dusky.pond.sub.org>
Subject: Re: [Qemu-devel] When it's okay to treat OOM as fatal?
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org


--Aaj1jBvBEV7KRjLi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Oct 16, 2018 at 03:01:29PM +0200, Markus Armbruster wrote:
> Anything that pages commonly becomes unusable long before
> allocations fail.  Anything that overcommits will send you a (commonly
> lethal) signal instead.  Anything that tries handling OOM gracefully,
> and manages to dodge both these bullets somehow, will commonly get it
> wrong and crash.

In the block layer blk_try_blockalign() (previously
qemu_try_blockalign()) is used because significant amounts of memory can
be allocated by the untrusted guest or untrusted disk image files.  I
think the error handling is reasonable in those cases:
1. QEMU startup or disk hotplug fail with a nice error message
OR
2. An I/O request is failed (ultimately just EIO error reporting but
   it's better than killing the QEMU process!)

I'm pretty sure ENOMEM errors are possible even when memory overcommit
is enabled.

My thinking has been to use g_new() for small QEMU-internal structures
and g_try_new() for large amounts of memory allocated in response to
untrusted inputs.  (Untrusted inputs must never be used for unbounded
allocation sizes but those bounded sizes can still be large.)

Stefan

--Aaj1jBvBEV7KRjLi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbxwlNAAoJEJykq7OBq3PIpBEIAMpZ6wA3hpet4BzUkMCF1+Yg
kZoXLyAO6lpETHuU4+VQb/Vf3qrTB1/GAWUrB8P/HPryFZAZdabClmMjDx3Srt0l
vVvfxODW3Fw9/dzojxtovNADoxiOJi3z4dZziRhvY9BWTsvXO7fIMeJCWlCJkOrt
Q9E05JkHLkzcBxIqGoGnaXuLpl3vvqUTKdAJv6nCRef7QjytIc75ItFotA524u0/
SZEtO5lWu2wj53hzbjxDyoYttKY+GrureaeGNkNvO3gGlYAN+TQLZ6OJbq/2xP0j
UzuX5i9pQliC7G4u4T0myUCM0L3bz2jcQCcioTHONdGVrhX0IUxT8neQ2607P5s=
=Ci0g
-----END PGP SIGNATURE-----

--Aaj1jBvBEV7KRjLi--
