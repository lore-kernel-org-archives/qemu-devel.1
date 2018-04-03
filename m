Received: from eggs.gnu.org ([2001:4830:134:3::10]:48028)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1f3Ljh-0002kc-N2
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 09:12:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1f3Ljg-0001I5-1E
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 09:12:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:33390 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1f3Ljf-0001Hs-TJ
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 09:12:27 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 925E7402314E
	for <qemu-devel@nongnu.org>; Tue,  3 Apr 2018 13:12:27 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
Date: Tue,  3 Apr 2018 15:12:14 +0200
Message-Id: <6fe03e3d464c44ed638484ab558a771076d5c11f.1522760575.git.mprivozn@redhat.com>
In-Reply-To: <cover.1522760575.git.mprivozn@redhat.com>
References: <cover.1522760575.git.mprivozn@redhat.com>
In-Reply-To: <cover.1522760575.git.mprivozn@redhat.com>
References: <cover.1522760575.git.mprivozn@redhat.com>
Subject: [Qemu-devel] [PATCH 1/2] qemu-pr-helper: Daemonize before dropping
 privileges
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, famz@redhat.com

After we've dropped privileges it might be not possible to write
pidfile. For instance, if this binary is run as root (because
user wants it to write pidfile to some privileged location)
writing pidfile fails because privileges are dropped before we
even get to that.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 scsi/qemu-pr-helper.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index 21e1b8ea60..eeff80acf2 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -1081,13 +1081,6 @@ int main(int argc, char **argv)
                                          accept_client,
                                          NULL, NULL);
 
-#ifdef CONFIG_LIBCAP
-    if (drop_privileges() < 0) {
-        error_report("Failed to drop privileges: %s", strerror(errno));
-        exit(EXIT_FAILURE);
-    }
-#endif
-
     if (daemonize) {
         if (daemon(0, 0) < 0) {
             error_report("Failed to daemonize: %s", strerror(errno));
@@ -1096,6 +1089,13 @@ int main(int argc, char **argv)
         write_pidfile();
     }
 
+#ifdef CONFIG_LIBCAP
+    if (drop_privileges() < 0) {
+        error_report("Failed to drop privileges: %s", strerror(errno));
+        exit(EXIT_FAILURE);
+    }
+#endif
+
     state = RUNNING;
     do {
         main_loop_wait(false);
-- 
2.16.1
