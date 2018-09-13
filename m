Received: from eggs.gnu.org ([2001:4830:134:3::10]:34604)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0ZaV-0004gY-0p
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 17:55:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0ZaG-0000vi-4H
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 17:55:37 -0400
References: <20180913125217.23173-1-kwolf@redhat.com>
	<20180913125217.23173-14-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <1c1f99c1-9841-2d33-d369-ace492afe3ed@redhat.com>
Date: Thu, 13 Sep 2018 23:52:36 +0200
MIME-Version: 1.0
In-Reply-To: <20180913125217.23173-14-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="vLMPO19bn9TEiB6GMzwOj5vn4RWb2jsyj"
Subject: Re: [Qemu-devel] [PATCH v2 13/17] blockjob: Lie better in
 child_job_drained_poll()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--vLMPO19bn9TEiB6GMzwOj5vn4RWb2jsyj
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <1c1f99c1-9841-2d33-d369-ace492afe3ed@redhat.com>
Subject: Re: [PATCH v2 13/17] blockjob: Lie better in child_job_drained_poll()
References: <20180913125217.23173-1-kwolf@redhat.com>
 <20180913125217.23173-14-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-14-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.09.18 14:52, Kevin Wolf wrote:
> Block jobs claim in .drained_poll() that they are in a quiescent state
> as soon as job->deferred_to_main_loop is true. This is obviously wrong,=

> they still have a completion BH to run. We only get away with this
> because commit 91af091f923 added an unconditional aio_poll(false) to th=
e
> drain functions, but this is bypassing the regular drain mechanisms.
>=20
> However, just removing this and telling that the job is still active
> doesn't work either: The completion callbacks themselves call drain
> functions (directly, or indirectly with bdrv_reopen), so they would
> deadlock then.
>=20
> As a better lie, tell that the job is active as long as the BH is
> pending, but falsely call it quiescent from the point in the BH when th=
e
> completion callback is called. At this point, nested drain calls won't
> deadlock because they ignore the job, and outer drains will wait for th=
e
> job to really reach a quiescent state because the callback is already
> running.

=2E..because it's running in the main loop, so it's impossible for anothe=
r
drain to run there concurrently.  I suppose.

At least that's what makes this patch make sense to me.

> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qemu/job.h |  3 +++
>  blockjob.c         |  2 +-
>  job.c              | 11 ++++++++++-
>  3 files changed, 14 insertions(+), 2 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--vLMPO19bn9TEiB6GMzwOj5vn4RWb2jsyj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlua3CUACgkQ9AfbAGHV
z0AKuAf44sMzNK+aXp3B2j/WN8M+vkul4er6449rtx9IEfppCJP4eH0mlml/CI3A
FXRYnavmWu1irKXvqR0TweMvvXondNxaspxJWXHp+6lwAst8hcnLn+PDz7Lz5+Y7
1AB5zVAXNTLrRtuizAKyt8KGcSOeIgnuolEXzO+vj5qa6Fa09NPC+kTYxY/CIGXM
aryFU5DJByENAnPQgWIbdS2WcCtw75xK6CnMDPzKOQMr8EjgD25nFcQM1xLgQCB2
+QCvpwUN5MvU6/40pfB7BFsaM1sZf8x3v0GevgWMwg7lpxPg4ryhb/0u4P7ziA9y
+q4Sybyn1WS/3gVuCIXMsQHJmGW1
=rH4z
-----END PGP SIGNATURE-----

--vLMPO19bn9TEiB6GMzwOj5vn4RWb2jsyj--
