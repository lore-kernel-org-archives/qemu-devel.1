Received: from eggs.gnu.org ([2001:4830:134:3::10]:55072)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9QIK-0002mK-Ew
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:17:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9QIJ-0004KE-LA
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:17:20 -0400
Date: Fri, 20 Apr 2018 15:17:11 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180420071711.GE15181@stefanha-x1.localdomain>
References: <20180411163940.2523-1-kwolf@redhat.com>
	<20180411163940.2523-7-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="WBsA/oQW3eTA3LlM"
Content-Disposition: inline
In-Reply-To: <20180411163940.2523-7-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 06/19] block: Avoid
 unnecessary aio_poll() in AIO_WAIT_WHILE()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com


--WBsA/oQW3eTA3LlM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2018 at 06:39:27PM +0200, Kevin Wolf wrote:
> Commit 91af091f923 added an additional aio_poll() to BDRV_POLL_WHILE()
> in order to make sure that all pending BHs are executed on drain. This
> was the wrong place to make the fix, as it is useless overhead for all
> other users of the macro and unnecessarily complicates the mechanism.
>=20
> This patch effectively reverts said commit (the context has changed a
> bit and the code has moved to AIO_WAIT_WHILE()) and instead polls in the
> loop condition for drain.
>=20
> The effect is probably hard to measure in any real-world use case
> because actual I/O will dominate, but if I run only the initialisation
> part of 'qemu-img convert' where it calls bdrv_block_status() for the
> whole image to find out how much data there is copy, this phase actually
> needs only roughly half the time after this patch.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/aio-wait.h | 22 ++++++++--------------
>  block/io.c               | 11 ++++++++++-
>  2 files changed, 18 insertions(+), 15 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--WBsA/oQW3eTA3LlM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa2ZP3AAoJEJykq7OBq3PIdJEH/1SoIZSrfsNkrauahf+eQJvn
jsDY33IGDQ1QogYoHOftXSPgoTMvV0vTYvHvNx4yVwKoWw3fQEuDJVj5cp5UJECQ
q3W3bSlmyX9KqTWJLqPitQC2CKLpTV3NgD8O7WtVRMNtOmDwzBGNZdVC0VUPhpGD
26AQ1rTmviNCGDyZIp9omrEnmpjIoHWinekfxqLPYG5u+DblVzPuFvB0UiutlIF0
FfnkL36i21CO/33anaSEv+cRqSE7CvPqim3r1azv5sKUdKLqWyU9+mwnjco9WMGb
HflfbJaV7FMYhWgyk8wX0MTh7RsXSuR7MSRDUve7M+5ZHiPxXgdzvAVtN6YpLi4=
=lj02
-----END PGP SIGNATURE-----

--WBsA/oQW3eTA3LlM--
