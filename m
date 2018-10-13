Received: from eggs.gnu.org ([2001:4830:134:3::10]:39765)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7zA-0001zQ-Mv
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:40:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7z7-0000WH-OG
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:40:52 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:39433)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gB7z7-0000Vx-Hj
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 20:40:49 -0400
Received: by mail-wm1-x343.google.com with SMTP id y144-v6so14326265wmd.4
	for <qemu-devel@nongnu.org>; Fri, 12 Oct 2018 17:40:49 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Oct 2018 02:40:29 +0200
Message-Id: <20181013004034.6968-5-f4bug@amsat.org>
In-Reply-To: <20181013004034.6968-1-f4bug@amsat.org>
References: <20181013004034.6968-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 4/8] tests/vm: Display remaining seconds to
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
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 tests/vm/basevm.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tests/vm/basevm.py b/tests/vm/basevm.py
index 9415e7c33a..81a1cb05dd 100755
--- a/tests/vm/basevm.py
+++ b/tests/vm/basevm.py
@@ -177,11 +177,14 @@ class BaseVM(object):
 
     def wait_ssh(self, seconds=300):
         starttime = datetime.datetime.now()
+        endtime = starttime + datetime.timedelta(seconds=seconds)
         guest_up = False
-        while (datetime.datetime.now() - starttime).total_seconds() < seconds:
+        while datetime.datetime.now() < endtime:
             if self.ssh("exit 0") == 0:
                 guest_up = True
                 break
+            seconds = (endtime - datetime.datetime.now()).total_seconds()
+            logging.debug("%ds before timeout", seconds)
             time.sleep(1)
         if not guest_up:
             raise Exception("Timeout while waiting for guest ssh")
-- 
2.19.1
