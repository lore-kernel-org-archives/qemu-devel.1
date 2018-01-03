Received: from eggs.gnu.org ([2001:4830:134:3::10]:34636)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWfVd-000772-Ps
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:38:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1eWfVb-00072z-MS
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:38:53 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44008)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1eWfVb-00072Q-FM
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 04:38:51 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 998C96A7C5
	for <qemu-devel@nongnu.org>; Wed,  3 Jan 2018 09:38:50 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed,  3 Jan 2018 10:38:26 +0100
Message-Id: <20180103093834.20879-7-quintela@redhat.com>
In-Reply-To: <20180103093834.20879-1-quintela@redhat.com>
References: <20180103093834.20879-1-quintela@redhat.com>
Subject: [Qemu-devel] [PULL 06/14] migration: fix analyze-migration.py
 script with radix table
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, lvivier@redhat.com, peterx@redhat.com

From: Laurent Vivier <lvivier@redhat.com>

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
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Reviewed-by: Greg Kurz <groug@kaod.org>
Signed-off-by: Juan Quintela <quintela@redhat.com>
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
