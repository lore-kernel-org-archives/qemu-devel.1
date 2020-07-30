Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 528CAC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:45:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1BCAE2082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aEj6mFVU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1BCAE2082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Akg-0000iU-1q
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 11:45:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53878)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AdG-0007EE-Km
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:10 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50058)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AdE-000279-Ie
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:10 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXTUh007545;
 Thu, 30 Jul 2020 15:38:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=PujpgNBRqtJDW0eHkpwQ/PjdVFOXyApGGQ17TcFFI7A=;
 b=aEj6mFVU1tghb/4DWX+gv+Z7cCHY+DyW7tIrLybr0cWjqo5fueUL9bx2W9ehaBlYPgp2
 NVoKnZOZaqGW5J4ekjaDBnWXMKxqPbcWCb9acb2VdEbCoBgmwzdN0goFyAufaUpnQymh
 psKloh3aTZHzp31nCeBIRTfi+gl1qbuJUxJ71+P7LikJ8PpmD/4vtd9og9WLjoGJohhN
 L5qUf+2lLbcHZiFhQuhpVXKAsY1o60yl31mFEWgXyS+TOOSqb8SPluSRGPpV1nOgozK0
 jun6SwUcByLOUELRAT6FA7u7h+IdkJcHbU8RVpqOm3DQDGTXV+apy8fJ8liN/480h8eX IQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 32hu1jmfem-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 15:38:05 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFYkKR172346;
 Thu, 30 Jul 2020 15:38:05 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3020.oracle.com with ESMTP id 32hu5x0wct-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 15:38:05 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06UFc3BR007481;
 Thu, 30 Jul 2020 15:38:03 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 08:38:03 -0700
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 14/32] savevm: VMS_RESTART and cprsave restart
Date: Thu, 30 Jul 2020 08:14:18 -0700
Message-Id: <1596122076-341293-15-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 bulkscore=0
 malwarescore=0 suspectscore=1 spamscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 clxscore=1015
 malwarescore=0 spamscore=0 suspectscore=1 bulkscore=0 priorityscore=1501
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

Add the VMS_RESTART variant of vmstate, for use when upgrading qemu in place
on the same host without a reboot.  Invoke it using:
  cprsave <filename> restart

VMS_RESTART supports guest ram mapped by private anonymous memory, versus
VMS_REBOOT which requires that guest ram be mapped by persistent shared
memory.  Subsequent patches complete its implementation.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 hmp-commands.hx             | 4 +++-
 include/migration/vmstate.h | 1 +
 migration/savevm.c          | 4 +++-
 monitor/qmp-cmds.c          | 2 +-
 qapi/migration.json         | 1 +
 5 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/hmp-commands.hx b/hmp-commands.hx
index 7517876..11a2089 100644
--- a/hmp-commands.hx
+++ b/hmp-commands.hx
@@ -369,7 +369,7 @@ ERST
     {
         .name       = "cprsave",
         .args_type  = "file:s,mode:s",
-        .params     = "file 'reboot'",
+        .params     = "file 'restart'|'reboot'",
         .help       = "create a checkpoint of the VM in file",
         .cmd        = hmp_cprsave,
     },
@@ -380,6 +380,8 @@ SRST
   in *file*.
   If *mode* is 'reboot', the checkpoint can be cprload'ed after a host kexec
   reboot.
+  If *mode* is 'restart', the checkpoint can be cprload'ed after restarting
+  qemu.
   exec() /usr/bin/qemu-exec if it exists, else exec /usr/bin/qemu-system-x86_64,
   passing all the original command line arguments.  The VCPUs remain paused.
 ERST
diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index c58551a..8239b84 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -162,6 +162,7 @@ typedef enum {
     VMS_MIGRATE  = (1U << 1),
     VMS_SNAPSHOT = (1U << 2),
     VMS_REBOOT   = (1U << 3),
+    VMS_RESTART  = (1U << 4),
     VMS_MODE_ALL = ~0U
 } VMStateMode;
 
diff --git a/migration/savevm.c b/migration/savevm.c
index 00f493b..38cc63a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2708,6 +2708,8 @@ void save_cpr_snapshot(const char *file, const char *mode, Error **errp)
 
     if (!strcmp(mode, "reboot")) {
         op = VMS_REBOOT;
+    } else if (!strcmp(mode, "restart")) {
+        op = VMS_RESTART;
     } else {
         error_setg(errp, "cprsave: bad mode %s", mode);
         return;
@@ -2973,7 +2975,7 @@ void load_cpr_snapshot(const char *file, Error **errp)
         return;
     }
 
-    ret = qemu_loadvm_state(f, VMS_REBOOT);
+    ret = qemu_loadvm_state(f, VMS_REBOOT | VMS_RESTART);
     qemu_fclose(f);
     if (ret < 0) {
         error_setg(errp, "Error %d while loading VM state", ret);
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 8c400e6..8a74c6e 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -164,7 +164,7 @@ void qmp_cont(Error **errp)
 
 char *qmp_cprinfo(Error **errp)
 {
-    return g_strdup("reboot");
+    return g_strdup("reboot restart");
 }
 
 void qmp_cprsave(const char *file, const char *mode, Error **errp)
diff --git a/qapi/migration.json b/qapi/migration.json
index 8190b16..d22992b 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1639,6 +1639,7 @@
 #
 # @file: name of checkpoint file
 # @mode: 'reboot' : checkpoint can be cprload'ed after a host kexec reboot.
+#        'restart': checkpoint can be cprload'ed after restarting qemu.
 #
 # Since 5.0
 ##
-- 
1.8.3.1


