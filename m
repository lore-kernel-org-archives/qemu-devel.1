Received: from eggs.gnu.org ([2001:4830:134:3::10]:47217)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fDmED-00040g-Ro
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:31:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1fDmE9-0008DO-Vw
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:31:05 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:55394 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1fDmE9-0008Cu-Rd
	for qemu-devel@nongnu.org; Wed, 02 May 2018 03:31:01 -0400
From: Fam Zheng <famz@redhat.com>
Date: Wed,  2 May 2018 15:30:34 +0800
Message-Id: <20180502073034.15141-3-famz@redhat.com>
In-Reply-To: <20180502073034.15141-1-famz@redhat.com>
References: <20180502073034.15141-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH v4 2/2] tests: Use query-usernet instead of
 'info usernet'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Samuel Thibault <samuel.thibault@ens-lyon.org>, Fam Zheng <famz@redhat.com>, Jason Wang <jasowang@redhat.com>, Eric Blake <eblake@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/vm/basevm.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 3a2d508c35..dcfa6597ad 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -101,7 +101,7 @@ class BaseVM(object):
                    "-o", "StrictHostKeyChecking=no",
                    "-o", "UserKnownHostsFile=" + os.devnull,
                    "-o", "ConnectTimeout=1",
-                   "-p", self.ssh_port, "-i", self._ssh_key_file]
+                   "-p", str(self.ssh_port), "-i", self._ssh_key_file]
         if interactive:
             ssh_cmd += ['-t']
         assert not isinstance(cmd, str)
@@ -163,13 +163,13 @@ class BaseVM(object):
             raise
         atexit.register(self.shutdown)
         self._guest = guest
-        usernet_info = guest.qmp("human-monitor-command",
-                                 command_line="info usernet")
+        usernet_info = guest.qmp("query-usernet")
         self.ssh_port = None
-        for l in usernet_info["return"].splitlines():
-            fields = l.split()
-            if "TCP[HOST_FORWARD]" in fields and "22" in fields:
-                self.ssh_port = l.split()[3]
+        for i in usernet_info["return"]:
+            if i.get("id") != "vnet":
+                continue
+            self.ssh_port = i["connections"][0]["src_port"]
+            break
         if not self.ssh_port:
             raise Exception("Cannot find ssh port from 'info usernet':\n%s" % \
                             usernet_info)
-- 
2.14.3
