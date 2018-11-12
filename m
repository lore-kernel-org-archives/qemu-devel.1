Received: from eggs.gnu.org ([2001:4830:134:3::10]:59726)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfF-0000HP-4Q
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gMFfE-0006n4-Bz
	for qemu-devel@nongnu.org; Mon, 12 Nov 2018 12:06:17 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 12 Nov 2018 18:05:52 +0100
Message-Id: <20181112170603.23986-4-kwolf@redhat.com>
In-Reply-To: <20181112170603.23986-1-kwolf@redhat.com>
References: <20181112170603.23986-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 03/14] blockdev: Consistently use
 snapshot_node_name in external_snapshot_prepare()
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

From: Peter Maydell <peter.maydell@linaro.org>

In the function external_snapshot_prepare() we have a
BlockdevSnapshotSync struct, which has the usual combination
of has_snapshot_node_name and snapshot_node_name fields for an
optional field. We set up a local variable
        const char *snapshot_node_name =3D
            s->has_snapshot_node_name ? s->snapshot_node_name : NULL;

and then mostly use "if (!snapshot_node_name)" for checking
whether we have a snapshot node name. The exception is that in
one place we check s->has_snapshot_node_name instead. This
confuses Coverity (CID 1396473), which thinks it might be
possible to get here with s->has_snapshot_node_name true but
snapshot_node_name NULL, and warns that the call to
qdict_put_str() will segfault in that case.

Make the code consistent and unconfuse Coverity by using
the same check for this conditional that we do in the rest
of the surrounding code.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 blockdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/blockdev.c b/blockdev.c
index 9310ff3e7c..81f95d920b 100644
--- a/blockdev.c
+++ b/blockdev.c
@@ -1640,7 +1640,7 @@ static void external_snapshot_prepare(BlkActionStat=
e *common,
         }
=20
         options =3D qdict_new();
-        if (s->has_snapshot_node_name) {
+        if (snapshot_node_name) {
             qdict_put_str(options, "node-name", snapshot_node_name);
         }
         qdict_put_str(options, "driver", format);
--=20
2.19.1
