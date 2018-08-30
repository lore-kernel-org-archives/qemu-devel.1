Received: from eggs.gnu.org ([2001:4830:134:3::10]:54700)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvPCN-0006mW-40
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:49:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvP8a-0005Zb-5O
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:45:39 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:44696)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Liam.Merwick@oracle.com>)
	id 1fvP8Z-0005Wl-T1
	for qemu-devel@nongnu.org; Thu, 30 Aug 2018 11:45:36 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	w7UFdGcV030752
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 15:45:35 GMT
Received: from aserv0021.oracle.com (aserv0021.oracle.com [141.146.126.233])
	by aserp2120.oracle.com with ESMTP id 2m2y2pwhj4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 15:45:35 +0000
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
	by aserv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7UFjY3s014142
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 15:45:34 GMT
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
	by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id w7UFjYmU007767
	for <qemu-devel@nongnu.org>; Thu, 30 Aug 2018 15:45:34 GMT
From: Liam Merwick <Liam.Merwick@oracle.com>
Date: Thu, 30 Aug 2018 16:47:10 +0100
Message-Id: <1535644031-848-8-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1535644031-848-1-git-send-email-Liam.Merwick@oracle.com>
References: <1535644031-848-1-git-send-email-Liam.Merwick@oracle.com>
Subject: [Qemu-devel] [PATCH 7/8] io: file descriptor not initialized in
 qio_channel_command_new_spawn()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

Incorrect checking of flags could result in uninitialized
file descriptor being used.

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
Reviewed-by: Darren Kenny <Darren.Kenny@oracle.com>
Reviewed-by: Mark Kanda <Mark.Kanda@oracle.com>
---
 io/channel-command.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io/channel-command.c b/io/channel-command.c
index 3e7eb17eff54..38deb687da21 100644
--- a/io/channel-command.c
+++ b/io/channel-command.c
@@ -59,10 +59,10 @@ qio_channel_command_new_spawn(const char *const argv[],
 
     flags = flags & O_ACCMODE;
 
-    if (flags == O_RDONLY) {
+    if ((flags & O_RDONLY) == O_RDONLY) {
         stdinnull = true;
     }
-    if (flags == O_WRONLY) {
+    if ((flags & O_WRONLY) == O_WRONLY) {
         stdoutnull = true;
     }
 
-- 
1.8.3.1
