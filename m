Received: from eggs.gnu.org ([2001:4830:134:3::10]:56616)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eMCLG-00035M-FM
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 07:29:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lvivier@redhat.com>) id 1eMCLD-0002OR-Ad
	for qemu-devel@nongnu.org; Tue, 05 Dec 2017 07:28:54 -0500
From: Laurent Vivier <lvivier@redhat.com>
Date: Tue,  5 Dec 2017 13:27:40 +0100
Message-Id: <20171205122740.15005-1-lvivier@redhat.com>
Subject: [Qemu-devel] [PATCH] migration: fix analyze-migration.py script
 with radix table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, David Gibson <david@gibson.dropbear.id.au>, Bharata B Rao <bharata@linux.vnet.ibm.com>, Juan Quintela <quintela@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>

Since commit 3a38429748 ("Add a "no HPT" encoding to HTAB migration stream")
the HTAB migration stream contains a header set to "-1", meaning there
is no HPT. Teach analyze-migration.py to ignore the section in this case.

Without this fix, the script fails with a dump from a POWER9 guest:

Traceback (most recent call last):
  File "./qemu/scripts/analyze-migration.py", line 602, in <module>
    dump.read(dump_memory = args.memory)
  File "./qemu/scripts/analyze-migration.py", line 539, in read
    section.read()
  File "./qemu/scripts/analyze-migration.py", line 250, in read
    self.file.readvar(n_valid * self.HASH_PTE_SIZE_64)
  File "./qemu/scripts/analyze-migration.py", line 64, in readvar
    raise Exception("Unexpected end of %s at 0x%x" % (self.filename, self.file.tell()))
Exception: Unexpected end of migrate.dump at 0x1d4763ba

Fixes: 3a38429748 ("Add a "no HPT" encoding to HTAB migration stream")
Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 scripts/analyze-migration.py | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 14553876a2..88ff4adb30 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -234,6 +234,10 @@ class HTABSection(object):
 
         header = self.file.read32()
 
+        if (header == -1):
+            # "no HPT" encoding
+            return
+
         if (header > 0):
             # First section, just the hash shift
             return
-- 
2.14.3
