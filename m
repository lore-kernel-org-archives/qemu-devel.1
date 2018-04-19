Received: from eggs.gnu.org ([2001:4830:134:3::10]:33168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9CiC-0003IP-W6
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:47:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9CiB-0007RY-Pi
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:47:09 -0400
Received: from mail-qt0-x22b.google.com ([2607:f8b0:400d:c0d::22b]:45202)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1f9CiB-0007RE-KF
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 12:47:07 -0400
Received: by mail-qt0-x22b.google.com with SMTP id b13-v6so6485545qtp.12
	for <qemu-devel@nongnu.org>; Thu, 19 Apr 2018 09:47:07 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 19 Apr 2018 13:46:38 -0300
Message-Id: <20180419164642.9536-4-f4bug@amsat.org>
In-Reply-To: <20180419164642.9536-1-f4bug@amsat.org>
References: <20180419164642.9536-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH 3/7] qemu.py: Check console arch is
 supported before calling mktemp()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, Cleber Rosa <crosa@redhat.com>, Amador Pahim <apahim@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>, Zheng Xiang <xiang.zheng@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Fam Zheng <famz@redhat.com>, Alistair Francis <alistair23@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 scripts/qemu.py | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/scripts/qemu.py b/scripts/qemu.py
index 0eecc44d09..379767b62f 100644
--- a/scripts/qemu.py
+++ b/scripts/qemu.py
@@ -189,6 +189,16 @@ class QEMUMachine(object):
                 if option in item:
                     return []
 
+        device = '{dev_type},chardev=console'
+        if '86' in self._arch:
+            device = device.format(dev_type='isa-serial')
+        elif 'ppc' in self._arch:
+            device = device.format(dev_type='spapr-vty')
+        elif 's390x' in self._arch:
+            device = device.format(dev_type='sclpconsole')
+        else:
+            return []
+
         chardev = 'socket,id=console,{address},server,nowait'
         if console_address is None:
             console_address = tempfile.mktemp()
@@ -203,16 +213,6 @@ class QEMUMachine(object):
 
         self._console_address = console_address
 
-        device = '{dev_type},chardev=console'
-        if '86' in self._arch:
-            device = device.format(dev_type='isa-serial')
-        elif 'ppc' in self._arch:
-            device = device.format(dev_type='spapr-vty')
-        elif 's390x' in self._arch:
-            device = device.format(dev_type='sclpconsole')
-        else:
-            return []
-
         return ['-chardev', chardev,
                 '-device', device]
 
-- 
2.17.0
