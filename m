Received: from eggs.gnu.org ([2001:4830:134:3::10]:47887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTqRo-0004Ar-7u
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:15:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fTqRm-0000gg-GZ
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:15:32 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:57558 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fTqRm-0000gN-5j
	for qemu-devel@nongnu.org; Fri, 15 Jun 2018 11:15:30 -0400
From: "Dr. David Alan Gilbert (git)" <dgilbert@redhat.com>
Date: Fri, 15 Jun 2018 16:15:09 +0100
Message-Id: <20180615151518.83637-2-dgilbert@redhat.com>
In-Reply-To: <20180615151518.83637-1-dgilbert@redhat.com>
References: <20180615151518.83637-1-dgilbert@redhat.com>
Subject: [Qemu-devel] [PULL 01/10] typedefs: add QJSON
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, quintela@redhat.com, peterx@redhat.com, groug@kaod.org, vsementsov@virtuozzo.com, xiaoguangrong@tencent.com, bala24@linux.vnet.ibm.com

From: Greg Kurz <groug@kaod.org>

Since commit 83ee768d6247b, we now have two places that define the
QJSON type:

$ git grep 'typedef struct QJSON QJSON'
include/migration/vmstate.h:typedef struct QJSON QJSON;
migration/qjson.h:typedef struct QJSON QJSON;

This breaks docker-test-build@centos6:

In file included from /tmp/qemu-test/src/migration/savevm.c:59:
/tmp/qemu-test/src/migration/qjson.h:16: error: redefinition of typedef
 'QJSON'
/tmp/qemu-test/src/include/migration/vmstate.h:30: note: previous
 declaration of 'QJSON' was here
make: *** [migration/savevm.o] Error 1

This happens because CentOS 6 has an old GCC 4.4.7. Even if redefining
a typedef with the same type is permitted since GCC 4.6, unless -pedantic
is passed, we don't really need to do that on purpose. Let's have a
single definition in <qemu/typedefs.h> instead.

Signed-off-by: Greg Kurz <groug@kaod.org>
Message-Id: <152844714981.11789.3657734445739553287.stgit@bahia.lan>
Reviewed-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
Signed-off-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
---
 include/migration/vmstate.h | 2 --
 include/qemu/typedefs.h     | 1 +
 migration/qjson.h           | 2 --
 3 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index 3747110f95..42b946ce90 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -27,8 +27,6 @@
 #ifndef QEMU_VMSTATE_H
 #define QEMU_VMSTATE_H
 
-typedef struct QJSON QJSON;
-
 typedef struct VMStateInfo VMStateInfo;
 typedef struct VMStateDescription VMStateDescription;
 typedef struct VMStateField VMStateField;
diff --git a/include/qemu/typedefs.h b/include/qemu/typedefs.h
index 325c72de33..3ec0e13a96 100644
--- a/include/qemu/typedefs.h
+++ b/include/qemu/typedefs.h
@@ -97,6 +97,7 @@ typedef struct QEMUTimer QEMUTimer;
 typedef struct QEMUTimerListGroup QEMUTimerListGroup;
 typedef struct QBool QBool;
 typedef struct QDict QDict;
+typedef struct QJSON QJSON;
 typedef struct QList QList;
 typedef struct QNull QNull;
 typedef struct QNum QNum;
diff --git a/migration/qjson.h b/migration/qjson.h
index 2978b5f371..41664f2d71 100644
--- a/migration/qjson.h
+++ b/migration/qjson.h
@@ -13,8 +13,6 @@
 #ifndef QEMU_QJSON_H
 #define QEMU_QJSON_H
 
-typedef struct QJSON QJSON;
-
 QJSON *qjson_new(void);
 void qjson_destroy(QJSON *json);
 void json_prop_str(QJSON *json, const char *name, const char *str);
-- 
2.17.1
