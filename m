Return-Path: <SRS0=5yua=6H=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90545C2BA19
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:38:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 41AD72071C
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2020 04:38:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jbL5Hy6a"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 41AD72071C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jRTck-0000fy-G2
	for qemu-devel@archiver.kernel.org; Thu, 23 Apr 2020 00:38:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50752)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTJ1-0004Xz-K5
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:17:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jRTJ0-0003uJ-MJ
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:17:43 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:40978)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jRTJ0-0003rj-4A
 for qemu-devel@nongnu.org; Thu, 23 Apr 2020 00:17:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4DR9B052417;
 Thu, 23 Apr 2020 04:17:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=XruYxXVLHukGDn0Lhs0GUruXJLc6GnWGB4z7SFeAlEg=;
 b=jbL5Hy6aQbvmxsNnRzb6Eb1UxcIAbLM1PTrsfPjMKzI4UYTCH08eJfFXlotPx2ml4a3E
 sMPhWmwKl2iLVoqwVJrKW1f9qi4lbBpdlVzUQUHoapAZ6uhwJy0MkHoA9WBhQ6xMCnSG
 33s5G2Zo/jzOyS+syQREnvqFCbJ6fU9rGm5502NtJXB5fqDf7T7sooyf0pXnvAtwxkEk
 815clzeiPGw0dad9I8sJNpNlGD36g1yy5+thnFNAvZUxlPYJ7rWyWoykm7XsDx3ruZTy
 zcKyRiqKUXMAfE6//IYR0lXdFa3Id5LCZ91lCiVOEAknGZVDs8DH/6HIItJzx3bDP17O ew== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 30jhyc547t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:17:34 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03N4BfYR093736;
 Thu, 23 Apr 2020 04:15:33 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 30gb3ux12v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 23 Apr 2020 04:15:33 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03N4FWW7026790;
 Thu, 23 Apr 2020 04:15:32 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Wed, 22 Apr 2020 21:15:32 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH RESEND v6 36/36] multi-process: add configure and usage
 information
Date: Wed, 22 Apr 2020 21:14:11 -0700
Message-Id: <526ab3d1a840ad0693c6c8d38e56602d2c53024b.1587614626.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1587614626.git.elena.ufimtseva@oracle.com>
References: <cover.1587614626.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0
 spamscore=0 adultscore=0
 mlxlogscore=999 phishscore=0 suspectscore=1 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9599
 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999
 spamscore=0 mlxscore=0
 clxscore=1015 suspectscore=1 phishscore=0 lowpriorityscore=0 bulkscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004230027
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=elena.ufimtseva@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/04/23 00:14:40
X-ACL-Warn: Detected OS   = Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.85
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
 MAINTAINERS                          |  2 +
 docs/multi-process.rst               | 85 +++++++++++++++++++++++++
 scripts/mpqemu-launcher-perf-mode.py | 92 ++++++++++++++++++++++++++++
 scripts/mpqemu-launcher.py           | 53 ++++++++++++++++
 4 files changed, 232 insertions(+)
 create mode 100644 docs/multi-process.rst
 create mode 100755 scripts/mpqemu-launcher-perf-mode.py
 create mode 100755 scripts/mpqemu-launcher.py

diff --git a/MAINTAINERS b/MAINTAINERS
index ed48615e15..8ff3bfae6a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2880,6 +2880,8 @@ F: remote/iohub.c
 F: remote/remote-opts.h
 F: remote/remote-opts.c
 F: docs/devel/multi-process.rst
+F: scripts/mpqemu-launcher.py
+F: scripts/mpqemu-launcher-perf-mode.py
 
 Build and test automation
 -------------------------
diff --git a/docs/multi-process.rst b/docs/multi-process.rst
new file mode 100644
index 0000000000..8387d6c691
--- /dev/null
+++ b/docs/multi-process.rst
@@ -0,0 +1,85 @@
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
+scripts/mpqemu-launcher-perf-mode.py launches in "perf" mode. In this mode,
+the same QEMU process connects to multiple remote devices, each emulated in
+a separate process.
+
+As of now, we only support the emulation of lsi53c895a in a separate process.
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
+  - The first command-line option in the remote process is one of the
+    sockets created by the Orchestrator
+
+  - The remaining options are no different from how one launches QEMU with
+    devices. The only other requirement is each PCI device must have a
+    unique ID specified to it. This is needed to pair remote device with the
+    Proxy object.
+
+  - Example command-line for the remote process is as follows:
+
+      /usr/bin/qemu-scsu-dev 4                                           \
+      -device lsi53c895a,id=lsi0                                         \
+      -drive id=drive_image2,file=/build/ol7-nvme-test-1.qcow2           \
+      -device scsi-hd,id=drive2,drive=drive_image2,bus=lsi0.0,scsi-id=0
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
+
+* Monitor / QMP:
+
+  - The remote process supports QEMU monitor. It could be specified using the
+    "-monitor" or "-qmp" command-line options
+
+  - As an example, one could connect to the monitor by adding the following
+    to the command-line of the remote process
+
+      -monitor unix:/home/qmp-sock,server,nowait
+
+  - The user could connect to the monitor using the qmp script or using
+    "socat" as outlined below:
+
+      socat /home/qmp-sock stdio
diff --git a/scripts/mpqemu-launcher-perf-mode.py b/scripts/mpqemu-launcher-perf-mode.py
new file mode 100755
index 0000000000..2733424c76
--- /dev/null
+++ b/scripts/mpqemu-launcher-perf-mode.py
@@ -0,0 +1,92 @@
+#!/usr/bin/env python3
+
+import socket
+import os
+import subprocess
+import time
+
+PROC_QEMU='/usr/bin/qemu-system-x86_64'
+
+PROC_REMOTE='/usr/bin/qemu-scsi-dev'
+
+proxy_1, remote_1 = socket.socketpair(socket.AF_UNIX, socket.SOCK_STREAM)
+proxy_2, remote_2 = socket.socketpair(socket.AF_UNIX, socket.SOCK_STREAM)
+proxy_3, remote_3 = socket.socketpair(socket.AF_UNIX, socket.SOCK_STREAM)
+
+remote_cmd_1 = [ PROC_REMOTE,                                                  \
+                 str(remote_1.fileno()),                                       \
+                 '-device', 'lsi53c895a,id=lsi1',                              \
+                 '-drive', 'id=drive_image1,'                                  \
+                               'file=/build/ol7-nvme-test-1.qcow2',            \
+                 '-device', 'scsi-hd,id=drive1,drive=drive_image1,'            \
+                                'bus=lsi1.0,scsi-id=0',                        \
+               ]
+
+remote_cmd_2 = [ PROC_REMOTE,                                                  \
+                 str(remote_2.fileno()),                                       \
+                 '-device', 'lsi53c895a,id=lsi2',                              \
+                 '-drive', 'id=drive_image2,'                                  \
+                               'file=/build/ol7-nvme-test-2.qcow2',            \
+                 '-device', 'scsi-hd,id=drive2,drive=drive_image2,'            \
+                                'bus=lsi2.0,scsi-id=0'                         \
+               ]
+
+remote_cmd_3 = [ PROC_REMOTE,                                                  \
+                 str(remote_3.fileno()),                                       \
+                 '-device', 'lsi53c895a,id=lsi3',                              \
+                 '-drive', 'id=drive_image3,'                                  \
+                               'file=/build/ol7-nvme-test-3.qcow2',            \
+                 '-device', 'scsi-hd,id=drive3,drive=drive_image3,'            \
+                                'bus=lsi3.0,scsi-id=0'                         \
+               ]
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
+              '-device', 'pci-proxy-dev,id=lsi1,'                              \
+                             'socket='+str(proxy_1.fileno()),                  \
+              '-device', 'pci-proxy-dev,id=lsi2,'                              \
+                             'socket='+str(proxy_2.fileno()),                  \
+              '-device', 'pci-proxy-dev,id=lsi3,'                              \
+                             'socket='+str(proxy_3.fileno())                   \
+            ]
+
+
+pid = os.fork();
+if pid == 0:
+    # In remote_1
+    print('Launching Remote process 1');
+    process = subprocess.Popen(remote_cmd_1, pass_fds=[remote_1.fileno()])
+    os._exit(0)
+
+
+pid = os.fork();
+if pid == 0:
+    # In remote_2
+    print('Launching Remote process 2');
+    process = subprocess.Popen(remote_cmd_2, pass_fds=[remote_2.fileno()])
+    os._exit(0)
+
+
+pid = os.fork();
+if pid == 0:
+    # In remote_3
+    print('Launching Remote process 3');
+    process = subprocess.Popen(remote_cmd_3, pass_fds=[remote_3.fileno()])
+    os._exit(0)
+
+
+print('Launching Proxy process');
+process = subprocess.Popen(proxy_cmd, pass_fds=[proxy_1.fileno(),              \
+                           proxy_2.fileno(), proxy_3.fileno()])
diff --git a/scripts/mpqemu-launcher.py b/scripts/mpqemu-launcher.py
new file mode 100755
index 0000000000..81e370663e
--- /dev/null
+++ b/scripts/mpqemu-launcher.py
@@ -0,0 +1,53 @@
+#!/usr/bin/env python3
+import socket
+import os
+import subprocess
+import time
+
+PROC_QEMU='/usr/bin/qemu-system-x86_64'
+
+PROC_REMOTE='/usr/bin/qemu-scsi-dev'
+
+proxy, remote = socket.socketpair(socket.AF_UNIX, socket.SOCK_STREAM)
+
+remote_cmd = [ PROC_REMOTE,                                                    \
+               str(remote.fileno()),                                           \
+               '-device', 'lsi53c895a,id=lsi1',                                \
+               '-drive', 'id=drive_image1,file=/build/ol7-nvme-test-1.qcow2',  \
+               '-device', 'scsi-hd,id=drive1,drive=drive_image1,bus=lsi1.0,'   \
+                              'scsi-id=0',                                     \
+               '-device', 'lsi53c895a,id=lsi2',                                \
+               '-drive', 'id=drive_image2,file=/build/ol7-nvme-test-2.qcow2',  \
+               '-device', 'scsi-hd,id=drive2,drive=drive_image2,bus=lsi2.0,'   \
+                              'scsi-id=0'                                      \
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
+              '-device', 'pci-proxy-dev,id=lsi1,socket='+str(proxy.fileno()),  \
+              '-device', 'pci-proxy-dev,id=lsi2,socket='+str(proxy.fileno())   \
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
2.25.GIT


