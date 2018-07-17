Received: from eggs.gnu.org ([2001:4830:134:3::10]:49275)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffG2j-0000Dq-Jt
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:48:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffG2f-0008WL-Nw
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:48:49 -0400
Received: from mail-vk0-x22f.google.com ([2607:f8b0:400c:c05::22f]:45842)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffG2f-0008W2-Hm
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 22:48:45 -0400
Received: by mail-vk0-x22f.google.com with SMTP id b78-v6so8792855vka.12
	for <qemu-devel@nongnu.org>; Mon, 16 Jul 2018 19:48:45 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 16 Jul 2018 23:48:26 -0300
Message-Id: <20180717024827.27897-5-f4bug@amsat.org>
In-Reply-To: <20180717024827.27897-1-f4bug@amsat.org>
References: <20180717024827.27897-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 4/5] tests/vm: Display remaining seconds to
 wait for a VM to start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/vm/basevm.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 715e433142..7575c36f0b 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -183,12 +183,15 @@ class BaseVM(object):
 
     def wait_ssh(self, seconds=120):
         starttime = datetime.datetime.now()
+        endtime = starttime + datetime.timedelta(seconds=seconds)
         guest_up = False
-        while (datetime.datetime.now() - starttime).total_seconds() < seconds:
+        while datetime.datetime.now() < endtime:
             if self.ssh("exit 0") == 0:
                 guest_up = True
                 break
             time.sleep(1)
+            seconds = (endtime - datetime.datetime.now()).total_seconds()
+            logging.debug("%ds before timeout", seconds)
         if not guest_up:
             raise Exception("Timeout while waiting for guest ssh")
 
-- 
2.18.0
