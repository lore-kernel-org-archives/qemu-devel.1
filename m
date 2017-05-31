Received: from eggs.gnu.org ([2001:4830:134:3::10]:47667)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dG2Ra-0000iq-5Z
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:09:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dG2RZ-00011Z-Bo
	for qemu-devel@nongnu.org; Wed, 31 May 2017 08:09:42 -0400
From: Kamil Rytarowski <n54@gmx.com>
Date: Wed, 31 May 2017 14:00:49 +0200
Message-Id: <20170531120049.14111-1-n54@gmx.com>
Subject: [Qemu-devel] [PATCH v3] ivshmem-server: ivshmem-client: Build when
 eventfd() is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-trivial@nongnu.org
Cc: qemu-devel@nongnu.org, eblake@redhat.com, peter.maydell@redhat.com, marcandre.lureau@gmail.com, f4bug@amsat.org, armbru@redhat.com, Kamil Rytarowski <n54@gmx.com>

Currently ivshmem requires eventfd() which is Linux specific.
Do not and build it unconditionally on every Linux/BSD/Solaris.

This patch indirectly fixes build failure on NetBSD, where these tools
additionally require -lrt for shm_open(3). In future there should be
added support for NetBSD and the linking addressed appropriately.

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
---
 configure                            | 2 ++
 contrib/ivshmem-client/Makefile.objs | 2 +-
 contrib/ivshmem-server/Makefile.objs | 2 +-
 3 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/configure b/configure
index 1a5ee4b909..483307be53 100755
--- a/configure
+++ b/configure
@@ -4928,6 +4928,8 @@ if test "$want_tools" = "yes" ; then
   tools="qemu-img\$(EXESUF) qemu-io\$(EXESUF) $tools"
   if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
     tools="qemu-nbd\$(EXESUF) $tools"
+  fi
+  if [ "$eventfd" = "yes" ]; then
     tools="ivshmem-client\$(EXESUF) ivshmem-server\$(EXESUF) $tools"
   fi
 fi
diff --git a/contrib/ivshmem-client/Makefile.objs b/contrib/ivshmem-client/Makefile.objs
index bfab2d20dd..13d864082d 100644
--- a/contrib/ivshmem-client/Makefile.objs
+++ b/contrib/ivshmem-client/Makefile.objs
@@ -1 +1 @@
-ivshmem-client-obj-y = ivshmem-client.o main.o
+ivshmem-client-obj-$(CONFIG_IVSHMEM) = ivshmem-client.o main.o
diff --git a/contrib/ivshmem-server/Makefile.objs b/contrib/ivshmem-server/Makefile.objs
index c060dd3698..d9469fd777 100644
--- a/contrib/ivshmem-server/Makefile.objs
+++ b/contrib/ivshmem-server/Makefile.objs
@@ -1 +1 @@
-ivshmem-server-obj-y = ivshmem-server.o main.o
+ivshmem-server-obj-$(CONFIG_IVSHMEM) = ivshmem-server.o main.o
-- 
2.13.0
