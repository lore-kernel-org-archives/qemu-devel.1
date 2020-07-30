Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9201C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:51:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 731B8206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:51:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="T+hVvyLG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 731B8206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1AqF-0000wj-KF
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 11:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53954)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AdN-0007TZ-6M
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:17 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50150)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AdK-0002Ag-6O
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:16 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXcGv007652;
 Thu, 30 Jul 2020 15:38:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=T4ZfUEryyQOwpRw5tgVkPIpr18yCga2sggJCM6Ln6So=;
 b=T+hVvyLGa2mk7Ry+Z6hgrlGP4fkKb4v1ky0CzCa0BLJcFTRl+IxZWlX9Wf95p6xy5Pb2
 Y3kf6TTDIlfGjqQcjyoPxNkD/BS4aXJbdfoVir8qwdXwEhIWbA87KHOytlbDw1fTWANi
 IzHxhfwE1XjyzWmNAOmbGHaFoigaO51B34ylSJBKVEhz40YU5TAJFDAssp+ot6WysrL9
 PYYmRluXRt2GvXfY7ScHoqvYW0TPZVU44FJGm4KVoLZUA9fPUQzpC28HHlMgvUE2fIOH
 ew2NZheeyvuwn8gkd7FU82Ua1np3YA5xFaXunSEDDgAs91AHUDIm5Ouyxo7siMWTqmD3 Rg== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
 by userp2130.oracle.com with ESMTP id 32hu1jmffa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 15:38:11 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
 by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFYjOR172108;
 Thu, 30 Jul 2020 15:38:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3020.oracle.com with ESMTP id 32hu5x0wkd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 15:38:10 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06UFc9lt001893;
 Thu, 30 Jul 2020 15:38:09 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 08:38:08 -0700
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 20/32] vl: add helper to request re-exec
Date: Thu, 30 Jul 2020 08:14:24 -0700
Message-Id: <1596122076-341293-21-git-send-email-steven.sistare@oracle.com>
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

Add a qemu_exec_requested() hook that causes the main loop to exit and
re-exec qemu using the same initial arguments.  If /usr/bin/qemu-exec
exists, exec that instead.  This is an optional site-specific trampoline
that may alter the environment before exec'ing the qemu binary.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
---
 include/sysemu/sysemu.h |  1 +
 softmmu/vl.c            | 30 ++++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 5360da5..4dfc4ca 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -15,6 +15,7 @@ extern QemuUUID qemu_uuid;
 extern bool qemu_uuid_set;
 
 void qemu_add_data_dir(const char *path);
+void qemu_system_exec_request(void);
 
 void qemu_add_exit_notifier(Notifier *notify);
 void qemu_remove_exit_notifier(Notifier *notify);
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 7016e39..72f0e08 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -116,6 +116,7 @@
 
 #define MAX_VIRTIO_CONSOLES 1
 
+static char **argv_main;
 static const char *data_dir[16];
 static int data_dir_idx;
 const char *bios_name = NULL;
@@ -1296,6 +1297,7 @@ static ShutdownCause reset_requested;
 static ShutdownCause shutdown_requested;
 static int shutdown_signal;
 static pid_t shutdown_pid;
+static int exec_requested;
 static int powerdown_requested;
 static int debug_requested;
 static int suspend_requested;
@@ -1326,6 +1328,11 @@ static int qemu_shutdown_requested(void)
     return atomic_xchg(&shutdown_requested, SHUTDOWN_CAUSE_NONE);
 }
 
+static int qemu_exec_requested(void)
+{
+    return atomic_xchg(&exec_requested, 0);
+}
+
 static void qemu_kill_report(void)
 {
     if (!qtest_driver() && shutdown_signal) {
@@ -1582,6 +1589,13 @@ void qemu_system_shutdown_request(ShutdownCause reason)
     qemu_notify_event();
 }
 
+void qemu_system_exec_request(void)
+{
+    shutdown_requested = 1;
+    exec_requested = 1;
+    qemu_notify_event();
+}
+
 static void qemu_system_powerdown(void)
 {
     qapi_event_send_powerdown();
@@ -1617,6 +1631,16 @@ void qemu_system_debug_request(void)
     qemu_notify_event();
 }
 
+static void qemu_exec(void)
+{
+    const char *helper = "/usr/bin/qemu-exec";
+    const char *bin = !access(helper, X_OK) ? helper : argv_main[0];
+
+    execvp(bin, argv_main);
+    error_report("execvp failed, errno %d.", errno);
+    exit(1);
+}
+
 static bool main_loop_should_exit(void)
 {
     RunState r;
@@ -1637,6 +1661,11 @@ static bool main_loop_should_exit(void)
     }
     request = qemu_shutdown_requested();
     if (request) {
+
+        if (qemu_exec_requested()) {
+            qemu_exec();
+            /* not reached */
+        }
         qemu_kill_report();
         qemu_system_shutdown(request);
         if (no_shutdown) {
@@ -2891,6 +2920,7 @@ void qemu_init(int argc, char **argv, char **envp)
 
     os_set_line_buffering();
 
+    argv_main = argv;
     error_init(argv[0]);
     module_call_init(MODULE_INIT_TRACE);
 
-- 
1.8.3.1


