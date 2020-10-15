Return-Path: <SRS0=muvY=DW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41261C433E7
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:26:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 956EE20848
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Oct 2020 18:26:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xl7rqD4t"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 956EE20848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40316 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kT7xN-0001ji-Hv
	for qemu-devel@archiver.kernel.org; Thu, 15 Oct 2020 14:26:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1kT7dc-0000Dv-CK
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:06:05 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jag.raman@oracle.com>)
 id 1kT7dW-0002Sa-Du
 for qemu-devel@nongnu.org; Thu, 15 Oct 2020 14:06:01 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
 by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FI4bpc127828;
 Thu, 15 Oct 2020 18:05:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=Z6rMg6JdeOZnTBRFic2JLHTUM6e2QEvOj2NK72zqg9k=;
 b=Xl7rqD4tUWtIqWqTVVDl1cTBeGe+Tj+xp+L9XEMxOv1KOpbaYcPTkam7Q8me4fxbBM70
 azyvVEoh/NnzqrgZgfTsr9H8YDEnYkji1M06s/C50Q7e+HUyG/euJ2oRISUTJB6DSYvh
 x3veW8YSzt/lpSng7kLketNbAhT1cZv8CHq0q7nmE4J2iEYEaNwJtbthXLnBXXMRyeSV
 oXVJni10gW4AgqjatP7xOhi3vjGVaoiPztSee+mE8cJyfrj9bxPluG0DNTmSnq//s7WS
 2eeI38em3VHwJHRvaJDRqIzZ1eYo1Nv5QPHNqlMiMz6IDPFLUYsuqPpO2UYu/U//9gWK uA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2130.oracle.com with ESMTP id 346g8gkce1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 15 Oct 2020 18:05:52 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 09FI5e2V040335;
 Thu, 15 Oct 2020 18:05:51 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3020.oracle.com with ESMTP id 344by5hj33-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 Oct 2020 18:05:51 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 09FI5nSO032583;
 Thu, 15 Oct 2020 18:05:49 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 15 Oct 2020 11:05:49 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v11 19/19] multi-process: add configure and usage information
Date: Thu, 15 Oct 2020 14:05:12 -0400
Message-Id: <c0c67a48b6ebba7ecb2661d4775c105d2753eebd.1602784930.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1602784930.git.jag.raman@oracle.com>
References: <cover.1602784930.git.jag.raman@oracle.com>
In-Reply-To: <cover.1602784930.git.jag.raman@oracle.com>
References: <cover.1602784930.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0
 suspectscore=1 mlxscore=0 malwarescore=0 adultscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2010150121
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9775
 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 suspectscore=1
 priorityscore=1501 phishscore=0 clxscore=1015 spamscore=0 adultscore=0
 mlxscore=0 malwarescore=0 bulkscore=0 mlxlogscore=999 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2010150121
Received-SPF: pass client-ip=141.146.126.79; envelope-from=jag.raman@oracle.com;
 helo=aserp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/15 11:04:16
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001, UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS                |  2 ++
 docs/multi-process.rst     | 67 ++++++++++++++++++++++++++++++++++++++++++++++
 scripts/mpqemu-launcher.py | 49 +++++++++++++++++++++++++++++++++
 3 files changed, 118 insertions(+)
 create mode 100644 docs/multi-process.rst
 create mode 100755 scripts/mpqemu-launcher.py

diff --git a/MAINTAINERS b/MAINTAINERS
index 9a911e0..d12aba7 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3118,6 +3118,8 @@ F: include/hw/pci/memory-sync.h
 F: hw/i386/remote-iohub.c
 F: include/hw/i386/remote-iohub.h
 F: docs/devel/multi-process.rst
+F: scripts/mpqemu-launcher.py
+F: scripts/mpqemu-launcher-perf-mode.py
 
 Build and test automation
 -------------------------
diff --git a/docs/multi-process.rst b/docs/multi-process.rst
new file mode 100644
index 0000000..c4b022c
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
+      -machine x-remote                                                  \
+      -device lsi53c895a,id=lsi0                                         \
+      -drive id=drive_image2,file=/build/ol7-nvme-test-1.qcow2           \
+      -device scsi-hd,id=drive2,drive=drive_image2,bus=lsi0.0,scsi-id=0  \
+      -object x-remote-object,id=robj1,devid=lsi1,fd=4,
+
+* QEMU:
+
+  - Since parts of the RAM are shared between QEMU & remote process, a
+    memory-backend-memfd is required to facilitate this, as follows:
+
+    -object memory-backend-memfd,id=mem,size=2G
+
+  - A "x-pci-proxy-dev" device is created for each of the PCI devices emulated
+    in the remote process. A "socket" sub-option specifies the other end of
+    unix channel created by orchestrator. The "id" sub-option must be specified
+    and should be the same as the "id" specified for the remote PCI device
+
+  - Example commandline for QEMU is as follows:
+
+      -device x-pci-proxy-dev,id=lsi0,socket=3
diff --git a/scripts/mpqemu-launcher.py b/scripts/mpqemu-launcher.py
new file mode 100755
index 0000000..6e0ef22
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
+remote_cmd = [ PROC_QEMU,                                                      \
+               '-machine', 'x-remote',                                         \
+               '-device', 'lsi53c895a,id=lsi1',                                \
+               '-drive', 'id=drive_image1,file=/build/ol7-nvme-test-1.qcow2',  \
+               '-device', 'scsi-hd,id=drive1,drive=drive_image1,bus=lsi1.0,'   \
+                              'scsi-id=0',                                     \
+               '-object',                                                      \
+               'x-remote-object,id=robj1,devid=lsi1,fd='+str(remote.fileno()), \
+               '-nographic',                                                   \
+             ]
+
+proxy_cmd = [ PROC_QEMU,                                                       \
+              '-name', 'OL7.4',                                                \
+              '-machine', 'q35,accel=kvm',                                     \
+              '-smp', 'sockets=1,cores=1,threads=1',                           \
+              '-m', '2048',                                                    \
+              '-object', 'memory-backend-memfd,id=sysmem-file,size=2G',        \
+              '-numa', 'node,memdev=sysmem-file',                              \
+              '-device', 'virtio-scsi-pci,id=virtio_scsi_pci0',                \
+              '-drive', 'id=drive_image1,if=none,format=qcow2,'                \
+                            'file=/home/ol7-hdd-1.qcow2',                      \
+              '-device', 'scsi-hd,id=image1,drive=drive_image1,'               \
+                             'bus=virtio_scsi_pci0.0',                         \
+              '-boot', 'd',                                                    \
+              '-vnc', ':0',                                                    \
+              '-device', 'x-pci-proxy-dev,id=lsi1,fd='+str(proxy.fileno()),    \
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


