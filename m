Received: from eggs.gnu.org ([2001:4830:134:3::10]:41994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dikoj-0007ek-8S
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:12:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <apahim@redhat.com>) id 1dikog-0005iN-2c
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:12:17 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <apahim@redhat.com>) id 1dikof-0005iA-Sn
	for qemu-devel@nongnu.org; Fri, 18 Aug 2017 13:12:14 -0400
From: Amador Pahim <apahim@redhat.com>
Date: Fri, 18 Aug 2017 19:05:20 +0200
Message-Id: <20170818170526.13496-6-apahim@redhat.com>
In-Reply-To: <20170818170526.13496-1-apahim@redhat.com>
References: <20170818170526.13496-1-apahim@redhat.com>
Subject: [Qemu-devel] [PATCH v7 05/11] qemu.py: cleanup redundant calls in
 launch()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: stefanha@gmail.com, famz@redhat.com, berrange@redhat.com, ehabkost@redhat.com, mreitz@redhat.com, kwolf@redhat.com, armbru@redhat.com, crosa@redhat.com, ldoktor@redhat.com, Amador Pahim <apahim@redhat.com>

Now that shutdown() is guaranteed to always execute self._load_io_log()
and self._post_shutdown(), their calls in 'except' became redundant and
we can safely replace it by a call to shutdown().

Signed-off-by: Amador Pahim <apahim@redhat.com>
---
 scripts/qemu.py | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 774f971f69..902d4c6c78 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -155,11 +155,7 @@ class QEMUMachine(object):
                                            stderr=subprocess.STDOUT, shell=False)
             self._post_launch()
         except:
-            if self.is_running():
-                self._popen.kill()
-                self._popen.wait()
-            self._load_io_log()
-            self._post_shutdown()
+            self.shutdown()
             raise
 
     def shutdown(self):
-- 
2.13.5
