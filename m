Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C906C433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:40:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB5C2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:40:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VnmNKzPJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB5C2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59758 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Af1-0000SA-79
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 11:39:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53794)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AdB-00076G-GO
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:05 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49936)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1Ad8-00025Z-Cr
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:05 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXqlU008034;
 Thu, 30 Jul 2020 15:37:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=hbOroEKaTxV0w6TXCHIDZ5gWaq360kaGUNlpSPZEzCw=;
 b=VnmNKzPJh0AifsGIk2Ca/laONYb95ExHFi+JFYY74cFN9Mw20vYgRdwncN5kJlfLdyoB
 Bd0VrRfD7fLau2xoAGMS7GFBNlCYQi2C/cm6E6o8YOPJtx6m4fWfpUqij+JtFKuXG1IA
 JLfozkiGUqufd5h/7ro8yZX4q0pjPd2wY47rQiztOonGBe/yBfCHgYXYoG5JyQoaogPN
 qgpfw9ZHoc4OJ4ay6Ci+1lvyQdwVHY5j+fKEMGm7Ngnp5JZCbwRNpo9ViGFJl8g6oa9u
 iBBHzbnVUobDqGGg+EdVzqq+TP3WDPwNps7wHiG0MRpLblR9+TUS2MkCLD9rZq2xkVq4 8Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 32hu1jmfdk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 15:37:58 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFYj2Q172040;
 Thu, 30 Jul 2020 15:37:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 32hu5x0w2p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 15:37:57 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06UFbu84001820;
 Thu, 30 Jul 2020 15:37:56 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 08:37:56 -0700
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 04/32] savevm: HMP Command for cprsave
Date: Thu, 30 Jul 2020 08:14:08 -0700
Message-Id: <1596122076-341293-5-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=3 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=3 bulkscore=0 priorityscore=1501
 phishscore=0 mlxlogscore=999 lowpriorityscore=0 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
Received-SPF: pass client-ip=156.151.31.86;
 envelope-from=steven.sistare@oracle.com; helo=userp2130.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 11:37:58
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -63
X-Spam_score: -6.4
X-Spam_bar: ------
X-Spam_report: (-6.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=-1, SPF_HELO_PASS=-0.001,
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
Cc: "Daniel P. Berrange" <berrange@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Juan Quintela <quintela@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Steve Sistare <steven.sistare@oracle.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Enable HMP access to the cprsave QMP command.

Usage: cprsave <filename> <mode>

Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hmp-commands.hx       | 18 ++++++++++++++++++
 include/monitor/hmp.h |  1 +
 monitor/hmp-cmds.c    | 10 ++++++++++
 3 files changed, 29 insertions(+)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 60f395c..c8defd9 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -354,6 +354,24 @@ SRST
 ERST
 
     {
+        .name       = "cprsave",
+        .args_type  = "file:s,mode:s",
+        .params     = "file 'reboot'",
+        .help       = "create a checkpoint of the VM in file",
+        .cmd        = hmp_cprsave,
+    },
+
+SRST
+``cprsave`` *tag*
+  Stop VCPUs, create a checkpoint of the whole virtual machine and save it
+  in *file*.
+  If *mode* is 'reboot', the checkpoint can be cprload'ed after a host kexec
+  reboot.
+  exec() /usr/bin/qemu-exec if it exists, else exec /usr/bin/qemu-system-x86_64,
+  passing all the original command line arguments.  The VCPUs remain paused.
+ERST
+
+    {
         .name       = "delvm",
         .args_type  = "name:s",
         .params     = "tag",
diff --git a/include/monitor/hmp.h b/include/monitor/hmp.h
index c986cfd..af8ee23 100644
--- a/include/monitor/hmp.h
+++ b/include/monitor/hmp.h
@@ -59,6 +59,7 @@ void hmp_balloon(Monitor *mon, const QDict *qdict);
 void hmp_loadvm(Monitor *mon, const QDict *qdict);
 void hmp_savevm(Monitor *mon, const QDict *qdict);
 void hmp_delvm(Monitor *mon, const QDict *qdict);
+void hmp_cprsave(Monitor *mon, const QDict *qdict);
 void hmp_migrate_cancel(Monitor *mon, const QDict *qdict);
 void hmp_migrate_continue(Monitor *mon, const QDict *qdict);
 void hmp_migrate_incoming(Monitor *mon, const QDict *qdict);
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index ae4b6a4..59196ed 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -1139,6 +1139,16 @@ void hmp_announce_self(Monitor *mon, const QDict *qdict)
     qapi_free_AnnounceParameters(params);
 }
 
+void hmp_cprsave(Monitor *mon, const QDict *qdict)
+{
+    Error *err = NULL;
+
+    qmp_cprsave(qdict_get_try_str(qdict, "file"),
+                qdict_get_try_str(qdict, "mode"),
+                &err);
+    hmp_handle_error(mon, err);
+}
+
 void hmp_migrate_cancel(Monitor *mon, const QDict *qdict)
 {
     qmp_migrate_cancel(NULL);
-- 
1.8.3.1


