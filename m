Received: from eggs.gnu.org ([2001:4830:134:3::10]:40334)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFhOb-0007E3-U3
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:41:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1dFhOZ-000216-LP
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:41:13 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45097
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1dFhOZ-00020x-Eq
	for qemu-devel@nongnu.org; Tue, 30 May 2017 09:41:11 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v4UDcfwD123866
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 09:41:10 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0b-001b2d01.pphosted.com with ESMTP id 2as7mre5bg-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 30 May 2017 09:41:10 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <groug@kaod.org>;
	Tue, 30 May 2017 14:41:08 +0100
From: Greg Kurz <groug@kaod.org>
Date: Tue, 30 May 2017 15:40:34 +0200
In-Reply-To: <1496151640-29919-1-git-send-email-groug@kaod.org>
References: <1496151640-29919-1-git-send-email-groug@kaod.org>
Message-Id: <1496151640-29919-6-git-send-email-groug@kaod.org>
Subject: [Qemu-devel] [PULL v2 05/11] fsdev: fix virtfs-proxy-helper cwd
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>, Greg Kurz <groug@kaod.org>

Since chroot() doesn't change the current directory, it is indeed a good
practice to chdir() to the target directory and then then chroot(), or
to chroot() to the target directory and then chdir("/").

The current code does neither of them actually. Let's go for the latter.

This doesn't fix any security issue since all of this takes place before
the helper begins to process requests.

Signed-off-by: Greg Kurz <groug@kaod.org>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 fsdev/virtfs-proxy-helper.c | 8 ++++----
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
-- 
2.7.5
