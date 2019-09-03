Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571DEC3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:50:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1E7BE230F2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 20:50:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Rji2O74k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1E7BE230F2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51236 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5Fkp-0008LD-8a
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 16:50:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53251)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZo-0007Iy-38
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FZm-0000I3-PU
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:55 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56830)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FZm-0000HI-Ix
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:38:54 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KXpvk053643;
 Tue, 3 Sep 2019 20:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=7zDGOIXoDOxm5PMB7Fr+f1SykrhndE2bHYknbic9f8o=;
 b=Rji2O74kPUr1gv2wAdaFaV9Uo7pEl6cIit35ruyk8sOT32yg6hc8xbX09a52XEmTRrKs
 FvcThNs68szBU2RLD8hIqg/I+YypO45oJJ+ZOkbJTJLaOlqCxxmnofq54g9dXXcqb2IR
 jU5tthB4KTHNCtQcH9YCTCtvmWMLSH7zkzd9DEs+Z2R1pZA8t8btAmAzyi/sh7ixZ5nm
 i44JG/fEYcJnlTjzVQydIO2SHD+ffD34Z2lHFIdFj6YSGQgcb4OZBA/lN6ACQzHOfqtZ
 NCjWEdepCv1Pyo60UpNSY7QEXMzK7OSztV0ae1Go412xI//bWBSqz5hNUHLXHHkclLGq IA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by aserp2120.oracle.com with ESMTP id 2usy6n01ys-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcZ6j178259;
 Tue, 3 Sep 2019 20:38:47 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by userp3020.oracle.com with ESMTP id 2us4wegqab-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:38:46 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83Kcjxe012307;
 Tue, 3 Sep 2019 20:38:45 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:38:44 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:37:40 -0400
Message-Id: <b299af7f81ff976a7f9facd8758231b17691e7ec.1567534653.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
In-Reply-To: <cover.1567534653.git.jag.raman@oracle.com>
References: <cover.1567534653.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=3
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909030207
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9369
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=3 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909030206
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic]
X-Received-From: 141.146.126.78
Subject: [Qemu-devel] [RFC v3 PATCH 14/45] mutli-process: build remote
 command line args
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
 New patch in v3

 hw/proxy/qemu-proxy.c         | 80 +++++++++++++++++++++++++++++++++----------
 include/hw/proxy/qemu-proxy.h |  2 +-
 2 files changed, 62 insertions(+), 20 deletions(-)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 0ec7bb6..e5fd4bb 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -45,47 +45,89 @@
 
 static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
 
+static int add_argv(char *command_str, char **argv, int argc)
+{
+    int max_args = 64;
+
+    if (argc < max_args - 1) {
+        argv[argc++] = command_str;
+        argv[argc] = 0;
+    } else {
+        return 0;
+    }
+
+    return argc;
+}
+
+static int make_argv(char *command_str, char **argv, int argc)
+{
+    int max_args = 64;
+
+    char *p2 = strtok(command_str, " ");
+    while (p2 && argc < max_args - 1) {
+        argv[argc++] = p2;
+        p2 = strtok(0, " ");
+    }
+    argv[argc] = 0;
+
+    return argc;
+}
+
 int remote_spawn(PCIProxyDev *pdev, const char *command, Error **errp)
 {
-    char *args[3];
     pid_t rpid;
     int fd[2] = {-1, -1};
     Error *local_error = NULL;
+    char *argv[64];
+    int argc = 0, _argc;
+    char *sfd;
+    char *exec_dir;
+    int rc = -EINVAL;
 
     if (pdev->managed) {
         /* Child is forked by external program (such as libvirt). */
-        return -1;
+        return rc;
     }
 
     if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd)) {
         error_setg(errp, "Unable to create unix socket.");
-        return -1;
+        return rc;
     }
+    exec_dir = g_strdup_printf("%s/%s", qemu_get_exec_dir(), "qemu-scsi-dev");
+    argc = add_argv(exec_dir, argv, argc);
+    sfd = g_strdup_printf("%d", fd[1]);
+    argc = add_argv(sfd, argv, argc);
+    _argc = argc;
+    argc = make_argv((char *)command, argv, argc);
+
     /* TODO: Restrict the forked process' permissions and capabilities. */
     rpid = qemu_fork(&local_error);
 
     if (rpid == -1) {
         error_setg(errp, "Unable to spawn emulation program.");
         close(fd[0]);
-        close(fd[1]);
-        return -1;
+        goto fail;
     }
 
     if (rpid == 0) {
         close(fd[0]);
-
-        args[0] = g_strdup(command);
-        args[1] = g_strdup_printf("%d", fd[1]);
-        args[2] = NULL;
-        execvp(args[0], (char *const *)args);
+        execvp(argv[0], (char *const *)argv);
         exit(1);
     }
     pdev->remote_pid = rpid;
-    pdev->rsocket = fd[0];
+    pdev->rsocket = fd[1];
+    pdev->socket = fd[0];
 
+    rc = 0;
+
+fail:
     close(fd[1]);
 
-    return 0;
+    for (int i = 0; i < _argc; i++) {
+        g_free(argv[i]);
+    }
+
+    return rc;
 }
 
 static int get_proxy_sock(PCIDevice *dev)
@@ -94,7 +136,7 @@ static int get_proxy_sock(PCIDevice *dev)
 
     pdev = PCI_PROXY_DEV(dev);
 
-    return pdev->rsocket;
+    return pdev->socket;
 }
 
 static void set_proxy_sock(PCIDevice *dev, int socket)
@@ -103,7 +145,7 @@ static void set_proxy_sock(PCIDevice *dev, int socket)
 
     pdev = PCI_PROXY_DEV(dev);
 
-    pdev->rsocket = socket;
+    pdev->socket = socket;
     pdev->managed = true;
 
 }
@@ -198,16 +240,16 @@ static void pci_proxy_dev_register_types(void)
 
 type_init(pci_proxy_dev_register_types)
 
-static void init_proxy(PCIDevice *dev, char *command, Error **errp)
+static void init_proxy(PCIDevice *dev, char *command, bool need_spawn, Error **errp)
 {
     PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
     Error *local_error = NULL;
 
     if (!pdev->managed) {
-        if (command) {
-            remote_spawn(pdev, command, &local_error);
-        } else {
-            return;
+        if (need_spawn) {
+            if (!remote_spawn(pdev, command, &local_error)) {
+                return;
+            }
         }
     } else {
         pdev->remote_pid = atoi(pdev->rid);
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index ee21818..3b37b65 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -63,7 +63,7 @@ typedef struct PCIProxyDev {
 
     void (*set_remote_opts) (PCIDevice *dev, QDict *qdict, unsigned int cmd);
     void (*proxy_ready) (PCIDevice *dev);
-    void (*init_proxy) (PCIDevice *pdev, char *command, Error **errp);
+    void (*init_proxy) (PCIDevice *dev, char *command, bool need_spawn, Error **errp);
 
 } PCIProxyDev;
 
-- 
1.8.3.1


