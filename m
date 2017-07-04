Received: from eggs.gnu.org ([2001:4830:134:3::10]:44012)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dSHhj-0003k1-9i
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:53:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dSHhi-00077Q-9P
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:52:59 -0400
Received: from [59.151.112.132] (port=52152 helo=heian.cn.fujitsu.com)
	by eggs.gnu.org with esmtp (Exim 4.71)
	(envelope-from <zhangchen.fnst@cn.fujitsu.com>) id 1dSHhh-0006rz-Tf
	for qemu-devel@nongnu.org; Tue, 04 Jul 2017 02:52:58 -0400
From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Date: Tue, 4 Jul 2017 14:53:56 +0800
Message-ID: <1499151236-14671-13-git-send-email-zhangchen.fnst@cn.fujitsu.com>
In-Reply-To: <1499151236-14671-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
References: <1499151236-14671-1-git-send-email-zhangchen.fnst@cn.fujitsu.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: [Qemu-devel] [PATCH V7 12/12] docs/colo-proxy.txt: Update
 colo-proxy usage of net driver with vnet_header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu devel <qemu-devel@nongnu.org>, Jason Wang <jasowang@redhat.com>
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Li Zhijian <lizhijian@cn.fujitsu.com>

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
---
 docs/colo-proxy.txt | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/docs/colo-proxy.txt b/docs/colo-proxy.txt
index c4941de..f6a624f 100644
--- a/docs/colo-proxy.txt
+++ b/docs/colo-proxy.txt
@@ -182,6 +182,32 @@ Secondary(ip:3.3.3.8):
 -chardev socket,id=red1,host=3.3.3.3,port=9004
 -object filter-redirector,id=f1,netdev=hn0,queue=tx,indev=red0
 -object filter-redirector,id=f2,netdev=hn0,queue=rx,outdev=red1
+-object filter-rewriter,id=f3,netdev=hn0,queue=all
+
+If you want to use virtio-net-pci or other driver with vnet_header:
+
+Primary(ip:3.3.3.3):
+-netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,downscript=/etc/qemu-ifdown
+-device e1000,id=e0,netdev=hn0,mac=52:a4:00:12:78:66
+-chardev socket,id=mirror0,host=3.3.3.3,port=9003,server,nowait
+-chardev socket,id=compare1,host=3.3.3.3,port=9004,server,nowait
+-chardev socket,id=compare0,host=3.3.3.3,port=9001,server,nowait
+-chardev socket,id=compare0-0,host=3.3.3.3,port=9001
+-chardev socket,id=compare_out,host=3.3.3.3,port=9005,server,nowait
+-chardev socket,id=compare_out0,host=3.3.3.3,port=9005
+-object filter-mirror,id=m0,netdev=hn0,queue=tx,outdev=mirror0,vnet_hdr_support
+-object filter-redirector,netdev=hn0,id=redire0,queue=rx,indev=compare_out,vnet_hdr_support
+-object filter-redirector,netdev=hn0,id=redire1,queue=rx,outdev=compare0,vnet_hdr_support
+-object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,outdev=compare_out0,vnet_hdr_support
+
+Secondary(ip:3.3.3.8):
+-netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,down script=/etc/qemu-ifdown
+-device e1000,netdev=hn0,mac=52:a4:00:12:78:66
+-chardev socket,id=red0,host=3.3.3.3,port=9003
+-chardev socket,id=red1,host=3.3.3.3,port=9004
+-object filter-redirector,id=f1,netdev=hn0,queue=tx,indev=red0,vnet_hdr_support
+-object filter-redirector,id=f2,netdev=hn0,queue=rx,outdev=red1,vnet_hdr_support
+-object filter-rewriter,id=f3,netdev=hn0,queue=all,vnet_hdr_support
 
 Note:
   a.COLO-proxy must work with COLO-frame and Block-replication.
-- 
2.7.4
