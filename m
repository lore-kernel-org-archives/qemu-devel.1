Return-Path: <SRS0=Jnn8=YR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17C8DCA9EAF
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:52:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1A7020856
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Oct 2019 09:52:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="lRDGEXRY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1A7020856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37030 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNZnI-00041j-6Z
	for qemu-devel@archiver.kernel.org; Thu, 24 Oct 2019 05:52:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44593)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1iNZC2-0007DQ-NM
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:14:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1iNZC1-00063O-Dr
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:14:06 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:35552)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1iNZC1-000631-4y
 for qemu-devel@nongnu.org; Thu, 24 Oct 2019 05:14:05 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
 by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O94NgV094929;
 Thu, 24 Oct 2019 09:13:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2019-08-05;
 bh=KK1DDsl5LoYz0kHfRVhfRF7BswS0wwZQTtSacPGONAc=;
 b=lRDGEXRY8A5sg6k7cou/n+fqputxDSIURN9M7YbDtMfo6c6xKVXbtOpJVNVa8dppgZ8R
 nqpGp99V8qbHXe7AX+uKu9biw7g4xsoHM7pAJ+Mx/YHFzofmFMp5Ng98IHY5Q5a3vv7D
 R/As9aUK6edoi5GTodFX8RIwZql7c6cU6vw4xphQJMxZT97FrsvK0gDJsi8Jx0RIziTt
 Rm0c5AJq0orrMdjCWmsGBPCk8EvNX+p0h9HytCKhzwGLt/Plf7EcLMxyHI/LvJQGz4vg
 xUwaGqYdNhYVrj6AznQSbFE0Dv/66bfMZFEUu/8VxrM/BAusBtL8qgQmy97x1xws5+d3 qQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
 by userp2120.oracle.com with ESMTP id 2vqu4r253u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:13:59 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
 by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9O98LXG047110;
 Thu, 24 Oct 2019 09:11:58 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
 by aserp3020.oracle.com with ESMTP id 2vu0fnu90t-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Oct 2019 09:11:58 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
 by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x9O9BwV3024589;
 Thu, 24 Oct 2019 09:11:58 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Thu, 24 Oct 2019 02:11:57 -0700
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [RFC v4 PATCH 46/49] multi-process/mig: Restore the VMSD in remote
 process
Date: Thu, 24 Oct 2019 05:09:27 -0400
Message-Id: <43b9bcb5db6e427b7ddc66af243f28d75a854dbc.1571905346.git.jag.raman@oracle.com>
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

From: Elena Ufimtseva <elena.ufimtseva@oracle.com>

The remote process accepts the VMSD from Proxy object and
restores it

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 New patch in v4

 migration/savevm.c   | 36 ++++++++++++++++++++++++++++++++++++
 migration/savevm.h   |  1 +
 remote/remote-main.c | 34 ++++++++++++++++++++++++++++++++++
 3 files changed, 71 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 0c84142..d730cd1 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2930,3 +2930,39 @@ int qemu_remote_savevm(QEMUFile *f)
 
     return 0;
 }
+
+int qemu_remote_loadvm(QEMUFile *f)
+{
+    uint8_t section_type;
+    int ret = 0;
+
+    qemu_mutex_lock_iothread();
+
+    while (true) {
+        section_type = qemu_get_byte(f);
+
+        if (qemu_file_get_error(f)) {
+            ret = qemu_file_get_error(f);
+            break;
+        }
+
+        switch (section_type) {
+        case QEMU_VM_SECTION_FULL:
+            ret = qemu_loadvm_section_start_full(f, NULL);
+            if (ret < 0) {
+                break;
+            }
+            break;
+        case QEMU_VM_EOF:
+            goto out;
+        default:
+            ret = -EINVAL;
+            goto out;
+        }
+    }
+
+out:
+    qemu_mutex_unlock_iothread();
+
+    return ret;
+}
diff --git a/migration/savevm.h b/migration/savevm.h
index a6582ac..415b72c 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -65,5 +65,6 @@ int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
 int qemu_load_device_state(QEMUFile *f);
 
 int qemu_remote_savevm(QEMUFile *f);
+int qemu_remote_loadvm(QEMUFile *f);
 
 #endif
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 2de5ddf..600c894 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -81,6 +81,7 @@
 #include "chardev/char.h"
 #include "sysemu/reset.h"
 #include "vl.h"
+#include "migration/misc.h"
 
 static MPQemuLinkState *mpqemu_link;
 
@@ -403,6 +404,30 @@ static void process_start_mig_out(MPQemuMsg *msg)
     qemu_fclose(f);
 }
 
+static int process_start_mig_in(MPQemuMsg *msg)
+{
+    Error *err = NULL;
+    QIOChannel *ioc;
+    QEMUFile *f;
+    int rc = -EINVAL;
+
+    ioc = qio_channel_new_fd(msg->fds[0], &err);
+    if (err) {
+        error_report_err(err);
+        return rc;
+    }
+
+    qio_channel_set_name(QIO_CHANNEL(ioc), "remote-migration-channel");
+
+    f = qemu_fopen_channel_input(ioc);
+
+    rc = qemu_remote_loadvm(f);
+
+    qemu_fclose(f);
+
+    return rc;
+}
+
 static void process_msg(GIOCondition cond, MPQemuChannel *chan)
 {
     MPQemuMsg *msg = NULL;
@@ -498,6 +523,13 @@ static void process_msg(GIOCondition cond, MPQemuChannel *chan)
     case START_MIG_OUT:
         process_start_mig_out(msg);
         break;
+    case START_MIG_IN:
+        if (process_start_mig_in(msg))
+        {
+            error_setg(&err, "Incoming migration failed.");
+            goto finalize_loop;
+        }
+        break;
     case RUNSTATE_SET:
         remote_runstate_set(msg->data1.runstate.state);
         break;
@@ -569,6 +601,8 @@ int main(int argc, char *argv[])
     }
     mpqemu_init_channel(mpqemu_link, &mpqemu_link->mmio, fd);
 
+    migration_object_init();
+
     parse_cmdline(argc - 3, argv + 3, NULL);
 
     mpqemu_link_set_callback(mpqemu_link, process_msg);
-- 
1.8.3.1


