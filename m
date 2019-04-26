Received: from eggs.gnu.org ([209.51.188.92]:52369)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hJwtM-0005E2-Sv
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:11:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <chen.zhang@intel.com>) id 1hJwtL-0003Pn-V0
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:11:36 -0400
Received: from mga04.intel.com ([192.55.52.120]:13455)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <chen.zhang@intel.com>)
	id 1hJwtL-0003Ob-Me
	for qemu-devel@nongnu.org; Fri, 26 Apr 2019 05:11:35 -0400
From: Zhang Chen <chen.zhang@intel.com >
Date: Fri, 26 Apr 2019 17:07:30 +0800
Message-Id: <20190426090730.2691-4-chen.zhang@intel.com>
In-Reply-To: <20190426090730.2691-1-chen.zhang@intel.com>
References: <20190426090730.2691-1-chen.zhang@intel.com>
Subject: [Qemu-devel] [PATCH 3/3] qemu-option.hx: Update missed parameter
 for colo-compare
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <laurent@vivier.eu>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Juan Quintela <quintela@redhat.com>, zhanghailiang <zhang.zhanghailiang@huawei.com>, Markus Armbruster <armbru@redhat.com>, qemu-dev <qemu-devel@nongnu.org>
Cc: Zhang Chen <zhangckid@gmail.com>, Zhang Chen <chen.zhang@intel.com>

From: Zhang Chen <chen.zhang@intel.com>

We missed the iothread related args in this file.
This patch is used to fix this issue.

Signed-off-by: Zhang Chen <chen.zhang@intel.com>
---
 qemu-options.hx | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/qemu-options.hx b/qemu-options.hx
index 08749a3391..a4500c99ef 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -4420,13 +4420,15 @@ Dump the network traffic on netdev @var{dev} to the file specified by
 The file format is libpcap, so it can be analyzed with tools such as tcpdump
 or Wireshark.
 
-@item -object colo-compare,id=@var{id},primary_in=@var{chardevid},secondary_in=@var{chardevid},outdev=@var{chardevid}[,vnet_hdr_support]
+@item -object colo-compare,id=@var{id},primary_in=@var{chardevid},secondary_in=@var{chardevid},outdev=@var{chardevid},iothread=@var{id}[,vnet_hdr_support]
 
 Colo-compare gets packet from primary_in@var{chardevid} and secondary_in@var{chardevid}, than compare primary packet with
 secondary packet. If the packets are same, we will output primary
 packet to outdev@var{chardevid}, else we will notify colo-frame
 do checkpoint and send primary packet to outdev@var{chardevid}.
-if it has the vnet_hdr_support flag, colo compare will send/recv packet with vnet_hdr_len.
+In order to improve efficiency, we need to put the task of comparison
+in another thread. If it has the vnet_hdr_support flag, colo compare
+will send/recv packet with vnet_hdr_len.
 
 we must use it with the help of filter-mirror and filter-redirector.
 
@@ -4441,10 +4443,11 @@ primary:
 -chardev socket,id=compare0-0,host=3.3.3.3,port=9001
 -chardev socket,id=compare_out,host=3.3.3.3,port=9005,server,nowait
 -chardev socket,id=compare_out0,host=3.3.3.3,port=9005
+-object iothread,id=iothread1
 -object filter-mirror,id=m0,netdev=hn0,queue=tx,outdev=mirror0
 -object filter-redirector,netdev=hn0,id=redire0,queue=rx,indev=compare_out
 -object filter-redirector,netdev=hn0,id=redire1,queue=rx,outdev=compare0
--object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,outdev=compare_out0
+-object colo-compare,id=comp0,primary_in=compare0-0,secondary_in=compare1,outdev=compare_out0,iothread=iothread1
 
 secondary:
 -netdev tap,id=hn0,vhost=off,script=/etc/qemu-ifup,down script=/etc/qemu-ifdown
-- 
2.17.GIT
