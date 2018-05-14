Received: from eggs.gnu.org ([2001:4830:134:3::10]:51356)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIJ7e-0006OB-S7
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:27:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fIJ7d-00089y-OI
	for qemu-devel@nongnu.org; Mon, 14 May 2018 15:27:02 -0400
References: <20180509162637.15575-1-kwolf@redhat.com>
	<20180509162637.15575-28-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <eb2515ab-3c00-af39-7e08-359cb9051806@redhat.com>
Date: Mon, 14 May 2018 21:26:52 +0200
MIME-Version: 1.0
In-Reply-To: <20180509162637.15575-28-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="YqPFsdPDj9QBeTKuFTQ4oIU97QFAIj2Ex"
Subject: Re: [Qemu-devel] [PATCH 27/42] job: Add job_drain()
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
--YqPFsdPDj9QBeTKuFTQ4oIU97QFAIj2Ex
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: eblake@redhat.com, jsnow@redhat.com, armbru@redhat.com, jcody@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <eb2515ab-3c00-af39-7e08-359cb9051806@redhat.com>
Subject: Re: [PATCH 27/42] job: Add job_drain()
References: <20180509162637.15575-1-kwolf@redhat.com>
 <20180509162637.15575-28-kwolf@redhat.com>
In-Reply-To: <20180509162637.15575-28-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-05-09 18:26, Kevin Wolf wrote:
> block_job_drain() contains a blk_drain() call which cannot be moved to
> Job, so add a new JobDriver callback JobDriver.drain which has a common=

> implementation for all BlockJobs. In addition to this we keep the
> existing BlockJobDriver.drain callback that is called by the common
> drain implementation for all block jobs.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/block/blockjob_int.h | 12 ++++++++++++
>  include/qemu/job.h           | 13 +++++++++++++
>  block/backup.c               |  1 +
>  block/commit.c               |  1 +
>  block/mirror.c               |  2 ++
>  block/stream.c               |  1 +
>  blockjob.c                   | 20 ++++++++++----------
>  job.c                        | 11 +++++++++++
>  tests/test-bdrv-drain.c      |  1 +
>  tests/test-blockjob-txn.c    |  1 +
>  tests/test-blockjob.c        |  2 ++
>  11 files changed, 55 insertions(+), 10 deletions(-)
>=20
> diff --git a/include/block/blockjob_int.h b/include/block/blockjob_int.=
h
> index bf2b762808..38fe22d7e0 100644
> --- a/include/block/blockjob_int.h
> +++ b/include/block/blockjob_int.h
> @@ -65,6 +65,10 @@ struct BlockJobDriver {
>       * If the callback is not NULL, it will be invoked when the job ha=
s to be
>       * synchronously cancelled or completed; it should drain BlockDriv=
erStates
>       * as required to ensure progress.
> +     *
> +     * Block jobs must use the default implementation for job_driver.d=
rain,
> +     * which will in turn call this callback after doing generic block=
 job
> +     * stuff.
>       */
>      void (*drain)(BlockJob *job);

I don't really see the point of having two drain callbacks for block
jobs.  Well, it allows an assert() that block_job_drain() is called at
some point, but still.  I'd like block jobs to be not very special, but
this makes them a bit more special than they need to be.

Maybe I'd like it a bit more if there was a macro to automatically set
these mandatory values for block jobs...

But mostly a question of style, so I'll grudgingly give a:

Reviewed-by: Max Reitz <mreitz@redhat.com>

>  };


--YqPFsdPDj9QBeTKuFTQ4oIU97QFAIj2Ex
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlr54vwACgkQ9AfbAGHV
z0D9Kgf/X5t4SIp4vDC0Rf3jTOyNBrc2dCRk/mzDmH5Cl/hMXTbwdZDw3gCfXZ8e
lM3qF0JUJz9Xb/JS5oCq7SUV5DCJD0+TbI6O/rCTJuamIkDha6LmtclTZhVXZ9P2
EHOwcO2b23y2/vUzSdmlHcILcuFlIjW6KpgwB5SHRQn4FGCFRe8FSu4Eb954J16z
Yf2sjz+ySdi3Am6WCogAhS1PdGLSMp3+eTo7Ec8J/IxKsocJ5UM4DBLZxOYnsKRY
ubAOojoSuutLNg759MA0GCWnuVQSiYIUQvwHjXt+MreAL9UzuZqhjdLOklASDLnM
pdDn+Sbx53NrOOkRyX+TZiRznt+i6g==
=/8Az
-----END PGP SIGNATURE-----

--YqPFsdPDj9QBeTKuFTQ4oIU97QFAIj2Ex--
