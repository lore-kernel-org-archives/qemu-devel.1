Received: from eggs.gnu.org ([2001:4830:134:3::10]:46916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIIi1-0007I4-FO
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:00:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIIi0-000756-J6
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:00:33 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-27-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <f33c73b2-c4a2-747d-78b6-c513c640e126@redhat.com>
Date: Mon, 14 May 2018 21:00:20 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-27-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="mpg9I50obwJADLsxMO2yYF3k4OhxUBCYH"
Subject: Re: [Qemu-devel] [PATCH 26/42] job: Convert
 block_job_cancel_async() to Job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mpg9I50obwJADLsxMO2yYF3k4OhxUBCYH
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <f33c73b2-c4a2-747d-78b6-c513c640e126@redhat.com>
Subject: Re: [PATCH 26/42] job: Convert block_job_cancel_async() to Job
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-27-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-27-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> block_job_cancel_async() did two things that were still block job
> specific:
>=20
> * Setting job->force. This field makes sense on the Job level, so we ca=
n
>   just move it. While at it, rename it to job->force_cancel to make its=

>   purpose more obvious.
>=20
> * Resetting the I/O status. This can't be moved because generic Jobs
>   don't have an I/O status. What the function really implements is a
>   user resume, except without entering the coroutine. Consequently, it
>   makes sense to call the .user_resume driver callback here which
>   already resets the I/O status.
>=20
>   The old block_job_cancel_async() has two separate if statements that
>   check job->iostatus !=3D BLOCK_DEVICE_IO_STATUS_OK and job->user_paus=
ed.
>   However, the former condition always implies the latter (as is
>   asserted in block_job_iostatus_reset()), so changing the explicit cal=
l
>   of block_job_iostatus_reset() on the former condition with the
>   .user_resume callback on the latter condition is equivalent and
>   doesn't need to access any BlockJob specific state.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob.h |  6 ------
>  include/qemu/job.h       |  6 ++++++
>  block/mirror.c           |  4 ++--
>  blockjob.c               | 25 +++++++++++++------------
>  4 files changed, 21 insertions(+), 20 deletions(-)

I'm not quite sure why you keep this function in blockjob.c, when you've
previously moved such static functions over to job.c and made them
temporarily public (e.g. job_state_transition()).

But I don't really care either way, in fact keeping the function in the
same file makes reviewing easier for me, so:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--mpg9I50obwJADLsxMO2yYF3k4OhxUBCYH
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr53MQACgkQ9AfbAGHV
z0Dldwf+JTfkDdRp4xjIN2QWP8jWffTFyRyAarvP8O2zlP11COtCV7UqojZ9w8bg
iX8vEAPuIwUmb20k99wBCFH9a0HowepNT4F2Q8kVo9tLx3Mm6PXpKv/VK6FhEQTq
Li1f7Gqw9CUEc3uVmbpXD2OE1WJ2GOE8cgYZsYR5QmqkOKTuek8759jH64MeORC6
af1DStaSSAE2MUCa6lVdxP1ZuLkj9xUvV5zHLpQE1asBOzA2VegG3fzvuAxaokEu
qE9IHKl8rBi6oas3IfAXith8NuGEGxcd7D17YrNsPz2wttizi9Qq9TxtlGsXPZ8b
mfUxLpJIQuO5ffopGRu/utDwGuYWtw==
=Q0XK
-----END PGP SIGNATURE-----

--mpg9I50obwJADLsxMO2yYF3k4OhxUBCYH--
