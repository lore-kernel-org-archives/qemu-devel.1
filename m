Received: from eggs.gnu.org ([2001:4830:134:3::10]:38493)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQbgi-0002xV-KZ
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:53:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQbge-0002jE-Ml
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:53:32 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:37626)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fQbge-0002io-Hl
	for qemu-devel@nongnu.org; Wed, 06 Jun 2018 12:53:28 -0400
Received: by mail-qk0-x242.google.com with SMTP id j12-v6so4389670qkk.4
	for <qemu-devel@nongnu.org>; Wed, 06 Jun 2018 09:53:28 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  6 Jun 2018 13:53:19 -0300
Message-Id: <20180606165319.27056-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [RFC PATCH] qmp.py: Fix exception parsing partial JSON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, Cleber Rosa <crosa@redhat.com>, Markus Armbruster <armbru@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>, =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>

The readline() call returns partial data.
Keep appending until the JSON buffer is complete.

This fixes:

    $ scripts/qmp/qmp-shell -v -p /tmp/qmp.sock
    Traceback (most recent call last):
      File "scripts/qmp/qmp-shell", line 456, in <module>
        main()
      File "scripts/qmp/qmp-shell", line 441, in main
        qemu.connect(negotiate)
      File "scripts/qmp/qmp-shell", line 284, in connect
        self._greeting = super(QMPShell, self).connect(negotiate)
      File "scripts/qmp/qmp.py", line 143, in connect
        return self.__negotiate_capabilities()
      File "scripts/qmp/qmp.py", line 71, in __negotiate_capabilities
        greeting = self.__json_read()
      File "scripts/qmp/qmp.py", line 85, in __json_read
        resp = json.loads(data)
      File "/usr/lib/python2.7/json/__init__.py", line 339, in loads
        return _default_decoder.decode(s)
      File "/usr/lib/python2.7/json/decoder.py", line 364, in decode
        obj, end = self.raw_decode(s, idx=_w(s, 0).end())
      File "/usr/lib/python2.7/json/decoder.py", line 380, in raw_decode
        obj, end = self.scan_once(s, idx)
    ValueError: Expecting object: line 1 column 3 (char 2)

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
Daniel suggested this is due to blocking i/o.

I'm sure there is a nicer/more pythonic way to do this, but this works for me,
sorry :)

 scripts/qmp/qmp.py | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/scripts/qmp/qmp.py b/scripts/qmp/qmp.py
index 5c8cf6a056..e8b55dfcc4 100644
--- a/scripts/qmp/qmp.py
+++ b/scripts/qmp/qmp.py
@@ -78,11 +78,16 @@ class QEMUMonitorProtocol(object):
         raise QMPCapabilitiesError
 
     def __json_read(self, only_event=False):
+        data = ""
         while True:
-            data = self.__sockfile.readline()
-            if not data:
+            tmp = self.__sockfile.readline()
+            if not tmp:
                 return
-            resp = json.loads(data)
+            data += tmp
+            try:
+                resp = json.loads(data)
+            except ValueError:
+                continue
             if 'event' in resp:
                 self.logger.debug("<<< %s", resp)
                 self.__events.append(resp)
-- 
2.17.1
