Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8C7FC38BF9
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:25:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962D8218AC
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:25:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="z+i7Lu4Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962D8218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43828 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6LEJ-0005a6-NF
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:25:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51068)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kn4-0000AA-IM
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kn3-0004BW-45
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:22 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45512)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Kn2-0004Aq-RZ
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:21 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKrXG9032136;
 Mon, 24 Feb 2020 20:57:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=gmyHrbZBFH56LM7a/G7epr+zPv1pFhtt2NM9agSpkqY=;
 b=z+i7Lu4QvzoowhqpGlSQRE6dIH3/kwSm4xpz/JumZPZ6pvJslB87/q7gaIS20zFi8ULO
 y+MTAJHPjka78wLLI+d/r4WVKOVVQyADIY+S7holi1UgrHmAegOQProCTyfyZish5lZT
 ynyB4S4H4XjoXXzC04DfUdV40lxhy+thvRDmstLkgtwVST/0mFcYP31wXwYmg6VpInbL
 gizD4JojC4zk9HVQpxTkOfhaRIBdR9MjhlLtTwoBW7egBlDaVYT05pTGY0KCTadHOEFI
 cXZOZsXyaCKojWc3c6HsoHauRhMr03geQ9E1UgTZrXXikthedm5hW6sBENXaOdouc0AT Bw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 2yauqua0sc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:57:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKq65G108991;
 Mon, 24 Feb 2020 20:57:15 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 2ybe123v5j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:57:15 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01OKvEYT009858;
 Mon, 24 Feb 2020 20:57:14 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:57:13 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 50/50] multi-process: add configure and usage information
Date: Mon, 24 Feb 2020 15:55:41 -0500
Message-Id: <bbba8cdef9f876ec6d194f3e1974347860eca732.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 suspectscore=1 malwarescore=0 phishscore=0 bulkscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 bulkscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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
Cc: elena.ufimtseva@oracle.com, fam@euphon.net, swapnil.ingle@nutanix.com,
 john.g.johnson@oracle.com, kraxel@redhat.com, jag.raman@oracle.com,
 quintela@redhat.com, mst@redhat.com, armbru@redhat.com,
 kanth.ghatraju@oracle.com, felipe@nutanix.com, thuth@redhat.com,
 ehabkost@redhat.com, konrad.wilk@oracle.com, dgilbert@redhat.com,
 liran.alon@oracle.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
 rth@twiddle.net, kwolf@redhat.com, berrange@redhat.com, mreitz@redhat.com,
 ross.lagerwall@citrix.com, marcandre.lureau@gmail.com, pbonzini@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
---
 docs/qemu-multiprocess.txt | 86 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 86 insertions(+)
 create mode 100644 docs/qemu-multiprocess.txt

diff --git a/docs/qemu-multiprocess.txt b/docs/qemu-multiprocess.txt
new file mode 100644
index 0000000..f156177
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
+  For example, for non multi-process qemu:
+    -device lsi53c895a,id=scsi0 device
+    -device scsi-hd,drive=drive0,bus=scsi0.0,scsi-id=0
+    -drive id=drive0,file=data-disk.img
+
+  and for multi-process qemu and no libvirt
+  support (i.e. QEMU forks child processes):
+    -device lsi53c895a,id=scsi0,rid=0
+    -device scsi-hd,drive=drive0,bus=scsi0.0,scsi-id=0,rid=0
+
+* The command-line options for the remote process are added to the "command"
+  suboption of the newly added "-remote" option. 
+
+   -remote [socket],rid=0,exec="...",command="..."
+
+  The drives to be emulated by the remote process are specified as part of
+  this command sub-option. The device to be used to connect to the monitor
+  is also specified as part of this suboption.
+
+  For example, the following option adds a drive and monitor to the remote
+  process:
+  -remote rid=0,exec="qemu-scsi-dev",command="-drive id=drive0,,file=data-disk.img -monitor unix:/home/qmp-sock,,server,,nowait"
+
+  Note: There's an issue with this "command" sub-option which we are in the
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
+  -remote rid=8,exec="qemu-scsi-dev",command="-drive id=drive_image2,,file=/root/remote-process-disk.img -monitor unix:/home/qmp-sock,,server,,nowait"
+
+  We could connect to the monitor using the following command:
+  socat /home/qmp-sock stdio
+
+  After hotplugging disks to the remote process, please execute the
+  following command in the guest to refresh the list of storage devices:
+  rescan_scsi_bus.sh -a
-- 
1.8.3.1


