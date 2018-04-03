Received: from eggs.gnu.org ([2001:4830:134:3::10]:48030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1f3Ljh-0002ki-UQ
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 09:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mprivozn@redhat.com>) id 1f3Ljh-0001Ih-4F
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 09:12:29 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:38420 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mprivozn@redhat.com>) id 1f3Ljg-0001IJ-VH
	for qemu-devel@nongnu.org; Tue, 03 Apr 2018 09:12:29 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
	[10.11.54.5])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 99C2F8182D1D
	for <qemu-devel@nongnu.org>; Tue,  3 Apr 2018 13:12:28 +0000 (UTC)
From: Michal Privoznik <mprivozn@redhat.com>
Date: Tue,  3 Apr 2018 15:12:15 +0200
Message-Id: <6defbc032d960acd076d87cb2f72a84e5905fa9a.1522760575.git.mprivozn@redhat.com>
In-Reply-To: <cover.1522760575.git.mprivozn@redhat.com>
References: <cover.1522760575.git.mprivozn@redhat.com>
In-Reply-To: <cover.1522760575.git.mprivozn@redhat.com>
References: <cover.1522760575.git.mprivozn@redhat.com>
Subject: [Qemu-devel] [PATCH 2/2] qemu-pr-helper: Write pidfile more often
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

Let's write pidfile even if user did not request --daemon but
they requested just --pidfile. Libvirt will use exactly this.

Signed-off-by: Michal Privoznik <mprivozn@redhat.com>
---
 scsi/qemu-pr-helper.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/scsi/qemu-pr-helper.c b/scsi/qemu-pr-helper.c
index eeff80acf2..d0f83176e1 100644
--- a/scsi/qemu-pr-helper.c
+++ b/scsi/qemu-pr-helper.c
@@ -924,6 +924,7 @@ int main(int argc, char **argv)
     Error *local_err = NULL;
     char *trace_file = NULL;
     bool daemonize = false;
+    bool pidfile_specified = false;
     unsigned socket_activation;
 
     struct sigaction sa_sigterm;
@@ -954,6 +955,7 @@ int main(int argc, char **argv)
         case 'f':
             g_free(pidfile);
             pidfile = g_strdup(optarg);
+            pidfile_specified = true;
             break;
 #ifdef CONFIG_LIBCAP
         case 'u': {
@@ -1086,9 +1088,11 @@ int main(int argc, char **argv)
             error_report("Failed to daemonize: %s", strerror(errno));
             exit(EXIT_FAILURE);
         }
-        write_pidfile();
     }
 
+    if (daemonize || pidfile_specified)
+        write_pidfile();
+
 #ifdef CONFIG_LIBCAP
     if (drop_privileges() < 0) {
         error_report("Failed to drop privileges: %s", strerror(errno));
-- 
2.16.1
