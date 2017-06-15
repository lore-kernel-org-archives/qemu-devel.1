Received: from eggs.gnu.org ([2001:4830:134:3::10]:52791)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLRPk-0006ry-7Z
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 05:50:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1dLRPf-0003SE-BU
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 05:50:08 -0400
Received: from mail-wr0-x243.google.com ([2a00:1450:400c:c0c::243]:33752)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1dLRPf-0003Rv-4y
	for qemu-devel@nongnu.org; Thu, 15 Jun 2017 05:50:03 -0400
Received: by mail-wr0-x243.google.com with SMTP id x23so2391438wrb.0
	for <qemu-devel@nongnu.org>; Thu, 15 Jun 2017 02:50:01 -0700 (PDT)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 15 Jun 2017 11:49:57 +0200
Message-Id: <1497520197-56796-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PATCH build fix] migration: do not doubly-define
 LoadStateHandler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: dgilbert@redhat.com, peter.maydell@linaro.org

As the simplest fix to un-confuse patchew, inline the type
in struct VMStateDescription.  As there are no users of
LoadStateHandler anymore in e.g. function declarations,
there isn't much advantage in defining it as a type.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/migration/vmstate.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index f3f3c2a..82d41fa 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -29,7 +29,6 @@
 
 #include "migration/qjson.h"
 
-typedef int LoadStateHandler(QEMUFile *f, void *opaque, int version_id);
 typedef struct VMStateInfo VMStateInfo;
 typedef struct VMStateDescription VMStateDescription;
 typedef struct VMStateField VMStateField;
@@ -176,7 +175,7 @@ struct VMStateDescription {
     int minimum_version_id;
     int minimum_version_id_old;
     MigrationPriority priority;
-    LoadStateHandler *load_state_old;
+    int (*load_state_old)(QEMUFile *f, void *opaque, int version_id);
     int (*pre_load)(void *opaque);
     int (*post_load)(void *opaque, int version_id);
     void (*pre_save)(void *opaque);
-- 
1.8.3.1
