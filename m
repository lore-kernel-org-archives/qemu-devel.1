Received: from eggs.gnu.org ([2001:4830:134:3::10]:46494)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9Kcz-0003j1-9P
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:46:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g9Kcy-0000tK-Br
	for qemu-devel@nongnu.org; Sun, 07 Oct 2018 21:46:33 -0400
References: <cover.1537367701.git.berto@igalia.com>
	<32c99e47940fcee5e83c780147e34a8f3840f7e4.1537367701.git.berto@igalia.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <5466eec0-4cc6-5717-945d-6e252e30c32d@redhat.com>
Date: Mon, 8 Oct 2018 03:46:13 +0200
MIME-Version: 1.0
In-Reply-To: <32c99e47940fcee5e83c780147e34a8f3840f7e4.1537367701.git.berto@igalia.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="fXPAH72CwCFdyguswzUcfkP0yIw96HJGN"
Subject: Re: [Qemu-devel] [PATCH 09/14] block: Use
 bdrv_reopen_set_read_only() in the mirror driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Jeff Cody <jcody@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fXPAH72CwCFdyguswzUcfkP0yIw96HJGN
From: Max Reitz <mreitz@redhat.com>
To: Alberto Garcia <berto@igalia.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Jeff Cody <jcody@redhat.com>
Message-ID: <5466eec0-4cc6-5717-945d-6e252e30c32d@redhat.com>
Subject: Re: [PATCH 09/14] block: Use bdrv_reopen_set_read_only() in the
 mirror driver
References: <cover.1537367701.git.berto@igalia.com>
 <32c99e47940fcee5e83c780147e34a8f3840f7e4.1537367701.git.berto@igalia.com>
In-Reply-To: <32c99e47940fcee5e83c780147e34a8f3840f7e4.1537367701.git.berto@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 19.09.18 16:47, Alberto Garcia wrote:
> The 'block-commit' QMP command is implemented internally using two
> different drivers. If the source image is the active layer then the
> mirror driver is used (commit_active_start()), otherwise the commit
> driver is used (commit_start()).
>=20
> In both cases the destination image must be put temporarily in
> read-write mode. This is done correctly in the latter case, but what
> commit_active_start() does is copy all flags instead.

Well, not only commit_active_start().  mirror_exit() does exactly the
same.  It does seem on purpose to let the target have exactly the same
flags as the source eventually.

Then again, none of the other flags seem to make any sense to me here.
Therefore, I tend to agree that it is a bug fix, even though I wouldn't
say it was an oversight.

Reviewed-by: Max Reitz <mreitz@redhat.com>

=2E..eagerly awaiting rebase on 737efc1eda2.

> This patch replaces the bdrv_reopen() calls in that function with
> bdrv_reopen_set_read_only() so that only the read-only status is
> changed.
>=20
> A similar change is made in mirror_exit(), which is also used by the
> 'drive-mirror' and 'blockdev-mirror' commands.
>=20
> Signed-off-by: Alberto Garcia <berto@igalia.com>
> ---
>  block/mirror.c | 20 +++++++++++++-------
>  1 file changed, 13 insertions(+), 7 deletions(-)


--fXPAH72CwCFdyguswzUcfkP0yIw96HJGN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlu6tuUACgkQ9AfbAGHV
z0CGQwf/RRwwamPcLD1BgHXvYq083i/z44XeomcCZ8OMyVS9LjKk42jS7Vbau7Cf
TgCcMknxQzD9L5+gq4r/CNWfYhRgQX1lYSI9YIda1nMD8onOUduE5Cgm3wYpjJEE
jArPtoSfagkM9l4oFWpDBPsMpfaq19tKVAiYBSmxO/2Dw+E8hp96JYKdzXpLF8Q7
aphaMnRCrWdEWu1wnp+2NXbuxsV3uE6KPKRcM4xWIB4+u33wvpMhgy+CHKkU6G9D
n5H/BXDNjEa0dDRI/9TQBaKeFZ7sW1cidxrRDlDR206OtD8w3NgXaqGo6xMciyTh
jdWfCzMJHv/W0FkJtn9PBY4MODxNYg==
=3IcL
-----END PGP SIGNATURE-----

--fXPAH72CwCFdyguswzUcfkP0yIw96HJGN--
