Received: from eggs.gnu.org ([209.51.188.92]:32774)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hIrpm-0004jR-Nu
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:35:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1hIrgH-0006tp-Dj
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:25:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33796)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1hIrgG-0006l9-QJ
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 05:25:37 -0400
Date: Tue, 23 Apr 2019 10:25:18 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190423092518.GD32465@stefanha-x1.localdomain>
References: <20190422004849.26463-1-richardw.yang@linux.intel.com>
	<20190422004849.26463-2-richardw.yang@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Content-Disposition: inline
In-Reply-To: <20190422004849.26463-2-richardw.yang@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v14 1/2] util/mmap-alloc: support MAP_SYNC
 in qemu_ram_mmap()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Wei Yang <richardw.yang@linux.intel.com>
Cc: qemu-devel@nongnu.org, xiaoguangrong.eric@gmail.com, pbonzini@redhat.com, pagupta@redhat.com, yu.c.zhang@linux.intel.com, mst@redhat.com, ehabkost@redhat.com, imammedo@redhat.com, dan.j.williams@intel.com, yi.z.zhang@linux.intel.com, Haozhong Zhang <haozhong.zhang@intel.com>


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2019 at 08:48:48AM +0800, Wei Yang wrote:
> From: Zhang Yi <yi.z.zhang@linux.intel.com>
>=20
> When a file supporting DAX is used as vNVDIMM backend, mmap it with
> MAP_SYNC flag in addition which can ensure file system metadata
> synced in each guest writes to the backend file, without other QEMU
> actions (e.g., periodic fsync() by QEMU).
>=20
> Current, We have below different possible use cases:
>=20
> 1. pmem=3Don is set, shared=3Don is set, MAP_SYNC supported:
>    a: backend is a dax supporting file.
>     - MAP_SYNC will active.
>    b: backend is not a dax supporting file.
>     - mmap will trigger a warning. then MAP_SYNC flag will be ignored
>=20
> 2. The rest of cases:
>    - we will never pass the MAP_SYNC to mmap2
>=20
> Signed-off-by: Haozhong Zhang <haozhong.zhang@intel.com>
> Signed-off-by: Zhang Yi <yi.z.zhang@linux.intel.com>
> [ehabkost: Rebased patch to latest code on master]
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> Signed-off-by: Wei Yang <richardw.yang@linux.intel.com>
> Tested-by: Wei Yang <richardw.yang@linux.intel.com>
>=20
> ---
> v14: rebase on top of current upstream
> ---
>  util/mmap-alloc.c | 41 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
>=20
> diff --git a/util/mmap-alloc.c b/util/mmap-alloc.c
> index 9713f4b960..f7f177d0ea 100644
> --- a/util/mmap-alloc.c
> +++ b/util/mmap-alloc.c
> @@ -10,6 +10,13 @@
>   * later.  See the COPYING file in the top-level directory.
>   */
> =20
> +#ifdef CONFIG_LINUX
> +#include <linux/mman.h>
> +#else  /* !CONFIG_LINUX */
> +#define MAP_SYNC              0x0
> +#define MAP_SHARED_VALIDATE   0x0
> +#endif /* CONFIG_LINUX */

MAP_SHARED_VALIDATE is is from 2017:

  commit 1c9725974074a047f6080eecc62c50a8e840d050
  Author: Dan Williams <dan.j.williams@intel.com>
  Date:   Wed Nov 1 16:36:30 2017 +0100

    mm: introduce MAP_SHARED_VALIDATE, a mechanism to safely define new mma=
p flags

This code fails to compile on Linux hosts with pre-4.15 headers.

Instead you could use the following (even on Linux!):

  #ifndef MAP_SYNC
  #define MAP_SYNC 0
  #endif
  #ifndef MAP_SHARED_VALIDATE
  #define MAP_SHARED_VALIDATE 0
  #endif

Either way:

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcvtn+AAoJEJykq7OBq3PIRwoH/3qeaHkj3/4NBNvVXsyeVbyl
5aD4BSe7ajBD5i/P2QoNfKzXGpnUvmbBzwCsjpgj49NX0N3krzMfPsehCyE3J2kS
jFjFbDanD5YQbAyLVcrNrBtPgjKLw/TupGVITaYUhmTjukhqBqqpK+zoNlPTWUiz
poBbsx03RXj4OrFqSOVwHwhiykPbKPQZftBfSlrsqv8t0tbIDSO1y3+mL52yVVBK
Ge2UH2ZjdTYH8A9X9ub9iSph6vVxynflqLy5GE4oWtHOZhmkHYLiDiwHaYKM7Poc
WdFGYUWJACN3Lc4XCRHMmb97HSY/jdHOU1LAor7b2Cwb24odrEUWejBlAXQ3vzI=
=Br/Y
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--
