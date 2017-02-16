Received: from eggs.gnu.org ([2001:4830:134:3::10]:52051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6u-00044A-P9
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ceN6t-0008L1-U5
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:40 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:34892)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ceN6t-0008KX-NP
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 09:32:39 -0500
Received: by mail-wm0-x243.google.com with SMTP id u63so3409230wmu.2
	for <qemu-devel@nongnu.org>; Thu, 16 Feb 2017 06:32:39 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 16 Feb 2017 15:31:43 +0100
Message-Id: <1487255507-106654-20-git-send-email-pbonzini@redhat.com>
In-Reply-To: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
References: <1487255507-106654-1-git-send-email-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 19/23] Makefile: avoid leaving the temporary
 QEMU_PKGVERSION header file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Lin Ma <lma@suse.com>

From: Lin Ma <lma@suse.com>

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
Message-Id: <20170215024030.23895-1-lma@suse.com>
Reviewed-by: Fam Zheng <famz@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
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
1.8.3.1
