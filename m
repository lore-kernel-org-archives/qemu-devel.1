Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10A4CC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D23112082E
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 15:40:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YVoVl/dT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D23112082E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1Af2-0000Tb-TY
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 11:40:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53816)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1AdC-000770-Gs
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:06 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:49920)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <steven.sistare@oracle.com>)
 id 1k1Ad7-00025A-Tr
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 11:38:06 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFXaIp007640;
 Thu, 30 Jul 2020 15:37:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=corp-2020-01-29;
 bh=NTT/O6BWx9NAiOeWb7X9irO+Oulxu74/KXA7hp5V6/k=;
 b=YVoVl/dTQMeSJSbSxIGf3e3TL5B9sj+n4Zdn/AdhPcwQWYz7e5yTW1DfX8+U2GeMV+YQ
 p3pVpCiY6tfapoxdyM3Hx/ReUdZA5SLlIwFehQYLN0TIFCwBywxW5/drg3LjvsR18TN/
 1JWa8jn0wsaXTU8qqX8AVERAXxEBjgxIkgI18wqvrIwqoMP51ktCMCnV1HXVtdOP4y+X
 MlK/VEGfdtJ1gY4Y1I7Fd2GoXIiAgPKJ0Tfhp5nkreoeyDTH+CHjW0qj+wGP6+jxF5Wk
 KZMfuY6ismCxZWOchu0R6JiUNxFQuteLkMpA8EyD4bc41Nvl457pM2NMA9Zq3p4sMsrN 7A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2130.oracle.com with ESMTP id 32hu1jmfda-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
 Thu, 30 Jul 2020 15:37:57 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06UFWpt3188405;
 Thu, 30 Jul 2020 15:37:56 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3030.oracle.com with ESMTP id 32hu5xj9n9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 30 Jul 2020 15:37:56 +0000
Received: from abhmp0001.oracle.com (abhmp0001.oracle.com [141.146.116.7])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06UFbtAJ001812;
 Thu, 30 Jul 2020 15:37:55 GMT
Received: from ca-dev63.us.oracle.com (/10.211.8.221)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 30 Jul 2020 08:37:55 -0700
From: Steve Sistare <steven.sistare@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH V1 03/32] savevm: QMP command for cprsave
Date: Thu, 30 Jul 2020 08:14:07 -0700
Message-Id: <1596122076-341293-4-git-send-email-steven.sistare@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
References: <1596122076-341293-1-git-send-email-steven.sistare@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9698
 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 mlxscore=0 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=999
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2007300111
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

To enable live reboot, provide the cprsave QMP command and the VMS_REBOOT
vmstate-saving operation, which saves the state of the virtual machine in a
simple file.

Syntax:
  {'command':'cprsave', 'data':{'file':'str', 'mode':'str'}}

  The mode argument must be 'reboot'.  Additional modes will be defined in
  the future.

Unlike the savevm command, cprsave supports any type of guest image and
block device.  cprsave stops the VM so that guest ram and block devices are
not modified after state is saved.  Guest ram must be mapped to a persistent
memory file such as /dev/dax0.0.  The ram object vmstate handler and block
device handler do not apply to VMS_REBOOT, so restrict them to VMS_MIGRATE
or VMS_SNAPSHOT.  After cprsave completes successfully, qemu exits.

After issuing cprsave, the caller may update qemu, update the host kernel,
reboot, start qemu using the same arguments as the original process, and
issue the cprload command to restore the guest.  cprload is added by
subsequent patches.

If the caller suspends the guest instead of stopping the VM, such as by
issuing guest-suspend-ram to the qemu guest agent, then cprsave and cprload
support guests with vfio devices.  The guest drivers suspend methods flush
outstanding requests and re-initialize the devices, and thus there is no
device state to save and restore.

Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
Signed-off-by: Maran Wilson <maran.wilson@oracle.com>
---
 include/migration/vmstate.h |  1 +
 include/sysemu/sysemu.h     |  2 ++
 migration/block.c           |  1 +
 migration/ram.c             |  1 +
 migration/savevm.c          | 59 +++++++++++++++++++++++++++++++++++++++++++++
 monitor/qmp-cmds.c          |  6 +++++
 qapi/migration.json         | 14 +++++++++++
 7 files changed, 84 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index fa575f9..c58551a 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -161,6 +161,7 @@ typedef enum {
 typedef enum {
     VMS_MIGRATE  = (1U << 1),
     VMS_SNAPSHOT = (1U << 2),
+    VMS_REBOOT   = (1U << 3),
     VMS_MODE_ALL = ~0U
 } VMStateMode;
 
diff --git a/include/sysemu/sysemu.h b/include/sysemu/sysemu.h
index 4b6a5c4..6fe86e6 100644
--- a/include/sysemu/sysemu.h
+++ b/include/sysemu/sysemu.h
@@ -24,6 +24,8 @@ extern bool machine_init_done;
 void qemu_add_machine_init_done_notifier(Notifier *notify);
 void qemu_remove_machine_init_done_notifier(Notifier *notify);
 
+void save_cpr_snapshot(const char *file, const char *mode, Error **errp);
+
 extern int autostart;
 
 typedef enum {
diff --git a/migration/block.c b/migration/block.c
index 737b649..a69accb 100644
--- a/migration/block.c
+++ b/migration/block.c
@@ -1023,6 +1023,7 @@ static SaveVMHandlers savevm_block_handlers = {
     .load_state = block_load,
     .save_cleanup = block_migration_cleanup,
     .is_active = block_is_active,
+    .mode_mask = VMS_MIGRATE | VMS_SNAPSHOT,
 };
 
 void blk_mig_init(void)
diff --git a/migration/ram.c b/migration/ram.c
index 76d4fee..f0d5d9f 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3795,6 +3795,7 @@ static SaveVMHandlers savevm_ram_handlers = {
     .load_setup = ram_load_setup,
     .load_cleanup = ram_load_cleanup,
     .resume_prepare = ram_resume_prepare,
+    .mode_mask = VMS_MIGRATE | VMS_SNAPSHOT,
 };
 
 void ram_mig_init(void)
diff --git a/migration/savevm.c b/migration/savevm.c
index ce02b6b..ff1a46e 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2680,6 +2680,65 @@ int qemu_load_device_state(QEMUFile *f)
     return 0;
 }
 
+static QEMUFile *qf_file_open(const char *filename, int flags, int mode,
+                              Error **errp)
+{
+    QIOChannel *ioc;
+    int fd = qemu_open(filename, flags, mode);
+
+    if (fd < 0) {
+        error_setg_errno(errp, errno, "%s(%s)", __func__, filename);
+        return NULL;
+    }
+
+    ioc = QIO_CHANNEL(qio_channel_file_new_fd(fd));
+
+    if (flags & O_WRONLY) {
+        return qemu_fopen_channel_output(ioc);
+    }
+
+    return qemu_fopen_channel_input(ioc);
+}
+
+void save_cpr_snapshot(const char *file, const char *mode, Error **errp)
+{
+    int ret = 0;
+    QEMUFile *f;
+    VMStateMode op;
+
+    if (!strcmp(mode, "reboot")) {
+        op = VMS_REBOOT;
+    } else {
+        error_setg(errp, "cprsave: bad mode %s", mode);
+        return;
+    }
+
+    f = qf_file_open(file, O_CREAT | O_WRONLY | O_TRUNC, 0600, errp);
+    if (!f) {
+        return;
+    }
+
+    ret = global_state_store();
+    if (ret) {
+        error_setg(errp, "Error saving global state");
+        qemu_fclose(f);
+        return;
+    }
+
+    vm_stop(RUN_STATE_SAVE_VM);
+
+    ret = qemu_savevm_state(f, op, errp);
+    if ((ret < 0) && !*errp) {
+        error_setg(errp, "qemu_savevm_state failed");
+    }
+    qemu_fclose(f);
+
+    if (op == VMS_REBOOT) {
+        no_shutdown = 0;
+        qemu_system_shutdown_request(SHUTDOWN_CAUSE_GUEST_SHUTDOWN);
+    }
+}
+
 int save_snapshot(const char *name, Error **errp)
 {
     BlockDriverState *bs, *bs1;
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 864cbfa..9ec7b88 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -35,6 +35,7 @@
 #include "qapi/qapi-commands-machine.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-ui.h"
+#include "qapi/qapi-commands-migration.h"
 #include "qapi/qmp/qerror.h"
 #include "hw/mem/memory-device.h"
 #include "hw/acpi/acpi_dev_interface.h"
@@ -161,6 +162,11 @@ void qmp_cont(Error **errp)
     }
 }
 
+void qmp_cprsave(const char *file, const char *mode, Error **errp)
+{
+    save_cpr_snapshot(file, mode, errp);
+}
+
 void qmp_system_wakeup(Error **errp)
 {
     if (!qemu_wakeup_suspend_enabled()) {
diff --git a/qapi/migration.json b/qapi/migration.json
index d500055..b61df1d 100644
--- a/qapi/migration.json
+++ b/qapi/migration.json
@@ -1621,3 +1621,17 @@
 ##
 { 'event': 'UNPLUG_PRIMARY',
   'data': { 'device-id': 'str' } }
+
+##
+# @cprsave:
+#
+# Create a checkpoint of the virtual machine device state in @file.
+# Guest RAM and guest block device blocks are not saved.
+#
+# @file: name of checkpoint file
+# @mode: 'reboot' : checkpoint can be cprload'ed after a host kexec reboot.
+#
+# Since 5.0
+##
+{ 'command': 'cprsave', 'data': { 'file': 'str', 'mode': 'str' } }
+
-- 
1.8.3.1


