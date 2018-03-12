Received: from eggs.gnu.org ([2001:4830:134:3::10]:47766)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1evLJD-0007f5-1r
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:08:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1evLJ8-0007Bd-R6
	for qemu-devel@nongnu.org; Mon, 12 Mar 2018 07:08:03 -0400
Date: Mon, 12 Mar 2018 11:07:55 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180312110755.GB5681@stefanha-x1.localdomain>
References: <20180307124619.6218-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TRYliJ5NKNqkz5bu"
Content-Disposition: inline
In-Reply-To: <20180307124619.6218-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] block: make
 BDRV_POLL_WHILE() re-entrancy safe
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, "fuweiwei (C)" <fuweiwei2@huawei.com>, Paolo Bonzini <pbonzini@redhat.com>


--TRYliJ5NKNqkz5bu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2018 at 12:46:19PM +0000, Stefan Hajnoczi wrote:
> Nested BDRV_POLL_WHILE() calls can occur.  Currently
> assert(!wait_->wakeup) fails in AIO_WAIT_WHILE() when this happens.
>=20
> This patch converts the bool wait_->need_kick flag to an unsigned
> wait_->num_waiters counter.
>=20
> Nesting works correctly because outer AIO_WAIT_WHILE() callers evaluate
> the condition again after the inner caller completes (invoking the inner
> caller counts as aio_poll() progress).
>=20
> Reported-by: "fuweiwei (C)" <fuweiwei2@huawei.com>
> Cc: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
> v2:
>  * Rebase onto qemu.git/master now that AIO_WAIT_WHILE() has landed
>    [Kevin]
>=20
>  include/block/aio-wait.h | 61 ++++++++++++++++++++++++------------------=
------
>  util/aio-wait.c          |  2 +-
>  2 files changed, 31 insertions(+), 32 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--TRYliJ5NKNqkz5bu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJapl+LAAoJEJykq7OBq3PIAVQH/R2aRkbc6hbVhf+Q47WlFODT
zs/ecO0X6JeDmaDS8ec6fIGNwsA6qjZyZALXcsTCka894xSbhnb13KF82bsn2zGm
rDnonDbW1hDr4H65EvjMrBZPnpQ9CPsAXragxzEBMl7ZHqdvz9+F5bU45ScgHLsK
nESfznIPoZ+OHKbgK0Zshp/XqURJogJRYpvng6JXoPIZTY6UEOKxF0LNY8lAyyvl
pM4+yNZivmuLXlp96Ho8fGlD18mKLtPKGeP3kYl3b3x++dqIAV9DrVKiB7nHUuWX
bsw9bI2ec2lDP7q30qE0xjYVALcxgZNevTVCWyUPgekJqSGLngwQGdpUjfldtnw=
=ZTCT
-----END PGP SIGNATURE-----

--TRYliJ5NKNqkz5bu--
