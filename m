Received: from eggs.gnu.org ([2001:4830:134:3::10]:48404)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52g-0000vL-AU
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1dX52f-0008Hl-AA
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46402)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1dX52f-0008Gd-3d
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 08:22:25 -0400
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Jul 2017 20:21:43 +0800
Message-Id: <1500294105-13713-13-git-send-email-jasowang@redhat.com>
In-Reply-To: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
References: <1500294105-13713-1-git-send-email-jasowang@redhat.com>
Subject: [Qemu-devel] [PULL 12/14] docs/colo-proxy.txt: Update colo-proxy
 usage of net driver with vnet_header
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org, qemu-devel@nongnu.org
Cc: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>, Jason Wang <jasowang@redhat.com>

From: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>

Signed-off-by: Zhang Chen <zhangchen.fnst@cn.fujitsu.com>
Signed-off-by: Jason Wang <jasowang@redhat.com>
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
