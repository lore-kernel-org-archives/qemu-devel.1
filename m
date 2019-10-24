Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7174CA9EBB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:37:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A43012166E
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:37:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="LZxAypPz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A43012166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36802 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZZ5-0005CJ-5G
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:37:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ9w-0000k5-Uc
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZ9v-0004zw-Ih
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:56 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33530)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZ9v-0004zG-AE
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:11:55 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94Md6094848;
 Thu, 24 Oct 2019 09:11:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=ZazKF5zASnYtKiQ2UrpEQ5g+M+DSQpkar+tDkJDYdyE=;
 b=LZxAypPz/dC9VxXmzbXcKai8tV1iNNUBlF5PKBeyeDUy3ZMmAMs/NVcxjcQNWJB16D6K
 6XOOUdq7XcbfE+szaMExVK5axXOC0/VGtG6MrsvENBsFEA08LicV75hx1UvOXleTCkMU
 HsnP+NwLhxgDZh6q2VRDnmhui+FZfuDs8RwbaFi8o+JMJ33/xC3//MEWFY9pXT2+Y0k4
 xvvECJB6oEBzWVggeAodu7VvSMqlNb4S/cjYrqtoE7MLrdZm3W0h8kzmrBBmqyd56MO4
 Ii/QjFI2Vq/0l3oNy31AM9pFyqQI1SUkW2qBLOKF/Rb8d/l1oxwJCKTkBkNFE1goNhQT bA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
 by userp2120.oracle.com with ESMTP id 2vqu4r24su-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:11:48 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
 by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O982qm093212;
 Thu, 24 Oct 2019 09:11:47 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
 by aserp3030.oracle.com with ESMTP id 2vtm244km6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:11:47 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x9O9Bjvd012361;
 Thu, 24 Oct 2019 09:11:45 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:11:44 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 42/49] multi-process/mig: Send VMSD of remote to the
 Proxy object
Date: Thu, 24 Oct 2019 05:09:23 -0400
Message-Id: <98de5369e4279decf5a09c17c513497d6153ed64.1571905346.git.jag.raman@oracle.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
In-Reply-To: <cover.1571905346.git.jag.raman@oracle.com>
References: <cover.1571905346.git.jag.raman@oracle.com>
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910240089
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9419
 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0
 suspectscore=1 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910240089
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

The remote process sends the VMSD to the Proxy object, on the source
side

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 New patch in v4

 migration/savevm.c   | 27 +++++++++++++++++++++++++++
 migration/savevm.h   |  2 ++
 remote/remote-main.c | 43 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 8d95e26..0c84142 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2903,3 +2903,30 @@ bool vmstate_check_only_migratable(const VMStateDescription *vmsd)
 
     return !(vmsd && vmsd->unmigratable);
 }
+
+int qemu_remote_savevm(QEMUFile *f)
+{
+    SaveStateEntry *se;
+    int ret;
+
+    QTAILQ_FOREACH(se, &savevm_state.handlers, entry) {
+        if (!se->vmsd || !vmstate_save_needed(se->vmsd, se->opaque)) {
+            continue;
+        }
+
+        save_section_header(f, se, QEMU_VM_SECTION_FULL);
+
+        ret = vmstate_save(f, se, NULL);
+        if (ret) {
+            qemu_file_set_error(f, ret);
+            return ret;
+        }
+
+        save_section_footer(f, se);
+    }
+
+    qemu_put_byte(f, QEMU_VM_EOF);
+    qemu_fflush(f);
+
+    return 0;
+}
diff --git a/migration/savevm.h b/migration/savevm.h
index 51a4b9c..a6582ac 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -64,4 +64,6 @@ void qemu_loadvm_state_cleanup(void);
 int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
 int qemu_load_device_state(QEMUFile *f);
 
+int qemu_remote_savevm(QEMUFile *f);
+
 #endif
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 341b7cf..0284039 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -66,6 +66,16 @@
 #include "qemu/log.h"
 #include "qemu/cutils.h"
 #include "remote-opts.h"
+#include "qapi/error.h"
+#include "io/channel-util.h"
+
+#include "io/channel.h"
+#include "io/channel-socket.h"
+#include "migration/qemu-file-types.h"
+#include "migration/savevm.h"
+#include "migration/qemu-file-channel.h"
+#include "migration/qemu-file.h"
+
 #include "monitor/monitor.h"
 #include "chardev/char.h"
 #include "sysemu/reset.h"
@@ -362,6 +372,36 @@ static int setup_device(MPQemuMsg *msg, Error **errp)
     return 0;
 }
 
+static void process_start_mig_out(MPQemuMsg *msg)
+{
+    int wait = msg->fds[1];
+    Error *err = NULL;
+    QIOChannel *ioc;
+    QEMUFile *f;
+
+    ioc = qio_channel_new_fd(msg->fds[0], &err);
+    if (err) {
+        error_report_err(err);
+        return;
+    }
+
+    qio_channel_set_name(QIO_CHANNEL(ioc), "remote-migration-channel");
+
+    f = qemu_fopen_channel_output(ioc);
+
+    bdrv_drain_all();
+    (void)bdrv_flush_all();
+
+    (void)qemu_remote_savevm(f);
+
+    qemu_fflush(f);
+
+    notify_proxy(wait, (uint64_t)qemu_ftell(f));
+    PUT_REMOTE_WAIT(wait);
+
+    qemu_fclose(f);
+}
+
 static void process_msg(GIOCondition cond, MPQemuChannel *chan)
 {
     MPQemuMsg *msg = NULL;
@@ -454,6 +494,9 @@ static void process_msg(GIOCondition cond, MPQemuChannel *chan)
     case DEVICE_RESET:
         process_device_reset_msg(msg);
         break;
+    case START_MIG_OUT:
+        process_start_mig_out(msg);
+        break;
     default:
         error_setg(&err, "Unknown command");
         goto finalize_loop;
-- 
1.8.3.1


