Received: from eggs.gnu.org ([2001:4830:134:3::10]:51335)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dnjfB-0000Kk-1B
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:59:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <otubo@redhat.com>) id 1dnjfA-0001Rg-5C
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:59:01 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45910)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <otubo@redhat.com>) id 1dnjf9-0001RK-V6
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 06:59:00 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id D8B49C047B9B
	for <qemu-devel@nongnu.org>; Fri,  1 Sep 2017 10:58:58 +0000 (UTC)
From: Eduardo Otubo <otubo@redhat.com>
Date: Fri,  1 Sep 2017 12:58:18 +0200
Message-Id: <20170901105818.31956-7-otubo@redhat.com>
In-Reply-To: <20170901105818.31956-1-otubo@redhat.com>
References: <20170901105818.31956-1-otubo@redhat.com>
Subject: [Qemu-devel] [PATCHv4 6/6] seccomp: adding documentation to new
 seccomp model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: berrange@redhat.com, thuth@redhat.com

Adding new documentation under docs/ to describe every one and each new
option added by the refactoring patchset.

Signed-off-by: Eduardo Otubo <otubo@redhat.com>
---
 docs/seccomp.txt | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)
 create mode 100644 docs/seccomp.txt

diff --git a/docs/seccomp.txt b/docs/seccomp.txt
new file mode 100644
index 0000000000..a5eca85a9b
--- /dev/null
+++ b/docs/seccomp.txt
@@ -0,0 +1,31 @@
+QEMU Seccomp system call filter
+===============================
+
+Starting from QEMU version 2.11, the seccomp filter does not work as a
+whitelist but as a blacklist instead. This method allows safer deploys since
+only the strictly forbidden system calls will be black-listed and the
+possibility of breaking any workload is close to zero.
+
+The default option (-sandbox on) has a slightly looser security though and the
+reason is that it shouldn't break any backwards compatibility with previous
+deploys and command lines already running. But if the intent is to have a
+better security from this version on, one should make use of the following
+additional options properly:
+
+* obsolete=allow|deny: It allows Qemu to run safely on old system that still
+  relies on old system calls.
+
+* elevateprivileges=allow|deny|children: It allows or denies Qemu process
+  to elevate its privileges by blacklisting all set*uid|gid system calls. The
+  'children' option sets the PR_SET_NO_NEW_PRIVS to 1 which allows helpers
+  (forks and execs) to run unprivileged.
+
+* spawn=allow|deny: It blacklists fork and execve system calls, avoiding QEMU to
+  spawn new threads or processes.
+
+* resourcecontrol=allow|deny: It blacklists all process affinity and scheduler
+  priority system calls to avoid that the process can increase its amount of
+  allowed resource consumption.
+
+--
+Eduardo Otubo <otubo@redhat.com>
-- 
2.13.5
