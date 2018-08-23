Received: from eggs.gnu.org ([2001:4830:134:3::10]:34427)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fsnp8-0001if-QT
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 07:30:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1fsnge-0002qB-FN
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 07:22:01 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:44834)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1fsnge-0002pQ-8N
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 07:22:00 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 Aug 2018 12:21:53 +0100
Message-Id: <20180823112153.15279-1-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH] tests/vm: Increase timeout waiting for VM to
 boot to 5 minutes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>

The VM tests currently have a timeout of 2 minutes for trying
to connect to ssh. Since the guest VM has to boot from cold
to the point of accepting inbound ssh during this time, if the
host machine is heavily loaded it can spuriously time out.
Increase the timeout from 2 to 5 minutes.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
I see this ssh-connection-attempt timeout occasionally
in my test builds...

 tests/vm/basevm.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index d7149dea7da..7e58d9e0ca2 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -176,7 +176,7 @@ class BaseVM(object):
             raise Exception("Cannot find ssh port from 'info usernet':\n%s" % \
                             usernet_info)
 
-    def wait_ssh(self, seconds=120):
+    def wait_ssh(self, seconds=300):
         starttime = datetime.datetime.now()
         guest_up = False
         while (datetime.datetime.now() - starttime).total_seconds() < seconds:
-- 
2.18.0
