Received: from eggs.gnu.org ([2001:4830:134:3::10]:50102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvnwI-0007Gi-RL
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:14:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Liam.Merwick@oracle.com>) id 1fvnwH-0005vs-5T
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:14:34 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:55990)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Liam.Merwick@oracle.com>)
	id 1fvnwG-0005vV-Ur
	for qemu-devel@nongnu.org; Fri, 31 Aug 2018 14:14:33 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
	by aserp2120.oracle.com (8.16.0.22/8.16.0.22) with SMTP id
	w7VIDudm094223
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 18:14:32 GMT
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
	by aserp2120.oracle.com with ESMTP id 2m2y2q4vjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 18:14:32 +0000
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
	by userv0021.oracle.com (8.14.4/8.14.4) with ESMTP id w7VIEVPk025987
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256
	verify=OK) for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 18:14:31 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
	by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id w7VIEVgH029612
	for <qemu-devel@nongnu.org>; Fri, 31 Aug 2018 18:14:31 GMT
From: Liam Merwick <Liam.Merwick@oracle.com>
Date: Fri, 31 Aug 2018 19:16:11 +0100
Message-Id: <1535739372-24454-8-git-send-email-Liam.Merwick@oracle.com>
In-Reply-To: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
References: <1535739372-24454-1-git-send-email-Liam.Merwick@oracle.com>
Subject: [Qemu-devel] [PATCH v3 7/8] io: potential unnecessary check in
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

In qio_channel_command_new_spawn() the 'flags' variable is checked
to see if /dev/null should be used for stdin or stdout; first with
O_RDONLY and then O_WRONLY.  However the second check for O_WRONLY
is only needed if flags != O_RDONLY and therefore should be an
else if statement.

This minor optimization has the added benefit of suppressing a warning
from a static analysis tool (Parfait) which incorrectly reported an
incorrect checking of flags in qio_channel_command_new_spawn() could
result in an uninitialized file descriptor being used. Removing this
noise will help us better find real issues.

Signed-off-by: Liam Merwick <Liam.Merwick@oracle.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
---
 io/channel-command.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/io/channel-command.c b/io/channel-command.c
index 3e7eb17eff54..82acd3234915 100644
--- a/io/channel-command.c
+++ b/io/channel-command.c
@@ -61,8 +61,7 @@ qio_channel_command_new_spawn(const char *const argv[],
 
     if (flags == O_RDONLY) {
         stdinnull = true;
-    }
-    if (flags == O_WRONLY) {
+    } else if (flags == O_WRONLY) {
         stdoutnull = true;
     }
 
-- 
1.8.3.1
