Received: from eggs.gnu.org ([2001:4830:134:3::10]:58601)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUapW-00043R-EM
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:42:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUapV-0000OH-LD
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:42:34 -0400
Date: Mon, 10 Jul 2017 16:42:20 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170710154220.GL14195@stefanha-x1.localdomain>
References: <20170706163828.24082-1-pbonzini@redhat.com>
	<20170706163828.24082-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="L1EIGrW/+75u5Nmw"
Content-Disposition: inline
In-Reply-To: <20170706163828.24082-3-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 02/11] block: make write-threshold
 thread-safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--L1EIGrW/+75u5Nmw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jul 06, 2017 at 06:38:19PM +0200, Paolo Bonzini wrote:
> For simplicity, use bdrv_drained_begin/end to avoid concurrent
> writes to the write threshold, or reading it while it is being set.
> qmp_block_set_write_threshold is protected by the BQL.

I find the commit message misleading: the write threshold code is not
being made thread-safe.

The commit description helps to clear this up, but we need to avoid
thinking "write threshold is thread-safe" because that would lead to
races between bdrv_write_threshold_set() callers.

Perhaps:

  block: protect write threshold qmp cmd from concurrent requests

Anyway:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--L1EIGrW/+75u5Nmw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZY6BcAAoJEJykq7OBq3PIRHIH/31kCxJaK/Bark8USxLBVjwU
aa9I+eRAe01xtpJS6rwnGovajgOvFiPvXEnVp3g9osC3uaKFo/3xWhQAiCqNZ+lI
XFeQKvHHYh1F6eUxAXkoTNJnp8X0izQDXXbeGD2XrcrNRqv7i/JzvAs1RBjpTzbk
cERW05GIQ5z7qy9607hs+f9VMt5rq3CbylefyRcGCJm6FpVFxpY00kuBT91Zc2sY
Yy2qKNr2vnCvzoyNAmfomOkVu+sFxE8aludz1C4sQAZbR3aPeSXkvcHfoZYLN2PJ
yKTfZhVMSGExa2dtcr+Q9s6x3dpCEopPXO/yr/N8+M2owBAMepUb4K4VOSIQDYg=
=KMnF
-----END PGP SIGNATURE-----

--L1EIGrW/+75u5Nmw--
