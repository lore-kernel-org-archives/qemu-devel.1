Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73318C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:29:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 447D822B42
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 18:29:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="niq9l6xU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 447D822B42
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41062 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Zmw-0005Gp-Hu
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 14:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58240)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1Zef-0002S2-61
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:21:17 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:55140)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1k1Zec-0005Rq-PA
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 14:21:16 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VIBwu3069937;
 Fri, 31 Jul 2020 18:21:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=z+B+7nLzsZ06MKfna63YXrq7L1SIE6BY4AOI+9Toi4I=;
 b=niq9l6xUi5/EEfdXzssoZ4DeT/ZVFtwnDxBnHXIUzY9qQPwYvrjINAHsGv3OY1wZVoaS
 tUjipY68xqOuWZOoJJCOsrrDwepV4Fss0BfPqgXdCO+bkBwDgW06OEcYR6+nEI+vxayJ
 UVqospUO7YtJ9oxs5CtX6ADqrhXXKgrQ9Ot5ts8YBvml8ojnJB5LlyFxaW4DQb4iHTu9
 ZzyfnRS4yYg/xFfPKR34gmzA7kLNMyZLx0l/+jJPqN41zWTbxpNKvVzjlE4l1NYu6wTT
 0Ot7usznukllUPckgsYsBF7qg6o9a7I5cg+H69C9ewZnKor4BgUvzSa+s7PMmhcmVFwk qQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 32mf702u9c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Fri, 31 Jul 2020 18:21:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06VIIccS137659;
 Fri, 31 Jul 2020 18:21:07 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3020.oracle.com with ESMTP id 32hu64r7rm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 31 Jul 2020 18:21:06 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06VIL67Y013536;
 Fri, 31 Jul 2020 18:21:06 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Fri, 31 Jul 2020 11:21:05 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v8 20/20] multi-process: add configure and usage information
Date: Fri, 31 Jul 2020 14:20:27 -0400
Message-Id: <4d3d55b69bfb5a7a10c9b4bc5b1b2dcbf160084b.1596217462.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1596217462.git.jag.raman@oracle.com>
References: <cover.1596217462.git.jag.raman@oracle.com>
In-Reply-To: <cover.1596217462.git.jag.raman@oracle.com>
References: <cover.1596217462.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 adultscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 spamscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310137
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9699
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 bulkscore=0 suspectscore=1
 spamscore=0 impostorscore=0 clxscore=1015 phishscore=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 malwarescore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007310136
Received-SPF: pass client-ip=156.151.31.85; envelope-from=jag.raman@oracle.com;
 helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/31 14:20:51
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
 alex.williamson@redhat.com, stefanha@redhat.com, thanos.makatos@nutanix.com,
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
 MAINTAINERS                |  2 ++
 docs/multi-process.rst     | 67 ++++++++++++++++++++++++++++++++++++++++++++++
 scripts/mpqemu-launcher.py | 49 +++++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+)
 create mode 100644 docs/multi-process.rst
 create mode 100755 scripts/mpqemu-launcher.py

diff --git a/MAINTAINERS b/MAINTAINERS
index f41b54c..3df9441 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3058,6 +3058,8 @@ F: include/hw/pci/memory-sync.h
 F: hw/remote/iohub.c
 F: include/hw/remote/iohub.h
 F: docs/devel/multi-process.rst
+F: scripts/mpqemu-launcher.py
+F: scripts/mpqemu-launcher-perf-mode.py
 
 Build and test automation
 -------------------------
diff --git a/docs/multi-process.rst b/docs/multi-process.rst
new file mode 100644
index 0000000..9dc55e3
--- /dev/null
+++ b/docs/multi-process.rst
@@ -0,0 +1,67 @@
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
+Multi-process QEMU requires an orchestrator to launch. Please refer to a
+light-weight python based orchestrator for mpqemu in
+scripts/mpqemu-launcher.py to lauch QEMU in multi-process mode.
+
+Following is a description of command-line used to launch mpqemu.
+
+* Orchestrator:
+
+  - The Orchestrator creates a unix socketpair
+
+  - It launches the remote process and passes one of the
+    sockets to it via command-line.
+
+  - It then launches QEMU and specifies the other socket as an option
+    to the Proxy device object
+
+* Remote Process:
+
+  - QEMU can enter remote process mode by using the "remote" machine
+    option.
+
+  - The orchestrator creates a "remote-object" with details about
+    the device and the file descriptor for the device
+
+  - The remaining options are no different from how one launches QEMU with
+    devices.
+
+  - Example command-line for the remote process is as follows:
+
+      /usr/bin/qemu-system-x86_64                                        \
+      -machine remote                                                    \
+      -device lsi53c895a,id=lsi0                                         \
+      -drive id=drive_image2,file=/build/ol7-nvme-test-1.qcow2           \
+      -device scsi-hd,id=drive2,drive=drive_image2,bus=lsi0.0,scsi-id=0  \
+      -object remote-object,id=robj1,devid=lsi1,fd=4,
+
+* QEMU:
+
+  - Since parts of the RAM are shared between QEMU & remote process, a
+    memory-backend-memfd is required to facilitate this, as follows:
+
+    -object memory-backend-memfd,id=mem,size=2G
+
+  - A "pci-proxy-dev" device is created for each of the PCI devices emulated
+    in the remote process. A "socket" sub-option specifies the other end of
+    unix channel created by orchestrator. The "id" sub-option must be specified
+    and should be the same as the "id" specified for the remote PCI device
+
+  - Example commandline for QEMU is as follows:
+
+      -device pci-proxy-dev,id=lsi0,socket=3
diff --git a/scripts/mpqemu-launcher.py b/scripts/mpqemu-launcher.py
new file mode 100755
index 0000000..07b11c6
--- /dev/null
+++ b/scripts/mpqemu-launcher.py
@@ -0,0 +1,49 @@
+#!/usr/bin/env python3
+import socket
+import os
+import subprocess
+import time
+
+PROC_QEMU='/usr/bin/qemu-system-x86_64'
+
+proxy, remote = socket.socketpair(socket.AF_UNIX, socket.SOCK_STREAM)
+
+remote_cmd = [ PROC_QEMU,                                                     \
+               '-machine', 'remote',                                          \
+               '-device', 'lsi53c895a,id=lsi1',                               \
+               '-drive', 'id=drive_image1,file=/build/ol7-nvme-test-1.qcow2', \
+               '-device', 'scsi-hd,id=drive1,drive=drive_image1,bus=lsi1.0,'  \
+                              'scsi-id=0',                                    \
+               '-object',                                                     \
+               'remote-object,id=robj1,devid=lsi1,fd='+str(remote.fileno()),  \
+               '-nographic',                                                  \
+             ]
+
+proxy_cmd = [ PROC_QEMU,                                                      \
+              '-name', 'OL7.4',                                               \
+              '-machine', 'q35,accel=kvm',                                    \
+              '-smp', 'sockets=1,cores=1,threads=1',                          \
+              '-m', '2048',                                                   \
+              '-object', 'memory-backend-memfd,id=sysmem-file,size=2G',       \
+              '-numa', 'node,memdev=sysmem-file',                             \
+              '-device', 'virtio-scsi-pci,id=virtio_scsi_pci0',               \
+              '-drive', 'id=drive_image1,if=none,format=qcow2,'               \
+                            'file=/home/ol7-hdd-1.qcow2',                     \
+              '-device', 'scsi-hd,id=image1,drive=drive_image1,'              \
+                             'bus=virtio_scsi_pci0.0',                        \
+              '-boot', 'd',                                                   \
+              '-vnc', ':0',                                                   \
+              '-device', 'pci-proxy-dev,id=lsi1,fd='+str(proxy.fileno()),     \
+            ]
+
+
+pid = os.fork();
+
+if pid:
+    # In Proxy
+    print('Launching QEMU with Proxy object');
+    process = subprocess.Popen(proxy_cmd, pass_fds=[proxy.fileno()])
+else:
+    # In remote
+    print('Launching Remote process');
+    process = subprocess.Popen(remote_cmd, pass_fds=[remote.fileno()])
-- 
1.8.3.1


