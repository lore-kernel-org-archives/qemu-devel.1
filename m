Received: from eggs.gnu.org ([2001:4830:134:3::10]:54178)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEFks-0003at-6k
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:30:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eEFko-0006o4-6X
	for qemu-devel@nongnu.org; Mon, 13 Nov 2017 09:30:30 -0500
Date: Mon, 13 Nov 2017 14:30:09 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171113143009.GD27765@stefanha-x1.localdomain>
References: <20171110172545.32609-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Content-Disposition: inline
In-Reply-To: <20171110172545.32609-1-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 for-2.11] block: Make bdrv_next() keep
 strong references
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Fam Zheng <famz@redhat.com>, Eric Blake <eblake@redhat.com>


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 10, 2017 at 06:25:45PM +0100, Max Reitz wrote:
> On one hand, it is a good idea for bdrv_next() to return a strong
> reference because ideally nearly every pointer should be refcounted.
> This fixes intermittent failure of iotest 194.
>=20
> On the other, it is absolutely necessary for bdrv_next() itself to keep
> a strong reference to both the BB (in its first phase) and the BDS (at
> least in the second phase) because when called the next time, it will
> dereference those objects to get a link to the next one.  Therefore, it
> needs these objects to stay around until then.  Just storing the pointer
> to the next in the iterator is not really viable because that pointer
> might become invalid as well.
>=20
> Both arguments taken together means we should probably just invoke
> bdrv_ref() and blk_ref() in bdrv_next().  This means we have to assert
> that bdrv_next() is always called from the main loop, but that was
> probably necessary already before this patch and judging from the
> callers, it also looks to actually be the case.
>=20
> Keeping these strong references means however that callers need to give
> them up if they decide to abort the iteration early.  They can do so
> through the new bdrv_next_cleanup() function.
>=20
> Suggested-by: Kevin Wolf <kwolf@redhat.com>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
> v2: Instead of keeping the strong reference in bdrv_drain_all_*() only,
>     have them for all callers of bdrv_next() [Fam, Kevin]
>     (Completely different patch now, so no git-backport-diff included
>      here)
> ---
>  include/block/block.h |  1 +
>  block.c               |  3 +++
>  block/block-backend.c | 48 +++++++++++++++++++++++++++++++++++++++++++++=
+--
>  block/snapshot.c      |  6 ++++++
>  migration/block.c     |  1 +
>  5 files changed, 57 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaCaxxAAoJEJykq7OBq3PIgpYH/iC74mOk05rIW2g/3onrZEi1
V7Mc/lxtPxCrdiCyYOJEqhKyDq+FvHHJRuyJG4uV87aMOXicJZW9Wsyxh/yHTNpw
GPXYeidcXwGeJNQrVJy6DqU0nFEV6K7fesriKUQrXaraeOXfDRzt21BHhLicFAZD
ZGkFL2Z3K+03HniL4FtPHrNEN+6OdTDaALMALFRlSoLuoGW/TKS7Wb2GRLA18cVp
E8S648EVwbUrqQNfeVi9zl8c+dB5OzSvrl4c89hHHKjQQgc4D7np4BYA/U+wxtRJ
CH9bjdT9OIsGJkMnmbaXd8NI0vfOosPC3ul8y4vMQH61K8nh81OaMotrVfSkjU8=
=jUtm
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
