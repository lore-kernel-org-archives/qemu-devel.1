Received: from eggs.gnu.org ([2001:4830:134:3::10]:37736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5DD-0007OT-HE
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK5D8-00078J-LB
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54470)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK5D8-00077t-Ev
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 10:23:14 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B1CF543A3C
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 15:23:13 +0000 (UTC)
Received: from donizetti.redhat.com (ovpn-116-19.ams2.redhat.com
	[10.36.116.19])
	by int-mx10.intmail.prod.int.phx2.redhat.com (8.14.4/8.14.4) with ESMTP
	id uBMFN1xK027210
	for <qemu-devel@nongnu.org>; Thu, 22 Dec 2016 10:23:13 -0500
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Thu, 22 Dec 2016 16:22:42 +0100
Message-Id: <20161222152300.32395-8-pbonzini@redhat.com>
In-Reply-To: <20161222152300.32395-1-pbonzini@redhat.com>
References: <20161222152300.32395-1-pbonzini@redhat.com>
Subject: [Qemu-devel] [PULL 07/25] rules.mak: add more rules to avoid
 chaining
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Really rule chaining is not a particularly expensive task, since
GNU Make caches the directory listing.  However it is easy to
avoid it for most files and for phony targets (one was missing).

After this patch, only "Makefile", "scripts/hxtool" and
"scripts/create_config" attempt to use chained rules.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 Makefile.target | 1 +
 rules.mak       | 4 ++++
 2 files changed, 5 insertions(+)

diff --git a/Makefile.target b/Makefile.target
index 6689e31..8ae82cb 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -76,6 +76,7 @@ $(QEMU_PROG)-simpletrace.stp: $(BUILD_DIR)/trace-events-all
 else
 stap:
 endif
+.PHONY: stap
 
 all: $(PROGS) stap
 
diff --git a/rules.mak b/rules.mak
index c69863f..ce9e7e6 100644
--- a/rules.mak
+++ b/rules.mak
@@ -7,6 +7,10 @@ MAKEFLAGS += -rR
 
 # Files with this suffixes are final, don't try to generate them
 # using implicit rules
+%/trace-events:
+%.hx:
+%.py:
+%.objs:
 %.d:
 %.h:
 %.c:
-- 
2.9.3
