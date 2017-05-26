Received: from eggs.gnu.org ([2001:4830:134:3::10]:33362)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1dE87R-0006As-2T
	for qemu-devel@nongnu.org; Fri, 26 May 2017 01:49:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1dE87N-0000aa-Sh
	for qemu-devel@nongnu.org; Fri, 26 May 2017 01:49:01 -0400
Received: from mout.gmx.net ([212.227.17.20]:62711)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1dE87N-0000a1-I1
	for qemu-devel@nongnu.org; Fri, 26 May 2017 01:48:57 -0400
From: Kamil Rytarowski <n54@gmx.com>
Date: Fri, 26 May 2017 07:40:13 +0200
Message-Id: <20170526054013.299-1-n54@gmx.com>
In-Reply-To: <20170513004616.25749-1-n54@gmx.com>
References: <20170513004616.25749-1-n54@gmx.com>
Subject: [Qemu-devel] [PATCH] ivshmem-server: ivshmem-clean: Install only
 when eventfd() is available
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com, peter.maydell@linaro.org, f4bug@amsat.org, Kamil Rytarowski <n54@gmx.com>

Currently ivshmem requires eventfd() which is Linux specific.
Do not and build it unconditionally on every Linux/BSD/Solaris.

This patch indirectly fixes build failure on NetBSD, where these tools
additionally require -lrl for shm_open(3). In future there should be
added support for NetBSD and the linking addressed appropriately.

Signed-off-by: Kamil Rytarowski <n54@gmx.com>
---
 configure | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure b/configure
index 1a5ee4b909..84d8660354 100755
--- a/configure
+++ b/configure
@@ -4928,6 +4928,8 @@ if test "$want_tools" = "yes" ; then
   tools="qemu-img\$(EXESUF) qemu-io\$(EXESUF) $tools"
   if [ "$linux" = "yes" -o "$bsd" = "yes" -o "$solaris" = "yes" ] ; then
     tools="qemu-nbd\$(EXESUF) $tools"
+  fi
+  if [ "$eventfd" != "no" ]; then
     tools="ivshmem-client\$(EXESUF) ivshmem-server\$(EXESUF) $tools"
   fi
 fi
-- 
2.13.0
