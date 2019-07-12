Return-Path: <SRS0=r3/N=VJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7474FC742A8
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 06:53:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 476D62084B
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2019 06:53:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 476D62084B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=huawei.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47052 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlpQo-0007Nh-DU
	for qemu-devel@archiver.kernel.org; Fri, 12 Jul 2019 02:53:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56098)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <king.wang@huawei.com>) id 1hlpQe-0006yd-VC
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 02:53:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <king.wang@huawei.com>) id 1hlpQd-0001jd-Ip
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 02:53:12 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:53354 helo=huawei.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <king.wang@huawei.com>)
 id 1hlpQd-0001bN-4g
 for qemu-devel@nongnu.org; Fri, 12 Jul 2019 02:53:11 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
 by Forcepoint Email with ESMTP id 5F8741FB7011A7BED614;
 Fri, 12 Jul 2019 14:52:58 +0800 (CST)
Received: from localhost (10.177.17.7) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Fri, 12 Jul 2019
 14:52:48 +0800
From: Wang King <king.wang@huawei.com>
To: <pbonzini@redhat.com>
Date: Fri, 12 Jul 2019 14:52:41 +0800
Message-ID: <20190712065241.11784-1-king.wang@huawei.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.177.17.7]
X-CFilter-Loop: Reflected
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 45.249.212.35
Subject: [Qemu-devel] [PATCH] memory: unref the memory region in simplify
 flatview
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: weidong.huang@huawei.com, qemu-devel@nongnu.org, king.wang@huawei.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: King Wang<king.wang@huawei.com>

The memory region reference is increased when insert a range
into flatview range array, then decreased by destroy flatview.
If some flat range merged by flatview_simplify, the memory region
reference can not be decreased by destroy flatview any more.

In this case, start virtual machine by the command line:
qemu-system-x86_64
-name guest=3Dubuntu,debug-threads=3Don
-machine pc,accel=3Dkvm,usb=3Doff,dump-guest-core=3Doff
-cpu host
-m 16384
-realtime mlock=3Doff
-smp 8,sockets=3D2,cores=3D4,threads=3D1
-object memory-backend-file,id=3Dram-node0,prealloc=3Dyes,mem-path=3D/dev=
/hugepages,share=3Dyes,size=3D8589934592
-numa node,nodeid=3D0,cpus=3D0-3,memdev=3Dram-node0
-object memory-backend-file,id=3Dram-node1,prealloc=3Dyes,mem-path=3D/dev=
/hugepages,share=3Dyes,size=3D8589934592
-numa node,nodeid=3D1,cpus=3D4-7,memdev=3Dram-node1
-no-user-config
-nodefaults
-rtc base=3Dutc
-no-shutdown
-boot strict=3Don
-device piix3-usb-uhci,id=3Dusb,bus=3Dpci.0,addr=3D0x1.0x2
-device virtio-scsi-pci,id=3Dscsi0,bus=3Dpci.0,addr=3D0x2
-device virtio-serial-pci,id=3Dvirtio-serial0,bus=3Dpci.0,addr=3D0x3
-drive file=3Dubuntu.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-dis=
k0,cache=3Dnone,aio=3Dnative
-device virtio-blk-pci,scsi=3Doff,bus=3Dpci.0,addr=3D0x4,drive=3Ddrive-vi=
rtio-disk0,id=3Dvirtio-disk0,bootindex=3D1
-chardev pty,id=3Dcharserial0
-device isa-serial,chardev=3Dcharserial0,id=3Dserial0
-device usb-tablet,id=3Dinput0,bus=3Dusb.0,port=3D1
-vnc 0.0.0.0:0
-device VGA,id=3Dvideo0,vgamem_mb=3D16,bus=3Dpci.0,addr=3D0x5
-device virtio-balloon-pci,id=3Dballoon0,bus=3Dpci.0,addr=3D0x6
-msg timestamp=3Don

And run the script in guest OS:
while true
do
    setpci -s 00:06.0 04.b=3D03
	setpci -s 00:06.0 04.b=3D07
done

I found the reference of node0 HostMemoryBackendFile is a big one.
(gdb) p numa_info[0]->node_memdev->parent.ref
$6 =3D 1636278
(gdb)

Signed-off-by: King Wang<king.wang@huawei.com>
---
 memory.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/memory.c b/memory.c
index 480f3d989b..d8d42bdff8 100644
--- a/memory.c
+++ b/memory.c
@@ -321,7 +321,7 @@ static bool can_merge(FlatRange *r1, FlatRange *r2)
 /* Attempt to simplify a view by merging adjacent ranges */
 static void flatview_simplify(FlatView *view)
 {
-    unsigned i, j;
+    unsigned i, j, k;
=20
     i =3D 0;
     while (i < view->nr) {
@@ -332,6 +332,9 @@ static void flatview_simplify(FlatView *view)
             ++j;
         }
         ++i;
+        for (k =3D i; k < j; k++) {
+            memory_region_unref(view->ranges[k].mr);
+        }
         memmove(&view->ranges[i], &view->ranges[j],
                 (view->nr - j) * sizeof(view->ranges[j]));
         view->nr -=3D j - i;
--=20
2.21.0



