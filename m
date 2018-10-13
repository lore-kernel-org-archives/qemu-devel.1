Received: from eggs.gnu.org ([2001:4830:134:3::10]:54035)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBLe1-0006Rx-Dv
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 11:15:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBLe0-0004PP-Ow
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 11:15:57 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:39405)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1gBLe0-0004OW-IU
	for qemu-devel@nongnu.org; Sat, 13 Oct 2018 11:15:56 -0400
Received: by mail-wr1-x444.google.com with SMTP id 61-v6so16444471wrb.6
	for <qemu-devel@nongnu.org>; Sat, 13 Oct 2018 08:15:56 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Oct 2018 17:15:41 +0200
Message-Id: <20181013151545.3731-3-f4bug@amsat.org>
In-Reply-To: <20181013151545.3731-1-f4bug@amsat.org>
References: <20181013151545.3731-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH v3 2/6] tests/acceptance: Add a kludge to
 not use the default console
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Cleber Rosa <crosa@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Fam Zheng <famz@redhat.com>

The board already instantiate the proper devices, we don't want to
add extra devices but connect the chardev to one of the serial already
available.

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/qemu.py | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index fca9b76990..7e779954e6 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -221,8 +221,10 @@ class QEMUMachine(object):
                                                  self._name + "-console.sock")
             chardev = ('socket,id=console,path=%s,server,nowait' %
                        self._console_address)
-            device = '%s,chardev=console' % self._console_device_type
-            args.extend(['-chardev', chardev, '-device', device])
+            args.extend(['-chardev', chardev])
+            if len(self._console_device_type):
+                device = '%s,chardev=console' % self._console_device_type
+                args.extend(['-device', device])
         return args
 
     def _pre_launch(self):
-- 
2.19.1
