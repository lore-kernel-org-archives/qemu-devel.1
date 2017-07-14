Received: from eggs.gnu.org ([2001:4830:134:3::10]:53700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dVwVE-0003wC-1G
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:03:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pm215@archaic.org.uk>) id 1dVwVD-00060e-4d
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:03:12 -0400
Received: from orth.archaic.org.uk ([2001:8b0:1d0::2]:37573)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <pm215@archaic.org.uk>)
	id 1dVwVC-00060O-TL
	for qemu-devel@nongnu.org; Fri, 14 Jul 2017 05:03:11 -0400
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jul 2017 09:33:45 +0100
Message-Id: <1500021225-4118-4-git-send-email-peter.maydell@linaro.org>
In-Reply-To: <1500021225-4118-1-git-send-email-peter.maydell@linaro.org>
References: <1500021225-4118-1-git-send-email-peter.maydell@linaro.org>
Subject: [Qemu-devel] [PATCH 3/3] configure: Don't build ivshmem tools
 unless CONFIG_IVSHMEM is set
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: patches@linaro.org, Kamil Rytarowski <n54@gmx.com>, Markus Armbruster <armbru@redhat.com>

From: Kamil Rytarowski <n54@gmx.com>

Don't try to build the ivshmem-server and ivshmem-client tools unless
CONFIG_IVSHMEM is set.

This fixes in passing a build bug on NetBSD, which fails to build the
ivshmem tools because they use shm_open() and on NetBSD that requires
linking against -lrt.

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
[PMM: moved some code into earlier patches; minor bugfixes;
 added commit message]
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 configure     | 2 ++
 Makefile      | 2 ++
 Makefile.objs | 4 ++--
 3 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index dea46c5..b54bc2e 100755
--- a/configure
+++ b/configure
@@ -4979,6 +4979,8 @@ if test "$want_tools" = "yes" ; then
   tools="qemu-img\$(EXESUF) qemu-io\$(EXESUF) $tools"
   if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
     tools="qemu-nbd\$(EXESUF) $tools"
+  fi
+  if [ "$ivshmem" = "yes" ]; then
     tools="ivshmem-client\$(EXESUF) ivshmem-server\$(EXESUF) $tools"
   fi
 fi
diff --git a/Makefile b/Makefile
index 16a0430..5d5bd6a 100644
--- a/Makefile
+++ b/Makefile
@@ -470,10 +470,12 @@ ifneq ($(EXESUF),)
 qemu-ga: qemu-ga$(EXESUF) $(QGA_VSS_PROVIDER) $(QEMU_GA_MSI)
 endif
 
+ifdef CONFIG_IVSHMEM
 ivshmem-client$(EXESUF): $(ivshmem-client-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
 ivshmem-server$(EXESUF): $(ivshmem-server-obj-y) $(COMMON_LDADDS)
 	$(call LINK, $^)
+endif
 vhost-user-scsi$(EXESUF): $(vhost-user-scsi-obj-y)
 	$(call LINK, $^)
 
diff --git a/Makefile.objs b/Makefile.objs
index bfd5a6c..24a4ea0 100644
--- a/Makefile.objs
+++ b/Makefile.objs
@@ -107,8 +107,8 @@ qga-vss-dll-obj-y = qga/
 
 ######################################################################
 # contrib
-ivshmem-client-obj-y = contrib/ivshmem-client/
-ivshmem-server-obj-y = contrib/ivshmem-server/
+ivshmem-client-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-client/
+ivshmem-server-obj-$(CONFIG_IVSHMEM) = contrib/ivshmem-server/
 libvhost-user-obj-y = contrib/libvhost-user/
 vhost-user-scsi.o-cflags := $(LIBISCSI_CFLAGS)
 vhost-user-scsi.o-libs := $(LIBISCSI_LIBS)
-- 
2.7.4
