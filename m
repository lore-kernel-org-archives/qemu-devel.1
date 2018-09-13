Received: from eggs.gnu.org ([2001:4830:134:3::10]:57104)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0T4u-0006RO-7k
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:58:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g0T4t-0002qI-JX
	for qemu-devel@nongnu.org; Thu, 13 Sep 2018 10:58:44 -0400
References: <20180913125217.23173-1-kwolf@redhat.com>
	<20180913125217.23173-9-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <b8f722c6-3a6a-2593-f0de-50fb545293fa@redhat.com>
Date: Thu, 13 Sep 2018 16:58:27 +0200
MIME-Version: 1.0
In-Reply-To: <20180913125217.23173-9-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="zTFlGkCMUmbQm7fF1854l4QAAgAkiylyK"
Subject: Re: [Qemu-devel] [PATCH v2 08/17] block: Add missing locking in
 bdrv_co_drain_bh_cb()
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
--zTFlGkCMUmbQm7fF1854l4QAAgAkiylyK
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: famz@redhat.com, pbonzini@redhat.com, slp@redhat.com, jsnow@redhat.com,
 qemu-devel@nongnu.org
Message-ID: <b8f722c6-3a6a-2593-f0de-50fb545293fa@redhat.com>
Subject: Re: [PATCH v2 08/17] block: Add missing locking in
 bdrv_co_drain_bh_cb()
References: <20180913125217.23173-1-kwolf@redhat.com>
 <20180913125217.23173-9-kwolf@redhat.com>
In-Reply-To: <20180913125217.23173-9-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 13.09.18 14:52, Kevin Wolf wrote:
> bdrv_do_drained_begin/end() assume that they are called with the
> AioContext lock of bs held. If we call drain functions from a coroutine=

> with the AioContext lock held, we yield and schedule a BH to move out o=
f
> coroutine context. This means that the lock for the home context of the=

> coroutine is released and must be re-acquired in the bottom half.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  include/qemu/coroutine.h |  5 +++++
>  block/io.c               | 15 +++++++++++++++
>  util/qemu-coroutine.c    |  5 +++++
>  3 files changed, 25 insertions(+)

I suppose the coroutine lock you mean is the one aio_co_enter() takes?

If so:

Reviewed-by: Max Reitz <mreitz@redhat.com>

(Sorry, I still really don't have much understanding of how coroutines,
bottom halves, and all nice things like them work.)


--zTFlGkCMUmbQm7fF1854l4QAAgAkiylyK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluaexMACgkQ9AfbAGHV
z0CshAf9EJP/EI8tP2nDYbfrs/U9nLWsPEca28MpK4jlFAPqJBM875RLeci6DOGp
iGBrARsTwVWIZCIabY2T34fJZF4O5XRy23ztkCELgmePD6ADsZYBQj8WYsZC9rHB
QOLy7LsZvrUBl5OSr32phpM6WSSdVASPCIYvroSp0g2HIOgYcWAllWTHRpxt83DB
DNMnyIzmI1TdiT5ILQMgzeJV+g4Dpx53jtkRtJA2OsKtcjyFfLvBQNciedwcra/9
PecA8WmRTuETN9cFRRz+oyQTdKvmX0kriU6FD88wa0nEPHTqSq51d/EYXkhsl0Aj
7kA7nwDmZ5KG1YmPpYrwOeyQSsinEw==
=mZ+Y
-----END PGP SIGNATURE-----

--zTFlGkCMUmbQm7fF1854l4QAAgAkiylyK--
