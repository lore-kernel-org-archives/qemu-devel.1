Received: from eggs.gnu.org ([209.51.188.92]:37701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gyaFM-00025U-GC
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 05:46:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gyaFF-0001mj-4g
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 05:45:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40398)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gyaF6-0001k4-Sr
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 05:45:49 -0500
Date: Tue, 26 Feb 2019 10:45:41 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190226104541.GA31847@stefanha-x1.localdomain>
References: <2932080.UxbmD43V0u@neil>
	<20190208062441.GF16257@stefanha-x1.localdomain>
	<20190208094818.GA2608@work-vm> <1808957.OXY5YYl177@neil>
	<20190212025658.GB28401@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sm4nu43k4a2Rpi4c"
Content-Disposition: inline
In-Reply-To: <20190212025658.GB28401@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [regression] Clock jump on VM migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Neil Skrypuch <neil@tembosocial.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org


--sm4nu43k4a2Rpi4c
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 12, 2019 at 10:56:58AM +0800, Stefan Hajnoczi wrote:
> I'll return to this issue on Monday.

I have played around with posix_fadvise(POSIX_FADV_DONTNEED) and
measured 100+ millisecond latencies.  This is not a great primitive to
rely on during migration downtime since it can be slow.

On the other hand, we need it to ensure consistency when migrating to
another host with cache.direct=off.  In the cross-host migration case
the invalidation will be relatively fast because few pages will be
present.

An asynchronous flush and page cache invalidation on the source host at
the beginning of live migration would help your use case, but I don't
think the complexity of adding it is worthwhile (it doesn't help the
cross-host migration case).

Let's go back to the original idea of adding a parameter to disable the
flush and page cache invalidation.  I will send a patch.

Stefan

--sm4nu43k4a2Rpi4c
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcdRjVAAoJEJykq7OBq3PIuQgH/2fCjt7Xmdq4STFXNFfcWFch
cKuzoRFq2b8Iy6OdYknkwcTraK8A9adiS3m90h3RlkJnDsZmG1pcoAZ2uTKwyUw/
0HZRtZI7WhHZSiuR8+MEn19jfaKcQ2/woOmF/D3joZ29AWedK5lDJq5v57M+sklm
AADVuRlNZrPd2hWahRabNdlGur5yhNxkskbvRw5Rc1WY8R1Dq1A4TN6qEfilwEu7
WUQ2wSuXUVgi1An5XCxvHNMNXsLWyraoGrmfOgBoy7gi1IerQR03YUZXFkMkCJrC
/J2SUkGG/yNrTxD1RYstFH31tOVOzgTbaMApEsrcOVAhqSJplhvr83993qbTfZU=
=vUFc
-----END PGP SIGNATURE-----

--sm4nu43k4a2Rpi4c--
