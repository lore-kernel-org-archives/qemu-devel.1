Received: from eggs.gnu.org ([2001:4830:134:3::10]:32971)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g74ER-00089Y-Jh
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:51:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1g74EQ-0000bo-C2
	for qemu-devel@nongnu.org; Mon, 01 Oct 2018 15:51:51 -0400
References: <20180821005843.5146-1-famz@redhat.com>
	<20180821005843.5146-4-famz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <ddc55ba4-a0e0-d2e3-e469-c5dfcceb6975@redhat.com>
Date: Mon, 1 Oct 2018 21:51:33 +0200
MIME-Version: 1.0
In-Reply-To: <20180821005843.5146-4-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="U4aM1ovEHGV0w72oqzDes6xZ8p4hhxc8L"
Subject: Re: [Qemu-devel] [PATCH v4 3/3] tests: Add unit tests for image
 locking
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--U4aM1ovEHGV0w72oqzDes6xZ8p4hhxc8L
From: Max Reitz <mreitz@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Message-ID: <ddc55ba4-a0e0-d2e3-e469-c5dfcceb6975@redhat.com>
Subject: Re: [PATCH v4 3/3] tests: Add unit tests for image locking
References: <20180821005843.5146-1-famz@redhat.com>
 <20180821005843.5146-4-famz@redhat.com>
In-Reply-To: <20180821005843.5146-4-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 21.08.18 02:58, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  tests/Makefile.include     |   2 +
>  tests/test-image-locking.c | 154 +++++++++++++++++++++++++++++++++++++=

>  2 files changed, 156 insertions(+)
>  create mode 100644 tests/test-image-locking.c
>=20
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 760a0f18b6..8cc0595b39 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -95,6 +95,7 @@ check-unit-y +=3D tests/test-bdrv-drain$(EXESUF)
>  check-unit-y +=3D tests/test-blockjob$(EXESUF)
>  check-unit-y +=3D tests/test-blockjob-txn$(EXESUF)
>  check-unit-y +=3D tests/test-block-backend$(EXESUF)
> +check-unit-y +=3D tests/test-image-locking$(EXESUF)
>  check-unit-y +=3D tests/test-x86-cpuid$(EXESUF)
>  # all code tested by test-x86-cpuid is inside topology.h
>  gcov-files-test-x86-cpuid-y =3D
> @@ -640,6 +641,7 @@ tests/test-bdrv-drain$(EXESUF): tests/test-bdrv-dra=
in.o $(test-block-obj-y) $(te
>  tests/test-blockjob$(EXESUF): tests/test-blockjob.o $(test-block-obj-y=
) $(test-util-obj-y)
>  tests/test-blockjob-txn$(EXESUF): tests/test-blockjob-txn.o $(test-blo=
ck-obj-y) $(test-util-obj-y)
>  tests/test-block-backend$(EXESUF): tests/test-block-backend.o $(test-b=
lock-obj-y) $(test-util-obj-y)
> +tests/test-image-locking$(EXESUF): tests/test-image-locking.o $(test-b=
lock-obj-y) $(test-util-obj-y)
>  tests/test-thread-pool$(EXESUF): tests/test-thread-pool.o $(test-block=
-obj-y)
>  tests/test-iov$(EXESUF): tests/test-iov.o $(test-util-obj-y)
>  tests/test-hbitmap$(EXESUF): tests/test-hbitmap.o $(test-util-obj-y) $=
(test-crypto-obj-y)
> diff --git a/tests/test-image-locking.c b/tests/test-image-locking.c
> new file mode 100644
> index 0000000000..ac1a5fd4ca
> --- /dev/null
> +++ b/tests/test-image-locking.c
> @@ -0,0 +1,154 @@
> +/*
> + * Image locking tests
> + *
> + * Copyright (c) 2018 Red Hat Inc.
> + *
> + * Author: Fam Zheng <famz@redhat.com>
> + *
> + * Permission is hereby granted, free of charge, to any person obtaini=
ng a copy
> + * of this software and associated documentation files (the "Software"=
), to deal
> + * in the Software without restriction, including without limitation t=
he rights
> + * to use, copy, modify, merge, publish, distribute, sublicense, and/o=
r sell
> + * copies of the Software, and to permit persons to whom the Software =
is
> + * furnished to do so, subject to the following conditions:
> + *
> + * The above copyright notice and this permission notice shall be incl=
uded in
> + * all copies or substantial portions of the Software.
> + *
> + * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXP=
RESS OR
> + * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABI=
LITY,
> + * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT S=
HALL
> + * THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES O=
R OTHER
> + * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARI=
SING FROM,
> + * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALI=
NGS IN
> + * THE SOFTWARE.
> + */
> +
> +#include "qemu/osdep.h"
> +#include "block/block.h"
> +#include "sysemu/block-backend.h"
> +#include "qapi/error.h"
> +#include "qapi/qmp/qdict.h"
> +
> +static BlockBackend *open_image(const char *path,
> +                                uint64_t perm, uint64_t shared_perm,
> +                                Error **errp)
> +{
> +    Error *local_err =3D NULL;
> +    BlockBackend *blk;
> +    QDict *options =3D qdict_new();
> +
> +    qdict_put_str(options, "driver", "raw");
> +    blk =3D blk_new_open(path, NULL, options, BDRV_O_RDWR, &local_err)=
;
> +    if (blk) {
> +        g_assert_null(local_err);
> +        if (blk_set_perm(blk, perm, shared_perm, errp)) {
> +            blk_unref(blk);
> +            blk =3D NULL;
> +        }
> +    } else {
> +        error_propagate(errp, local_err);
> +    }
> +    return blk;
> +}
> +
> +static void check_locked_bytes(int fd, uint64_t perm_locks,
> +                               uint64_t shared_perm_locks)
> +{
> +    int i;
> +
> +    if (!perm_locks && !shared_perm_locks) {
> +        g_assert(!qemu_lock_fd_test(fd, 0, 0, true));
> +        return;
> +    }
> +    for (i =3D 0; (1ULL << i) <=3D BLK_PERM_ALL; i++) {
> +        uint64_t bit =3D (1ULL << i);
> +        bool perm_expected =3D !!(bit & perm_locks);
> +        bool shared_perm_expected =3D !!(bit & shared_perm_locks);
> +        g_assert_cmpint(perm_expected, =3D=3D,
> +                        !!qemu_lock_fd_test(fd, 100 + i, 1, true));
> +        g_assert_cmpint(shared_perm_expected, =3D=3D,
> +                        !!qemu_lock_fd_test(fd, 200 + i, 1, true));
> +    }
> +}
> +
> +static void test_image_locking_basic(void)
> +{
> +    BlockBackend *blk1, *blk2, *blk3;
> +    char img_path[] =3D "/tmp/qtest.XXXXXX";
> +    uint64_t perm, shared_perm;
> +
> +    int fd =3D mkstemp(img_path);
> +    assert(fd >=3D 0);

Don't you want to remove these temporary files after the test?

> +
> +    perm =3D BLK_PERM_WRITE | BLK_PERM_CONSISTENT_READ;
> +    shared_perm =3D BLK_PERM_ALL;
> +    blk1 =3D open_image(img_path, perm, shared_perm, &error_abort);
> +    g_assert(blk1);
> +
> +    check_locked_bytes(fd, perm, ~shared_perm);
> +
> +    /* compatible perm between blk1 and blk2 */
> +    blk2 =3D open_image(img_path, perm | BLK_PERM_RESIZE, shared_perm,=
 NULL);
> +    g_assert(blk2);
> +    check_locked_bytes(fd, perm | BLK_PERM_RESIZE, ~shared_perm);
> +
> +    /* incompatible perm with already open blk1 and blk2 */
> +    blk3 =3D open_image(img_path, perm, BLK_PERM_WRITE_UNCHANGED, NULL=
);
> +    g_assert_null(blk3);
> +
> +    blk_unref(blk2);
> +
> +    /* Check that extra bytes in blk2 are correctly unlocked */
> +    check_locked_bytes(fd, perm, ~shared_perm);
> +
> +    blk_unref(blk1);
> +
> +    /* Image is unused, no lock there */
> +    check_locked_bytes(fd, 0, 0);
> +    blk3 =3D open_image(img_path, perm, BLK_PERM_WRITE_UNCHANGED, &err=
or_abort);
> +    g_assert(blk3);
> +    blk_unref(blk3);
> +    close(fd);
> +}
> +
> +static void test_set_perm_abort(void)
> +{
> +    BlockBackend *blk1, *blk2;
> +    char img_path[] =3D "/tmp/qtest.XXXXXX";
> +    uint64_t perm, shared_perm;
> +    int r;
> +    int fd =3D mkstemp(img_path);
> +    assert(fd >=3D 0);
> +
> +    perm =3D BLK_PERM_WRITE | BLK_PERM_CONSISTENT_READ;
> +    shared_perm =3D BLK_PERM_ALL;
> +    blk1 =3D open_image(img_path, perm, shared_perm, &error_abort);
> +    g_assert(blk1);
> +
> +    blk2 =3D open_image(img_path, perm, shared_perm, &error_abort);
> +    g_assert(blk2);
> +
> +    check_locked_bytes(fd, perm, ~shared_perm);
> +
> +    /* A failed blk_set_perm mustn't change perm status (locked bytes)=
 */
> +    r =3D blk_set_perm(blk2, perm | BLK_PERM_RESIZE, BLK_PERM_WRITE_UN=
CHANGED,
> +                     NULL);
> +    g_assert_cmpint(r, !=3D, 0);
> +    check_locked_bytes(fd, perm, ~shared_perm);

And I think this test should close close bl1k and blk2.

Max

> +}
> +
> +int main(int argc, char **argv)
> +{
> +    bdrv_init();
> +    qemu_init_main_loop(&error_abort);
> +
> +    g_test_init(&argc, &argv, NULL);
> +
> +    if (qemu_has_ofd_lock()) {
> +        g_test_add_func("/image-locking/basic", test_image_locking_bas=
ic);
> +        g_test_add_func("/image-locking/set-perm-abort", test_set_perm=
_abort);
> +    }
> +
> +    return g_test_run();
> +}
>=20



--U4aM1ovEHGV0w72oqzDes6xZ8p4hhxc8L
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAluyesUACgkQ9AfbAGHV
z0AUpgf+OoUlKOS2LshUzNnYBUUOBPiAa543hPA6FXA+1m4nmtpLmBYYJr6JFyDz
7WlfKab+JLbEpmEeeOAV2NG1zFIPHj8q7IG9+De4M75L7K+b9aqet02iCfHtdKkN
MFKIwM2jztRdy18tlSWCkvQBlvKjJxjmmWKpJbBHSBpT815kdmt0OLUPwPDkwQR4
saMdk+cP9zys773h5hrE9U8ALUNXmmbjIByzFV5ZXnSW/JAFXAAbnsBiFe7+eusp
eS//2Yeos4FqzmKJXih6A8UoZ8oTd0/Tjs/W0DFvZVY/9kjKzz1wraeJAm2BXFdZ
gIyPHBxuHv2j+lsmKKPjI46aRaOXUg==
=xdDy
-----END PGP SIGNATURE-----

--U4aM1ovEHGV0w72oqzDes6xZ8p4hhxc8L--
