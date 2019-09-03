Return-Path: <SRS0=U1cK=W6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F47C3A5A2
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:25:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D87C22DBF
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2019 21:25:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="KxeBPd+V"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D87C22DBF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51738 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5GJ9-0007td-80
	for qemu-devel@archiver.kernel.org; Tue, 03 Sep 2019 17:25:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53792)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1i5FaV-0008DQ-Tt
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1i5FaU-0000tQ-Ne
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:39 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:60880)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1i5FaU-0000so-F4
 for qemu-devel@nongnu.org; Tue, 03 Sep 2019 16:39:38 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KdXVW067263;
 Tue, 3 Sep 2019 20:39:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=Ua0BS30lSDPp5MEUWWufTVVG+lPd8WUQahGgCFpVYD0=;
 b=KxeBPd+VNuCRbQLVjOSv9FjSbU25ds76SpQHmfmMv7EClqHa9kPNugojjZcpIkTiV0nI
 pzymaKawOgp1p0kOdYxp43MeTERT/FjEEFsckvyc+T7Co8bRWZn5voaIrEriwPBd4tiD
 G1qneA/oPC91/XxMnDb5mnmeA5B068dGFNYkDnFwcFmmjvb8UgVSPK0Rjqm+q0bZm0lv
 s6l8fHPFD8uwoUws0mZqtRJyKxmSmvOkuFyg+b8zeBAO74107ntzXZLxHnW5GL4Ncr/j
 /fd2H1H9ZkUO2iuLG9iqtxK8FTW5hesWeVjco3cW6duOOIVXMy+wSQsgPCM4VUg558ON Jw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 2usy66r2je-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x83KcIcr094739;
 Tue, 3 Sep 2019 20:39:32 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by userp3030.oracle.com with ESMTP id 2usu51u2d4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 03 Sep 2019 20:39:32 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x83KdVFb017870;
 Tue, 3 Sep 2019 20:39:31 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Tue, 03 Sep 2019 13:39:30 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Date: Tue,  3 Sep 2019 16:38:08 -0400
Message-Id: <e650db79c118ad5f0fb68426340d2b9e7e0690e4.1567534653.git.jag.raman@oracle.com>
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
X-Received-From: 156.151.31.85
Subject: [Qemu-devel] [RFC v3 PATCH 42/45] multi-process/mon: Initialize QMP
 module for remote processes
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

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 New patch in v3

 remote/remote-main.c | 11 +++++++++++
 remote/remote-opts.c | 10 ++++++++++
 2 files changed, 21 insertions(+)

diff --git a/remote/remote-main.c b/remote/remote-main.c
index a6ff338..41da405 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -68,6 +68,7 @@
 
 #include "monitor/monitor.h"
 #include "sysemu/reset.h"
+#include "vl.h"
 
 static ProxyLinkState *proxy_link;
 
@@ -562,6 +563,8 @@ int main(int argc, char *argv[], char **envp)
 
     module_call_init(MODULE_INIT_QOM);
 
+    monitor_init_globals();
+
     bdrv_init_with_whitelist();
 
     if (qemu_init_main_loop(&err)) {
@@ -577,6 +580,8 @@ int main(int argc, char *argv[], char **envp)
 
     qemu_add_opts(&qemu_device_opts);
     qemu_add_opts(&qemu_drive_opts);
+    qemu_add_opts(&qemu_chardev_opts);
+    qemu_add_opts(&qemu_mon_opts);
     qemu_add_drive_opts(&qemu_legacy_drive_opts);
     qemu_add_drive_opts(&qemu_common_drive_opts);
     qemu_add_drive_opts(&qemu_drive_opts);
@@ -609,6 +614,12 @@ int main(int argc, char *argv[], char **envp)
 
     proxy_link_set_callback(proxy_link, process_msg);
 
+    qemu_opts_foreach(qemu_find_opts("chardev"),
+                      chardev_init_func, NULL, &error_fatal);
+
+    qemu_opts_foreach(qemu_find_opts("mon"),
+                      mon_init_func, NULL, &error_fatal);
+
     start_handler(proxy_link);
 
     return 0;
diff --git a/remote/remote-opts.c b/remote/remote-opts.c
index 416ff59..7ddfe5c 100644
--- a/remote/remote-opts.c
+++ b/remote/remote-opts.c
@@ -95,6 +95,16 @@ void parse_cmdline(int argc, char **argv, char **envp)
                     exit(1);
                 }
                 break;
+            case QEMU_OPTION_qmp:
+                monitor_parse(optarg, "control", false);
+                break;
+            case QEMU_OPTION_monitor:
+                if (!strncmp(optarg, "stdio", 5)) {
+                    warn_report("STDIO not supported in remote process");
+                } else if (strncmp(optarg, "none", 4)) {
+                    monitor_parse(optarg, "readline", false);
+                }
+                break;
             default:
                 break;
             }
-- 
1.8.3.1


