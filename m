Received: from eggs.gnu.org ([2001:4830:134:3::10]:36545)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1cdpWc-0001Rc-Ih
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 21:40:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lma@suse.com>) id 1cdpWX-0006ON-Ly
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 21:40:58 -0500
Received: from prv3-mh.provo.novell.com ([137.65.250.26]:54905)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lma@suse.com>) id 1cdpWX-0006MB-C1
	for qemu-devel@nongnu.org; Tue, 14 Feb 2017 21:40:53 -0500
From: Lin Ma <lma@suse.com>
Date: Wed, 15 Feb 2017 10:40:30 +0800
Message-Id: <20170215024030.23895-1-lma@suse.com>
Subject: [Qemu-devel] [PATCH v3] Makefile: avoid leaving the temporary
 QEMU_PKGVERSION header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, pbonzini@redhat.com
Cc: famz@redhat.com, stefanha@redhat.com

By commit 67a1de0d, When we perform 'git pull && make && sudo make install',
In 'make' stage a qemu-version.h.tmp will be generated. If the content of
qemu-version.h.tmp and qemu-version.h aren't consistent, The qemu-version.h.tmp
will be renamed to qemu-version.h. Because of the target FORCE, The same action
will be do again in 'make install' stage.

In 'make install' stage, If there is no qemu-version.h.tmp exists and we run
'make install' with sudo, The owner and group of new qemu-version.h.tmp will be
privileged user/group. When we run 'make' next time, qemu-version.h.tmp can't
be overwritten because of permission issue.

This patch removed qemu-version.h.tmp after build to fix this issue.

Signed-off-by: Lin Ma <lma@suse.com>
---
 Makefile | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index b993741..830fa5a 100644
--- a/Makefile
+++ b/Makefile
@@ -299,7 +299,11 @@ qemu-version.h: FORCE
 				printf '""\n'; \
 			fi; \
 		fi) > $@.tmp)
-	$(call quiet-command, cmp -s $@ $@.tmp || mv $@.tmp $@)
+	$(call quiet-command, if ! cmp -s $@ $@.tmp; then \
+	  mv $@.tmp $@; \
+	 else \
+	  rm $@.tmp; \
+	 fi)
 
 config-host.h: config-host.h-timestamp
 config-host.h-timestamp: config-host.mak
-- 
2.9.2
