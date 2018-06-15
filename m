Received: from eggs.gnu.org ([2001:4830:134:3::10]:43298)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fTezo-0000im-DW
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 23:01:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1fTezn-0002jA-Di
	for qemu-devel@nongnu.org; Thu, 14 Jun 2018 23:01:52 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 15 Jun 2018 11:01:23 +0800
Message-Id: <1529031683-27458-5-git-send-email-jasowang@redhat.com>
In-Reply-To: <1529031683-27458-1-git-send-email-jasowang@redhat.com>
References: <1529031683-27458-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 4/4] vhost-user: delete net client if necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, peter.maydell@linaro.org
Cc: linzhecheng <linzhecheng@huawei.com>, qemu-stable@nongnu.org, Jason Wang <jasowang@redhat.com>

From: linzhecheng <linzhecheng@huawei.com>

As qemu_new_net_client create new ncs but error happens later,
ncs will be left in global net_clients list and we can't use them any
more, so we need to cleanup them.

Cc: qemu-stable@nongnu.org
Signed-off-by: linzhecheng <linzhecheng@huawei.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
---
 net/vhost-user.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/vhost-user.c b/net/vhost-user.c
index 608b837..a39f9c9 100644
--- a/net/vhost-user.c
+++ b/net/vhost-user.c
@@ -345,6 +345,9 @@ err:
             s->vhost_user = NULL;
         }
     }
+    if (nc0) {
+        qemu_del_net_client(nc0);
+    }
 
     return -1;
 }
-- 
2.7.4
