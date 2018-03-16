Received: from eggs.gnu.org ([2001:4830:134:3::10]:33308)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ewir6-0005c4-9D
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 02:28:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1ewir5-0007sO-A7
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 02:28:44 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:43614 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1ewir5-0007s4-66
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 02:28:43 -0400
From: Fam Zheng <famz@redhat.com>
Date: Fri, 16 Mar 2018 14:28:22 +0800
Message-Id: <20180316062822.15425-3-famz@redhat.com>
In-Reply-To: <20180316062822.15425-1-famz@redhat.com>
References: <20180316062822.15425-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH for-2.13 v3 2/2] tests: Use query-usernet
 instead of 'info usernet'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Markus Armbruster <armbru@redhat.com>, Fam Zheng <famz@redhat.com>, Samuel Thibault <samuel.thibault@ens-lyon.org>, Jan Kiszka <jan.kiszka@siemens.com>, Jason Wang <jasowang@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 tests/vm/basevm.py | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 686d88decf..f51604e0ab 100755
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
@@ -166,13 +166,13 @@ class BaseVM(object):
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
