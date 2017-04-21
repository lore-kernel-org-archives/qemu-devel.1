Received: from eggs.gnu.org ([2001:4830:134:3::10]:54273)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Xf2-0002Tz-8i
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1d1Xf1-0000qg-FD
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53742)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1d1Xf1-0000qW-8r
	for qemu-devel@nongnu.org; Fri, 21 Apr 2017 08:27:39 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 48C1F8E3FA
	for <qemu-devel@nongnu.org>; Fri, 21 Apr 2017 12:27:38 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Fri, 21 Apr 2017 20:27:09 +0800
Message-Id: <20170421122710.15373-14-famz@redhat.com>
In-Reply-To: <20170421122710.15373-1-famz@redhat.com>
References: <20170421122710.15373-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH 13/14] qga: Make errp the last parameter of
 qga_vss_fsfreeze
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 qga/commands-win32.c | 4 ++--
 qga/vss-win32.c      | 2 +-
 qga/vss-win32.h      | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/qga/commands-win32.c b/qga/commands-win32.c
index 19d72b2..04026ee 100644
--- a/qga/commands-win32.c
+++ b/qga/commands-win32.c
@@ -768,7 +768,7 @@ int64_t qmp_guest_fsfreeze_freeze(Error **errp)
     /* cannot risk guest agent blocking itself on a write in this state */
     ga_set_frozen(ga_state);
 
-    qga_vss_fsfreeze(&i, &local_err, true);
+    qga_vss_fsfreeze(&i, true, &local_err);
     if (local_err) {
         error_propagate(errp, local_err);
         goto error;
@@ -807,7 +807,7 @@ int64_t qmp_guest_fsfreeze_thaw(Error **errp)
         return 0;
     }
 
-    qga_vss_fsfreeze(&i, errp, false);
+    qga_vss_fsfreeze(&i, false, errp);
 
     ga_unset_frozen(ga_state);
     return i;
diff --git a/qga/vss-win32.c b/qga/vss-win32.c
index 9a0e463..a80933c 100644
--- a/qga/vss-win32.c
+++ b/qga/vss-win32.c
@@ -145,7 +145,7 @@ void ga_uninstall_vss_provider(void)
 }
 
 /* Call VSS requester and freeze/thaw filesystems and applications */
-void qga_vss_fsfreeze(int *nr_volume, Error **errp, bool freeze)
+void qga_vss_fsfreeze(int *nr_volume, bool freeze, Error **errp)
 {
     const char *func_name = freeze ? "requester_freeze" : "requester_thaw";
     QGAVSSRequesterFunc func;
diff --git a/qga/vss-win32.h b/qga/vss-win32.h
index 4d1d150..51d303a 100644
--- a/qga/vss-win32.h
+++ b/qga/vss-win32.h
@@ -21,6 +21,6 @@ bool vss_initialized(void);
 int ga_install_vss_provider(void);
 void ga_uninstall_vss_provider(void);
 
-void qga_vss_fsfreeze(int *nr_volume, Error **errp, bool freeze);
+void qga_vss_fsfreeze(int *nr_volume, bool freeze, Error **errp);
 
 #endif
-- 
2.9.3
