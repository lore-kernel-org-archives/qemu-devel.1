Received: from eggs.gnu.org ([2001:4830:134:3::10]:53497)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtFA-000605-8b
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <michael@fritscher.net>) id 1dxtF9-0007oA-Ib
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:08 -0400
Received: from mifritscher.de ([188.40.170.105]:33014
	helo=mail.mifritscher.vserverkompetenz.de)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <michael@fritscher.net>)
	id 1dxtF9-0007nW-Bz
	for qemu-devel@nongnu.org; Fri, 29 Sep 2017 07:14:07 -0400
From: Michael Fritscher <michael@fritscher.net>
Date: Fri, 29 Sep 2017 13:13:19 +0200
Message-Id: <20170929111323.6308-15-michael@fritscher.net>
In-Reply-To: <20170929111323.6308-1-michael@fritscher.net>
References: <20170929111323.6308-1-michael@fritscher.net>
Subject: [Qemu-devel] [PATCH 14/18] Disable rlimit under Windows
List-Unsubscribe: <https://lists.gnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=unsubscribe>
List-Archive: <http://lists.gnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@gnu.org>
List-Help: <mailto:qemu-devel-request@gnu.org?subject=help>
List-Subscribe: <https://lists.gnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@gnu.org?subject=subscribe>
To: gkurz@linux.vnet.ibm.com, sw@weilnetz.de, aneesh.kumar@linux.vnet.ibm.com, mst@redhat.com, qemu-devel@nongnu.org
Cc: Michael Fritscher <michael@fritscher.net>
List-ID: <qemu-devel.nongnu.org>

Signed-off-by: Michael Fritscher <michael@fritscher.net>
---
 hw/9pfs/9p.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 53f812ec06..e0ef1a2a6b 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -3630,6 +3630,7 @@ void v9fs_reset(V9fsState *s)
 
 static void __attribute__((__constructor__)) v9fs_set_fd_limit(void)
 {
+#ifndef _WIN32
     struct rlimit rlim;
     if (getrlimit(RLIMIT_NOFILE, &rlim) < 0) {
         error_report("Failed to get the resource limit");
@@ -3637,4 +3638,5 @@ static void __attribute__((__constructor__)) v9fs_set_fd_limit(void)
     }
     open_fd_hw = rlim.rlim_cur - MIN(400, rlim.rlim_cur/3);
     open_fd_rc = rlim.rlim_cur/2;
+#endif
 }
-- 
2.13.2.windows.1
