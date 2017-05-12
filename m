Received: from eggs.gnu.org ([2001:4830:134:3::10]:55984)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zdC-0000HG-5j
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zdA-0003ew-8T
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:34 -0400
Received: from [59.151.112.132] (port=14198 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1d8zd9-0003YR-SM
	for qemu-devel@nongnu.org; Thu, 11 May 2017 21:44:32 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Fri, 12 May 2017 09:41:17 +0800
Message-ID: <1494553288-30764-2-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1494553288-30764-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V4 01/12] net: Add vnet_hdr_len related
 arguments in NetClientState
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, weifuqiang <weifuqiang@huawei.com>, "eddie
	. dong" <eddie.dong@intel.com>, bian naimeng <biannm@cn.fujitsu.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

Add vnet_hdr_len and using_vnet_hdr arguments in NetClientState
that make othermodule get real vnet_hdr_len easily.

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 include/net/net.h | 2 ++
 net/net.c         | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/net/net.h b/include/net/net.h
index 99b28d5..70edfc0 100644
--- a/include/net/net.h
+++ b/include/net/net.h
@@ -100,6 +100,8 @@ struct NetClientState {
     unsigned int queue_index;
     unsigned rxfilter_notify_enabled:1;
     int vring_enable;
+    bool using_vnet_hdr;
+    int vnet_hdr_len;
     QTAILQ_HEAD(NetFilterHead, NetFilterState) filters;
 };
 
diff --git a/net/net.c b/net/net.c
index 0ac3b9e..a00a0c9 100644
--- a/net/net.c
+++ b/net/net.c
@@ -472,6 +472,7 @@ void qemu_using_vnet_hdr(NetClientState *nc, bool enable)
         return;
     }
 
+    nc->using_vnet_hdr = enable;
     nc->info->using_vnet_hdr(nc, enable);
 }
 
@@ -491,6 +492,7 @@ void qemu_set_vnet_hdr_len(NetClientState *nc, int len)
         return;
     }
 
+    nc->vnet_hdr_len = len;
     nc->info->set_vnet_hdr_len(nc, len);
 }
 
-- 
2.7.4
