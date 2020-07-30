Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5962C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:50:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF84206F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Emg4Uuw5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF84206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39562 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Ap9-0007dv-QK
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 11:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54558)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1Af6-0001CJ-0o
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:40:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:47832)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1Af3-0002U1-Qz
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:40:03 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXTG9152212;
 Thu, 30 Jul 2020 15:39:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=d1OT3ty10GFpJwdnOpO08ryOwyf2KWtChB0Ypajkg9M=;
 b=Emg4Uuw5rZONqvucdJs1QRfhNS/VSGS6ktxi6Fl0eaas4SWyKxs2/jXtQCYKSec9hn5R
 UdxaVYHTqAdFjL3djkWKp613Q3pT3XqMTxBzROxjajnw6bXWIBM9bt/aexroVagum4t3
 OngfikS4/GMsMqMLfy5k6gWhv9rEXLbetxFz0R00Pf2HkER+sEJysMP9iohPbvArq5p9
 TOUHZvQS4jvr7wsAjhOvrf/parVwHgdKVFVWAljc4Wb4EgfMvskxQ2TjRJsLzHKga7y0
 jxq8E87vYQcKVYcf5X95e/bHdMGI1lnAnbsn2qASgaO3caSzn6i5ckMZgwgO7NtHlFaf QQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2120.oracle.com with ESMTP id 32hu1jveb2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 15:39:58 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXSO3130733;
 Thu, 30 Jul 2020 15:37:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by userp3030.oracle.com with ESMTP id 32hu5wwgn1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 15:37:58 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06UFbuT0001829;
 Thu, 30 Jul 2020 15:37:56 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 08:37:56 -0700
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 05/32] savevm: QMP command for cprload
Date: Thu, 30 Jul 2020 08:14:09 -0700
Message-Id: <1596122076-341293-6-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 mlxlogscore=999 mlxscore=0
 suspectscore=1 bulkscore=0 malwarescore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015
 mlxlogscore=999
 malwarescore=0 impostorscore=0 priorityscore=1501 spamscore=0 phishscore=0
 suspectscore=1 bulkscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007300111
Received-SPF: pass client-ip=156.151.31.85;
 envelope-from=steven.sistare@oracle.com; helo=userp2120.oracle.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/07/30 11:38:02
X-ACL-Warn: Detected OS   = Linux 3.1-3.10 [fuzzy]
X-Spam_score_int: -53
X-Spam_score: -5.4
X-Spam_bar: -----
X-Spam_report: (-5.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001,
 UNPARSEABLE_RELAY=0.001 autolearn=ham autolearn_force=no
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

Provide the cprload QMP command.  The VM is created from the file produced
by the cprsave command.  Guest RAM is restored in-place from the shared
memory backend file, and guest block devices are used as is.  The contents
of such devices must not be modified between the cprsave and cprload
operations.  If the VM was running at cprsave time, then VM execution
resumes.

Syntax:
  {'command':'cprload', 'data':{'file':'str'}}

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
---
 include/sysemu/sysemu.h |  2 ++
 migration/savevm.c      | 34 ++++++++++++++++++++++++++++++++++
 monitor/qmp-cmds.c      |  5 +++++
 qapi/migration.json     | 11 +++++++++++
 softmmu/vl.c            | 15 ++++++++++++++-
 5 files changed, 66 insertions(+), 1 deletion(-)

diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 6fe86e6..5360da5 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -25,6 +25,7 @@ void qemu_add_machine_init_done_notifier(Notifier *notify);
 void qemu_remove_machine_init_done_notifier(Notifier *notify);
 
 void save_cpr_snapshot(const char *file, const char *mode, Error **errp);
+void load_cpr_snapshot(const char *file, Error **errp);
 
 extern int autostart;
 
@@ -53,6 +54,7 @@ extern uint8_t *boot_splash_filedata;
 extern bool enable_mlock;
 extern bool enable_cpu_pm;
 extern QEMUClockType rtc_clock;
+extern int start_on_wake;
 
 #define MAX_OPTION_ROMS 16
 typedef struct QEMUOptionRom {
diff --git a/migration/savevm.c b/migration/savevm.c
index ff1a46e..1509173 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2948,6 +2948,40 @@ void qmp_xen_load_devices_state(const char *filename, Error **errp)
     migration_incoming_state_destroy();
 }
 
+void load_cpr_snapshot(const char *file, Error **errp)
+{
+    QEMUFile *f;
+    int ret;
+    RunState state;
+
+    if (runstate_is_running()) {
+        error_setg(errp, "cprload called for a running VM");
+        return;
+    }
+
+    f = qf_file_open(file, O_RDONLY, 0, errp);
+    if (!f) {
+        return;
+    }
+
+    ret = qemu_loadvm_state(f, VMS_REBOOT);
+    qemu_fclose(f);
+    if (ret < 0) {
+        error_setg(errp, "Error %d while loading VM state", ret);
+        return;
+    }
+
+    state = global_state_get_runstate();
+    if (state == RUN_STATE_RUNNING) {
+        vm_start();
+    } else {
+        runstate_set(state);
+        if (runstate_check(RUN_STATE_SUSPENDED)) {
+            start_on_wake = 1;
+        }
+    }
+}
+
 int load_snapshot(const char *name, Error **errp)
 {
     BlockDriverState *bs, *bs_vm_state;
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 9ec7b88..81e6feb 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -167,6 +167,11 @@ void qmp_cprsave(const char *file, const char *mode, Error **errp)
     save_cpr_snapshot(file, mode, errp);
 }
 
+void qmp_cprload(const char *file, Error **errp)
+{
+    load_cpr_snapshot(file, errp);
+}
+
 void qmp_system_wakeup(Error **errp)
 {
     if (!qemu_wakeup_suspend_enabled()) {
diff --git a/qapi/migration.json b/qapi/migration.json
index b61df1d..ce4d32b 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1635,3 +1635,14 @@
 ##
 { 'command': 'cprsave', 'data': { 'file': 'str', 'mode': 'str' } }
 
+##
+# @cprload:
+#
+# Start virtual machine from checkpoint file that was created earlier using
+# the cprsave command.
+#
+# @file: name of checkpoint file
+#
+# Since 5.0
+##
+{ 'command': 'cprload', 'data': { 'file': 'str' } }
diff --git a/softmmu/vl.c b/softmmu/vl.c
index 660537a..8478778 100644
--- a/softmmu/vl.c
+++ b/softmmu/vl.c
@@ -137,6 +137,7 @@ static time_t rtc_ref_start_datetime;
 static int rtc_realtime_clock_offset; /* used only with QEMU_CLOCK_REALTIME */
 static int rtc_host_datetime_offset = -1; /* valid & used only with
                                              RTC_BASE_DATETIME */
+int start_on_wake;
 QEMUClockType rtc_clock;
 int vga_interface_type = VGA_NONE;
 static DisplayOptions dpy;
@@ -602,6 +603,8 @@ static const RunStateTransition runstate_transitions_def[] = {
     { RUN_STATE_PRELAUNCH, RUN_STATE_RUNNING },
     { RUN_STATE_PRELAUNCH, RUN_STATE_FINISH_MIGRATE },
     { RUN_STATE_PRELAUNCH, RUN_STATE_INMIGRATE },
+    { RUN_STATE_PRELAUNCH, RUN_STATE_SUSPENDED },
+    { RUN_STATE_PRELAUNCH, RUN_STATE_PAUSED },
 
     { RUN_STATE_FINISH_MIGRATE, RUN_STATE_RUNNING },
     { RUN_STATE_FINISH_MIGRATE, RUN_STATE_PAUSED },
@@ -1519,7 +1522,17 @@ void qemu_system_wakeup_request(WakeupReason reason, Error **errp)
     if (!(wakeup_reason_mask & (1 << reason))) {
         return;
     }
-    runstate_set(RUN_STATE_RUNNING);
+
+    /*
+     * Must call vm_start if it has never been called, to invoke the state
+     * change callbacks for the first time.
+     */
+    if (start_on_wake) {
+        start_on_wake = 0;
+        vm_start();
+    } else {
+        runstate_set(RUN_STATE_RUNNING);
+    }
     wakeup_reason = reason;
     qemu_notify_event();
 }
-- 
1.8.3.1


