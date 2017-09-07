Received: from eggs.gnu.org ([2001:4830:134:3::10]:41703)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsOZ-0000NX-Ie
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:42:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1dpsOU-0000uS-V8
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:42:43 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39300)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1dpsOU-0000uJ-P4
	for qemu-devel@nongnu.org; Thu, 07 Sep 2017 04:42:38 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51B12C0587E3
	for <qemu-devel@nongnu.org>; Thu,  7 Sep 2017 08:42:37 +0000 (UTC)
From: Fam Zheng <famz@redhat.com>
Date: Thu,  7 Sep 2017 16:42:30 +0800
Message-Id: <20170907084230.26493-1-famz@redhat.com>
Subject: [Qemu-devel] [PATCH] buildsys: Move rdma libs to per object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, Peter Xu <peterx@redhat.com>

Signed-off-by: Fam Zheng <famz@redhat.com>
---
 configure               | 2 +-
 migration/Makefile.objs | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure b/configure
index fb7e34a901..470b8a085b 100755
--- a/configure
+++ b/configure
@@ -2818,7 +2818,6 @@ EOF
   rdma_libs="-lrdmacm -libverbs"
   if compile_prog "" "$rdma_libs" ; then
     rdma="yes"
-    libs_softmmu="$libs_softmmu $rdma_libs"
   else
     if test "$rdma" = "yes" ; then
         error_exit \
@@ -6035,6 +6034,7 @@ echo "CONFIG_TRACE_FILE=$trace_file" >> $config_host_mak
 
 if test "$rdma" = "yes" ; then
   echo "CONFIG_RDMA=y" >> $config_host_mak
+  echo "RDMA_LIBS=$rdma_libs" >> $config_host_mak
 fi
 
 if test "$have_rtnetlink" = "yes" ; then
diff --git a/migration/Makefile.objs b/migration/Makefile.objs
index 1c7770da46..99e038024d 100644
--- a/migration/Makefile.objs
+++ b/migration/Makefile.objs
@@ -11,3 +11,4 @@ common-obj-$(CONFIG_RDMA) += rdma.o
 
 common-obj-$(CONFIG_LIVE_BLOCK_MIGRATION) += block.o
 
+rdma.o-libs := $(RDMA_LIBS)
-- 
2.13.5
