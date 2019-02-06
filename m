Received: from eggs.gnu.org ([209.51.188.92]:38359)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grTIw-0000I3-SM
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:56:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1grTIv-00085F-Ha
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 14:56:18 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Wed,  6 Feb 2019 20:55:50 +0100
Message-Id: <20190206195551.28893-8-mreitz@redhat.com>
In-Reply-To: <20190206195551.28893-1-mreitz@redhat.com>
References: <20190206195551.28893-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 7/8] iotests: Test internal option typing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, Kevin Wolf <kwolf@redhat.com>

It would be nice if qemu used the correct types for blockdev options
internally, even if the user specified string values (either through
-drive or by being not so nice and using json:{} with string values).
This patch adds a test verifying that fact.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/089     | 25 +++++++++++++++++++++++++
 tests/qemu-iotests/089.out |  9 +++++++++
 2 files changed, 34 insertions(+)

diff --git a/tests/qemu-iotests/089 b/tests/qemu-iotests/089
index 3165d79e2a..0ac1e1fbf5 100755
--- a/tests/qemu-iotests/089
+++ b/tests/qemu-iotests/089
@@ -35,6 +35,7 @@ trap "_cleanup; exit \$status" 0 1 2 3 15
 # get standard environment, filters and checks
 . ./common.rc
 . ./common.filter
+. ./common.qemu
=20
 _supported_fmt qcow2
 _supported_proto file
@@ -144,6 +145,30 @@ $QEMU_IO -c "open -o driver=3Dqcow2 json:{\"file.fil=
ename\":\"$TEST_IMG\"}" \
 $QEMU_IO -c "open -o driver=3Dqcow2 json:{\"driver\":\"raw\",\"file.file=
name\":\"$TEST_IMG\"}" \
          -c "info" 2>&1 | _filter_img_info
=20
+echo
+echo "=3D=3D=3D Testing option typing =3D=3D=3D"
+echo
+
+# json:{} accepts both strings and correctly typed values (even mixed,
+# although we probably do not want to support that...), but when
+# creating a json:{} filename, it should be correctly typed.
+# Therefore, both of these should make the "size" value an integer.
+
+TEST_IMG=3D"json:{'driver': 'null-co', 'size':  42 }" _img_info | grep '=
^image'
+TEST_IMG=3D"json:{'driver': 'null-co', 'size': '42'}" _img_info | grep '=
^image'
+
+echo
+
+# This should even work when some driver abuses bs->options to store
+# non-QAPI options (and the given -drive options are not complete)
+# (Watch for whether file.align appears as an int or a string)
+qemu_comm_method=3Dmonitor _launch_qemu \
+    -drive if=3Dnone,id=3Ddrv0,node-name=3Dnode0,format=3Draw,file=3Dblk=
debug::null-co://,file.align=3D512
+
+_send_qemu_cmd $QEMU_HANDLE 'info block' 'json:'
+
+_cleanup_qemu
+
=20
 # success, all done
 echo "*** done"
diff --git a/tests/qemu-iotests/089.out b/tests/qemu-iotests/089.out
index 89e3e4340a..35ffbabe77 100644
--- a/tests/qemu-iotests/089.out
+++ b/tests/qemu-iotests/089.out
@@ -49,4 +49,13 @@ vm state offset: 512 MiB
 format name: IMGFMT
 cluster size: 64 KiB
 vm state offset: 512 MiB
+
+=3D=3D=3D Testing option typing =3D=3D=3D
+
+image: json:{"driver": "null-co", "size": 42}
+image: json:{"driver": "null-co", "size": 42}
+
+QEMU X.Y.Z monitor - type 'help' for more information
+(qemu) info block
+drv0 (node0): json:{"driver": "raw", "file": {"image": {"driver": "null-=
co"}, "driver": "blkdebug", "align": 512}} (raw)
 *** done
--=20
2.20.1
