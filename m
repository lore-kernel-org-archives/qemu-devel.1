Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1006C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:23:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89B2F204EC
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:23:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="bGhH486Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89B2F204EC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5GGo-0005Iw-T1
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:23:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54285)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5FcY-0001kB-77
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:41:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FcW-0003Nz-Sc
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:41:46 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:59980)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FcW-0003NT-KI
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:41:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83Kfc7Z059938;
 Tue, 3 Sep 2019 20:41:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=EYAzeaVP/SXNXnkqG9utwSGLQ8673c7bclN594zH3ig=;
 b=bGhH486QfjL0WU25EWhsW1+Fd0qmAggVRuQFoxIdAkreCapGVcqaeostiR5gM3CexBBj
 81Nzwh/YeSl4YsoOS/7rv5EZv/coYeo27TmXTeo806OOWH1XzUXLIychpsqpjnRgQ8+x
 38ES8BSpinewXc776GixMnS0oArLPPUqT0BaWS0RiAYb2H3iHlmRDex4Q/P1mIofrCUj
 StSVwpNuN+GMSa0dKCT5+apyAZBDzNGNfWfpN2/5pXhpNftXfDwJRo4REmjT2y//wyqj
 GmlEffH9WUXhk+YjLfG3KMQ++kB/g+j4mrv2w8cw9WHXO4kzZ1poHv9D1OBsK37lZdVg Tw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by aserp2120.oracle.com with ESMTP id 2usy6n02bh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:41:38 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83Kc9wp025372;
 Tue, 3 Sep 2019 20:39:38 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by aserp3020.oracle.com with ESMTP id 2us5pha116-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:37 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x83Kda4I029155;
 Tue, 3 Sep 2019 20:39:36 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:39:35 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:38:11 -0400
Message-Id: <0cef793b85d14a3ca56925488126eb3de6979b57.1567534653.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030207
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [RFC v3 PATCH 45/45] multi-process: add configure and
 usage information
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, john.g.johnson@oracle.com,
 kraxel@redhat.com, jag.raman@oracle.com, quintela@redhat.com, mst@redhat.com,
 armbru@redhat.com, kanth.ghatraju@oracle.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, rth@twiddle.net, kwolf@redhat.com,
 berrange@redhat.com, mreitz@redhat.com, ross.lagerwall@citrix.com,
 marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
Changes in v3:
 - since the changes were made to use existing device/drive options,
the document was modified to reflect this.
---
 docs/qemu-multiprocess.txt | 86 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 docs/qemu-multiprocess.txt

diff --git a/docs/qemu-multiprocess.txt b/docs/qemu-multiprocess.txt
new file mode 100644
index 0000000..c29f4df
--- /dev/null
+++ b/docs/qemu-multiprocess.txt
@@ -0,0 +1,86 @@
+Multi-process QEMU
+==================
+
+This document describes how to configure and use multi-process qemu.
+For the design document refer to docs/devel/qemu-multiprocess.
+
+1) Configuration
+----------------
+
+To enable support for multi-process add --enable-mpqemu
+to the list of options for the "configure" script.
+
+
+2) Usage
+--------
+
+To start qemu with devices intended to run in a separate emulation
+process without libvirtd support, the following should be used on QEMU
+command line. As of now, we only support the emulation of lsi53c895a
+in a separate process
+
+* Since parts of the RAM are shared between QEMU & remote process, a
+  memory-backend-file is required to facilitate this, as follows:
+
+  -object memory-backend-file,id=mem,mem-path=/dev/shm/,size=4096M,share=on
+
+* The devices to be emulated in the separate process are defined as
+  before with addition of "rid" suboption that serves as a remote group
+  identificator.
+
+  -device <device options>,rid="remote process id"
+
+  For exmaple, for non multi-process qemu:
+    -device lsi53c895a,id=scsi0 device
+    -device scsi-hd,drive=drive0,bus=scsi0.0,scsi-id=0
+    -drive id=drive0,file=data-disk.img
+
+  and for multi-process qemu and no libvirt
+  support (i.e. QEMU forks child processes):
+    -device lsi53c895a,id=scsi0,rid=0
+    -device scsi-hd,drive=drive0,bus=scsi0.0,scsi-id=0,rid="0"
+
+* The command-line options for the remote process is added to the "command"
+  suboption of the newly added "-remote" option. 
+
+   -remote [socket],rid=,command="..."
+
+  The drives to be emulated by the remote process are specified as part of
+  this command sub-option. The device to be used to connect to the monitor
+  is also specified as part of this suboption.
+
+  For example, the following option adds a drive and monitor to the remote
+  process:
+  -remote rid=0,command="-drive id=drive0,,file=data-disk.img -monitor unix:/home/qmp-sock,,server,,nowait"
+
+  Note: There's an issue with this "command" subtion which we are in the
+  process of fixing. To work around this issue, it requires additional
+  "comma" characters as illustrated above, and in the example below.
+
+* Example QEMU command-line to launch lsi53c895a in a remote process
+
+  #/bin/sh
+  qemu-system-x86_64 \
+  -name "OL7.4" \
+  -machine q35,accel=kvm \
+  -smp sockets=1,cores=1,threads=1 \
+  -cpu host \
+  -m 2048 \
+  -object memory-backend-file,id=mem,mem-path=/dev/shm/,size=2G,share=on \
+  -numa node,memdev=mem \
+  -device virtio-scsi-pci,id=virtio_scsi_pci0 \
+  -drive id=drive_image1,if=none,format=raw,file=/root/ol7.qcow2 \
+  -device scsi-hd,id=image1,drive=drive_image1,bus=virtio_scsi_pci0.0 \
+  -boot d \
+  -monitor stdio \
+  -vnc :0 \
+  -device lsi53c895a,id=lsi0,remote,rid=8,command="qemu-scsi-dev" \
+  -device scsi-hd,id=drive2,drive=drive_image2,bus=lsi0.0,scsi-id=0,remote,rid=8,command="qemu-scsi-dev"\
+  -remote rid=8,command="-drive id=drive_image2,,file=/root/remote-process-disk.img -monitor unix:/home/qmp-sock,,server,,nowait"
+
+  We could connect to the monitor using the following command:
+  socat /home/qmp-sock stdio
+
+  After hotplugging disks to the remote process, please execute the
+  following command in the guest to refresh the list of storage devices:
+  rescan_scsi_bus.sh -a
-- 
1.8.3.1


