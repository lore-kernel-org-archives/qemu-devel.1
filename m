Received: from eggs.gnu.org ([209.51.188.92]:39001)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI6Z-00023P-Ip
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:23:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gyI6W-0002I8-8t
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 10:23:43 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Mon, 25 Feb 2019 16:20:53 +0100
Message-Id: <20190225152053.15976-72-kwolf@redhat.com>
In-Reply-To: <20190225152053.15976-1-kwolf@redhat.com>
References: <20190225152053.15976-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 71/71] iotests: Skip 211 on insufficient memory
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

From: Max Reitz <mreitz@redhat.com>

VDI keeps the whole bitmap in memory, and the maximum size (which is
tested here) is 2 GB.  This may not be available on all machines, and it
rarely is available when running a 32 bit build.

Fix this by making VM.run_job() return the error string if an error
occurred, and checking whether that contains "Could not allocate bmap"
in 211.  If so, the test is skipped.

Signed-off-by: Max Reitz <mreitz@redhat.com>
Message-id: 20190218180646.30282-1-mreitz@redhat.com
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
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
