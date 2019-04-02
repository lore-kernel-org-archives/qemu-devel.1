Received: from eggs.gnu.org ([209.51.188.92]:59518)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBIqx-0002Hv-O4
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:49:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hBIqw-0002yE-3T
	for qemu-devel@nongnu.org; Tue, 02 Apr 2019 08:49:23 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue,  2 Apr 2019 14:49:00 +0200
Message-Id: <20190402124907.24421-3-kwolf@redhat.com>
In-Reply-To: <20190402124907.24421-1-kwolf@redhat.com>
References: <20190402124907.24421-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/9] qemu-img: Enable BDRV_REQ_MAY_UNMAP in
 convert
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Nir Soffer <nirsof@gmail.com>

With Kevin's "block: Fix slow pre-zeroing in qemu-img convert"[1]
(commit c9fdcf202f, 'qemu-img: Use BDRV_REQ_NO_FALLBACK for
pre-zeroing') we skip the pre zero step called like this:

    blk_make_zero(s->target, BDRV_REQ_MAY_UNMAP | BDRV_REQ_NO_FALLBACK)

And we write zeroes later using:

    blk_co_pwrite_zeroes(s->target,
                         sector_num << BDRV_SECTOR_BITS,
                         n << BDRV_SECTOR_BITS, 0);

Since we use flags=3D0, this is translated to NBD_CMD_WRITE_ZEROES with
NBD_CMD_FLAG_NO_HOLE flag, which cause the NBD server to allocated space
instead of punching a hole.

Here is an example failure:

$ dd if=3D/dev/urandom of=3Dsrc.img bs=3D1M count=3D5
$ truncate -s 50m src.img
$ truncate -s 50m dst.img
$ nbdkit -f -v -e '' -U nbd.sock file file=3Ddst.img

$ ./qemu-img convert -n src.img nbd:unix:nbd.sock

We can see in nbdkit log that it received the NBD_CMD_FLAG_NO_HOLE
(may_trim=3D0):

nbdkit: file[1]: debug: newstyle negotiation: flags: export 0x4d
nbdkit: file[1]: debug: pwrite count=3D2097152 offset=3D0
nbdkit: file[1]: debug: pwrite count=3D2097152 offset=3D2097152
nbdkit: file[1]: debug: pwrite count=3D1048576 offset=3D4194304
nbdkit: file[1]: debug: zero count=3D33554432 offset=3D5242880 may_trim=3D=
0
nbdkit: file[1]: debug: zero count=3D13631488 offset=3D38797312 may_trim=3D=
0
nbdkit: file[1]: debug: flush

And the image became fully allocated:

$ qemu-img info dst.img
virtual size: 50M (52428800 bytes)
disk size: 50M

With this change we see that nbdkit did not receive the
NBD_CMD_FLAG_NO_HOLE (may_trim=3D1):

nbdkit: file[1]: debug: newstyle negotiation: flags: export 0x4d
nbdkit: file[1]: debug: pwrite count=3D2097152 offset=3D0
nbdkit: file[1]: debug: pwrite count=3D2097152 offset=3D2097152
nbdkit: file[1]: debug: pwrite count=3D1048576 offset=3D4194304
nbdkit: file[1]: debug: zero count=3D33554432 offset=3D5242880 may_trim=3D=
1
nbdkit: file[1]: debug: zero count=3D13631488 offset=3D38797312 may_trim=3D=
1
nbdkit: file[1]: debug: flush

And the file is sparse as expected:

$ qemu-img info dst.img
virtual size: 50M (52428800 bytes)
disk size: 5.0M

[1] http://lists.nongnu.org/archive/html/qemu-block/2019-03/msg00761.html

Signed-off-by: Nir Soffer <nsoffer@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/qemu-img.c b/qemu-img.c
index 76a961df82..aa6f81f1ea 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -1756,7 +1756,8 @@ static int coroutine_fn convert_co_write(ImgConvert=
State *s, int64_t sector_num,
             }
             ret =3D blk_co_pwrite_zeroes(s->target,
                                        sector_num << BDRV_SECTOR_BITS,
-                                       n << BDRV_SECTOR_BITS, 0);
+                                       n << BDRV_SECTOR_BITS,
+                                       BDRV_REQ_MAY_UNMAP);
             if (ret < 0) {
                 return ret;
             }
--=20
2.20.1
