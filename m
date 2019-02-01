Received: from eggs.gnu.org ([209.51.188.92]:38657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpbnJ-0006zg-1e
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:35:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gpbnE-00088Z-QF
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:35:55 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Fri,  1 Feb 2019 17:34:53 +0100
Message-Id: <20190201163518.31157-3-kwolf@redhat.com>
In-Reply-To: <20190201163518.31157-1-kwolf@redhat.com>
References: <20190201163518.31157-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 02/27] mirror: Block the source BlockDriverState
 in mirror_start_job()
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

From: Alberto Garcia <berto@igalia.com>

The mirror_start_job() function used for the commit-active job blocks
the source, target and all intermediate nodes for the duration of the
job.

   target <- intermediate <- source

Since 4ef85a9c2339 this function creates a dummy mirror_top_bs that
goes on top of the source node, and it is this dummy node that gets
blocked instead. The source node is never blocked or added to the
job's list of nodes.

   target <- intermediate <- source <- mirror_top

At the moment I don't think it is possible to exploit this problem
because any additional job on 'source' would either be forbidden for
other reasons or it would need to involve an additional node that is
blocked, causing an error.

This can be seen in the error messages, however, because they never
refer to the source node being blocked:

  $ qemu-img create -f qcow2 hd0.qcow2 1M
  $ qemu-img create -f qcow2 -b hd0.qcow2 hd1.qcow2
  $ qemu-io -c 'write 0 1M' hd0.qcow2
  $ $QEMU -drive if=3Dnone,file=3Dhd1.qcow2,node-name=3Dhd1
  { "execute": "qmp_capabilities" }
  { "execute": "block-commit", "arguments": {"device": "hd1", "speed": 25=
6}}
  { "execute": "block-stream", "arguments": {"device": "hd1"}}
  { "error": {"class": "GenericError",
    "desc": "Node 'hd0' is busy: block device is in use by block job: com=
mit"}}

After this patch the error message refers to 'hd1', as it should.

The expected output of iotest 141 also needs to be updated for the
same reason.

Signed-off-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/mirror.c             | 8 ++++++++
 tests/qemu-iotests/141.out | 4 ++--
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/block/mirror.c b/block/mirror.c
index 4cf1c088c0..b67b0120f8 100644
--- a/block/mirror.c
+++ b/block/mirror.c
@@ -1612,6 +1612,14 @@ static void mirror_start_job(const char *job_id, B=
lockDriverState *bs,
         goto fail;
     }
=20
+    ret =3D block_job_add_bdrv(&s->common, "source", bs, 0,
+                             BLK_PERM_WRITE_UNCHANGED | BLK_PERM_WRITE |
+                             BLK_PERM_CONSISTENT_READ,
+                             errp);
+    if (ret < 0) {
+        goto fail;
+    }
+
     /* Required permissions are already taken with blk_new() */
     block_job_add_bdrv(&s->common, "target", target, 0, BLK_PERM_ALL,
                        &error_abort);
diff --git a/tests/qemu-iotests/141.out b/tests/qemu-iotests/141.out
index f252c86875..41c7291258 100644
--- a/tests/qemu-iotests/141.out
+++ b/tests/qemu-iotests/141.out
@@ -28,7 +28,7 @@ Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D104=
8576 backing_file=3DTEST_DIR/t.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "BLOCK_JOB_READY", "data": {"device": "job0", "len": 0, "offset": 0, =
"speed": 0, "type": "mirror"}}
 {"return": {}}
-{"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: node i=
s used as backing hd of 'NODE_NAME'"}}
+{"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: block =
device is in use by block job: mirror"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job0"}}
@@ -45,7 +45,7 @@ Formatting 'TEST_DIR/o.IMGFMT', fmt=3DIMGFMT size=3D104=
8576 backing_file=3DTEST_DIR/t.
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "ready", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "BLOCK_JOB_READY", "data": {"device": "job0", "len": 0, "offset": 0, =
"speed": 0, "type": "commit"}}
 {"return": {}}
-{"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: node i=
s used as backing hd of 'NODE_NAME'"}}
+{"error": {"class": "GenericError", "desc": "Node 'drv0' is busy: block =
device is in use by block job: commit"}}
 {"return": {}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "waiting", "id": "job0"}}
 {"timestamp": {"seconds":  TIMESTAMP, "microseconds":  TIMESTAMP}, "even=
t": "JOB_STATUS_CHANGE", "data": {"status": "pending", "id": "job0"}}
--=20
2.20.1
