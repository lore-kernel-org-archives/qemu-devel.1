Received: from eggs.gnu.org ([2001:4830:134:3::10]:49316)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2Yd-0003VE-Hl
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:17:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dG2Yc-0003Jw-PG
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:16:59 -0400
Date: Wed, 31 May 2017 13:16:53 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170531121653.GC16733@stefanha-x1.localdomain>
References: <1495830130-30611-1-git-send-email-kwolf@redhat.com>
	<1495830130-30611-2-git-send-email-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="eHhjakXzOLJAF9wJ"
Content-Disposition: inline
In-Reply-To: <1495830130-30611-2-git-send-email-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 01/29] qed: Use bottom half to
 resume waiting requests
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, pbonzini@redhat.com, qemu-devel@nongnu.org, stefanha@redhat.com, mreitz@redhat.com


--eHhjakXzOLJAF9wJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 26, 2017 at 10:21:42PM +0200, Kevin Wolf wrote:
> The qed driver serialises allocating write requests. When the active
> allocation is finished, the AIO callback is called, but after this, the
> next allocating request is immediately processed instead of leaving the
> coroutine. Resuming another allocation request in the same request
> coroutine means that the request now runs in the wrong coroutine.
>=20
> The following is one of the possible effects of this: The completed
> request will generally reenter its request coroutine in a bottom half,
> expecting that it completes the request in bdrv_driver_pwritev().
> However, if the second request actually yielded before leaving the
> coroutine, the reused request coroutine is in an entirely different
> place and is reentered prematurely. Not a good idea.
>=20
> Let's make sure that we exit the coroutine after completing the first
> request by resuming the next allocating request only with a bottom
> half.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/qed.c | 13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--eHhjakXzOLJAF9wJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZLrQ1AAoJEJykq7OBq3PI8sIIAI0ceeyksbflVSYWO3NYYkOF
2Xb8Pnx9UzYfVLqL0w/pO5AWyLRiWVNAEUVzJwuGdkPTrAmPCHUGfiGdlO/iF453
+aqS9sz4sKL0iTqESy1HfHVBFuLnN6Kdl+Y2ka2QC/vBBUr0jdV/IPeFZSfR2MKz
cXGEY9RknL5EvfB2imWoOiSR0iQbXh5+PV65BwI0bipIPp70VoP1lKH3aumzzfIX
I5KRWNqTJorC/hU03JyPKNH2BtzxxCJL83AaSOKriJLJjtqR8FcwpjUn5PCtfMP7
2QQ4ZjE6T87yoGIAgHM3oNKZS9rNxHWt9ty9h3zED0A0Pad/QEccTnlwidlxApg=
=Owqg
-----END PGP SIGNATURE-----

--eHhjakXzOLJAF9wJ--
