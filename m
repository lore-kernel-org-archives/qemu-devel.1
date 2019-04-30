Received: from eggs.gnu.org ([209.51.188.92]:48827)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUus-000845-Ff
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLUup-00026N-Md
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 11:43:34 -0400
From: Kevin Wolf <kwolf@redhat.com>
Date: Tue, 30 Apr 2019 17:42:30 +0200
Message-Id: <20190430154244.30083-14-kwolf@redhat.com>
In-Reply-To: <20190430154244.30083-1-kwolf@redhat.com>
References: <20190430154244.30083-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 13/27] qemu-img: Make create hint at protocol
 options
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, qemu-devel@nongnu.org

From: Max Reitz <mreitz@redhat.com>

qemu-img create allows giving just a format and "-o help" to get a list
of the options supported by that format.  Users may not realize that the
protocol level may offer even more options, which they only get to see
by specifying a filename.

This patch adds a note to hint at that fact.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Reviewed-by: John Snow <jsnow@redhat.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 qemu-img.c                 | 13 ++++++++++++-
 tests/qemu-iotests/082.out | 20 ++++++++++++++++----
 2 files changed, 28 insertions(+), 5 deletions(-)

diff --git a/qemu-img.c b/qemu-img.c
index d7fe546b85..ddd55ab291 100644
--- a/qemu-img.c
+++ b/qemu-img.c
@@ -267,9 +267,20 @@ static int print_block_option_help(const char *filen=
ame, const char *fmt)
         create_opts =3D qemu_opts_append(create_opts, proto_drv->create_=
opts);
     }
=20
-    printf("Supported options:\n");
+    if (filename) {
+        printf("Supported options:\n");
+    } else {
+        printf("Supported %s options:\n", fmt);
+    }
     qemu_opts_print_help(create_opts, false);
     qemu_opts_free(create_opts);
+
+    if (!filename) {
+        printf("\n"
+               "The protocol level may support further options.\n"
+               "Specify the target filename to include those options.\n"=
);
+    }
+
     return 0;
 }
=20
diff --git a/tests/qemu-iotests/082.out b/tests/qemu-iotests/082.out
index 9a23b68511..7e25706813 100644
--- a/tests/qemu-iotests/082.out
+++ b/tests/qemu-iotests/082.out
@@ -242,7 +242,7 @@ Testing: create -f qcow2 -o backing_file=3DTEST_DIR/t=
.qcow2 -o ,, -o help TEST_DIR
 qemu-img: Invalid option list: ,,
=20
 Testing: create -f qcow2 -o help
-Supported options:
+Supported qcow2 options:
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
@@ -263,10 +263,16 @@ Supported options:
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
=20
+The protocol level may support further options.
+Specify the target filename to include those options.
+
 Testing: create -o help
-Supported options:
+Supported raw options:
   size=3D<size>            - Virtual disk size
=20
+The protocol level may support further options.
+Specify the target filename to include those options.
+
 Testing: create -f bochs -o help
 qemu-img: Format driver 'bochs' does not support image creation
=20
@@ -516,7 +522,7 @@ Testing: convert -O qcow2 -o backing_file=3DTEST_DIR/=
t.qcow2 -o ,, -o help TEST_DI
 qemu-img: Invalid option list: ,,
=20
 Testing: convert -O qcow2 -o help
-Supported options:
+Supported qcow2 options:
   backing_file=3D<str>     - File name of a base image
   backing_fmt=3D<str>      - Image format of the base image
   cluster_size=3D<size>    - qcow2 cluster size
@@ -537,10 +543,16 @@ Supported options:
   refcount_bits=3D<num>    - Width of a reference count entry in bits
   size=3D<size>            - Virtual disk size
=20
+The protocol level may support further options.
+Specify the target filename to include those options.
+
 Testing: convert -o help
-Supported options:
+Supported raw options:
   size=3D<size>            - Virtual disk size
=20
+The protocol level may support further options.
+Specify the target filename to include those options.
+
 Testing: convert -O bochs -o help
 qemu-img: Format driver 'bochs' does not support image creation
=20
--=20
2.20.1
