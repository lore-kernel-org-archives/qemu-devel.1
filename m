Received: from eggs.gnu.org ([2001:4830:134:3::10]:46295)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuEK2-0006EK-Og
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:00:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fuEK1-0001eL-UB
	for qemu-devel@nongnu.org; Mon, 27 Aug 2018 06:00:34 -0400
References: <20180823220856.10094-1-jsnow@redhat.com>
	<20180823220856.10094-4-jsnow@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <e2e1bfe0-d353-54b2-8945-d1ce10ead9cf@redhat.com>
Date: Mon, 27 Aug 2018 12:00:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180823220856.10094-4-jsnow@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="Zqic2ZCrjHyMFaobeRvn9FQ3EdLGnNjd9"
Subject: Re: [Qemu-devel] [PATCH v2 3/9] jobs: add exit shim
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com, Jeff Cody <jcody@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Zqic2ZCrjHyMFaobeRvn9FQ3EdLGnNjd9
From: Max Reitz <mreitz@redhat.com>
To: John Snow <jsnow@redhat.com>, qemu-block@nongnu.org, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>, jtc@redhat.com,
 Jeff Cody <jcody@redhat.com>
Message-ID: <e2e1bfe0-d353-54b2-8945-d1ce10ead9cf@redhat.com>
Subject: Re: [PATCH v2 3/9] jobs: add exit shim
References: <20180823220856.10094-1-jsnow@redhat.com>
 <20180823220856.10094-4-jsnow@redhat.com>
In-Reply-To: <20180823220856.10094-4-jsnow@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-24 00:08, John Snow wrote:
> All jobs do the same thing when they leave their running loop:
> - Store the return code in a structure
> - wait to receive this structure in the main thread
> - signal job completion via job_completed
>=20
> Few jobs do anything beyond exactly this. Consolidate this exit
> logic for a net reduction in SLOC.
>=20
> More seriously, when we utilize job_defer_to_main_loop_bh to call
> a function that calls job_completed, job_finalize_single will run
> in a context where it has recursively taken the aio_context lock,
> which can cause hangs if it puts down a reference that causes a flush.
>=20
> You can observe this in practice by looking at mirror_exit's careful
> placement of job_completed and bdrv_unref calls.
>=20
> If we centralize job exiting, we can signal job completion from outside=

> of the aio_context, which should allow for job cleanup code to run with=

> only one lock, which makes cleanup callbacks less tricky to write.
>=20
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  include/qemu/job.h | 11 +++++++++++
>  job.c              | 18 ++++++++++++++++++
>  2 files changed, 29 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--Zqic2ZCrjHyMFaobeRvn9FQ3EdLGnNjd9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluDy7EACgkQ9AfbAGHV
z0B1EAf+NiJ3aDOuLUxfUu6vzTUML+BatsjSKoxg6lOT8hJ4Il8pRupwOuOybWQg
bBEczCWyGqmMlZirgg0F7wloE8lKMwqwWAiScMU4h7ptF850LnbBQbnC45kUckQX
0lVtDHvb//DPpojJOyUXWi1cH3/wTdk2EOn0SECDtpQNRFLK6DvUMhPNcOpqVI3g
83986CWORsNbjCCrInGVunogzWRqd7vOvEHVNaSumyDscw1yt2U2edgCT5tsqk7k
66bdF82Ax+FBYMNUQEwuSru/Zok2jTXqKZnPU/+2AgzaTajlEXGBBVH1yHKwzsTz
dqwZUUq6uvlKduNKcdpeKMiJr2XkxQ==
=loJK
-----END PGP SIGNATURE-----

--Zqic2ZCrjHyMFaobeRvn9FQ3EdLGnNjd9--
