Received: from eggs.gnu.org ([2001:4830:134:3::10]:57434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dL3lE-0006hl-Er
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:34:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <quintela@redhat.com>) id 1dL3lA-0005F7-GK
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:34:44 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55908)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <quintela@redhat.com>) id 1dL3lA-0005Eo-A7
	for qemu-devel@nongnu.org; Wed, 14 Jun 2017 04:34:40 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 56448C0587C3
	for <qemu-devel@nongnu.org>; Wed, 14 Jun 2017 08:34:39 +0000 (UTC)
From: Juan Quintela <quintela@redhat.com>
Date: Wed, 14 Jun 2017 10:34:34 +0200
Message-Id: <20170614083434.17966-1-quintela@redhat.com>
Subject: [Qemu-devel] [PATCH] migration: Fix compilation with older compilers
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

That typedefs are needed on both files.  New compilers (F25 where I
work) don't complain about repeating a typedef.  But older ones
complain.

Signed-off-by: Juan Quintela <quintela@redhat.com>
---
 include/migration/register.h | 3 ---
 include/migration/vmstate.h  | 1 -
 include/qemu/typedefs.h      | 2 ++
 3 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/migration/register.h b/include/migration/register.h
index 717c617..d9498d9 100644
--- a/include/migration/register.h
+++ b/include/migration/register.h
@@ -14,9 +14,6 @@
 #ifndef MIGRATION_REGISTER_H
 #define MIGRATION_REGISTER_H
 
-typedef void SaveStateHandler(QEMUFile *f, void *opaque);
-typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
-
 typedef struct SaveVMHandlers {
     /* This runs inside the iothread lock.  */
     SaveStateHandler *save_state;
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index f3f3c2a..e85fbd8 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -29,7 +29,6 @@
 
 #include "migration/qjson.h"
 
-typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
 typedef struct VMStateInfo VMStateInfo;
 typedef struct VMStateDescription VMStateDescription;
 typedef struct VMStateField VMStateField;
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 51958bf..f745d5f 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -96,5 +96,7 @@ typedef struct uWireSlave uWireSlave;
 typedef struct VirtIODevice VirtIODevice;
 typedef struct Visitor Visitor;
 typedef struct node_info NodeInfo;
+typedef void SaveStateHandler(QEMUFile *f, void *opaque);
+typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
 
 #endif /* QEMU_TYPEDEFS_H */
-- 
2.9.4
