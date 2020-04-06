Return-Path: <SRS0=By5p=5W=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A28E8C2BA1E
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:05:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AF1D2063A
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2020 10:05:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="pZ1BIXuE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AF1D2063A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57841 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jLOdC-0000hw-KJ
	for qemu-devel@archiver.kernel.org; Mon, 06 Apr 2020 06:05:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45055)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOJB-00074m-HF
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:44:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <elena.ufimtseva@oracle.com>) id 1jLOJA-0004F8-Br
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:44:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:47900)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <elena.ufimtseva@oracle.com>)
 id 1jLOJA-0004EA-2l
 for qemu-devel@nongnu.org; Mon, 06 Apr 2020 05:44:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
 by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369hfiK073043;
 Mon, 6 Apr 2020 09:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=6Q59cXboZOXx0HdsTyg1XD4d3qx1PvHh6xmcCZ0i1ps=;
 b=pZ1BIXuEi24jQS2C7eqlHjdXwQ2oCBmpA/la6NCa/aooGyFbm7BwW4RfTKvdzyuvOP4B
 pf5YZBxtAkm1ZWWkLB/qhaK3UV6OxAPjAfaoq2QaJU9LTqRuBcITrxUqeMzCRDQaxmFq
 mbhbtsT6zYIVtoMDpEOI+4sAzGdtaZHEyNBpOid8Qx8TFYO6gyxyFN9ppvI0YAFgb3j1
 0wdVwfD2XlENIhqy7Rig4VWw76qMm9jDmzfNLI/0EYDoZYaR+U873wOjS/PMuKH9OQ0i
 GmE4rMf+HhjwaUfuiaEBQZfqKTP+S1E6AEycDDoPUfL3zGShNCu78IPb6PSiSsxG1wAV vw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by aserp2120.oracle.com with ESMTP id 306j6m5tnt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:44:37 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0369gaJ2107224;
 Mon, 6 Apr 2020 09:42:37 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
 by aserp3030.oracle.com with ESMTP id 3073spk6qy-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 06 Apr 2020 09:42:36 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
 by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0369gSZD032140;
 Mon, 6 Apr 2020 09:42:28 GMT
Received: from flaka.hsd1.ca.comcast.net (/67.180.143.163)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 06 Apr 2020 02:42:28 -0700
From: elena.ufimtseva@oracle.com
To: qemu-devel@nongnu.org
Subject: [PATCH v6 34/36] multi-process/mon: Initialize QMP module for remote
 processes
Date: Mon,  6 Apr 2020 02:41:24 -0700
Message-Id: <4c834a354e84bc5863b43fc24111422d450b79fa.1586165556.git.elena.ufimtseva@oracle.com>
X-Mailer: git-send-email 2.25.GIT
In-Reply-To: <cover.1586165555.git.elena.ufimtseva@oracle.com>
References: <cover.1586165555.git.elena.ufimtseva@oracle.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0
 phishscore=0 spamscore=0
 malwarescore=0 suspectscore=1 adultscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060084
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9582
 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0
 mlxlogscore=999 spamscore=0
 priorityscore=1501 suspectscore=1 lowpriorityscore=0 malwarescore=0
 impostorscore=0 mlxscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004060084
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 141.146.126.78
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
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 remote/remote-main.c | 13 +++++++++++++
 remote/remote-opts.c | 11 +++++++++++
 2 files changed, 24 insertions(+)

diff --git a/remote/remote-main.c b/remote/remote-main.c
index 6e198de35f..57f31616e0 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -39,6 +39,9 @@
 #include "remote/iohub.h"
 #include "remote-opts.h"
 #include "sysemu/reset.h"
+#include "qemu-parse.h"
+#include "monitor/monitor.h"
+#include "chardev/char.h"
 
 static void process_msg(GIOCondition cond, MPQemuLinkState *link,
                         MPQemuChannel *chan);
@@ -286,6 +289,8 @@ int main(int argc, char *argv[])
 
     module_call_init(MODULE_INIT_QOM);
 
+    monitor_init_globals();
+
     bdrv_init_with_whitelist();
 
     if (qemu_init_main_loop(&err)) {
@@ -303,6 +308,8 @@ int main(int argc, char *argv[])
 
     qemu_add_opts(&qemu_device_opts);
     qemu_add_opts(&qemu_drive_opts);
+    qemu_add_opts(&qemu_chardev_opts);
+    qemu_add_opts(&qemu_mon_opts);
     qemu_add_drive_opts(&qemu_legacy_drive_opts);
     qemu_add_drive_opts(&qemu_common_drive_opts);
     qemu_add_drive_opts(&qemu_drive_opts);
@@ -322,6 +329,12 @@ int main(int argc, char *argv[])
 
     parse_cmdline(argc - 2, argv + 2, NULL);
 
+    qemu_opts_foreach(qemu_find_opts("chardev"),
+                      chardev_init_func, NULL, &error_fatal);
+
+    qemu_opts_foreach(qemu_find_opts("mon"),
+                      mon_init_func, NULL, &error_fatal);
+
     mpqemu_init_channel(mpqemu_link, &mpqemu_link->com, fd);
 
     mpqemu_link_set_callback(mpqemu_link, process_msg);
diff --git a/remote/remote-opts.c b/remote/remote-opts.c
index f077221c71..ac3a9be6b8 100644
--- a/remote/remote-opts.c
+++ b/remote/remote-opts.c
@@ -15,6 +15,7 @@
 #include "qemu-options.h"
 #include "qemu-parse.h"
 #include "remote-opts.h"
+#include "monitor/monitor.h"
 
 /*
  * In remote process, we parse only subset of options. The code
@@ -64,6 +65,16 @@ void parse_cmdline(int argc, char **argv, char **envp)
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
2.25.GIT


