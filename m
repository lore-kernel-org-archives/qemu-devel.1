Received: from eggs.gnu.org ([209.51.188.92]:32946)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDXEt-00057u-R5
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:35:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hDXEs-00060G-Uh
	for qemu-devel@nongnu.org; Mon, 08 Apr 2019 12:35:19 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon,  8 Apr 2019 18:34:38 +0200
Message-Id: <20190408163439.18818-2-kwolf@redhat.com>
In-Reply-To: <20190408163439.18818-1-kwolf@redhat.com>
References: <20190408163439.18818-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/2] block: Forward 'discard' to temporary
 overlay
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

When bdrv_temp_snapshot_options() is called for snapshot=3Don, the
'discard' option in the options QDict hasn't been parsed and merged into
the flags yet. So copy the dict entry to make sure that the temporary
overlay enables discard when it was requested for the drive.

Signed-off-by: Kevin Wolf <kwolf@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
---
 block.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/block.c b/block.c
index 3050854528..16615bc876 100644
--- a/block.c
+++ b/block.c
@@ -950,8 +950,9 @@ static void bdrv_temp_snapshot_options(int *child_fla=
gs, QDict *child_options,
     qdict_set_default_str(child_options, BDRV_OPT_CACHE_DIRECT, "off");
     qdict_set_default_str(child_options, BDRV_OPT_CACHE_NO_FLUSH, "on");
=20
-    /* Copy the read-only option from the parent */
+    /* Copy the read-only and discard options from the parent */
     qdict_copy_default(child_options, parent_options, BDRV_OPT_READ_ONLY=
);
+    qdict_copy_default(child_options, parent_options, BDRV_OPT_DISCARD);
=20
     /* aio=3Dnative doesn't work for cache.direct=3Doff, so disable it f=
or the
      * temporary snapshot */
--=20
2.20.1
