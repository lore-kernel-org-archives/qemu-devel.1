Received: from eggs.gnu.org ([209.51.188.92]:57645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj54V-0003om-QM
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gj54U-0005OU-QW
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 11:26:43 -0500
From: Eric Blake <eblake@redhat.com>
Date: Mon, 14 Jan 2019 10:25:53 -0600
Message-Id: <20190114162605.5330-9-eblake@redhat.com>
In-Reply-To: <20190114162605.5330-1-eblake@redhat.com>
References: <20190114162605.5330-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 08/20] iotests: remove default filters from
 qmp_log
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:Block layer core" <qemu-block@nongnu.org>

From: John Snow <jsnow@redhat.com>

Several places in iotests deal with serializing objects into JSON
strings, but to add pretty-printing it seems desirable to localize
all of those cases.

log() seems like a good candidate for that centralized behavior.
log() can already serialize json objects, but when it does so,
it assumes filters=3D[] operates on QMP objects, not strings.

qmp_log currently operates by dumping outgoing and incoming QMP
objects into strings and filtering them assuming that filters=3D[]
are string filters.

To have qmp_log use log's serialization, qmp_log will need to
accept only qmp filters, not text filters.

However, only a single caller of qmp_log actually requires any
filters at all. I remove the default filter and add it explicitly
to the caller in preparation for refactoring qmp_log to use rich
filters instead.

test 206 is amended to name the filter explicitly and the default
is removed.

Signed-off-by: John Snow <jsnow@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-Id: <20181221093529.23855-9-jsnow@redhat.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 tests/qemu-iotests/206        | 8 ++++++--
 tests/qemu-iotests/iotests.py | 2 +-
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/tests/qemu-iotests/206 b/tests/qemu-iotests/206
index 128c334c7c5..e92550fa59f 100755
--- a/tests/qemu-iotests/206
+++ b/tests/qemu-iotests/206
@@ -26,7 +26,9 @@ from iotests import imgfmt
 iotests.verify_image_format(supported_fmts=3D['qcow2'])

 def blockdev_create(vm, options):
-    result =3D vm.qmp_log('blockdev-create', job_id=3D'job0', options=3D=
options)
+    result =3D vm.qmp_log('blockdev-create',
+                        filters=3D[iotests.filter_testfiles],
+                        job_id=3D'job0', options=3Doptions)

     if 'return' in result:
         assert result['return'] =3D=3D {}
@@ -52,7 +54,9 @@ with iotests.FilePath('t.qcow2') as disk_path, \
                           'filename': disk_path,
                           'size': 0 })

-    vm.qmp_log('blockdev-add', driver=3D'file', filename=3Ddisk_path,
+    vm.qmp_log('blockdev-add',
+               filters=3D[iotests.filter_testfiles],
+               driver=3D'file', filename=3Ddisk_path,
                node_name=3D'imgfile')

     blockdev_create(vm, { 'driver': imgfmt,
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 565eebb1ab5..57fe20db45a 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -460,7 +460,7 @@ class VM(qtest.QEMUQtestMachine):
             result.append(filter_qmp_event(ev))
         return result

-    def qmp_log(self, cmd, filters=3D[filter_testfiles], **kwargs):
+    def qmp_log(self, cmd, filters=3D[], **kwargs):
         full_cmd =3D OrderedDict((
             ("execute", cmd),
             ("arguments", ordered_kwargs(kwargs))
--=20
2.20.1
