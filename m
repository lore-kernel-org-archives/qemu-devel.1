Received: from eggs.gnu.org ([209.51.188.92]:34665)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gvnJp-0005M6-7j
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:07:06 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1gvnJo-0006Tm-91
	for qemu-devel@nongnu.org; Mon, 18 Feb 2019 13:07:05 -0500
From: Max Reitz <mreitz@redhat.com>
Date: Mon, 18 Feb 2019 19:06:46 +0100
Message-Id: <20190218180646.30282-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH] iotests: Skip 211 on insufficient memory
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>

VDI keeps the whole bitmap in memory, and the maximum size (which is
tested here) is 2 GB.  This may not be available on all machines, and it
rarely is available when running a 32 bit build.

Fix this by making VM.run_job() return the error string if an error
occurred, and checking whether that contains "Could not allocate bmap"
in 211.  If so, the test is skipped.

Signed-off-by: Max Reitz <mreitz@redhat.com>
---
 tests/qemu-iotests/211        | 4 +++-
 tests/qemu-iotests/iotests.py | 5 ++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/tests/qemu-iotests/211 b/tests/qemu-iotests/211
index 5d285450b5..6afc894f76 100755
--- a/tests/qemu-iotests/211
+++ b/tests/qemu-iotests/211
@@ -32,7 +32,9 @@ def blockdev_create(vm, options):
=20
     if 'return' in result:
         assert result['return'] =3D=3D {}
-        vm.run_job('job0')
+        error =3D vm.run_job('job0')
+        if error and 'Could not allocate bmap' in error:
+            iotests.notrun('Insufficient memory')
     iotests.log("")
=20
 with iotests.FilePath('t.vdi') as disk_path, \
diff --git a/tests/qemu-iotests/iotests.py b/tests/qemu-iotests/iotests.p=
y
index 387e026556..4910fb2005 100644
--- a/tests/qemu-iotests/iotests.py
+++ b/tests/qemu-iotests/iotests.py
@@ -532,7 +532,9 @@ class VM(qtest.QEMUQtestMachine):
         log(result, filters, indent=3Dindent)
         return result
=20
+    # Returns None on success, and an error string on failure
     def run_job(self, job, auto_finalize=3DTrue, auto_dismiss=3DFalse):
+        error =3D None
         while True:
             for ev in self.get_qmp_events_filtered(wait=3DTrue):
                 if ev['event'] =3D=3D 'JOB_STATUS_CHANGE':
@@ -541,13 +543,14 @@ class VM(qtest.QEMUQtestMachine):
                         result =3D self.qmp('query-jobs')
                         for j in result['return']:
                             if j['id'] =3D=3D job:
+                                error =3D j['error']
                                 log('Job failed: %s' % (j['error']))
                     elif status =3D=3D 'pending' and not auto_finalize:
                         self.qmp_log('job-finalize', id=3Djob)
                     elif status =3D=3D 'concluded' and not auto_dismiss:
                         self.qmp_log('job-dismiss', id=3Djob)
                     elif status =3D=3D 'null':
-                        return
+                        return error
                 else:
                     iotests.log(ev)
=20
--=20
2.20.1
