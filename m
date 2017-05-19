Received: from eggs.gnu.org ([2001:4830:134:3::10]:43585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBiw2-00008L-L7
	for qemu-devel@nongnu.org; Fri, 19 May 2017 10:31:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dBivR-0005FK-Gk
	for qemu-devel@nongnu.org; Fri, 19 May 2017 10:31:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:41721)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dBivR-0005EE-4r
	for qemu-devel@nongnu.org; Fri, 19 May 2017 10:30:41 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4JET707127505
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 10:30:40 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2ahwn9x5er-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Fri, 19 May 2017 10:30:39 -0400
Received: from localhost
	by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Fri, 19 May 2017 10:30:38 -0400
From: Greg Kurz <groug@kaod.org>
Date: Fri, 19 May 2017 16:30:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <149520423435.7495.2756710723268429379.stgit@bahia.lan>
Subject: [Qemu-devel] [PATCH] fsdev: fix virtfs-proxy-helper cwd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Eric Blake <eblake@redhat.com>, Greg Kurz <groug@kaod.org>

Since chroot() doesn't change the current directory, it is indeed a good
practice to chdir() to the target directory and then then chroot(), or
to chroot() to the target directory and then chdir("/").

The current code does neither of them actually. Let's go for the latter.

This doesn't fix any security issue since all of this takes place before
the helper begins to process requests.

Signed-off-by: Greg Kurz <groug@kaod.org>
---
 fsdev/virtfs-proxy-helper.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fsdev/virtfs-proxy-helper.c b/fsdev/virtfs-proxy-helper.c
index 54f7ad1c48f0..4c4238f62e53 100644
--- a/fsdev/virtfs-proxy-helper.c
+++ b/fsdev/virtfs-proxy-helper.c
@@ -1129,14 +1129,14 @@ int main(int argc, char **argv)
         }
     }
 
-    if (chdir("/") < 0) {
-        do_perror("chdir");
-        goto error;
-    }
     if (chroot(rpath) < 0) {
         do_perror("chroot");
         goto error;
     }
+    if (chdir("/") < 0) {
+        do_perror("chdir");
+        goto error;
+    }
 
     get_version = false;
 #ifdef FS_IOC_GETVERSION
