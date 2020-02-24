Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0E7C38BE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:03:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55B3B21927
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:03:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="wrw6qbh5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55B3B21927
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43210 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6Ksu-0000mQ-Dl
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:03:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50286)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6KmA-0006Hc-CV
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Km8-000351-TI
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:26 -0500
Received: from userp2120.oracle.com ([156.151.31.85]:41130)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Km8-000344-KO
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:56:24 -0500
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKqZfx017693;
 Mon, 24 Feb 2020 20:56:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=wu/8BnjW53rP1bdYeOpLZbtZ/ZVmT9UqvX3vg1UFB94=;
 b=wrw6qbh5vsrgDl4IDNSVVJbc18ldx5Xav5K+54HiZBbieAIIYfbzEDIt2cNcx+Xh3Phv
 1Ku6lpxBA0KShjWsW9j75cj+ppvLfTl+NJtLVf41P0zkrXfrrYpH+4U4LGdSz2jMLxHI
 FFRvPnTRLnQ1O94316nz/Xg9pBs+L8DlGZKmSKVCxN2Y7Umf9mmnUErE7fjch/ivnQU3
 RkTevJAFjhVtnmzu71gA8F3iYsXNfJmT3aqblSLQR1ZEg4rf80PEDLXqA6piOKZjAv3k
 KmC3CaOqGWgEfzDsi7r3SFnS1md0+D7Sv5CwRjMrlYvO54NchYUsSnPYlidwJQfvMf8R DQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2yavxrhyeg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:19 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKq5M7171132;
 Mon, 24 Feb 2020 20:56:19 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 2ybdshkrr6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:56:19 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01OKuIwx008020;
 Mon, 24 Feb 2020 20:56:18 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:56:17 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 14/50] mutli-process: build remote command line args
Date: Mon, 24 Feb 2020 15:55:05 -0500
Message-Id: <588dafeecd20f8562f4a0dd68fa4bafbd6ea18bb.1582576372.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
In-Reply-To: <cover.1582576372.git.jag.raman@oracle.com>
References: <cover.1582576372.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 suspectscore=1 spamscore=0
 malwarescore=0 mlxscore=0 bulkscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9541
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=1 bulkscore=0 mlxlogscore=999
 malwarescore=0 phishscore=0 adultscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2001150001
 definitions=main-2002240153
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
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
 v4 -> v5:
  - Added "exec" suboption to get the executable's name
  - Addressed feedback about variable names
  - Removed redundant check for spawning a process

 hw/proxy/qemu-proxy.c         | 68 +++++++++++++++++++++++++++++++++----------
 include/hw/proxy/qemu-proxy.h |  2 +-
 2 files changed, 54 insertions(+), 16 deletions(-)

diff --git a/hw/proxy/qemu-proxy.c b/hw/proxy/qemu-proxy.c
index 828bbd7..d792e86 100644
--- a/hw/proxy/qemu-proxy.c
+++ b/hw/proxy/qemu-proxy.c
@@ -19,19 +19,50 @@
 
 static void pci_proxy_dev_realize(PCIDevice *dev, Error **errp);
 
+static int add_argv(char *opts_str, char **argv, int argc)
+{
+    int max_args = 64;
+
+    if (argc < max_args - 1) {
+        argv[argc++] = opts_str;
+        argv[argc] = 0;
+    } else {
+        return 0;
+    }
+
+    return argc;
+}
+
+static int make_argv(char *opts_str, char **argv, int argc)
+{
+    int max_args = 64;
+
+    char *p2 = strtok(opts_str, " ");
+    while (p2 && argc < max_args - 1) {
+        argv[argc++] = p2;
+        p2 = strtok(0, " ");
+    }
+    argv[argc] = 0;
+
+    return argc;
+}
+
 static int remote_spawn(PCIProxyDev *pdev, const char *opts,
                         const char *exec_name, Error **errp)
 {
-    char *args[3];
     pid_t rpid;
     int fd[2] = {-1, -1};
     Error *local_error = NULL;
+    char *argv[64];
+    int argc = 0;
+    char *sfd;
+    char *exec_dir;
     int rc = -EINVAL;
 
     if (pdev->managed) {
         /* Child is forked by external program (such as libvirt). */
         error_setg(errp, "Remote processed is managed and launched by external program");
-        return -1;
+        return rc;
     }
 
     if (!exec_name) {
@@ -41,32 +72,38 @@ static int remote_spawn(PCIProxyDev *pdev, const char *opts,
 
     if (socketpair(AF_UNIX, SOCK_STREAM, 0, fd)) {
         error_setg(errp, "Unable to create unix socket.");
-        return -1;
+        return rc;
     }
+    exec_dir = g_strdup_printf("%s/%s", qemu_get_exec_dir(), exec_name);
+    argc = add_argv(exec_dir, argv, argc);
+    sfd = g_strdup_printf("%d", fd[1]);
+    argc = add_argv(sfd, argv, argc);
+    argc = make_argv((char *)opts, argv, argc);
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
 
-        args[0] = g_strdup(exec_name);
-        args[1] = g_strdup_printf("%d", fd[1]);
-        args[2] = NULL;
-        execvp(args[0], (char *const *)args);
+        rc = execv(argv[0], (char *const *)argv);
         exit(1);
     }
     pdev->remote_pid = rpid;
+    pdev->socket = fd[0];
+
+    rc = 0;
 
+fail:
     close(fd[1]);
 
-    return 0;
+    return rc;
 }
 
 static int get_proxy_sock(PCIDevice *dev)
@@ -177,16 +214,17 @@ static void pci_proxy_dev_register_types(void)
 type_init(pci_proxy_dev_register_types)
 
 static void init_proxy(PCIDevice *dev, char *command, char *exec_name,
-                       Error **errp)
+                       bool need_spawn, Error **errp)
 {
     PCIProxyDev *pdev = PCI_PROXY_DEV(dev);
     Error *local_error = NULL;
 
     if (!pdev->managed) {
-        if (command) {
-            remote_spawn(pdev, command, exec_name, &local_error);
-        } else {
-            return;
+        if (need_spawn) {
+            if (remote_spawn(pdev, command, exec_name, &local_error)) {
+                error_propagate(errp, local_error);
+                return;
+            }
         }
     } else {
         pdev->remote_pid = atoi(pdev->rid);
diff --git a/include/hw/proxy/qemu-proxy.h b/include/hw/proxy/qemu-proxy.h
index 28b0114..29fa2e9 100644
--- a/include/hw/proxy/qemu-proxy.h
+++ b/include/hw/proxy/qemu-proxy.h
@@ -39,7 +39,7 @@ typedef struct PCIProxyDev {
 
     void (*proxy_ready) (PCIDevice *dev);
     void (*init_proxy) (PCIDevice *dev, char *command, char *exec_name,
-                        Error **errp);
+                        bool need_spawn, Error **errp);
 
 } PCIProxyDev;
 
-- 
1.8.3.1


