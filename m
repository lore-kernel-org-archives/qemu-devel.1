Received: from eggs.gnu.org ([2001:4830:134:3::10]:47422)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fvk9w-0001Xm-QK
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 10:12:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fvk9w-0004Be-1t
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 10:12:24 -0400
References: <20180830015734.19765-1-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <0e2d7fea-fb6f-641e-22d9-aeb8e353bce7@redhat.com>
Date: Fri, 31 Aug 2018 16:12:05 +0200
MIME-Version: 1.0
In-Reply-To: <20180830015734.19765-1-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="oWo6no7QwNe4R7Uif63bAhSAXT4TvLpCz"
Subject: Re: [Qemu-devel] [PATCH v3 0/9] jobs: Job Exit Refactoring Pt 1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--oWo6no7QwNe4R7Uif63bAhSAXT4TvLpCz
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Jeff Cody <jcody@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com
Message-ID: <0e2d7fea-fb6f-641e-22d9-aeb8e353bce7@redhat.com>
Subject: Re: [PATCH v3 0/9] jobs: Job Exit Refactoring Pt 1
References: <20180830015734.19765-1-jsnow@redhat.com>
In-Reply-To: <20180830015734.19765-1-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-30 03:57, John Snow wrote:
> This is part one of a two part series that refactors the exit logic
> of jobs.
>=20
> Part one removes job_defer_to_main_loop.
> Part two removes the job->exit() callback introduced in part one.
>=20
> It's redundant to have each job manage deferring to the main loop
> itself. Unifying this makes sense from an API standpoint.
> Doing so also allows us to remove a tricky case where the completion
> code is called under an aio_context lock, which then calls the
> finalization code which is itself executed under a second aio_context
> lock, leading to deadlocks.
>=20
> Removing this recursive lock acquisition is necessary for converting
> mirror to only modify its graph post-finalization, but it's also just
> safer and will bite us less in the future.
>=20
> This series introduces a job->exit callback, but after jobs are
> fully transitioned to using the .commit/.abort callbacks in Pt 2,
> this new completion callback will be removed again. It's only here
> as a crutch to let us investigate the completion refactoring in Pt 2
> more carefully.

Thanks, dropped the superfluous g_strdup() in patch 2 and applied to my
block branch:

https://git.xanclic.moe/XanClic/qemu/commits/branch/block

Max


--oWo6no7QwNe4R7Uif63bAhSAXT4TvLpCz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluJTLUACgkQ9AfbAGHV
z0D9uQgAoC9lKUOeCp7Jb+q6RcJzb62qTTQSq7z3kgAzPmJMQYq5UrIT5pJLXZnR
y/pxPos1QEXhsVfdwiSwpwetLg4gl8xvpMtzQC+Iyv8FrbX4lQTwfnGty7qaG+PF
e/sZ7nPhDxLh9SqKvNieNElv8WlAb55xFkVu0ArHakFsOGY5xs4pyqTgI1nsVYV6
eIRlDVeyrfjn8W5Ioos9It938vKg8Yx19KDGeEQ7Tx+T2ZlWaBOju1MW83nJ6awo
XxEhRqyj4fwJOS1MGxMs0r81VlbDxyrG6waCa/boSxKiOfj+KIXy9vhoWANm3VWv
0DxqXFk8byQkHsgbl2KAm0YHBs61vg==
=p3cI
-----END PGP SIGNATURE-----

--oWo6no7QwNe4R7Uif63bAhSAXT4TvLpCz--
