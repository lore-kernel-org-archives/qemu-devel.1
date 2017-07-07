Received: from eggs.gnu.org ([2001:4830:134:3::10]:35096)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dTS9T-00055j-2Q
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:14:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <agraf@suse.de>) id 1dTS9O-0002ix-4e
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:14:27 -0400
Received: from mx2.suse.de ([195.135.220.15]:33153 helo=mx1.suse.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <agraf@suse.de>) id 1dTS9N-0002iR-U8
	for qemu-devel@nongnu.org; Fri, 07 Jul 2017 08:14:22 -0400
From: Alexander Graf <agraf@suse.de>
Date: Fri,  7 Jul 2017 14:14:43 +0200
Message-Id: <1499429683-73361-1-git-send-email-agraf@suse.de>
Subject: [Qemu-devel] [PATCH] migration: Make analyze-migration script
 target-page-size aware
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Juan Quintela <quintela@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>

The configuration section has a new subsection to transmit the target page
size along with the migration stream. The analyze migration script needs
to learn about that to read configuration streams that were triggering
this subsection to get transmitted.

With this patch applied, I can successfully analyze migration streams
on AArch64 again.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 scripts/analyze-migration.py | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 1455387..02784f2 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -254,12 +254,25 @@ class HTABSection(object):
 
 
 class ConfigurationSection(object):
+    QEMU_VM_SUBSECTION    = 0x05
+
     def __init__(self, file):
         self.file = file
 
     def read(self):
         name_len = self.file.read32()
         name = self.file.readstr(len = name_len)
+        oldpos = self.file.tell()
+        if self.file.read8() == self.QEMU_VM_SUBSECTION:
+            name = self.file.readstr()
+            version_id = self.file.read32()
+            if name == "configuration/target-page-bits":
+                target_page_size = self.file.read32()
+            else:
+                raise Exception("Unknown config subsection: %s" % name)
+        else:
+            # No subsection following, forget that we ever read anything
+            self.file.seek(oldpos)
 
 class VMSDFieldGeneric(object):
     def __init__(self, desc, file):
-- 
1.8.5.6
