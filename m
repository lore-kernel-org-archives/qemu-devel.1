Return-Path: <SRS0=dYSx=4M=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD99C38BE2
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:15:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A96820CC7
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2020 21:15:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="snUzxX27"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A96820CC7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=oracle.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43532 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j6L4J-0005AD-6M
	for qemu-devel@archiver.kernel.org; Mon, 24 Feb 2020 16:15:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51003)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kmz-0008Pu-P1
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jag.raman@oracle.com>) id 1j6Kmy-00047u-Iv
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:17 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45340)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jag.raman@oracle.com>)
 id 1j6Kmy-000478-9s
 for qemu-devel@nongnu.org; Mon, 24 Feb 2020 15:57:16 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
 by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKrgSd032171;
 Mon, 24 Feb 2020 20:57:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com;
 h=from : to : cc :
 subject : date : message-id : in-reply-to : references : in-reply-to :
 references; s=corp-2020-01-29;
 bh=0bgtJYi5Q+wqi1vj3BeRoc/5jB6JYG14IQlZmOpXzdM=;
 b=snUzxX27V0itBBRYmJGEsjo/W75fvVRQyfI1qtQ14w4b90fxai6sN61xLwz0xL+GlzEy
 F8mNZdFwXtsITViHsVzKKb+W2W9LALHdG2T0YQUwq5cHM/0szTv32hVZklCtl4ocOEfh
 mW6xR7+S3Yb7z6N3UjnFbG5F+q4QmG+fuTvdEmvyVdM57vP5Y4//eHqW8Qks8tv9EPUl
 Huro0jo6beW14yvyoO9MDXutRg6hK2ZRw3fKGHr5y3YRsXVyH3/EWqKrqeNC+0Gn5xxK
 H7Aam4K8QDyfnoTWl5PBb1Zq4omp2bYJURFFtlSJqxDviwVhQsx7arspjvYOHWHNycyf ng== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
 by userp2130.oracle.com with ESMTP id 2yauqua0rq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:57:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
 by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 01OKq5fO171086;
 Mon, 24 Feb 2020 20:57:10 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
 by userp3030.oracle.com with ESMTP id 2ybdshksuk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 24 Feb 2020 20:57:09 +0000
Received: from abhmp0010.oracle.com (abhmp0010.oracle.com [141.146.116.16])
 by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 01OKv8VW030212;
 Mon, 24 Feb 2020 20:57:08 GMT
Received: from jaraman-bur-1.us.oracle.com (/10.152.33.39)
 by default (Oracle Beehive Gateway v4.0)
 with ESMTP ; Mon, 24 Feb 2020 12:57:07 -0800
From: Jagannathan Raman <jag.raman@oracle.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v5 46/50] multi-process/mig: Restore the VMSD in remote process
Date: Mon, 24 Feb 2020 15:55:37 -0500
Message-Id: <68144e5a0cdc4a16c1fe63f4a7482191f86b7c0f.1582576372.git.jag.raman@oracle.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=1
 bulkscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=999 spamscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2001150001 definitions=main-2002240153
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 156.151.31.86
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

The remote process accepts the VMSD from Proxy object and
restores it

Signed-off-by: Elena Ufimtseva <elena.ufimtseva@oracle.com>
Signed-off-by: John G Johnson <john.g.johnson@oracle.com>
Signed-off-by: Jagannathan Raman <jag.raman@oracle.com>
---
 migration/savevm.c   | 36 ++++++++++++++++++++++++++++++++++++
 migration/savevm.h   |  1 +
 remote/remote-main.c | 33 +++++++++++++++++++++++++++++++++
 3 files changed, 70 insertions(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 09af14d..e95ea4a 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -2969,3 +2969,39 @@ int qemu_remote_savevm(QEMUFile *f)
 
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
index 0491d3a..8741c66 100644
--- a/migration/savevm.h
+++ b/migration/savevm.h
@@ -66,5 +66,6 @@ int qemu_loadvm_state_main(QEMUFile *f, MigrationIncomingState *mis);
 int qemu_load_device_state(QEMUFile *f);
 
 int qemu_remote_savevm(QEMUFile *f);
+int qemu_remote_loadvm(QEMUFile *f);
 
 #endif
diff --git a/remote/remote-main.c b/remote/remote-main.c
index 0260c7c..ab4ad0b 100644
--- a/remote/remote-main.c
+++ b/remote/remote-main.c
@@ -68,6 +68,7 @@
 #include "chardev/char.h"
 #include "sysemu/reset.h"
 #include "vl.h"
+#include "migration/misc.h"
 
 static MPQemuLinkState *mpqemu_link;
 
@@ -363,6 +364,30 @@ static void process_start_mig_out(MPQemuMsg *msg)
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
@@ -455,6 +480,12 @@ static void process_msg(GIOCondition cond, MPQemuChannel *chan)
     case START_MIG_OUT:
         process_start_mig_out(msg);
         break;
+    case START_MIG_IN:
+        if (process_start_mig_in(msg)) {
+            error_setg(&err, "Incoming migration failed.");
+            goto finalize_loop;
+        }
+        break;
     case RUNSTATE_SET:
         remote_runstate_set(msg->data1.runstate.state);
         notify_proxy(msg->fds[0], 0);
@@ -532,6 +563,8 @@ int main(int argc, char *argv[])
     }
     mpqemu_init_channel(mpqemu_link, &mpqemu_link->mmio, fd);
 
+    migration_object_init();
+
     parse_cmdline(argc - 3, argv + 3, NULL);
 
     mpqemu_link_set_callback(mpqemu_link, process_msg);
-- 
1.8.3.1


