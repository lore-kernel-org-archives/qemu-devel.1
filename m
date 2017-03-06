Received: from eggs.gnu.org ([2001:4830:134:3::10]:60371)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1cknec-0002iM-Fx
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:06:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mdroth@linux.vnet.ibm.com>) id 1ckneY-0006Un-B1
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:06:02 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:39635
	helo=mx0a-001b2d01.pphosted.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mdroth@linux.vnet.ibm.com>)
	id 1ckneY-0006UG-4R
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 03:05:58 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
	by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v26844Io012731
	for <qemu-devel@nongnu.org>; Mon, 6 Mar 2017 03:05:57 -0500
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	by mx0b-001b2d01.pphosted.com with ESMTP id 28yu2jhccw-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 03:05:56 -0500
Received: from localhost
	by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <mdroth@linux.vnet.ibm.com>;
	Mon, 6 Mar 2017 01:05:56 -0700
From: Michael Roth <mdroth@linux.vnet.ibm.com>
Date: Mon,  6 Mar 2017 02:03:41 -0600
In-Reply-To: <1488787422-30487-1-git-send-email-mdroth@linux.vnet.ibm.com>
References: <1488787422-30487-1-git-send-email-mdroth@linux.vnet.ibm.com>
Message-Id: <1488787422-30487-3-git-send-email-mdroth@linux.vnet.ibm.com>
Subject: [Qemu-devel] [PULL for-2.9 2/3] qga: ignore EBUSY when freezing a
 filesystem
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Peter Lieven <pl@kamp.de>, qemu-stable@nongnu.org

From: Peter Lieven <pl@kamp.de>

the current implementation fails if we try to freeze an
already frozen filesystem. This can happen if a filesystem
is mounted more than once (e.g. with a bind mount).

Suggested-by: Christian Theune <ct@flyingcircus.io>
Cc: qemu-stable@nongnu.org
Signed-off-by: Peter Lieven <pl@kamp.de>
Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Michael Roth <mdroth@linux.vnet.ibm.com>
---
 qga/commands-posix.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/qga/commands-posix.c b/qga/commands-posix.c
index ea37c09..73d93eb 100644
--- a/qga/commands-posix.c
+++ b/qga/commands-posix.c
@@ -1243,6 +1243,9 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
          * filesystems may not implement fsfreeze for less obvious reasons.
          * these will report EOPNOTSUPP. we simply ignore these when tallying
          * the number of frozen filesystems.
+         * if a filesystem is mounted more than once (aka bind mount) a
+         * consecutive attempt to freeze an already frozen filesystem will
+         * return EBUSY.
          *
          * any other error means a failure to freeze a filesystem we
          * expect to be freezable, so return an error in those cases
@@ -1250,7 +1253,7 @@ int64_t qmp_guest_fsfreeze_freeze_list(bool has_mountpoints,
          */
         ret = ioctl(fd, FIFREEZE);
         if (ret == -1) {
-            if (errno != EOPNOTSUPP) {
+            if (errno != EOPNOTSUPP && errno != EBUSY) {
                 error_setg_errno(errp, errno, "failed to freeze %s",
                                  mount->dirname);
                 close(fd);
-- 
2.7.4
