Received: from eggs.gnu.org ([2001:4830:134:3::10]:38885)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxVuS-0006zw-MD
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:46:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cxVuN-0005q0-Q7
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:46:56 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33881)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cxVuN-0005pw-JV
	for qemu-devel@nongnu.org; Mon, 10 Apr 2017 05:46:51 -0400
Received: by mail-wm0-x243.google.com with SMTP id x75so8641243wma.1
	for <qemu-devel@nongnu.org>; Mon, 10 Apr 2017 02:46:51 -0700 (PDT)
Date: Mon, 10 Apr 2017 10:46:48 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170410094648.GM2567@stefanha-x1.localdomain>
References: <20170323173928.14439-1-pbonzini@redhat.com>
	<20170323173928.14439-11-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Qgof7w7UksPF5inF"
Content-Disposition: inline
In-Reply-To: <20170323173928.14439-11-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 10/10] blockjob: use deferred_to_main_loop
 to indicate the coroutine has ended
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, jcody@redhat.com, jsnow@redhat.com


--Qgof7w7UksPF5inF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 23, 2017 at 06:39:28PM +0100, Paolo Bonzini wrote:
> All block jobs are using block_job_defer_to_main_loop as the final
> step just before the coroutine terminates.  At this point,
> block_job_enter should do nothing, but currently it restarts
> the freed coroutine.
>=20
> Now, the job->co states should probably be changed to an enum
> (e.g. BEFORE_START, STARTED, YIELDED, COMPLETED) subsuming
> block_job_started, job->deferred_to_main_loop and job->busy.
> For now, this patch eliminates the problematic reenter by
> removing the reset of job->deferred_to_main_loop (which served
> no purpose, as far as I could see) and checking the flag in
> block_job_enter.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  blockjob.c                   | 10 ++++++++--
>  include/block/blockjob_int.h |  3 ++-
>  2 files changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Qgof7w7UksPF5inF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY61SIAAoJEJykq7OBq3PImzgH+wXcZpTskOylTsQOOiWTK57A
F/xMjwiRhbXlkJSVs0wL8acsikyszgJEYtZR/gR40DAcJ4c4GzjkxZncUSnapWCy
gqzpc/je0LpMZQYFSk201oZGPxplQzDtpM3xSl0cwEHq9rJZeXb6llQTpEOHsG7b
oSMu3Zs4hnEEo1H1hh5OGlJzINX7YZ+Ecbs9fEGFgROyfaPQdVcBw1sYkUlWOAnU
JjL44Hsji1nYJUiiVklTDkOCWTFxlrgYGDpGYQcRBExsmFjTwH5pmjiGOYTHwHQn
JFiKuNBz/mZVC0PaBqlqSewH9SYrquT/AalVDKDpgQvgPxBGO04ClVSU3ealXLM=
=DD18
-----END PGP SIGNATURE-----

--Qgof7w7UksPF5inF--
