Received: from eggs.gnu.org ([2001:4830:134:3::10]:58612)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFKqP-0001Sh-FR
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:36:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1dFKqO-00004q-Mn
	for qemu-devel@nongnu.org; Mon, 29 May 2017 09:36:25 -0400
References: <1496060313-30190-1-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <7cc1060f-18a7-aaa0-e215-f2e10129f37f@redhat.com>
Date: Mon, 29 May 2017 15:36:09 +0200
MIME-Version: 1.0
In-Reply-To: <1496060313-30190-1-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="NJV5IF9USLJvSfFvO2clHVXptLj3RF6gQ"
Subject: Re: [Qemu-devel] [PATCH] mirror: Drop permissions on s->target on
 completion
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, ymankad@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NJV5IF9USLJvSfFvO2clHVXptLj3RF6gQ
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com, ymankad@redhat.com,
 qemu-devel@nongnu.org, qemu-stable@nongnu.org
Message-ID: <7cc1060f-18a7-aaa0-e215-f2e10129f37f@redhat.com>
Subject: Re: [PATCH] mirror: Drop permissions on s->target on completion
References: <1496060313-30190-1-git-send-email-kwolf@redhat.com>
In-Reply-To: <1496060313-30190-1-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2017-05-29 14:18, Kevin Wolf wrote:
> This fixes an assertion failure that was triggered by qemu-iotests 129
> on some CI host, while the same test case didn't seem to fail on other
> hosts.
>=20
> Essentially the problem is that the blk_unref(s->target) in
> mirror_exit() doesn't necessarily mean that the BlockBackend goes away
> immediately. It is possible that the job completion was triggered neste=
d
> in mirror_drain(), which looks like this:
>=20
>     BlockBackend *target =3D s->target;
>     blk_ref(target);
>     blk_drain(target);
>     blk_unref(target);
>=20
> In this case, the write permissions for s->target are retained until
> after blk_drain(), which makes removing mirror_top_bs fail for the
> active commit case (can't have a writable backing file in the chain
> without the filter driver).
>=20
> Explicitly dropping the permissions first means that the additional
> reference doesn't hurt and the job can complete successfully even if
> called from the nested blk_drain().
>=20
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/mirror.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--NJV5IF9USLJvSfFvO2clHVXptLj3RF6gQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEvBAEBCAAZBQJZLCPJEhxtcmVpdHpAcmVkaGF0LmNvbQAKCRD0B9sAYdXPQJrw
CACzipsTGI8orknBVHMMonAvlCzs454Z6EKIvILy4NL3TQPyr9zY6NT6jFQUw8CO
78Th/SGlkYwCnFOxBBWWPukOJ36bxKo28XZte3mhg5urJL9YSf2HYmwHcMbsvOAD
T16h7NSHY4cJN6CzO0eeMM1F+nI9hdWBKx4Y6xL2fiHi3stbRBlr4x8YzyYSIkaM
T3FMGgJQ36kuKaSzzJIg1cKn+1Adfh4ahjfLlMAhOSAFyoQezQqyGDRvywDzslF4
3LPbIlH2/KTbNxGr1m/5CjuL+7VuG2nQ1bkSaMGoEBAU972jkVKpu+JG91WRPntA
ZVxM7Y04hB8n4co6guTXQxML
=hy7W
-----END PGP SIGNATURE-----

--NJV5IF9USLJvSfFvO2clHVXptLj3RF6gQ--
